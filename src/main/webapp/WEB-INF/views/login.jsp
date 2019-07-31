<%--
  Created by IntelliJ IDEA.
  User: JSC
  Date: 2019/5/31
  Time: 9:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>用户登录</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#submit").click(function () {
                //将表单序列化
                var data = $("form").serialize();
                //发起请求，完成登录
                $.ajax({
                    url:"${pageContext.request.contextPath}/login",
                    type:"post",
                    data:data,
                    success:function (res) {
                        if(res.error){
                            //失败
                            alert(res.error);
                        }else{
                            if (res.uri != null){
                                location = "${pageContext.request.contextPath}"+res.uri;
                            }else{
                                location = "${pageContext.request.contextPath}/index";
                            }
                        }
                    }
                });
                return false;
            });
            $("#register").click(function () {
                location = "${pageContext.request.contextPath}/register";
                return false;
            });
            $("#find").click(function () {
               location = "${path}/find";
               return false;
            });
        });
    </script>
</head>
<body class="container">
    <div class="container">
        <div class="row-fluid">
            <div class="span12">
                <h2>&nbsp;</h2>
                <p>&nbsp;</p>
            </div>
        </div>
        <div class="row clearfix">
        <div class="col-md-12 column">
            <div id="fengmian" class="jumbotron" style="background-image: url('https://cdn.cnbj1.fds.api.mi-img.com/mi-mall/f838fdcd77715410b441f2f56d8f10cd.jpg')">
                <h1>
                    Hello, world!
                </h1>
                <p>
                    Raise your words, not your voice. It is rain that makes the flowers grow, not thunder.
                </p>
                <p>
                    <a class="btn btn-warning btn-large" href="${path}/index">商城官网</a>
                </p>
            </div>
            <div class="row clearfix">
                <div class="col-md-6 column">
                    <h3>用户登录</h3>
                    <blockquote>
                        <p>
                            It's not the travelling, it's the arriving that matters.
                        </p> <small>Someone famous <cite>Source Title</cite></small>
                    </blockquote>
                    <div class="progress active progress-striped">
                        <div class="progress-bar progress-success">
                        </div>
                    </div>
                </div>
                <div class="col-md-6 column">
                    <form role="form">
                        <form role="form" action="${pageContext.request.contextPath}/login" method="post">
                            <c:if test="${param.uri != null}">
                                <input type="hidden" name="uri" value="${param.uri}">
                            </c:if>
                            <div class="form-group">
                                <label for="username">用户名</label>
                                <input type="text" class="form-control" name="username" id="username" value="tom"
                                       placeholder="请输入用户名">
                                <p></p>
                            </div>
                            <div class="form-group">
                                <label for="password">密码</label>
                                <input type="text" class="form-control" name="password" id="password" value="123456"
                                       placeholder="请输入密码">
                                <p></p>
                            </div>
                            <input id="submit" class="btn btn-warning" type="submit" value="&nbsp;&nbsp;&nbsp;登录&nbsp;&nbsp;&nbsp;">
                            <input id="register" class="btn btn-warning" type="submit" value="&nbsp;&nbsp;&nbsp;注册&nbsp;&nbsp;&nbsp;">
                            <input id="find" class="btn btn-warning" type="submit" value="找回密码">
                        </form>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
