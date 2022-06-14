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
%>


<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet", type="text/css" href="../../css/Header.css">
    <link rel="stylesheet", type="text/css" href="../../css/manager/Page_Manager.css">
    <title>Part</title>
</head>
<body>
    <header>
        <div id="homepage">
            <input class="header_option_button" type="button" value="COM with me" onclick="location.href='../home.jsp'">
        </div>
        <div id="header_option">
            <input class="header_option_button" type="button" value="Login"onclick="location.href='../login/Page_Login.jsp'">
            <input class="header_option_button" type="button" value="Join" onclick="location.href='../join/Page_Join.jsp'">
        </div>
    </header>
    <nav id="header_menu">
        <input class="nav_button" type="button" value="CPU" onclick="move_site(this.value)">
        <input class="nav_button" type="button" value="Mainboard"  onclick="move_site(this.value)">
        <input class="nav_button" type="button" value="GPU"  onclick="move_site(this.value)">
        <input class="nav_button" type="button" value="RAM"  onclick="move_site(this.value)">
        <input class="nav_button" type="button" value="SSD&HDD"  onclick="move_site(this.value)">
        <input class="nav_button" type="button" value="Cooler"  onclick="move_site(this.value)">
        <input class="nav_button" type="button" value="Power"  onclick="move_site(this.value)">
        <input class="nav_button" type="button" value="Tower"  onclick="move_site(this.value)">
        <input class="nav_button" type="button" value="Forum" onclick="move_site(this.value)">
    </nav>
    <nav id="nav_menu">
        <div id="nav_filter"><p>Filter</p></div>
        <hr>
        <div class="nav_filter_list">
            <div class="nav_filter_criteria">Posts</div>
            <div class="nav_filter_name" onclick= "location.href='./Page_Post_Product.jsp'">Products</div>
            <div class="nav_filter_name" onclick="location.href='./Page_Post_Forum.jsp'">Forum</div>
        </div>
        <hr>
        <div class="nav_filter_list">
            <div class="nav_filter_criteria">Comments</div>
            <div class="nav_filter_name" onclick="location.href='./Page_Comment_Product.jsp'">Products</div>
            <div class="nav_filter_name" onclick="location.href='./Page_Comment_Forum.jsp'">Forum</div>
        </div>
        <hr>
        <div class="nav_filter_list">
            <div class="nav_filter_name" onclick="location.href='./Page_New_Product.jsp'">Post New Product</div>
        </div>
    </nav>

    <script>

        function move_site(part){
            location.href = "../Products/Page_Product_List.jsp?part="+part;
        }

    </script>

</body>
