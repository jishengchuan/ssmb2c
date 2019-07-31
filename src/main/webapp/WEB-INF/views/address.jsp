<%--
  Created by IntelliJ IDEA.
  User: JSC
  Date: 2019/6/19
  Time: 19:11
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
    <title>网上商城-个人中心</title>
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
        function del(e) {
            var result = confirm("确定删除吗？");
            if(result){
                var aid = $(e).parent().parent().parent().parent().children(":first").children(":input[name='aid']").val();
                //请求删除
                $.ajax({
                    url:"${path}/del?aid="+aid,
                    type:"post",
                    data:{
                        _method:"put"
                    },
                    success:function (res) {
                        if(res.success){
                            alert("删除成功！");
                            location = "${path}/address";
                        }else {
                            alert("删除失败！");
                        }
                    }
                });
            }
        }
        $(function () {
            $("#submit").click(function () {
                var file = $("#file").val();
                console.log(file);
                if (file === ""){
                    alert("请先选择头像")
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
                <form action="${path}/photo" method="post" enctype="multipart/form-data">
                    <a href="javascript:;" class="file" style="margin-left: 20px">修改头像
                        <input type="file" id="file" name="file"></a>
                    <a id="photo" href="javascript:;" class="file">上传
                         <input type="submit" id="submit" value="上传"></a>
                </form>
            </div>
            <div class="ddzx">个人中心</div>
            <div class="subddzx">
                <ul>
                    <li><a href="${path}/updateAddress">添加地址</a></li>
                    <li><a href="${path}/order">查看订单</a></li>
                    <li><a href="${path}/index">商城首页</a></li>
                    <li><a href="${path}/logout">退出登录</a> </li>
                </ul>
            </div>
        </div>
        <div class="rtcont fr" style="height: auto;">
            <div class="ddzxbt">用户地址</div>
            <div class="gwcxqbj">
                <div class="gwcxd center">
                    <div class="top2 center">
                        <div class="sub_top fl">收货人</div>
                        <div class="sub_top fl">收货地址</div>
                        <div class="sub_top fl" style="margin-left: 270px">联系方式</div>
                        <div class="sub_top fl" style="margin-left: 40px">添加时间</div>
                        <div class="sub_top fl" style="margin-left: 40px">操作</div>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
            <c:forEach items="${requestScope.address}" var="address">
                <div class="ddxq" style="height: auto;">
                    <div class="ddbh fl" style="width: 150px"><input type="hidden" name="aid" value="${address.address_id}">${address.addressee}</div>
                    <div class="ddbh fl" >${address.address}</div>
                    <div class="ztxx fr">
                        <ul>
                            <li>${address.tel}</li>
                            <li><fmt:formatDate value="${address.address_addtime}"></fmt:formatDate></li>
                            <li>
                                <a href="${path}/updateAddress?aid=${address.address_id}">修改</a>&nbsp;&nbsp;
                                <a href="javascript:void (0)" onclick="del(this)">删除</a>
                            </li>
                            <div class="clear"></div>
                        </ul>
                    </div>
                    <div class="clear"></div>
                </div>
            </c:forEach>
        </div>
        <div class="clear"></div>
    </div>
</div>
</body>
</html>