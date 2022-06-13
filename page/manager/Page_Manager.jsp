<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.util.Vector"%>

<%
    String logged_id = (String) session.getAttribute("logged_id");
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
    String filter = request.getParameter("filter");
    if(filter==null){
        filter="";
    }

    Vector<String> list = new Vector<String>();
    int cnt = 0;
    if(filter.equals("post_product")){
        String sql = "SELECT part_id,part_type, part_name, post_date FROM component ORDER BY part_id DESC";
        PreparedStatement query = connect.prepareStatement(sql);

        ResultSet result = query.executeQuery();

        while(result.next()){
            for(int idx=1; idx<=4; idx++){
                list.add(result.getString(idx));
            }
            cnt++;
        }
    }
    else if(filter.equals("post_forum")){
        String sql = "SELECT post_id, post_content, nickname, post_date FROM posts ORDER BY post_date DESC";
        PreparedStatement query = connect.prepareStatement(sql);

        ResultSet result = query.executeQuery();

        while(result.next()){
            for(int idx=1; idx<=4; idx++){
                list.add(result.getString(idx));
            }
            cnt++;
        }
    }
    else if(filter.equals("comment_product")){
        String sql = "SELECT part_id, comment_content, nickname, comment_date FROM component_comments ORDER BY comment_date DESC";
        PreparedStatement query = connect.prepareStatement(sql);

        ResultSet result = query.executeQuery();

        while(result.next()){
            for(int idx=1; idx<=4; idx++){
                list.add(result.getString(idx));
            }
            cnt++;
        }
    }
    else if(filter.equals("comment_forum")){
        String sql = "SELECT post_id, comment_content, nickname, comment_date FROM posts_comments ORDER BY comment_date DESC";
        PreparedStatement query = connect.prepareStatement(sql);

        ResultSet result = query.executeQuery();

        while(result.next()){
            for(int idx=1; idx<=5; idx++){
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
        <div class="nav_filter_list">
            <div class="nav_filter_criteria">Posts</div>
            <div class="nav_filter_name">Products</div>
            <div class="nav_filter_name">Forum</div>
        </div>
        <hr>
        <div class="nav_filter_list">
            <div class="nav_filter_criteria">Comments</div>
            <div class="nav_filter_name">Products</div>
            <div class="nav_filter_name">Forum</div>
        </div>
        <hr>
        <div class="nav_filter_list">
            <div class="nav_filter_name" onclick="location.href='./Page_New_Product.jsp'">Post New Product</div>
        </div>
    </nav>
    <main>
        <table>
            <tr>
                <th>Type</th>
                <th>Product_id</th>
                <th style="width:80%"colspan=2>Name</th>
                <th>Date</th>
            </tr>
            <tr>
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
                    <input type="button" id="2" onclick="delete_list()" value="삭제">
                </td>
                <td>
                    2022.03.22
                </td>
            </tr>
        </table>
    </main>

    <script>
        function make_list(){
            var new_tr = document.createElement("tr");
            var cnt = <%=cnt%>;

            var list_string = "<%=list%>";
            var list_data = list_string.substring(1, list_string.length-1).split(", ");

            for(var idx=0; idx<cnt; idx++){

            }
        }
    </script>

</body>
