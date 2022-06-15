<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.Vector"%>

<%
    String nickname = (String) session.getAttribute("nickname");
    int post_id = Integer.parseInt(request.getParameter("post_id"));

    if(nickname == null){
        response.sendRedirect("../Noauth.jsp");
    }else{

        String title = request.getParameter("title");
        String content = request.getParameter("post_content");

        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/comforyou","james","8366");

        if(title.equals("") || title==null || content.equals("") || content==null){
            response.sendRedirect("../Noauth.jsp");
        }
        else if(post_id==0){
            content=content.replace("\r\n","<br>");
            
            String sql = "INSERT INTO posts(post_title, post_content, nickname) VALUES (?,?,?)";
            PreparedStatement query = connect.prepareStatement(sql);
            query.setString(1, title);
            query.setString(2, content);
            query.setString(3, nickname);
        
            query.executeUpdate();
        }
        else{
            content=content.replace("\r\n","<br>");

            String sql = "UPDATE posts SET post_title=?, post_content=? WHERE post_id = ?";
            PreparedStatement query = connect.prepareStatement(sql);
            query.setString(1, title);
            query.setString(2, content);
            query.setInt(3, post_id);
        
            query.executeUpdate();
        }
    }
%>

<body>
    <script>
        window.onload = function(){
            var post_id = <%=post_id%>;
            if(post_id==0){
                location.href="./Post_List.jsp"
            }else{
                location.href="./Page_Post.jsp?post_id=" + post_id;
            }
        }
    </script>
</body>