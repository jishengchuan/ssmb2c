<%--
  Created by IntelliJ IDEA.
  User: JSC
  Date: 2019/6/20
  Time: 19:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>网上商城-个人中心</title>
    <link rel="stylesheet" type="text/css" href="${path}/static/css/base.min.css">
    <link rel="stylesheet" type="text/css" href="${path}/static/css/main.min.css">
    <link rel="stylesheet" href="${path}/static/css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/static/css/style.css">
    <style type="text/css">
        .file {
            position: relative;
            display: inline-block;
            background: #D0EEFF;
            border: 1px solid #99D3F5;
            border-radius: 4px;
            padding: 4px 12px;
            overflow: hidden;
            color: #1E88C7;
            text-decoration: none;
            text-indent: 0;
            line-height: 20px;
        }
        .file input {
            position: absolute;
            font-size: 100px;
            right: 0;
            top: 0;
            opacity: 0;
        }
        .file:hover {
            background: #AADFFD;
            border-color: #78C3F3;
            color: #004974;
            text-decoration: none;
        }
    </style>
    <script type="text/javascript" src="${path}/static/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#submit").click(function () {
                var file = $("#file").val();
                console.log(file);
                if (file === ""){
                    alert("请先选择头像");
                    return false;
                }
            })
        })
    </script>
</head>
<body>
<!-- start header -->
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
<!-- self_info -->
<div class="grzxbj">
    <div class="selfinfo center">
        <div class="lfnav fl">
            <div class="tx">
                <img style="width: 92px;width: 92px;margin: 20px;margin-left: 40px" src="${path}/${sessionScope.user.photo}"/>
                <form action="${path}/orderPhoto" method="post" enctype="multipart/form-data">
                    <a href="javascript:;" class="file" style="margin-left: 20px">修改头像
                        <input type="file" id="file" name="file"></a>
                    <a id="photo" href="javascript:;" class="file">上传
                        <input type="submit" id="submit" value="上传"></a>
                </form>
            </div>
            <div class="ddzx">个人中心</div>
            <div class="subddzx">
                <ul>
                    <li style="padding-left: 0px"><a href="${path}/address">查看地址</a></li>
                    <li style="padding-left: 0px"><a href="${path}/order">查看订单</a></li>
                    <li style="padding-left: 0px"><a href="${path}/index">商城首页</a></li>
                    <li style="padding-left: 0px"><a href="${path}/logout">退出登录</a> </li>
                </ul>
            </div>
        </div>
        <div class="rtcont fr" style="height: auto">
            <div class="ddzxbt">交易订单</div>
            <div class="box-bd">
                <div J_orderList>
                    <ul class="order-list">
                    <c:forEach items="${requestScope.orders}" var="orders">
                        <li class="uc-order-item uc-order-item-finish" style="margin-top: 10px">
                        <div class="order-detail">
                            <table class="order-detail-table" style="border: #cccccc solid 0.5px;width: 860px">
                                <thead>
                                <tr>
                                    <th class="col-main">
                                    <p class="caption-info">
                                        订单号：${orders.orders_id}
                                        <span class="sep">|</span>时间:${orders.orders_addtime}
                                    </p>
                                    </th>
                                    <th class="col-sub">
                                        <p class="caption-price">实付金额：<span class="num">${orders.totalPrice}</span>元</p>
                                    </th>
                                </tr>
                                </thead>
                                <c:forEach items="${orders.commodities}" var="commodity" varStatus="status">
                                        <tr style="border: #cccccc solid 0.5px">
                                        <td class="order-items">
                                            <ul class="goods-list">
                                                <li>
                                                    <div class="figure figure-thumb">
                                                        <div style="float: left">
                                                            <input type="hidden" value="${commodity.commodity_id}">
                                                            <a href="${path}/xiangqing?cid=${commodity.commodity_id}" target="_blank" style="margin-top: -5px"><img src="${path}/${commodity.commodity_image}" alt="${commodity.commodity_name}"></a>
                                                        </div>
                                                        <div style="width: 400px;float: left;margin: 10px">
                                                            <a href="${path}/xiangqing?cid=${commodity.commodity_id}">${commodity.commodity_nameinfo}</a>
                                                        </div>
                                                    </div>
                                                    <p class="name">
                                                        <a href="${path}/xiangqing?cid=${commodity.commodity_id}" target="_blank">${commodity.commodity_name}</a>
                                                    </p>
                                                    <p class="price">${commodity.commodity_price}元 × ${commodity.quantity}</p>
                                                </li>
                                            </ul>
                                        </td>
                                        <td class="order-actions" style="border: #cccccc solid 0.5px" rowspan="${fn:length(orders.commodities)}">
                                            <c:if test="${status.first}">
                                                ${orders.address.addressee}<br>
                                                ${orders.address.tel}<br>
                                                ${orders.address.address}<br><br>
                                            </c:if>
                                        </td>
                                        </tr>
                                </c:forEach>
                            </table>
                        </div>
                        </li>
                    </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
        <div class="clear"></div>
    </div>
</div>
</body>
</html>