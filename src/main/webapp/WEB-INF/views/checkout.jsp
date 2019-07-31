<%--
  Created by IntelliJ IDEA.
  User: JSC
  Date: 2019/6/22
  Time: 10:38
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
    <link rel="stylesheet" type="text/css" href="${path}/static/css/style.css">
    <link rel="stylesheet" type="text/css" href="${path}/static/css/base.min.css">
    <link rel="stylesheet" type="text/css" href="${path}/static/css/cart.min.css">
    <script type="text/javascript" src="${path}/static/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#J_goCheckout").click(function () {
                var url = "${path}/submit?"
                //获取收货地址的编号
                var aid = $(":radio[name='addressId']:checked").val();
                if($(":hidden[name='commodityId']").length === 0){
                    alert("请选择产品");
                    location = "${path}/shop";
                    return;
                }
                if(aid === undefined){
                    alert("请选地址")
                    return;
                }
                url += "aid="+aid+"&"
                console.log(aid);
                //获取要结算的商品编号
                $(":hidden[name='commodityId']").each(function () {
                    url += "cid="+this.value+"&"
                });
                if(confirm("请确认下单")){
                    $.ajax({
                        url:url,
                        type:"get",
                        success:function (res) {
                            if(res.success){
                                alert("下单成功");
                                location = "${path}/order";
                            }else {
                                alert("下单失败")
                            }
                        }
                    })
                }
            });
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
        <div class="rtcont" style="width: auto;height: auto">
            <div class="ddzxbt">结算页</div>
            <div class="gwcxqbj">
                <div class="gwcxd center" style="width: auto">
                    <div class="top2 center" style="margin-left: 130px">
                        <div class="sub_top fl">收货人</div>
                        <div class="sub_top fl">收货地址</div>
                        <div class="sub_top fl">联系方式</div>
                        <div class="clear"></div>
                    </div>
                    <c:forEach items="${requestScope.address}" var="address">
                        <div class="ddxq" style="margin-left: 130px;">
                            <div class="ddbh fl">
                                <input class="iconfont icon-checkbox icon-checkbox  J_itemCheckbox" type="radio" value="${address.address_id}" name="addressId">
                            </div>
                            <div class="ddbh fl" style="width: 150px">${address.addressee}</div>
                            <div class="ddbh fl">${address.address}</div>
                            <div class="ztxx fr" style="margin-right: 200px;">
                                <ul>
                                    <li>${address.tel}</li>
                                    <div class="clear"></div>
                                </ul>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <div class="clear"></div>
        <div id="J_cartBox" class="">
            <div class="addonitems-tips hide J_addonitemsTips"></div>
            <div class="cart-goods-list">
                <div class="list-head clearfix" style="margin-left: 130px;width: auto">
                    <div class="col col-img">&nbsp;</div>
                    <div class="col col-name">商品名称</div>
                    <div class="col col-price" style="text-align: right">单价</div>
                    <div class="col col-num" style="text-align: right">数量</div>
                    <div class="col col-total" style="padding-right: 0px">小计</div>
                </div>
                <c:forEach items="${requestScope.commodities}" var="commodities">
                    <div class="list-body" id="J_cartListBody" style="margin-left: 130px">
                        <div class="item-box">
                            <div class="item-table J_cartGoods" data-info="{ commodity_id:&#39;1173900157&#39;, gettype:&#39;buy&#39;, itemid:&#39;2173900152_0_buy&#39;, num:&#39;1&#39;} ">
                                <div class="item-row clearfix">
                                    <input type="hidden" name="commodityId" value="${commodities.commodity_id}" class="quanxuan"/>
                                <%--图片--%>
                                    <div class="col col-img">
                                        <a href="${path}/xiangqing?cid=${commodities.commodity_id}" target="_blank">
                                            <img src="${path}/${commodities.commodity_image3}" alt="">
                                        </a>
                                    </div>
                                        <%--介绍--%>
                                    <div class="col col-name">
                                        <div class="tags"></div>
                                        <div class="tags"></div>
                                        <h3 class="name">
                                            <a href="${path}/xiangqing?cid=${commodities.commodity_id}" target="_blank"> ${commodities.commodity_name} </a>
                                        </h3>
                                    </div>
                                    <div class="col col-price">
                                        ￥${commodities.commodity_price}
                                    </div>
                                    <div class="col col-num">
                                        <%--数量--%>
                                        <span>${commodities.quantity}</span>
                                    </div>
                                    <div class="col col-total"><p id="price">￥${commodities.commodity_price*commodities.quantity}</p> </div>
                                        <%--删除--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <!-- 加价购 -->
                <div class="raise-buy-box" id="J_raiseBuyBox"> </div>

                <div class="cart-bar clearfix" id="J_cartBar">
                    <div class="section-left">
                        <a href="${path}/list" class="back-shopping J_goShoping" data-stat-id="c074b1625b246f31" onclick="">继续购物</a>
                        <span class="cart-total">已选择 <i id="J_selTotalNum">${requestScope.total.quantity}</i> 件</span>
                    </div>
                    <span class="total-price">
                    合计：<em id="totalprice">${requestScope.total.totalprice}</em>元
                </span>
                    <a href="javascript:void(0);" class="btn btn-a btn btn-primary" id="J_goCheckout" onclick="">提交订单</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
