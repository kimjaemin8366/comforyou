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

    int part_id = Integer.parseInt(request.getParameter("part_id"));
    String part = request.getParameter("part");
    
    Vector<String> list = new Vector<String>();
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/comforyou","james","8366");


    String sql = "SELECT * FROM component LEFT JOIN component_" + part.toLowerCase() + " ON component.part_id = component_" + part.toLowerCase() + ".part_id WHERE component.part_id = " + part_id;
    Statement stmt = connect.createStatement();
    ResultSet result = stmt.executeQuery(sql);

    int colnum = 0;

    if(part.equals("CPU") || part.equals("Mainboard") || part.equals("RAM") || part.equals("Power") || part.equals("Tower")){
        colnum = 13;
    }else if(part.equals("GPU") || part.equals("Cooler")){
        colnum = 12;
    }else if(part.equals("Disk")){
        colnum = 15;
    }


    if(result.next()){
        for(int idx=1; idx<=colnum; idx++){
            list.add(result.getString(idx));
        }
    }

    Vector<String> comment_list = new Vector<String>();
    String comment_sql = "SELECT comment_id, comment_content, nickname, comment_date FROM component_comments WHERE part_id = ?";
    PreparedStatement comment_query = connect.prepareStatement(comment_sql);
    comment_query.setInt(1, part_id);
    ResultSet comment_result = comment_query.executeQuery();
    int comment_cnt = 0;
    while(comment_result.next()){
        for(int idx=1; idx<=4; idx++){
            comment_list.add(comment_result.getString(idx));
        }
        comment_cnt += 1;
    }
