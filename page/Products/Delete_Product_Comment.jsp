<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.Vector"%>

<%
    String logged_id = (String) session.getAttribute("logged_id");
    String nickname = (String) session.getAttribute("nickname");
    String ismanager = (String) session.getAttribute("ismanager");

    int comment_id = Integer.parseInt(request.getParameter("comment_id"));

    String part= request.getParameter("part");
    String part_id = request.getParameter("part_id");

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/comforyou","james","8366");

    String check_sql = "SELECT nickname FROM component_comments WHERE comment_id = ? AND nickname = ?";
    PreparedStatement check_query = connect.prepareStatement(check_sql);
    check_query.setInt(1, comment_id);
    check_query.setString(2, nickname);
    ResultSet result = check_query.executeQuery();

    if(result.next() || ismanager.equals("1")){        
        String sql = "DELETE FROM component_comments WHERE comment_id = ?";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setInt(1, comment_id);
        query.executeUpdate();
    }

    response.sendRedirect("./Page_Product.jsp?part="+part+"&part_id="+part_id);
%>