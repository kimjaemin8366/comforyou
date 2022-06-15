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


    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/comforyou","james","8366");

    Vector<String> list = new Vector<String>();
    int cnt = 0;

    String sql = "SELECT comment_id, part_id, comment_content, nickname, comment_date FROM component_comments ORDER BY comment_date DESC";
    PreparedStatement query = connect.prepareStatement(sql);

    ResultSet result = query.executeQuery();

    while(result.next()){
        for(int idx=1; idx<=5; idx++){
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
            <p class="header_option_logged" id="header_nickname_space"></p>
            <input class="header_option_logged" type="button" value="Logout" onclick="location.href='./login/Logout.jsp'">
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
    <main>
        <table id="table">
            <tr>
                <th>Part_id</th>
                <th style="width:80%"colspan=2>content</th>
                <th>nickname</th>
                <th>Date</th>
            </tr>
            <!-- <tr>
                <td>CPU</td>
                <td>1</td>
                <td>Intel Core i9-12900 Processor</td>
                <td class="delete_button">
                    <input type="button" id="1" onclick="delete_list()" value="삭제">
                </td>
                <td>
                    2022.03.22
                </td>
            </tr>
            <tr>
                <td>CPU</td>
                <td>2</td>
                <td>Intel Core i7-12700 Processor</td>
                <td class="delete_button">
                    <input type="button" onclick="delete_list()" value="삭제">
                </td>
                <td>
                    2022.03.22
                </td>
            </tr> -->
        </table>
    </main>

    <script>

        window.onload = function(){
            if_logged();
            make_list();
        }

        var now_filter = "";
        function make_list(){
            var table = document.getElementById("table");
            var cnt = <%=cnt%>;

            var list_string = "<%=list%>";
            var list_data = list_string.substring(1, list_string.length-1).split(", ");

            for(var idx=0; idx<cnt; idx++){
                var new_tr = document.createElement("tr");
                for(var idx2=0; idx2<6; idx2++){
                    var new_td = document.createElement("td");
                    if(idx2==0){
                        continue;
                    }
                    if(idx2==3){
                        new_td.className = "delete_button";

                        var new_button = document.createElement("input");
                        new_button.type="button";
                        new_button.value ="삭제";
                        (function(m){
                            new_button.addEventListener("click", function(){
                                delete_list(list_data[m*5]);
                            },false );
                        })(idx);
                        new_td.appendChild(new_button);
                    }else if(idx2==4 || idx2==5){
                        new_td.innerHTML = list_data[idx*5+idx2-1];
                        new_td.className="td_date";
                    }else{
                        new_td.innerHTML = list_data[idx*5+idx2];
                    }
                    new_tr.appendChild(new_td);
                }
                table.appendChild(new_tr);
            }
        }

        function delete_list(id){
            if(confirm("삭제 하시겠습니까?")){
                location.href="./Delete_Product_Comment.jsp?comment_id=" + id;
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
            location.href = "../Products/Page_Product_List.jsp?part="+part;
        }
    </script>

</body>