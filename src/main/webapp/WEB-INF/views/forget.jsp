<%--
  Created by IntelliJ IDEA.
  User: JSC
  Date: 2019/6/24
  Time: 18:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="utf-8" />
    <title>找回密码</title>
    <link rel="stylesheet" type="text/css" href="${path}/static/css/public.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/static/css/proList.css" />
    <link rel="stylesheet" type="text/css" href="${path}/static/css/forget.css" />
    <link rel="stylesheet" type="text/css" href="${path}/static/css/style.css">
    <style type="text/css">
        form.one input[type="button"]{
            background: #c10000;
        }
        .forCon form input[type="password"]{
            border:1px solid #DBDBDB;
            width:250px;
            padding-left:10px;
        }
    </style>
    <script type="text/javascript" src="${path}/static/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $(".next").click(function(){
                var tel = $("#tel").val();
                $.ajax({
                    url:"${path}/find",
                    type:"post",
                    data:{
                        tel:tel,
                    },
                    success:function (res) {
                        console.log(res)
                        if (res.success){
                            $(".two").show();
                            $(".one").hide();
                            $(".forCon ul li").eq(1).addClass("on").siblings("li").removeClass("on");
                        }else{
                            alert("没有此手机号")
                        }
                    }
                })
            });
            $(".getcode").click(function () {
                $.ajax({
                    url:"${path}/getCodes?getcode=1",
                    type:"get",
                    success:function (res) {
                        console.log(res);
                        if (res.success){
                            alert("已发送验证码");
                        }
                    }
                });
            });

            $(".next1").click(function () {
                var codes = $("#code").val();
                console.log(codes);
                $.ajax({
                    url:"${path}/find",
                    type:"post",
                    data:{
                        code:codes,
                    },
                    success:function (res) {
                        console.log(res)
                        if (res.success){
                            $(".three").show();
                            $(".two").hide();
                            $(".forCon ul li").eq(1).addClass("on").siblings("li").removeClass("on");
                        }else{
                            alert("验证码错误")
                        }
                    }
                })
            });
            $(".next2").click(function () {
                var p1 = $("#p1").val();
                var p2 = $("#p2").val()
                $.ajax({
                    url:"${path}/find",
                    type:"post",
                    data:{
                        p1:p1,
                        p2:p2,
                    },
                    success:function (res) {
                        console.log(res)
                        if (res){
                            location = "${path}/index";
                        }else{
                            alert("两次密码不一样");
                        }
                    }
                })
            })
        })

    </script>
</head>
<body>
<!----------------------------------------order------------------>
<div class="order cart">
    <!-----------------logo------------------->
    <div class="logo">
        <div class="banner_x center">
            <a href="${path}/index" ><div class="logo fl"></div></a>
        </div>
    </div>
    <div class="forCon">
        <p>安全设置-找回密码</p>
        <ul>
            <li class="on"><span>01/</span>输入手机号</li>
            <li><span>02/</span>验证信息</li>
            <li><span>03/</span>重置密码</li>
        </ul>
        <div class="formCon">
            <!--步骤1-->
            <form action="#" method="post" class="one">
                <input type="text" id="tel" value="" placeholder="请输入手机号"><label>请输入手机号</label><br />
                <input type="button" value="下一步" class="next">
            </form>
            <!--步骤2-->
            <form action="#" method="post" class="two">
                <input type="hidden" id="tel1" value="${sessionScope.tel}">
                <input type="text" id="code" value="" placeholder="请输入验证码"><label>请输入验证码</label><br />
                <p class="tip">验证码已发送至你的手机号，请填写完成验证</p>
                <input type="button" value="获取验证码" class="getcode">
                <input type="button" value="确认" class="next1">
            </form>
            <!--步骤3-->
            <form action="#" method="post" class="three">
                <label>新密码：</label><input type="text" id="p1" value=""><br />
                <label>确认密码：</label><input type="text" id="p2" value=""><br />
                <input type="button" value="完成" class="next2">
            </form>
        </div>
    </div>
</div>
</body>
</html>

