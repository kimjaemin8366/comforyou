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

    Vector<String> post_list = new Vector<String>();
    int post_id = Integer.parseInt(request.getParameter("post_id"));

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/comforyou","james","8366");


    String post_sql = "SELECT post_id, post_title, nickname, post_content FROM posts WHERE post_id=?";
    PreparedStatement post_query = connect.prepareStatement(post_sql);
    post_query.setInt(1, post_id);

    ResultSet result = post_query.executeQuery();

    if(result.next()){
        for(int idx=1; idx<=4; idx++){
            post_list.add(result.getString(idx));
        }
    }

    Vector<String> comment_list = new Vector<String>();
    String comment_sql = "SELECT comment_id, comment_content, nickname, comment_date FROM posts_comments WHERE post_id = ?";
    PreparedStatement comment_query = connect.prepareStatement(comment_sql);
    comment_query.setInt(1, post_id);
    ResultSet comment_result = comment_query.executeQuery();
    int comment_cnt = 0;
    while(comment_result.next()){
        for(int idx=1; idx<=4; idx++){
            comment_list.add(comment_result.getString(idx));
        }
        comment_cnt += 1;
    }

    
%>


<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet", type="text/css" href="../../css/Header.css">
    <link rel="stylesheet", type="text/css" href="../../css/forum/post.css">
    <title>Post</title>