%>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet", type="text/css" href="../../css/Header.css">
    <link rel="stylesheet", type="text/css" href="../../css//products/Product.css">
    <title>Product</title>
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
        <div id="Product_Content">
            <div id="Product_image_space">
                <img id="Product_image">
            </div>
            <div id="Product_simple_descript">
                <div id="Product_Name">
                    <p id="name"></p>
                </div>
                <div id="Product_Cost">
                    <p id="cost"></p>
                </div>
                <div id="Buy_button_space">
                    <input id="Buy_button" type="button" value="Buy Now" onclick="location.href='../Products/Page_Purchase.jsp?'">
                </div>
            </div>
        </div>
        <div id="Product_description_table">
            <table id="product_table">
                <tr>
                    <td class="attribute">manufacturer</td>
                    <td class="table_content" id="manufacturer"></td>
                    <td class="attribute">release_date</td>
                    <td class="table_content" id="release_date"></td>
                </tr>
            </table>
        </div>
        <div id="Comments_Space">
            <form action="Insert_New_Product_Comment.jsp" id="Comments_Input" onsubmit="before_insert()">
                <input type="hidden" name="part" value="<%=part%>">
                <input type="hidden" name="part_id" value="<%=part_id%>">
                <input id="Comments_Input_text" name="comment" type="text" placeholder="의견을 입력하세요">
                <input id="Comments_Input_button" type="submit" value="제출">
            </form>

            <div id="Comment_list">
                <table id="Comment_table">
                    <!-- <tr>
                        <td class="Comment_content">이거 완전 좋음</td>
                        <td class="Comment_info">
                            <p class="Comment_writer">김재민</p>
                            <p class="Comment_date">2022.12.27 10:00:00</p>
                        </td>
                        <td>
                            <input type="button" class="Comment_delete" value="삭제" onclick="delete_comment()">
                        </td>
                    </tr> -->
                </table>

            </div>
        </div>

        <footer style="height: 100px"></footer>
    </main>

    <script>
        window.onload = function(){
            if_logged();
            make_screen();
            
        }

        

        function make_screen(){
            var cpu = ["core", "ddr"];
            var board = ["usefor", "socket"];
            var gpu = ["chipset"];
            var ram = ["size","ddr"];
            var disk = ["disk", "size, interface", "rpm"];
            var cooler = ["socket"];
            var power = ["tower", "power"];
            var tower = ["type", "size"];

            var list_string = "<%=list%>";
            var list_data = list_string.substring(1, list_string.length-1).split(", ");
            var etc_length = list_data[list_data.length-1].length;
            var etc_data = list_data[list_data.length-1].substring(1, etc_length-1).split(",");
            var etc_cnt = etc_data.length;

            document.getElementById("Buy_button").addEventListener("click", function(){
                location.href= "../Products/Page_Purchase.jsp?part_id=" + list_data[0];
            })

            document.getElementById("name").innerHTML = list_data[1];
            document.getElementById("cost").innerHTML = list_data[3] + "(￦)";
            document.getElementById("Product_image").setAttribute("src", list_data[6]);
            document.getElementById("release_date").innerHTML = list_data[8];
            document.getElementById("manufacturer").innerHTML = list_data[9];
            var part = "<%=part%>";

            if(part=="CPU"){
                make_table(cpu, list_data, etc_data);
            }else if(part=="Mainboard"){
                make_table(board, list_data, etc_data);
            }
            else if(part=="GPU"){
                make_table(gpu, list_data, etc_data);
            }
            else if(part=="RAM"){
                make_table(ram, list_data, etc_data);
            }
            else if(part=="Disk"){
                make_table(disk, list_data, etc_data);
            }
            else if(part=="Cooler"){
                make_table(cooler, list_data, etc_data);
            }else if(part=="Power"){
                make_table(power, list_data, etc_data);
            }
            else if(part=="Tower"){
                make_table(tower, list_data, etc_data);
            }

            make_comment_list();
        }

        function make_table(part, list_data, etc_data){
            var table = document.getElementById("product_table");
            var list_cnt = (list_data.length-11);
            var etc_cnt = (etc_data.length)/2;
            if(rowcnt==0){
                if(cnt==0){
                    return;
                }
                var new_tr = document.createElement("tr");
                
                var new_td_1 = document.createElement("td");
                new_td_1.className = "attribute";
                new_td_1.innerHTML = part[0];

                var new_td_2  = document.createElement("td");
                new_td_2.className = "table_content";
                new_td_2.innerHTML = list_data[list_data.length-2];

                new_tr.append(new_td_1, new_td_2);
                table.appendChild(new_tr);
                return;
            }

            var td_list = [];
            for(var idx=list_cnt-1; idx>=0; idx--){
                var new_td_1 = document.createElement("td");
                new_td_1.className = "attribute";
                new_td_1.innerHTML = part[part.length-idx-1];

                var new_td_2 = document.createElement("td");
                new_td_2.className = "table_content";
                new_td_2.innerHTML = list_data[list_data.length-(2+idx)];

                td_list.push(new_td_1);
                td_list.push(new_td_2);
            }

            for(var idx=0; idx<etc_cnt; idx++){
                var new_td_1 = document.createElement("td");
                new_td_1.className = "attribute";
                new_td_1.innerHTML = etc_data[idx*2];

                var new_td_2 = document.createElement("td");
                new_td_2.className = "table_content";
                new_td_2.innerHTML = etc_data[idx*2+1];

                td_list.push(new_td_1);
                td_list.push(new_td_2);
                
            }

            var rowcnt = 0;
            var rowcnt_odd = false;
            if((td_list.length/2)%2 == 0){
                rowcnt = td_list.length/4;
            }else{
                rowcnt = parseInt((td_list.length/4) +1);
                rowcnt_odd = true;
            }

            for(var idx=0; idx<rowcnt; idx++){
                var new_tr=  document.createElement("tr");

                if(idx==rowcnt-1 && rowcnt_odd==true){
                    new_tr.append(td_list[idx*4], td_list[idx*4+1]);
                }else{
                    new_tr.append(td_list[idx*4], td_list[idx*4+1], td_list[idx*4+2], td_list[idx*4+3]);
                }
                table.appendChild(new_tr);
            }
            
        }

        function make_comment_list(){
            var comment_list_string = "<%=comment_list%>";
            var comment_list_data = comment_list_string.substring(1, comment_list_string.length-1).split(", ");
            var cnt = <%=comment_cnt%>;
            var nickname = "<%=nickname%>";
            var ismanager = "<%=ismanager%>";
            var table = document.getElementById("Comment_table");
            
            for(var idx=0; idx<cnt; idx++){
                var new_tr = document.createElement("tr");
                var content_td = document.createElement("td");
                content_td.className="Comment_content";
                content_td.innerHTML =comment_list_data[idx*4+1];
                
                var info_td = document.createElement("td");
                info_td.className = "Comment_info";
                var writer_p = document.createElement("p");
                writer_p.className="Comment_writer";
                writer_p.innerHTML = comment_list_data[idx*4+2];
                var date_p = document.createElement("p");
                date_p.className = "Comment_date";
                date_p.innerHTML = comment_list_data[idx*4+3];
                info_td.append(writer_p, date_p);

                if(nickname==comment_list_data[idx*4+2] || ismanager=="1"){
                    var button_td = document.createElement("td");
                    var button = document.createElement("input");
                    button.type="button";
                    button.className="Comment_delete";
                    button.value = "삭제";
                    (function(m){
                        button.addEventListener("click", function(){
                            delete_comment(comment_list_data[m*4]);
                        },false );
                    })(idx);

                    button_td.appendChild(button);
                    new_tr.append(content_td, info_td, button_td);
                }else{
                    new_tr.append(content_td, info_td);
                }
                table.appendChild(new_tr);
            }
        }

        function delete_comment(comment_id){
            if(confirm("삭제하시겠습니까?")){
                location.href="./Delete_Product_Comment.jsp?part=<%=part%>&part_id=<%=part_id%>&comment_id="+comment_id;
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