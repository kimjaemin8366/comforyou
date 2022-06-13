<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %> 
<%@ page import="java.sql.ResultSet" %> 

<%
    String logged_id = (String) session.getAttribute("logged_id");
    Boolean logged = false;
    if(logged_id != null){
        logged = true;
        response.sendRedirect("../home.jsp");
    }
%>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="../../css/login/Login.css">
</head>
<body>
    <main>
        <form id="login_form" action="./Check_Login.jsp" onsubmit="before_login_check()">
            <div id="login_title_div">
                <p id="login_title_text">MEMBER LOGIN</p>
            </div>
            <div class="input_form">
                <input  class="Input_Space" id="ID_Input" name="id" ype="text" placeholder="ID" maxlength="20">
            </div>
            <div class="input_form">
                <input class="Input_Space" id="PW_Input" name="pw" type="password" placeholder="PASSWORD" maxlength="20">
            </div>
            <div id="login_button_space">
                <input type="submit" id="Login_button" value="LOGIN">
            </div>
            <div id="Join_Space">
                <p>Not a Member?</p>
                <p id="Join_link" onclick="location.href='../../page/join/Page_Join.jsp'">JOIN</p>
            </div>
        </form>
    </main>

    <script>

        function before_login_check(){
            var inputs = document.getElementsByClassName("Input_Space");
            var error_message = ["아이디를 입력해주세요", "비밀번호를 입력해주세요"];
            for(var idx=0; idx<=1; idx++){
                if(inputs[idx].value==""){
                    alert(error_message[idx]);
                    event.preventDefault();
                    return;
                }
            }
        }
    </script>
</body>