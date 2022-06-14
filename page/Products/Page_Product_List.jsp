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

    String part = request.getParameter("part");
    String option = request.getParameter("option");

    if(part=="" || part==null){
        part= "CPU";
    }
    
    Vector<String> list = new Vector<String>();
    int cnt = 0;
    Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/comforyou","james","8366");

    if(option=="" || option==null){

        String sql = "SELECT part_id, part_name, part_price, imagepath FROM component WHERE part_type=? ORDER BY post_date DESC";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1, part);

        ResultSet result = query.executeQuery();

        while(result.next()){
            for(int idx=1; idx<=4; idx++){
                list.add(result.getString(idx));
            }
            cnt++;
        }
    }else{
        String[] filter = option.split("_");
        String sql = "SELECT component.part_id, part_name, part_price, imagepath FROM component LEFT JOIN component_" + part.toLowerCase() + " ON component.part_id = component_" + part.toLowerCase() + ".part_id WHERE part_type='" +part+ "' AND " + filter[0] + "='" + filter[1] + "'";    

        Statement stmt = connect.createStatement();
        ResultSet result = stmt.executeQuery(sql);

        while(result.next()){
            for(int idx=1; idx<=4; idx++){
                list.add(result.getString(idx));
            }
            cnt++;
        }
    }

    
%>


