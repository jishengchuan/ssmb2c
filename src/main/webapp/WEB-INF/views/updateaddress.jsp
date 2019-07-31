<%--
  Created by IntelliJ IDEA.
  User: JSC
  Date: 2019/6/21
  Time: 13:52
  To change this template use File | Settings | File Templates.
--%>
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
    <title>网上商城-地址管理</title>
    <link rel="stylesheet" href="${path}/static/css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="${path}/static/css/style.css">
    <script type="text/javascript" src="${path}/static/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("input[name='submit']").click(function () {
                var data = {
                    addressee:$("input[name='addressee']").val(),
                    address:$("input[name='address']").val(),
                    tel:$("input[name='tel']").val(),
                    _method:"put"
                };
                if($("input[name='aid']")[0]){
                    data.aid = $("input[name='aid']").val();
                }
                //发起请求
                $.ajax({
                    url:"${pageContext.request.contextPath}/updateAddress",
                    type:"post",
                    data:data,//请求参数
                    success:function (res) {
                        if(res.success){
                            alert("成功");
                            //返回列表页
                            location = "${path}/address";
                        }else{
                            alert("失败");
                        }
                    }
                });
                //阻止表单提交
                return false;
            });
        });
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
            <div class="ddzx">个人中心</div>
            <div class="subddzx">
                <ul>
                    <li><a href="${path}/address">查看地址</a></li>
                    <li><a href="${path}/order">查看订单</a></li>
                    <li><a href="${path}/index">商城首页</a></li>
                    <li><a href="${path}/logout">退出登录</a> </li>
                </ul>
            </div>
        </div>
        <div class="rtcont fr">
            <div class="ddzxbt">
                <c:if test="${param.aid != null}">修改地址</c:if>
                <c:if test="${param.aid == null}">添加地址</c:if>
            </div>
            <form role="form" action="${pageContext.request.contextPath}/updateAddress" method="post">
                <c:if test="${param.aid != null}">
                    <input type="hidden" value="${requestScope.address.address_id}" name = "aid"/>
                </c:if>
                <div class="form-group">
                    <label for="addressee">收件人</label>
                    <input type="text" class="form-control" name="addressee" id="addressee" value="${requestScope.address.addressee}"
                           placeholder="请输入收件人">
                </div>
                <div class="form-group">
                    <label for="address">地址</label>
                    <input type="text" class="form-control" name="address" value="${requestScope.address.address}"
                           id="address"
                           placeholder="请输入地址">
                </div>
                <div class="form-group">
                    <label for="tel">联系方式</label>
                    <input type="text" class="form-control" name="tel" id="tel" value="${requestScope.address.tel}"
                           placeholder="请输入联系方式">
                </div>
                <input name="submit" class="btn btn-primary" type="submit" value="提交">
            </form>
        </div>
        <div class="clear"></div>
    </div>
</div>
</body>
</html>
