<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String logged_id = (String) session.getAttribute("logged_id");
    String nickname = (String) session.getAttribute("nickname");
    String ismanager = (String) session.getAttribute("ismanager");
    Boolean logged = false;
    if(logged_id != null){
        logged = true;
    }
%>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet", type="text/css" href="../../css/Header.css">
    <link rel="stylesheet", type="text/css" href="../../css//products/After_Purchase.css">
    <title>Purchase</title>
</head>
<body>
    <header>
        <div id="homepage">
            <input class="header_option_button" type="button" value="COM with me" onclick="location.href='../home.jsp'">
        </div>
        <div id="header_option">
            <input class="header_option_button" type="button" value="Login"onclick="location.href='../login/Page_Login.jsp'">
            <input class="header_option_button" type="button" value="Join" onclick="location.href='../join/Page_Join.jsp'">
            <p class="header_option_logged" id="header_nickname_space"></p>
            <input class="header_option_logged" type="button" value="Logout" onclick="location.href='../login/Logout.jsp'">
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
        <input class="nav_button" type="button" value="Forum" onclick="location.href='../Forum/Post_List.jsp'">
        <input class="nav_button" type="button" value="Manager" onclick="move_manager_page()">
    </nav>
    <main>
        <p>Purchase Done</p>
        <input id="gohome_button" type="button" value="Go Home" onclick="location.href='../home.jsp'">
    </main>

    <script>
        function move_manager_page(){
            var ismanager = "<%=ismanager%>";
            if(ismanager==1){
                location.href="../manager/Page_Manager.jsp";
            }
            else{
                location.href="../Noauth.jsp";
            }
        }

        function move_site(part){
            location.href = "./Page_Product_List.jsp?part="+part;
        }
    </script>
</body>