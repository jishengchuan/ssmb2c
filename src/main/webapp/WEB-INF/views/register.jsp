<%--
  Created by IntelliJ IDEA.
  User: JSC
  Date: 2019/6/14
  Time: 20:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户注册</title>
    <link rel="stylesheet" type="text/css" href="${path}/static/css/login.css">
    <link rel="stylesheet" href="${path}/static/css/bootstrap.min.css"/>
    <script type="text/javascript" src="${path}/static/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#submit").click(function () {
                //将表单序列化
                var data = $("form").serialize();
                //发起请求，完成登录
                $.ajax({
                    url:"${pageContext.request.contextPath}/register",
                    type:"post",
                    data:data,
                    success:function (res) {
                        console.log(res);
                        if(res.success){
                            //成功
                            location = "${path}/index";
                        }else{
                            //失败
                            alert(res.error);
                        }
                    }
                });
                return false;
            });
            //获取验证码
            $("#getcodes").click(function () {
                var tel = $("input[name='tel']").val();
                console.log(tel);
                if("" === tel){
                    alert("请输入手机号")
                    return false;
                }
                $.ajax({
                    url:"${path}/getCodes?tel="+tel,
                    type:"get",
                    success:function (res) {
                        console.log(res);
                        if (res.success){
                            alert("已发送验证码");
                        }
                    }
                });
                return false;
            });
            //判断用户名
            $("input[name='username']").blur(function () {
                var username = $(this).val()
                $.ajax({
                    url:"${pageContext.request.contextPath}/checkUsername?username="+username,
                    type:"get",
                    success:function (res) {
                        console.log(res);
                        if (res.result){
                            $("#username").text("可以使用");
                        } else{
                            $("#username").text("用户名已存在");
                        }
                    }
                });
            });
            //判断密码
            $("input[name='repassword']").blur(function () {
                var password = $("input[name='password']").val();
                var repassword = $("input[name='repassword']").val();
                if (password != repassword){
                    $("#repassword").text("两次密码不一致");
                }else{
                    $("#repassword").text("两次密码一致");
                }
            });
        });
    </script>
</head>
<body>
<form method="post" action="#">
    <div class="regist">
        <div class="regist_center">
            <div class="regist_top">
                <div class="left fl">用户注册</div>
                <div class="right fr"><a href="${path}/index" target="_self">网上商城</a></div>
                <div class="clear"></div>
                <div class="xian center"></div>
            </div>
            <div class="regist_main center">
                <div class="username">用&nbsp;&nbsp;户&nbsp;&nbsp;名:&nbsp;&nbsp;<input class="shurukuang" type="text" name="username" placeholder="请输入你的用户名"/><span id="username">请不要输入汉字</span></div>
                <div class="username">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码:&nbsp;&nbsp;<input class="shurukuang" type="password" name="password" placeholder="请输入你的密码"/><span id="password">请输入你的密码</span></div>

                <div class="username">确认密码:&nbsp;&nbsp;<input class="shurukuang" type="password" name="repassword" placeholder="请确认你的密码"/><span id="repassword">两次密码要输入一致哦</span></div>
                <div class="username">手&nbsp;&nbsp;机&nbsp;&nbsp;号:&nbsp;&nbsp;<input class="shurukuang" type="text" name="tel" placeholder="请填写正确的手机号"/><span id="tel">填写下手机号吧，方便我们联系您！</span></div>
                <div class="username">
                    <div class="left fl">验&nbsp;&nbsp;证&nbsp;&nbsp;码:&nbsp;&nbsp;<input class="codes" type="text" name="codes" placeholder="请输入验证码"/></div>
                    <div class="right fl"><input id="getcodes" class="btn btn-sm btn-warning" type="submit" value="获取验证码"></div>
                    <div class="clear"></div>
                </div>
            </div>
            <div class="regist_submit">
                <input class="submit" type="submit" id="submit" name="submit" value="立即注册" >
            </div>

        </div>
    </div>
</form>
</body>
</html>