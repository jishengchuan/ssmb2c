<%--
  Created by IntelliJ IDEA.
  User: JSC
  Date: 2019/6/6
  Time: 10:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="UTF-8">
    <title>网上商城</title>
    <link rel="stylesheet" type="text/css" href="${path}/static/css/style.css">
    <link rel="stylesheet" href="${path}/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="${path}/static/css/reset.css">
    <script type="text/javascript" src="${path}/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="${path}/static/js/bootstrap.min.js"></script>
</head>
<body>
<!-- start header 导入_header.jsp界面-->
<%@include file="_header.jsp"%>
<!--end header -->

<!-- start banner_x -->
<div class="banner_x center">
    <a href="${path}/index" ><div class="logo fl"></div></a>
    <%--<a href=""><div class="ad_top fl"></div></a>--%>
    <div class="nav fl">
        <ul>
            <li><a href="${path}/index" >首页</a></li>
            <c:forEach items="${requestScope.brands}" var="brand">
                <li><a href="${path}/list?<c:if test="${param.sid != null}">sid=${param.sid}&</c:if>bid=${brand.brand_id}" >${brand.brand_name}</a></li>
            </c:forEach>
            <li><a href="${path}/list">全部商品</a></li>
            <li><a href="${path}/list?<c:if test="${param.sid != null}">sid=${param.sid}&</c:if><c:if test="${param.bid != null}">bid=${param.bid}&</c:if>desc=0">价格升序</a></li>
            <li><a href="${path}/list?<c:if test="${param.sid != null}">sid=${param.sid}&</c:if><c:if test="${param.bid != null}">bid=${param.bid}&</c:if>desc=1">价格降序</a></li>
        </ul>
    </div>
    <div class="search fr">
        <form method="get" action="${path}/list">
            <div class="text fl">
                <input type="text" class="shuru"  name="name" value="${param.name}" placeholder="关键字">
            </div>
            <div class="submit fl">
                <input type="submit" class="sousuo" value="搜索"/>
            </div>
            <div class="clear"></div>
        </form>
        <div class="clear"></div>
    </div>
</div>
<!-- end banner_x -->

<!-- start danpin -->
<div class="danpin center">

    <div class="biaoti center">商品</div>
    <div class="main center">
        <c:forEach items="${requestScope.list}" var="list">
            <div class="mingxing fl">
                <div class="sub_mingxing"><a href="${path}/xiangqing?cid=${list.commodity_id}"><img src="${path}/${list.commodity_image}" alt=""></a></div>
                <div class="pinpai"><a href="${path}/xiangqing?cid=${list.commodity_id}" title="${list.commodity_name}">${list.commodity_name}</a></div>
                <div class="youhui">5月9日-21日享花呗12期分期免息</div>
                <div class="jiage"><fmt:formatNumber value="${list.commodity_price}" type="CURRENCY"></fmt:formatNumber></div>
            </div>
        </c:forEach>
        <div class="clear"></div>
    </div>
</div><br/><br/>
<div class="text-center">
    <ul class="pagination justify-content-center">
        <li class="page-item"><a class="page-link" <c:if test="${param.page == 1}">href="javascript:return false;"</c:if> href="${path}/list?<c:if test="${param.sid != null}">sid=${param.sid}&</c:if><c:if test="${param.bid != null}">bid=${param.bid}&</c:if><c:if test="${param.name != null}">name=${param.name}&</c:if><c:if test="${param.desc != null}">desc=${param.desc}&</c:if>page=${param.page - 1}"><</a></li>
        <c:forEach begin="1" end="${requestScope.pages}" varStatus="status">
            <li class="page-item<c:if test="${requestScope.pageNum == status.count}"> active</c:if>"><a class="page-link" href="${path}/list?<c:if test="${param.sid != null}">sid=${param.sid}&</c:if><c:if test="${param.bid != null}">bid=${param.bid}&</c:if><c:if test="${param.name != null}">name=${param.name}&</c:if><c:if test="${param.desc != null}">desc=${param.desc}&</c:if>page=${status.count}">${status.count}</a></li>
        </c:forEach>
        <li class="page-item"><a class="page-link" <c:if test="${param.page == requestScope.pages}"> href="javascript:return false;" </c:if> href="${path}/list?<c:if test="${param.sid != null}">sid=${param.sid}&</c:if><c:if test="${param.bid != null}">bid=${param.bid}&</c:if><c:if test="${param.name != null}">name=${param.name}&</c:if><c:if test="${param.desc != null}">desc=${param.desc}&</c:if>page=${param.page + 1}">></a></li>
    </ul>
</div>
</body>
</html>