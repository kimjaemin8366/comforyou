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
    String ismanager = (String) session.getAttribute("ismanager");

    Boolean logged = false;
    if(logged_id != null){
        logged = true;
    }

    Vector<String> post_list = new Vector<String>();
    String post_id = request.getParameter("post_id");
    int modify_post_id = 0;

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/comforyou","james","8366");

    if(post_id==null){
        post_id = "";
    }else{
        modify_post_id = Integer.parseInt(post_id);

        String post_sql = "SELECT post_title, post_content, nickname FROM posts WHERE post_id=?";
        PreparedStatement post_query = connect.prepareStatement(post_sql);
        post_query.setInt(1, modify_post_id);
    
        ResultSet result = post_query.executeQuery();
    
        if(result.next()){
            for(int idx=1; idx<=3; idx++){
                post_list.add(result.getString(idx));
            }
        }
    }
    
    
%>


<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet", type="text/css" href="../../css/Header.css">
    <link rel="stylesheet", type="text/css" href="../../css/forum/writing_post.css">
    <title>Post</title>
</head>
<body>
    <header>
        <div id="homepage">
            <input class="header_option_button" type="button" value="COM for you" onclick="location.href='../home.jsp'">
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
        <input class="nav_button" type="button" value="Disk"  onclick="move_site(this.value)">
        <input class="nav_button" type="button" value="Cooler"  onclick="move_site(this.value)">
        <input class="nav_button" type="button" value="Power"  onclick="move_site(this.value)">
        <input class="nav_button" type="button" value="Tower"  onclick="move_site(this.value)">
        <input class="nav_button" type="button" value="Forum" onclick="location.href='../Forum/Post_List.jsp'">
        <input class="nav_button" type="button" value="Manager" onclick="move_manager_page()">
    </nav>

    <main>
        <form action="Upload_Post.jsp" onsubmit="before_upload()">
            <div id="post_button_space">
                <input type="submit" class="button" value="Upload">
            </div>
            <input type="hidden" id="post_id" name="post_id" value="0">
            <table id="post_table">
                <tr>
                    <input type="text" id="title" name="title" placeholder="제목을 입력해주세요" maxlength="100">
                </tr>
                <tr>
                    <td>
                        <textarea id="post_content" name="post_content" rows="50" placeholder="내용을 입력해주세요"></textarea>
                    </td>
                </tr>
            </table>
        </form>
        <footer style="height:100px"></footer>
    </main>

    <script>
        window.onload= function(){
            if_logged();
            show_post();
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
            }else{
                alert("로그인 해주세요.");
                location.href="../login/Page_Login.jsp";
            }
        }

        function show_post(){
            var modify_post_id = <%=modify_post_id%>;
            var nickname = "<%=nickname%>";

            if(modify_post_id > 0){
                var post_string = "<%=post_list%>";
                var post_data = post_string.substring(1, post_string.length-1).split(", ");

                if(nickname == post_data[2]){
                    document.getElementById("post_id").value = modify_post_id;
                    document.getElementById("title").value = post_data[0];
                    document.getElementById("post_content").innerHTML = post_data[1].replaceAll("<br>","\r\n");;
                }else{
                    location.href= "../Noauth.jsp";
                }
            }

        }

        function before_upload(){
            var title = document.getElementById("title").value;
            var textarea = document.getElementById("post_content").value;
            if(title==""){
                alert("제목을 입력해주세요.");
                event.preventDefault();
                return;
            }
            if(textarea == ""){
                alert("내용을 입력해주세요.");
                event.preventDefault();
                return;
            }
        }

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
            location.href = "../Products/Page_Product_List.jsp?part="+part;
        }
    </script>
</body>
