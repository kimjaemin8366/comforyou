<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.io.*" %>
<%@ page import="java.sql.ResultSet" %> 

<%

    Boolean join_success = true;

    String id = (String) request.getParameter("id");
    String nick = (String) request.getParameter("nickname");
    String pw = (String) request.getParameter("password");
    if(id=="" || id==null || id.length()>20 || pw=="" || pw==null || pw.length()>20 || nick=="" || nick==null || nick.length()>10 ){
        join_success = false;
    }

    if(join_success){
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/comforyou","james","8366");
        
        String sql = "INSERT INTO users(user_id, nickname, password) VALUES (?,?,?)";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1, id);
        query.setString(2, nick);
        query.setString(3, pw);
    
        query.executeUpdate();
    }

%>


<body>
    <script>
        window.onload = function(){
            var join_success = <%=join_success%>;

            if(join_success){
                alert("환영합니다.");
                location.href="../../index.jsp";
            }else{
                alert("가입 내용 오류");
                location.href="./Page_Join.jsp";
            }
        }
    </script>
</body>