<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet", type="text/css" href="../../css/Header.css">
    <link rel="stylesheet", type="text/css" href="../../css//products/Part.css">
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
        <input class="nav_button" type="button" value="Forum" onclick="move_site(this.value)">
    </nav>
    <nav id="nav_menu">
        <div id="nav_filter"><p>Filter</p></div>
        <hr>
    </nav>
    <main>
        <div></div>
    </main>

    <script>

        
        window.onload = function(){
            show_product_list_nav();
            if_logged();
            product_list(); 
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

        function show_product_list_nav(){
            var part = "<%=part%>";

            if(part=="CPU"){
                cpu_filter();
            }else if(part=="Mainboard"){
                mainboard_filter();
            }else if(part=="GPU"){
                gpu_filter();
            }else if(part=="RAM"){
                ram_filter();
            }else if(part=="Disk"){
                disk_filter();
            }else if(part=="Cooler"){
                cooler_filter();
            }else if(part=="Power"){
                power_filter();
            }else if(part="Tower"){
                tower_filter();
            }

        }

        function make_list(filter, site){
            var list = document.createElement("div");
            list.className = "nav_filter_list";

            var list_criteria = document.createElement("div");
            list_criteria.className="nav_filter_criteria";
            list_criteria.innerHTML = filter[0];

            list.appendChild(list_criteria)
            
            for(idx2=1; idx2<filter.length; idx2++){
                var list_name = document.createElement("div");
                list_name.className= "nav_filter_name";
                list_name.innerHTML=filter[idx2];

                (function(m){
                    list_name.addEventListener("click", function(){
                        location.href= site + "option=" + filter[0]+ "_" + filter[m];
                    },false );
                })(idx2);

                list.appendChild(list_name);
            }

            return list;
        }

        function cpu_filter(){
            var manufacturer = ["Manufacturer", "Intel", "AMD"];
            var core = ["Core", "16+8", "8+8", "8+4"];
            var ddr = ["DDR", "DDR5", "DDR4", "DDR3"];
            var filters = [manufacturer, core, ddr];

            var menu = document.getElementById("nav_menu");
            var site = "./Page_Product_List.jsp?part=CPU&";
            for(idx=0; idx<filters.length; idx++){
                var hr = document.createElement("hr");
                menu.append(make_list(filters[idx], site), hr);
            }
        }

        function mainboard_filter(){

            var manufacturer = ["Manufacturer","ASUS", "MSI", "GIGABYTE"];
            var usefor = ["Usefor", "Intel", "AMD"];
            var socket = ["Socket", "1700", "1200", "AM4", "sWRX8"];
            var filters = [manufacturer, usefor, socket];

            var menu = document.getElementById("nav_menu");
            var site = "./Page_Product_List.jsp?part=Mainboard&";
            for(idx=0; idx<filters.length; idx++){
                var hr = document.createElement("hr");
                menu.append(make_list(filters[idx], site), hr);
            }
        }

        function gpu_filter(){
            var manufacturer = ["Manufacturer","MSI", "Emtek", "GIGABYTE", "ASUS"];
            var chipset = ["Chipset", "NVIDIA", "AMD"];
            var filters = [manufacturer, chipset];

            var menu = document.getElementById("nav_menu");
            var site = "./Page_Product_List.jsp?part=GPU&";
            for(idx=0; idx<filters.length; idx++){
                var hr = document.createElement("hr");
                menu.append(make_list(filters[idx], site), hr);
            }
        }

        function ram_filter(){
            var manufacturer = ["Manufacturer", "Samsung", "Micron"];
            var size = ["Memory Size","16GB", "8GB", "4GB"];
            var ddr = ["DDR", "DDR5", "DDR4", "DDR3"];
            var filters = [manufacturer, size, ddr];

            var menu = document.getElementById("nav_menu");
            var site = "./Page_Product_List.jsp?part=RAM&";
            for(idx=0; idx<filters.length; idx++){
                var hr = document.createElement("hr");
                menu.append(make_list(filters[idx], site), hr);
            }
        }

        function disk_filter(){
            var disk = ["Disk", "SSD", "HDD"]
            var manufacturer = ["Samsung", "SK Hynix", "Micron", "Seagate", "TOSHIBA"];
            var size = ["Memory Size","4TB", "2TB", "1TB", "512GB"];
            var interface = ["interface", "SATA3", "PCIe4.0", "PCIe3.0"];
            var rpm = ["RPM", "15000", "10000", "7200"]
            var filters = [disk, manufacturer, size, interface, rpm];

            var menu = document.getElementById("nav_menu");
            var site = "./Page_Product_List.jsp?part=Disk&";
            for(idx=0; idx<filters.length; idx++){
                var hr = document.createElement("hr");
                menu.append(make_list(filters[idx], site), hr);
            }
        }

        function cooler_filter(){
            var manufacturer = ["Manufacturer", "PCCOOLER", "NZXT", "DEEPCOOL"];
            var socket = ["Socket", "1700", "1200", "AM4", "sWRX8"];
            var filters = [manufacturer, socket];

            var menu = document.getElementById("nav_menu");
            var site = "./Page_Product_List.jsp?part=RAM&";
            for(idx=0; idx<filters.length; idx++){
                var hr = document.createElement("hr");
                menu.append(make_list(filters[idx], site), hr);
            }
        }

        function power_filter(){
            var manufacturer = ["Manufacturer", "Micronics", "Seasonic", "PSP"];
            var type = ["Type", "ATX", "M-ATX(SFX)", "TFX", "Server"]
            var power = ["Power", "700W~", "600~699W", "500~599W", "499W"];
            var filters = [manufacturer, type, power];

            var menu = document.getElementById("nav_menu");
            var site = "./Page_Product_List.jsp?part=Power&";
            for(idx=0; idx<filters.length; idx++){
                var hr = document.createElement("hr");
                menu.append(make_list(filters[idx], site), hr);
            }
        }

        function tower_filter(){
            var manufacturer = ["Manufacturer","Abko", "darkFlash", "Micronics"];
            var type = ["Type", "ATX", "M-ATX", "RTX"]
            var size = ["Size", "Big", "Middle", "Mini"];
            var filters = [manufacturer, type, size];

            var menu = document.getElementById("nav_menu");
            var site = "./Page_Product_List.jsp?part=Tower&";
            for(idx=0; idx<filters.length; idx++){
                var hr = document.createElement("hr");
                menu.append(make_list(filters[idx], site), hr);
            }
        }

        function product_list(){
            var cnt = <%=cnt%>;

            var list_string = "<%=list%>";
            var list_data = list_string.substring(1, list_string.length-1).split(", ");
            
            for(var idx=0; idx<cnt; idx++){
                var product_div = document.createElement("div");
                product_div.className = "product";
                
                var image = document.createElement("img");
                image.src = list_data[idx*4+3];
                image.width = 200;
                image.height = 200;
                image.className = "product_img"

                var name = document.createElement("p");
                product_div.className = "product_name";
                name.innerHTML = list_data[idx*4+1];

                var price = document.createElement("p");
                price.className = "product_price";
                price.innerHTML = list_data[idx*4+2] + "(￦)";

                product_div.append(image, name, price);

                var site = "./Page_Product.jsp?";
                                
                (function(m){
                    product_div.addEventListener("click", function(){
                        location.href= site + "part=<%=part%>&part_id=" + list_data[m*4];
                    },false );
                })(idx);


                document.getElementsByTagName("main")[0].appendChild(product_div);
            }
        }
        
        function move_site(part){
            location.href = "./Page_Product_List.jsp?part="+part;
        }

    </script>
</body>
