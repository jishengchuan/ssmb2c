<%--
  Created by IntelliJ IDEA.
  User: JSC
  Date: 2019/6/11
  Time: 10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<head>
    <link rel="stylesheet" type="text/css" href="${path}/static/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${path}/static/css/style.css">
</head>
<header>
    <div class="top center">
        <div class="left fl">
            <ul>
                <li><a href="${path}/index" >网上商城</a></li>
                <c:forEach items="${requestScope.nav}" var="nav">
                    <li><a href="${path}/list?sid=${nav.sort_id}" >${nav.sort_name}</a></li>
                </c:forEach>
                <li><a href="${path}/list">全部商品</a></li>
                <div class="clear"></div>
            </ul>
        </div>
        <div class="right fr">
            <div class="gouwuche fr"><a href="${path}/shop">购物车</a></div>
            <div class="fr">
                <ul>
                    <c:if test="${sessionScope.user == null}">
                        <li><a href="${path}/login" >登录</a></li>
                        <li>|</li>
                        <li><a href="${path}/register" >注册</a></li>
                    </c:if>
                    <c:if test="${sessionScope.user != null}">
                        <li>${sessionScope.user.users_name}</li>
                        <li>|</li>
                        <li><a href="${path}/address">地址</a></li>
                        <li>|</li>
                        <li><a href="${path}/order">订单</a></li>
                        <li>|</li>
                        <li><a href="${path}/logout">退出登录</a></li>
                    </c:if>
                </ul>
            </div>
            <div class="clear"></div>
        </div>
        <div class="clear"></div>
    </div>
</header>