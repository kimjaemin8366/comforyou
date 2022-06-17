<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.Vector"%>

<%
    String nickname = (String) session.getAttribute("nickname");
    String ismanager = (String) session.getAttribute("ismanager");
    int comment_id = Integer.parseInt(request.getParameter("comment_id"));
    String comment_content = request.getParameter("comment_content");
    int post_id = Integer.parseInt(request.getParameter("post_id"));

    if(nickname == null){
        response.sendRedirect("../Noauth.jsp");
    }else{

        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/comforyou","james","8366");

        if(comment_content==null || comment_content==""){
            response.sendRedirect("../Noauth.jsp");
        }else{
            comment_content=comment_content.replace("\r\n","<br>");
            String check_sql = "SELECT nickname, post_id FROM posts_comments WHERE comment_id=? AND nickname=?";
            PreparedStatement check_query = connect.prepareStatement(check_sql);
            check_query.setInt(1, comment_id);
            check_query.setString(2, nickname);
    
            ResultSet result = check_query.executeQuery();
    
            if(result.next() || ismanager.equals("1")){
    
    
                String sql = "UPDATE posts_comments SET comment_content=? WHERE comment_id=?";
                PreparedStatement query = connect.prepareStatement(sql);
                query.setString(1, comment_content);
                query.setInt(2, comment_id);
            
                query.executeUpdate();
    
            }else{
                response.sendRedirect("../Noauth.jsp");
            }
        }

    }
%>

<body>
    <script>
        window.onload = function(){
            location.href="./Page_Post.jsp?post_id=<%=post_id%>";
        }
    </script>
</body>