</head>
<body>
    <header>
        <div id="homepage">
            <input class="header_option_button" type="button" value="COM for you" onclick="location.href='../home.jsp'">
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
        <input class="nav_button" type="button" value="Disk"  onclick="move_site(this.value)">
        <input class="nav_button" type="button" value="Cooler"  onclick="move_site(this.value)">
        <input class="nav_button" type="button" value="Power"  onclick="move_site(this.value)">
        <input class="nav_button" type="button" value="Tower"  onclick="move_site(this.value)">
        <input class="nav_button" type="button" value="Forum" onclick="location.href='../Forum/Post_List.jsp'">
        <input class="nav_button" type="button" value="Manager" onclick="move_manager_page()">
    </nav>

    <main>
        <div id="post_button_space">
            <input type="button" class="post_button" value="Modify" onclick="location.href='./Page_Writing_Post.jsp?post_id=<%=post_id%>'">
            <input type="button" class="post_button" value="Delete" onclick="before_delete()">
        </div>
        <table id="post_table">
            <input type="hidden" id="post_id">
            <tr id="tr_info">
                <td id="title"></td>
                <td id="writer"></td>
            </tr>
            <tr id="tr_content">
                <td colspan="2">
                    <textarea id="post_content" rows="50" disabled></textarea>
                </td>
            </tr>
        </table>
        <div id="Comments_Space">
            <form action="Insert_Comment.jsp" id="Comments_Input" onsubmit="before_insert()">
                <input type="hidden" name="post_id" value="">
                <textarea id="Comments_Input_text" name="comment" placeholder="댓글을 입력해주세요" cols="10"></textarea>
                <input id="Comments_Input_button" type="submit" value="제출">
            </form>

            <div id="Comment_list">
                <table id="Comment_table">
                    <!-- <tr>
                        <td class="Comment_content">
                            <textarea class="content">안녕하세요.</textarea>
                        </td>
                        <td class="Comment_info">
                            <p class="Comment_writer">김재민</p>
                            <p class="Comment_date">2022.12.27 10:00:00</p>
                        </td>
                        <td>
                            <input type="button" class="Comment_modify" value="수정" onclick="delete_comment()">
                            <input type="button" class="Comment_delete" value="삭제" onclick="delete_comment()">
                        </td>
                    </tr> -->
                </table>

            </div>
        </div>
        <footer style="height:100px"></footer>
    </main>

    <script>
        window.onload= function(){
            if_logged();
            show_post();
            make_comment_list();
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

        function show_post(){
            var post_string = "<%=post_list%>";
            var post_data = post_string.substring(1, post_string.length-1).split(", ");

            var nickname= "<%=nickname%>";
            var ismanager= "<%=ismanager%>";
            document.getElementById("post_id").value = post_data[0];
            document.getElementById("title").innerHTML = post_data[1];
            document.getElementById("writer").innerHTML = post_data[2];
            document.getElementById("post_content").innerHTML = post_data[3].replaceAll("<br>","\r\n");
            document.getElementsByName("post_id")[0].value = post_data[0];
            if(nickname==post_data[2] || ismanager==1){
                for(var idx=0; idx<2; idx++){
                    document.getElementById("post_button_space").style.visibility="visible";
                }
            }

        }

        function before_delete(){
            if(confirm("게시물을 삭제하시겠습니까?")){
                location.href='./Delete_Post.jsp?post_id=<%=post_id%>'
            }
        }

        function make_comment_list(){
            var comment_list_string = "<%=comment_list%>";
            var comment_list_data = comment_list_string.substring(1, comment_list_string.length-1).split(", ");
            var cnt = <%=comment_cnt%>;
            var nickname = "<%=nickname%>";
            var ismanager = "<%=ismanager%>";
            var table = document.getElementById("Comment_table");
            
            for(var idx=0; idx<cnt; idx++){
                var new_tr = document.createElement("tr");
                var content_td = document.createElement("td");
                content_td.className="Comment_content_space";
                var textarea = document.createElement("textarea");
                textarea.className="Comment_content";
                comment_list_data[idx*4+1] = comment_list_data[idx*4+1].replaceAll("<br>","\r\n");
                textarea.value = comment_list_data[idx*4+1];
                textarea.setAttribute("rows","4");
                textarea.setAttribute("disabled", true);
                content_td.appendChild(textarea);
                
                var info_td = document.createElement("td");
                info_td.className = "Comment_info";
                var writer_p = document.createElement("p");
                writer_p.className="Comment_writer";
                writer_p.innerHTML = comment_list_data[idx*4+2];
                var date_p = document.createElement("p");
                date_p.className = "Comment_date";
                date_p.innerHTML = comment_list_data[idx*4+3];
                info_td.append(writer_p, date_p);

                var button_td = document.createElement("td");
                var delete_button = document.createElement("input");
                delete_button.type="button";
                delete_button.className="Comment_delete";
                delete_button.value = "삭제";
                (function(m){
                    delete_button.addEventListener("click", function(){
                        delete_comment(comment_list_data[m*4]);
                    },false );
                })(idx);

                var modify_button = document.createElement("input");
                modify_button.type="button";
                modify_button.className="Comment_modify";
                modify_button.value = "수정";
                (function(m){
                    modify_button.addEventListener("click", function(){
                        modify_comment_ready(m);
                    },false );
                })(idx);


                var modify_confirm_button = document.createElement("input");
                modify_confirm_button.type="button";
                modify_confirm_button.className="Comment_modify_confirm";
                modify_confirm_button.value = "수정 완료";
                (function(m){
                    modify_confirm_button.addEventListener("click", function(){
                        modify_comment_confirm(comment_list_data[m*4], m);
                    },false );
                })(idx);

                var modify_cancel_button = document.createElement("input");
                modify_cancel_button.type="button";
                modify_cancel_button.className="Comment_modify_cancel";
                modify_cancel_button.value = "수정 취소";
                (function(m){
                    modify_cancel_button.addEventListener("click", function(){
                        modify_comment_cancel(comment_list_data[m*4+1], m);
                    },false );
                })(idx);

                if(nickname==comment_list_data[idx*4+2] || ismanager=="1"){
                    button_td.style.visibility = "visible";
                }else{
                    button_td.style.visibility = "hidden";
                }

                button_td.append(modify_button, delete_button, modify_confirm_button, modify_cancel_button);
                new_tr.append(content_td, info_td, button_td);
    
                table.appendChild(new_tr);
            }
        }

        function before_insert(){
            var content = document.getElementById("Comments_Input_text").value;
            var nickname = "<%=nickname%>";
            if(nickname=="null" || nickname==""){
                alert("로그인해주세요.");
                event.preventDefault();
                return;
            }
            if(content==""){
                alert("댓글을 입력하세요.");
                event.preventDefault();
                return;
            }
        }

        function delete_comment(comment_id){
            if(confirm("삭제하시겠습니까?")){
                location.href="./Delete_Comment.jsp?post_id=<%=post_id%>&comment_id="+comment_id;
            }
        }

        function modify_comment_ready(index){
            document.getElementsByClassName("Comment_content")[index].removeAttribute("disabled");

            document.getElementsByClassName("Comment_modify")[index].style.display = "none";
            document.getElementsByClassName("Comment_delete")[index].style.display = "none";
            document.getElementsByClassName("Comment_modify_confirm")[index].style.display = "inline";
            document.getElementsByClassName("Comment_modify_cancel")[index].style.display = "inline";
        }

        function modify_comment_cancel(comment, index){
            document.getElementsByClassName("Comment_content")[index].value = comment;
            document.getElementsByClassName("Comment_content")[index].setAttribute("disabled", true);

            document.getElementsByClassName("Comment_modify")[index].style.display = "inline";
            document.getElementsByClassName("Comment_delete")[index].style.display = "inline";
            document.getElementsByClassName("Comment_modify_confirm")[index].style.display = "none";
            document.getElementsByClassName("Comment_modify_cancel")[index].style.display = "none";
        }

        function modify_comment_confirm(comment_id, index){
            var change_content = document.getElementsByClassName("Comment_content")[index].value;
            change_content = change_content.replace(/(\n|\r\n)/g, "<br>");
            location.href= "./Modify_Comment.jsp?post_id=<%=post_id%>&comment_id="+comment_id + "&comment_content="+change_content;
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
            location.href = "../Products/Page_Product_List.jsp?part="+part;
        }
    </script>
</body>
