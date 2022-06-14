<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.Vector"%>

<%
    String logged_id = (String) session.getAttribute("logged_id");
    String ismanager = (String) session.getAttribute("ismanager");
    Boolean logged = false;
    if(logged_id != null){
        logged = true;
    }

    if(ismanager==null){
        response.sendRedirect("../Noauth.jsp");
    }
    else if(!(ismanager.equals("1"))){
        response.sendRedirect("../Noauth.jsp");
    }

    int comment_id = Integer.parseInt(request.getParameter("comment_id"));

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/comforyou","james","8366");

    String sql = "DELETE FROM posts_comments WHERE comment_id = ?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setInt(1, comment_id);
    query.executeUpdate();
%>

<body>
    <script>
        window.onload = function(){
            location.href="./Page_Comment_Forum.jsp";
        }
    </script>
</body>