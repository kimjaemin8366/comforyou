<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%> 
<%@ page import="java.sql.ResultSet"%> 

<%
    String logged_id = (String) session.getAttribute("logged_id");
    Boolean logged = false;
    Boolean logged_success = false;
    if(logged_id != null){
        logged = true;
    }
    else{

        String input_id = request.getParameter("id");
        String input_pw = request.getParameter("pw");
    
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/comforyou","james","8366");
        
        String sql = "SELECT * FROM users WHERE user_id = ? AND password=?";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1, input_id);
        query.setString(2, input_pw);
        ResultSet result = query.executeQuery();
    
        if(result.next()){
            logged_success = true;
            session.setAttribute("logged_id", input_id);
            
            String nickname = result.getString("nickname");
            session.setAttribute("nickname", nickname);
            String ismanager = result.getString("ismanager");
            session.setAttribute("ismanager", ismanager);
        }
    }
%>

<body>

    <script>

        window.onload= function(){
            var already_logged = <%=logged%>;
            if(already_logged){
                location.href="../../index.jsp";
            }else{
                login_check();
            }
        }

        function login_check(){

            var logged_success = <%=logged_success%>;
            if(logged_success){
                location.href="../home.jsp";
            }else{
                alert("회원정보가 일치하지 않습니다.");
                location.href="./Page_Login.jsp";
            }
        }

    </script>
</body>