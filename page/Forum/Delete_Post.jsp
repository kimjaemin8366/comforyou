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

        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/comforyou","james","8366");

        String check_sql = "SELECT nickname FROM posts WHERE post_id=? AND nickname=?";
        PreparedStatement check_query = connect.prepareStatement(check_sql);
        check_query.setInt(1, post_id);
        check_query.setString(2, nickname);

        ResultSet result = check_query.executeQuery();

        if(result.next()){
            String sql = "DELETE FROM posts WHERE post_id=?";
            PreparedStatement query = connect.prepareStatement(sql);
            query.setInt(1, post_id);
        
            query.executeUpdate();

        }else{
            response.sendRedirect("../Noauth.jsp");
        }

    }
%>

<body>
    <script>
        window.onload = function(){
            location.href="./Post_List.jsp";
        }
    </script>
</body>