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

    Vector<String> list = new Vector<String>();
    int cnt = 0;

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/comforyou","james","8366");


    String sql = "SELECT post_id, post_title, nickname, post_date FROM posts ORDER BY post_date DESC";
    PreparedStatement query = connect.prepareStatement(sql);

    ResultSet result = query.executeQuery();

    while(result.next()){
        for(int idx=1; idx<=4; idx++){
            list.add(result.getString(idx));
        }
        cnt++;
    }
    
    
%>


<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet", type="text/css" href="../../css/Header.css">
    <link rel="stylesheet", type="text/css" href="../../css/forum/post_list.css">
    <title>Part</title>
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
        <div id="new_post_button_space">
            <input type="button" id="new_post_button" value="New Post" onclick="location.href='./Page_Writing_Post.jsp'"> 
        </div>
        <table id="post_table">
            <tr>
                <th id="number">Post_id</th>
                <th id="title" colspan="2">Title</th>
                <th id="writer">Writer</th>
                <th id="date">Date</th>
            </tr>
            <!-- <tr>
                <td>1</td>
                <td class="post_title">CPU 후기</td>
                <td class="delete_button_space">
                    <input type="button" class="delete_button" value="삭제">
                </td>
                <td>김재민</td>
                <td>
                    2022.4.26 10:30:00
                </td>
            </tr> -->
        </table>
    </main>

    <script>
        window.onload= function(){
            if_logged();
            make_list();
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

        function make_list(){
            var list_string = "<%=list%>";
            var cnt = <%=cnt%>;
            var list_data = list_string.substring(1, list_string.length-1).split(", ");
            var nickname = "<%=nickname%>";
            var ismanager = "<%=ismanager%>"
            var table = document.getElementById("post_table");
            for(var idx=0; idx<cnt; idx++){
                var new_tr= document.createElement("tr");

                var id_td = document.createElement("td");
                id_td.innerHTML = list_data[idx*4];
                var title_td = document.createElement("td");
                title_td.innerHTML = list_data[idx*4+1];
                title_td.className = "post_title";
                (function(m){
                    title_td.addEventListener("click", function(){
                        location.href= "./Page_Post.jsp?post_id=" + list_data[m*4];
                    },false );
                })(idx);

                var writer_td= document.createElement("td");
                writer_td.innerHTML = list_data[idx*4+2];
                var date_td = document.createElement("td");
                date_td.innerHTML = list_data[idx*4+3];

                if(nickname == list_data[idx*4+2] || ismanager=="1"){
                    var button_td = document.createElement("td");
                    button_td.className = "delete_button_space";
                    var button = document.createElement("input");
                    button.type = "button";
                    button.className = "delete_button";
                    button.value = "삭제";
                    (function(m){
                        button.addEventListener("click", function(){
                            if(confirm("게시물을 삭제하시겠습니까?")){
                                location.href= "./Delete_Post.jsp?post_id=" + list_data[m*4];
                            }
                        },false );
                    })(idx);
                    button_td.appendChild(button);
                    

                    new_tr.append(id_td, title_td, button_td, writer_td, date_td);
                }else{
                    title_td.setAttribute("colspan", "2");
                    new_tr.append(id_td, title_td, writer_td, date_td);
                }

                table.appendChild(new_tr);
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
