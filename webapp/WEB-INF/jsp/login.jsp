<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>발주 재고조사 시스템</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <link rel="stylesheet" type="text/css" href="css/orderinven.css" />
        <style>
            html,
            body {
                background-color: #232F3F;
                width: 100%;
                height: 100%;
                color: #D7BB99;
            }
        </style>
        <script type="text/javascript">
            $(document).ready(function() {
                $('#submitBtn').click(function() {
                    var userId  = $('#userId' ).val() ;
                    var userPwd = $('#userPwd').val() ;

                    if(userId == "" || userPwd == ""){
                        alert('아이디와 비밀번호를 입력해 주세요');
                    }
                    else
                    {
                        submitCheck();
                    }
                });

                $('#userId').keydown(function(key) {
                    if(key.key == 'Enter' || key.keyCode == 13) {
                        $('#submitBtn').click() ;
                    }
                });

                $('#userPwd').keydown(function(key) {
                    if(key.key == 'Enter' || key.keyCode == 13) {
                        $('#submitBtn').click() ;
                    }
                });
            });

            function submitCheck() {
                var userId  = $('#userId' ).val() ;
                var userPwd = $('#userPwd').val() ;

                $.ajax({
                    type: "post",
                    url: "/logincheck",
                    dataType: "text",
                    async: "false",
                    data: {user_id : userId, pwd : userPwd},
                    success: function(data) {
                        if(data == "false")
                        {
                            alert('잘못된 아이디이거나, 비밀번호가 틀렸습니다.');
                        }
                        else
                        {
                            //location.href="/mainmenu" ;
                            pageGoPost({
                                url: "/mainmenu",	//이동할 페이지
                                target: "_self",
                                vals: [				//전달할 인수들
                                    ["userId", userId]
                                ]
                            });
                        }                        
                        
                    },
                    error: function(request, status, error) {
                        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                    }
                });
            }

            function pageGoPost(d){
                var insdoc = "";
                
                for (var i = 0; i < d.vals.length; i++) {
                insdoc+= "<input type='hidden' name='"+ d.vals[i][0] +"' value='"+ d.vals[i][1] +"'>";
                }
                
                var goform = $("<form>", {
                method: "post",
                action: d.url,
                target: d.target,
                html: insdoc
                }).appendTo("body");
                
                goform.submit();
            }

        </script>
    </head>
    <body>
        <div style="display:table; width:100%; height:100%;">
            <div style="display:table-cell; text-align:center; vertical-align:middle;">
                <form id="loginForm" method="post">
                    <header>
                        <h2>발주 재고조사 시스템</h2>
                    </header>
                    <div align="center">
                        <table id="loginTable" >
                            <tr align="center">
                                <td>
                                    <div class="input-box">
                                        <input id="userId" type="text" name="userId" placeholder="아이디">
                                        <label for="userId">아이디</label>
                                    </div>
                                </td>
                            </tr>
                            <tr align="center">
                                <td>
                                    <div class="input-box">
                                        <input id="userPwd" type="password" name="userPwd" placeholder="비밀번호">
                                        <label for="userPwd">비밀번호</label>
                                    </div>
                                </td>                        
                            </tr>
                            <tr align="center">
                                <td>
                                    <input class="loginbtn" type="button" value="로그인" id="submitBtn">
                                </td>                        
                            </tr>
                        </table>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
