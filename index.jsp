<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>


<%
    int sizeLimit = 256*256*20;
    String savePath = request.getRealPath("/");

%>
<body>
    <script>

        alert("<%=savePath%>");
        // window.onload= function(){
        //     location.href="./page/home.jsp";
        // }
    </script>
</body>