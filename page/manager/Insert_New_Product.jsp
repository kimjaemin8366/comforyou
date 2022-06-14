<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>


<%
    String logged_id = (String) session.getAttribute("logged_id");
    String nickname = (String) session.getAttribute("nickname");
    Boolean logged = false;
    if(logged_id != null){
        logged = true;
    }
    int sizeLimit = 256*256*20;
    String savePath = request.getRealPath("/image/Product");

    MultipartRequest mr = new MultipartRequest(request, savePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());


    String img = mr.getFilesystemName("img");
    String name = mr.getParameter("name");
    String price = mr.getParameter("price");
    String part = mr.getParameter("part");
    String manufacturer = mr.getParameter("Manufacturer");
    String date = mr.getParameter("date");
    String imagepath = "../../image/Product" + img;

    int cnt = Integer.parseInt(mr.getParameter("cnt"));
    String etc = "[";
    for(int i=1; i<=cnt; i++){
        String property = mr.getParameter("property_"+cnt);
        String content = mr.getParameter("content_"+cnt);

        etc += property;
        etc += ",";
        etc += content;
        if(i!=cnt){
            etc += ",";
        }
    }
    etc+= "]";

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/comforyou","james","8366");
    
    String sql = "INSERT INTO component(part_name, part_type, part_price, nickname, imagepath) VALUES (?,?,?,?,?)";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, name);
    query.setString(2, part);
    query.setString(3, price);
    query.setString(4, nickname);
    query.setString(5, imagepath);

    query.executeUpdate();

    String sql2 = "SELECT part_id FROM component WHERE imagepath=?";
    PreparedStatement query2 = connect.prepareStatement(sql2);
    query2.setString(1, imagepath);

    ResultSet result = query2.executeQuery();

    int part_id= 0;
    if(result.next()){
        part_id = result.getInt("part_id");
    }

    Boolean success = false;

    if(part.equals("CPU")){
        String core = mr.getParameter("core_value");
        String socket = mr.getParameter("socket_value");
        String sql3 = "INSERT INTO component_cpu(part_id, release_date, manufacturer, core, socket, etc_option) VALUES (?,?,?,?,?,?)";
        PreparedStatement query3 = connect.prepareStatement(sql3);
        query3.setInt(1, part_id);
        query3.setString(2, date);
        query3.setString(3, manufacturer);
        query3.setString(4, core);
        query3.setString(5, socket);
        query3.setString(6, etc);
        query3.executeUpdate();
        
        success= true;
    }else if(part.equals("Mainboard")){
        String usefor = mr.getParameter("usefor_value");
        String socket = mr.getParameter("socket_value");
        String sql3 = "INSERT INTO component_mainboard(part_id, release_date, manufacturer, usefor, socket, etc_option) VALUES (?,?,?,?,?,?)";
        PreparedStatement query3 = connect.prepareStatement(sql3);
        query3.setInt(1, part_id);
        query3.setString(2, date);
        query3.setString(3, manufacturer);
        query3.setString(4, usefor);
        query3.setString(5, socket);
        query3.setString(6, etc);
        query3.executeUpdate();
        success= true;

    }else if(part.equals("GPU")){
        String chipset = mr.getParameter("chipset_value");
        String sql3 = "INSERT INTO component_gpu(part_id, release_date, manufacturer, chipset, etc_option) VALUES (?,?,?,?,?)";
        PreparedStatement query3 = connect.prepareStatement(sql3);
        query3.setInt(1, part_id);
        query3.setString(2, date);
        query3.setString(3, manufacturer);
        query3.setString(4, chipset);
        query3.setString(5, etc);
        query3.executeUpdate();
        success= true;

    }else if(part.equals("RAM")){
        String size = mr.getParameter("size_value");
        String ddr = mr.getParameter("ddr_value");
        String sql3 = "INSERT INTO component_ram(part_id, release_date, manufacturer, size, ddr, etc_option) VALUES (?,?,?,?,?,?)";
        PreparedStatement query3 = connect.prepareStatement(sql3);
        query3.setInt(1, part_id);
        query3.setString(2, date);
        query3.setString(3, manufacturer);
        query3.setString(4, size);
        query3.setString(5, ddr);
        query3.setString(6, etc);
        query3.executeUpdate();
        success= true;

    }else if(part.equals("Disk")){
        String type = mr.getParameter("type_value");
        String size = mr.getParameter("size_value");
        String interf = mr.getParameter("interface_value");
        String rpm = mr.getParameter("rpm_value");
        
        String sql3 = "INSERT INTO component_disk(part_id, release_date, manufacturer, type, size, interface, rpm, etc_option) VALUES (?,?,?,?,?,?,?,?)";
        PreparedStatement query3 = connect.prepareStatement(sql3);
        query3.setInt(1, part_id);
        query3.setString(2, date);
        query3.setString(3, manufacturer);
        query3.setString(4, type);
        query3.setString(5, size);
        query3.setString(6, interf);
        query3.setString(7, rpm);
        query3.setString(8, etc);
        query3.executeUpdate();
        success= true;

    }else if(part.equals("Cooler")){
        String socket = mr.getParameter("socket_value");
        String sql3 = "INSERT INTO component_cooler(part_id, release_date, manufacturer, socket, etc_option) VALUES (?,?,?,?,?)";
        PreparedStatement query3 = connect.prepareStatement(sql3);
        query3.setInt(1, part_id);
        query3.setString(2, date);
        query3.setString(3, manufacturer);
        query3.setString(4, socket);
        query3.setString(5, etc);
        query3.executeUpdate();
        success= true;

    }else if(part.equals("Power")){
        String type = mr.getParameter("type_value");
        String power = mr.getParameter("power_value");
        String sql3 = "INSERT INTO component_power(part_id, release_date, manufacturer, type, power, etc_option) VALUES (?,?,?,?,?,?)";
        PreparedStatement query3 = connect.prepareStatement(sql3);
        query3.setInt(1, part_id);
        query3.setString(2, date);
        query3.setString(3, manufacturer);
        query3.setString(4, type);
        query3.setString(5, power);
        query3.setString(6, etc);
        query3.executeUpdate();
        success= true;      

    }else if(part.equals("Tower")){
        String type = mr.getParameter("type_value");
        String size = mr.getParameter("size_value");
        String sql3 = "INSERT INTO component_ram(part_id, release_date, manufacturer, type, size, etc_option) VALUES (?,?,?,?,?,?)";
        PreparedStatement query3 = connect.prepareStatement(sql3);
        query3.setInt(1, part_id);
        query3.setString(2, date);
        query3.setString(3, manufacturer);
        query3.setString(4, type);
        query3.setString(5, size);
        query3.setString(6, etc);
        query3.executeUpdate();
        success= true;
    }

    
%>

<body>
    <script>
       window.onload= function(){
           if(<%=success%>){
                alert("success");
                location.href= "./Page_Manager.jsp";
           }
       }
    </script>
</body>


