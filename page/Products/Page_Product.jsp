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
        <input class="nav_button" type="button" value="Forum" onclick="move_site(this.value)">
    </nav>

    <main>
        <div id="Product_Content">
            <div id="Product_image_space">
                <img id="Product_image" src="../../image/Product/i9-12900.jpg">
            </div>
            <div id="Product_simple_descript">
                <div id="Product_Name">
                    <p id="name">Intel® Core™ i9-12900 Processor</p>
                </div>
                <div id="Product_Cost">
                    <p id="cost"> 746480 (₩)</p>
                </div>
                <div id="Buy_button_space">
                    <input id="Buy_button" type="button" value="Buy Now" onclick="location.href='../Products/Page_Purchase.jsp'">
                </div>
            </div>
        </div>
        <div id="Product_description_table">
            <table id="product_table">
                <tr>
                    <td class="attribute">제품회사</td>
                    <td class="table_content" id="manufacturer">Intel</td>
                    <td class="attribute">출시일</td>
                    <td class="table_content" id="release_date">2021 4분기</td>
                </tr>
            </table>
        </div>
        <div id="Comments_Space">
            <div id="Comments_Input">
                <input id="Comments_Input_text" type="text" value="의견을 입력하세요">
                <input id="Comments_Input_button" type="button" value="제출">
            </div>
        </div>
    </main>

    <script>
        window.onload = function(){

            if_logged();
            make_screen();
        }

        function make_screen(){
            var cpu = ["core", "socket"];
            var board = ["usefor", "socket"];
            var gpu = ["chipset"];
            var ram = ["size","ddr"];
            var disk = ["disk", "size, interface", "rpm"];
            var cooler = ["socket"];
            var power = ["tower", "power"];
            var tower = ["type", "size"];

            var list_string = "<%=list%>";
            var list_data = list_string.substring(1, list_string.length-1).split(", ");
            console.log(list_data);
            var etc_length = list_data[list_data.length-1].length;
            var etc_data = list_data[list_data.length-1].substring(1, etc_length-1).split(",");
            var etc_cnt = etc_data.length;

            document.getElementById("name").innerHTML = list_data[1];
            document.getElementById("cost").innerHTML = list_data[3] + "(￦)";
            document.getElementById("Product_image").setAttribute("src", list_data[6]);
            document.getElementById("release_date").innerHTML = list_data[8];
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
            console.log(rowcnt);
            console.log(td_list);

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

        function move_site(part){
            location.href = "./Page_Product_List.jsp?part="+part;
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
    </script>
</body>