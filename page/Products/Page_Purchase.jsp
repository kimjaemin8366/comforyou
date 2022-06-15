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

    String part_id = request.getParameter("part_id");
    Vector<String> list = new Vector<String>();
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/comforyou","james","8366");

    String sql = "SELECT part_name, part_price, imagepath FROM component WHERE part_id=?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, part_id);

    ResultSet result = query.executeQuery();

    while(result.next()){
        for(int idx=1; idx<=3; idx++){
            list.add(result.getString(idx));
        }
    }

    
%>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet", type="text/css" href="../../css/Header.css">
    <link rel="stylesheet", type="text/css" href="../../css//products/Purchase.css">
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
        <div id="main_header">
            <p>Ordered Product</p>
            <hr>
        </div>
        <div id="main_content_summary">
            <img id="img" width="200px" height="200px">
            <div>
                <p>Product name</p>
                <p id="name">Intel® Core™ i9-12900 Processor</p>
            </div>
            <div>
                <p>Product cost</p>
                <p id="cost">746480 (₩)</p>
            </div>
            <div>
                <p>Purchase Amount</p>
                <select id="amount_select" name="amount" onchange="change_total()">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                    <option value="7">7</option>
                    <option value="8">8</option>
                    <option value="9">9</option>
                    <option value="10">10</option>
                </select>
            </div>
            <div>
                <p>Total Cost</p>
                <p id="total_cost"></p>
            </div>
        </div>
        <form action="Page_After_Purchase.jsp", id="Ordered_Info">
            <input type="hidden" id="all_price" name="all_price">
            <p>Ordered Info</p>
            <div class="Info_category">
                <p class="Category">Orderer name</p>
                <input class="Info" name="name" type="text">
            </div>
            <div class="Info_category">
                <p class="Category">Phone number</p>
                <input class="Info" name="phone" type="text">
            </div>
            <div class="Info_category">
                <p class="Category">Shipping address</p>
                <input  class="Info" name="address" type="text">
            </div>
            <div class="Info_category">
                <p class="Category">Bank name</p>
                <input class="Info" name="bank" type="text">
            </div>
            <div class="Info_category">
                <p class="Category">Account number</p>
                <input class="Info" name="account" type="text">
            </div>
            <div class="Info_category">
                <p class="Category">Account holder</p>
                <input class="Info" name="account_holder" type="text">
                <input id="Pay_Now_button" type="submit" value="Pay Now" onclick="check_all_input()">
            </div>
        </form>
    </main>

    <script>
        
        window.onload = function(){
            if_logged();
            make_screen();
            change_total();
        }

        

        function make_screen(){
            var list_string = "<%=list%>";
            var list_data = list_string.substring(1, list_string.length-1).split(", ");
            document.getElementById("name").innerHTML = list_data[0];
            document.getElementById("cost").innerHTML = list_data[1];
            document.getElementById("img").setAttribute("src" , list_data[2]);
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
                alert("로그인이 필요합니다.");
                location.href="../login/Page_Login.jsp";
            }
        }

        function change_total(){
            var amount = parseInt(document.getElementById("amount_select").value);
            var one = parseInt(document.getElementById("cost").innerText);
            var total = one * amount;
            document.getElementById("total_cost").innerHTML = total + "(￦)";
            document.getElementById("all_price").value = total;
        }

        function check_all_input(){
            var inputs = document.getElementsByClassName("Info");
            for(var idx=0; idx<6; idx++){
                if(inputs[idx].value == ""){
                    alert("모든 내용을 입력해주세요.");
                    event.preventDefault();
                    return;
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
