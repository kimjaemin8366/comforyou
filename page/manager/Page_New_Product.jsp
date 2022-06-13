<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %>

<%
    String logged_id = (String) session.getAttribute("logged_id");
    String ismanager = (String) session.getAttribute("ismanager");
    Boolean logged = false;
    if(logged_id != null){
        logged = true;
    }

    if(ismanager==null){
        response.sendRedirect("../home.jsp");
    }
    else if(!(ismanager.equals("1"))){
        response.sendRedirect("../Noauth.jsp");
    }

    String part = request.getParameter("part");
%>


<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet", type="text/css" href="../../css/Header.css">
    <link rel="stylesheet", type="text/css" href="../../css//manager/Page_New_Product.css">
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
    <main>
        <form action="Insert_New_Product.jsp" enctype="multipart/form-data" method="POST">
            <div>
                IMG:
                <input name="img" id="img_input" class="inputs" type="file">
            </div>
            <br>
            <div>
                Product name: <input name="name" class="inputs" type="text">
            </div>
            <br>
            <div>
                Price: <input name="price" class="inputs" type="text">
            </div>
            <br>
            <div>
                <input type="button" value="속성 추가" class="prop_button" onclick="insert_tr()">
                <input type="button" value="속성 제거" class="prop_button" onclick="delete_tr()">
                <input type="hidden" name="cnt" value=1>
            </div>

            <br>
            <table id="table">
                <tr>
                    <th class="part_property">
                        <input class="property" type="text" value="제품 품목" readonly>
                    </th>
                    <td>
                        <select class="content" name="part" id="type" onchange="move(this.value)">
                            <option value="none" disabled>Part</option>
                            <option value="CPU">CPU</option>
                            <option value="Mainboard">Mainboard</option>
                            <option value="GPU">GPU</option>
                            <option value="RAM">RAM</option>
                            <option value="Disk">SSD&HDD</option>
                            <option value="Cooler">Cooler</option>
                            <option value="Power">Power</option>
                            <option value="Tower">Tower</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th class="part_property">
                        <input class="property" type="text" value="제품 회사" readonly>
                    </th>
                    <td class="property_content">
                        <input class="content" name="Manufacturer" type="text">
                    </td>
                </tr>
                <tr>
                    <th class="part_property">
                        <input class="property" type="text" value="출시일" readonly>
                    </th>
                    <td class="property_content">
                        <input class="content" name="date" type="date">
                    </td>
                </tr>
                <!-- <tr>
                    <th class="part_property">
                        <input class="property" name="property_1" type="text" placeholder="속성">
                    </th>
                    <td class="property_content">
                        <input class="content" name="content_1" type="text">
                    </td>
                </tr> -->
            </table>
            <div id="submit_div">
                <input type="submit" id="submit_button" value="제출">
            </div>
        </form>
    </main>

    <script>
        var cnt = 1;
        function insert_tr(){
            var table = document.getElementById("table");
            var new_tr = document.createElement("tr");
            
            var new_th = document.createElement("th");
            new_th.className = "part_property";
            var new_prop = document.createElement("input");
            new_prop.type= "text";
            new_prop.className = "property";
            new_prop.name = "property_"+cnt;
            new_prop.setAttribute("placeholder", "속성");

            new_th.appendChild(new_prop);

            new_td = document.createElement("td");
            new_td.className= "property_content";
            new_content = document.createElement("input");
            new_content.className="content";
            new_content.name = "content_"+cnt;
            new_content.type = "text";
            new_td.appendChild(new_content);
            new_tr.append(new_th, new_td);
            table.appendChild(new_tr)

            cnt += 1;
        }
        function delete_tr(){
            if(cnt==1){
                return;
            }
            var table = document.getElementById("table");
            table.removeChild(table.lastChild);
            cnt-=1;
        }

        function move(part){

            location.href = "./Page_New_Product.jsp?part="+part;
        }

        function make_part_table(){
            var part = "<%=part%>";
            document.getElementById("type").value = part;

            var cpu_props = ["core", "socket"];
            var main_props = ["usefor", "socket"];
            var gpu_props = ["chipset"];
            var ram_props = ["size", "ddr"];
            var disk_props = ["type", "size", "interface", "rpm"];
            var cool_props = ["socket"];
            var power_props = ["type", "power"];
            var tower_props = ["type", "size"];
            if(part=="CPU"){
                make_table(cpu_props);
            }else if(part=="Mainboard"){
                make_table(main_props);
            }else if(part=="GPU"){
                make_table(gpu_props);
            }else if(part=="RAM"){
                make_table(ram_props);
            }else if(part=="Disk"){
                make_table(disk_props);
            }else if(part=="Cooler"){
                make_table(cool_props);
            }else if(part=="Power"){
                make_table(power_props);
            }else if(part=="Tower"){
                make_table(tower_props);
            }
        }

        function make_table(props){
            var table = document.getElementById("table");
            for(var idx=0; idx<props.length; idx++){
                var new_tr = document.createElement("tr");
                
                var new_th = document.createElement("th");
                new_th.className = "part_property";
                var new_prop = document.createElement("input");
                new_prop.type= "text";
                new_prop.className = "property";
                new_prop.value = props[idx];
                new_prop.setAttribute("placeholder", "속성");
                new_prop.setAttribute("readonly", true);

                new_th.appendChild(new_prop);

                new_td = document.createElement("td");
                new_td.className= "property_content";
                new_content = document.createElement("input");
                new_content.className="content";
                new_content.name = props[idx] + "_value";
                new_content.type = "text";
                new_td.appendChild(new_content);
                new_tr.append(new_th, new_td);
                table.appendChild(new_tr)
            }
        }

        window.onload = function(){

            make_part_table();
        }
    </script>
</body>
