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
    <title>Home</title>
    <link rel="stylesheet" type="text/css" href="../css/Header.css">
    <link rel="stylesheet" type="text/css" href="../css/Home.css">
</head>
<body>
    <header>
        <div id="homepage">
            <input class="header_option_button" type="button" value="COM for you" onclick="location.href='./home.jsp'">
        </div>
        <div id="header_option">
            <input class="header_option_button" type="button" value="Login"onclick="location.href='./login/Page_Login.jsp'">
            <input class="header_option_button" type="button" value="Join" onclick="location.href='./join/Page_Join.jsp'">
            <p class="header_option_logged" id="header_nickname_space"></p>
            <input class="header_option_logged" type="button" value="Logout" onclick="location.href='./login/Logout.jsp'">
        </div>
    </header>
    <nav id="header_menu">
        <input class="nav_button" type="button" value="CPU" onclick="move_site(this.value)">
        <input class="nav_button" type="button" value="Mainboard"  onclick="move_site(this.value)">
        <input class="nav_button" type="button" value="GPU"  onclick="move_site(this.value)">
        <input class="nav_button" type="button" value="RAM"  onclick="move_site(this.value)">
        <input class="nav_button" type="button" value="Disk"  onclick="move_site(this.value)">
        <input class="nav_button" type="button" value="Cooler"  onclick="move_site(this.value)">
        <input class="nav_button" type="button" value="Power"  onclick="move_site(this.value)">
        <input class="nav_button" type="button" value="Tower"  onclick="move_site(this.value)">
        <input class="nav_button" type="button" value="Forum" onclick="location.href='./Forum/Post_List.jsp'">
        <input class="nav_button" type="button" value="Manager" onclick="move_manager_page()">
    </nav>
    <main>
        <section>
            <img id="home_img" src="../../image/Home/Home_img.jpg">
        </section>
        <article>
            <div class="article_menus">
                <div class="menu" id="CPU" onclick="move_site(this.id)">
                   <img class="menu_img"src="../../image/Home/cpu-tower.png">
                   <p class="menu_text">CPU</p>
                </div>
                <div class="menu" id="Mainboard" onclick="move_site(this.id)">
                    <img class="menu_img" src="../../image/Home/mainboard.png">
                    <p class="menu_text">Mainboard</p>
                 </div>
                 <div class="menu" id="GPU" onclick="move_site(this.id)">
                    <img class="menu_img" src="../../image/Home/gpu.png">
                    <p class="menu_text">GPU</p>
                 </div>
                 <div class="menu" id="RAM"  onclick="move_site(this.id)">
                    <img class="menu_img" src="../../image/Home/ram.png">
                    <p class="menu_text">RAM</p>
                 </div>
            </div>
            <div class="article_menus">
                <div class="menu" id="Disk" onclick="move_site(this.id)">
                    <img class="menu_img"src="../../image/Home/drive.png">
                    <p class="menu_text">SSD&HDD</p>
                 </div>
                 <div class="menu" id="Cooler" onclick="move_site(this.id)">
                     <img class="menu_img" src="../../image/Home/cooler.png">
                     <p class="menu_text">Cooler</p>
                  </div>
                  <div class="menu" id="Power" onclick="move_site(this.id)"> 
                     <img class="menu_img" src="../../image/Home/power.png">
                     <p class="menu_text">Power</p>
                  </div>
                  <div class="menu" id="Tower" onclick="move_site(this.id)">
                     <img class="menu_img" src="../../image/Home/case.png">
                     <p class="menu_text">Tower</p>
                  </div>
             </div>
            </div>
        </article>
    </main>

    <script>
        

        window.onload= function(){
            if_logged();
        }

        function if_logged(){
            var nick = "<%=nickname%>";
            var logged = <%=logged%>;
            if(logged){
                document.getElementsByClassName("header_option_logged")[0].innerHTML = nick;
                for(var idx=0; idx<2; idx++){
                    document.getElementsByClassName("header_option_logged")[idx].style.display = "block";
                }
                for(var idx=1; idx<3; idx++){
                    document.getElementsByClassName("header_option_button")[idx].style.display = "none";
                }
            }
        }

        function move_site(part){
            location.href = "../page/Products/Page_Product_List.jsp?part="+part;
        }

        function move_manager_page(){
            var ismanager = "<%=ismanager%>";
            if(ismanager==1){
                location.href="./manager/Page_Manager.jsp";
            }
            else{
                location.href="./Noauth.jsp";
            }
        }



    </script>
</body>
