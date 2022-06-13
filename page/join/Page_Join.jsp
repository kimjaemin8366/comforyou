<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../../css/join/Join.css">
    <title>JOIN</title>
</head>
<body>
    <main>
        <form id="join_form" name="join_form" action="Input_Join.jsp" onsubmit="before_join_input()">
            <div id="Join_title_div">
                <p id="Join_title_text">MEMBER JOIN</p>
            </div>
            <div id="Input_div">
                <div class="Input_Form_withButton">
                    <input id="ID_Input" class="Input_Space" type="text" name="id" placeholder="ID, 최대 20글자" maxlength="20">
                    <div class="Check_button_space">
                        <input class="duplicate_check_button" type="button" value="중복 확인" onclick="id_duplicate_check()">
                    </div>
                    <input type="hidden" id="id_duplicate_checked" name="id_check_duplication" value="NoCheck">
                </div>
                <div class="Input_Form_withButton">
                    <input id="Nick_Input" class="Input_Space" type="text" name="nickname" placeholder="Nickname, 최대 10글자" maxlength="10">
                    <div class="Check_button_space">
                        <input class="Duplicate_check_button" type="button" value="중복 확인" onclick="nick_duplicate_check()">
                    </div>
                    <input type="hidden" id="nick_duplicate_checked" name="nick_check_duplication" value="NoCheck">
                </div>
                <div class="Input_Form">
                    <input id="PW_Input" class="Input_Space" type="password" name="password" placeholder="Password, 최대 20글자" maxlength="20">
                </div>
                <div class="Input_Form">
                    <input id="PW_Check_Input" class="Input_Space" type="password" name="password_check" placeholder="Password 확인, 최대 20글자" maxlength="20" oninput="password_same_check()">
                    <p id="password_same_check_p"></p>
                </div>
            </div>
            <div id="Join_button_space">
                <input type="submit" id="Join_button" value="JOIN">
            </div>
        </form>
    </main>

    <script>
        function password_same_check(){
            var pw = document.getElementById("PW_Input").value;
            var pw_confirm = document.getElementById("PW_Check_Input").value;
            var result = document.getElementById("password_same_check_p");
            if(pw!=pw_confirm){
                result.innerHTML = "비밀번호가 일치하지 않습니다.";
            }else{
                result.innerHTML = "비밀번호가 일치합니다.";
            }
        }

        function before_join_input(){
            var inputs = document.getElementsByClassName("Input_Space");
            var error_message = ["아이디를 입력해주세요.", "비밀번호를 입력해주세요.", "비밀번호 확인을 입력해주세요.","별명을 입력해주세요."];
            var pw = document.getElementById("PW_Input").value;
            var pw_confirm = document.getElementById("PW_Check_Input").value;
            var id_duplicate_checked = document.getElementById("id_duplicate_checked").value;
            var nick_duplicate_checked = document.getElementById("nick_duplicate_checked").value;

            for(var idx=0; idx<4; idx++){
                if(inputs[idx].value == ""){
                    alert(error_message[idx]);
                    event.preventDefault();
                    return;
                }
            }

            if(pw!=pw_confirm){
                alert("비밀번호가 일치하지 않습니다.");
                event.preventDefault();
                return;
            }

            if(id_duplicate_checked=="NoCheck"){
                alert("아이디 중복확인을 해주세요.");
                event.preventDefault();
                return;
            }
            
            if(nick_duplicate_checked=="NoCheck"){
                alert("별명 중복확인을 해주세요.");
                event.preventDefault();
                return;
            }
            document.getElementById("ID_Input").removeAttribute("disabled");
            document.getElementById("Nick_Input").removeAttribute("disabled");
        }

        function id_duplicate_check(){
            
            var input_id = document.getElementById("ID_Input").value;
            if(input_id == ""){
                alert("아이디를 입력해주세요.");
            }else{
                window.open("./Popup_ID_Duplicate_Check.jsp?user_id="+ input_id, "아이디 중복 확인", "width= 450px, height= 450px, resize=off");
            }
        }

        function nick_duplicate_check(){
            var input_nick = document.getElementById("Nick_Input").value;
            if(input_nick == ""){
                alert("닉네임을 입력해주세요.");
            }else{
                window.open("./Popup_Nick_Duplicate_Check.jsp?nickname="+ input_nick, "닉네임 중복 확인", "width= 450px, height= 450px, resize=off");
            }
        }

    </script>
</body>