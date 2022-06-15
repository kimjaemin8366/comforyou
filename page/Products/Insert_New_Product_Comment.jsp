<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.Vector"%>

<%
    String logged_id = (String) session.getAttribute("logged_id");
    String nickname = (String) session.getAttribute("nickname");
    String comment = request.getParameter("comment");
    String part = request.getParameter("part");
    int part_id = Integer.parseInt(request.getParameter("part_id"));
    
    Boolean logged = false;
    if(logged_id != null){
        logged = true;
    }
    
    if(logged==true){
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/comforyou","james","8366");
        
        String sql = "INSERT INTO component_comments(comment_content, nickname, part_id) VALUES (?,?,?)";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1, comment);
        query.setString(2, nickname);
        query.setInt(3, part_id);
        query.executeUpdate();

        response.sendRedirect("./Page_Product.jsp?part="+part+"&part_id="+part_id);
    }
%>

