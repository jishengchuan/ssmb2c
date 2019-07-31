<%--
  Created by IntelliJ IDEA.
  User: JSC
  Date: 2019/6/17
  Time: 14:11
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
    <title>我的购物车-网上商城</title>
    <link rel="stylesheet" type="text/css" href="${path}/static/css/style.css">
    <link rel="stylesheet" type="text/css" href="${path}/static/css/base.min.css">
    <link rel="stylesheet" type="text/css" href="${path}/static/css/cart.min.css">
    <script type="text/javascript" src="${path}/static/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript">
        function del(e) {
            var cid = $(e).parent().parent().children().children().val();
            //发起请求，删除商品
            if(confirm('确认删除')){
                $.ajax({
                    url:"${path}/shopDelete",
                    type:"get",
                    data:{
                        cid:cid
                    },
                    success:function (res) {
                        queryTotal();
                        location="${path}/shop";
                    }
                });
            };
            return false;
        };
        function queryTotal() {
            var length = $(":checkbox[name='commodityId']:checked").length;
            if(length === 0){
                $("#J_selTotalNum").text(0);
                $("#totalprice").text(0);
                return;
            }
            //获取选中的商品编号
            var url = "${path}/shopTotal?"
            $(":checkbox[name='commodityId']:checked").each(function () {
                url += "cid="+this.value+"&";
            });
            $.ajax({
                url:url,
                type:"get",
                success:function (res) {
                    console.log(res)
                    $("#J_selTotalNum").text(res.quantity);
                    $("#totalprice").text(res.totalprice);
                }
            });
        };
        function updateQuantity(e){
            var price = $(e).parent().parent().parent().children().children("#price");
            var cid = $(e).parent().parent().parent().children().children().val();
            var input = $(e).parent().children("input");
            //设置点击的复选框为选择状态
            $(e).parent().parent().parent().children().children().prop("checked",true);
            var action = "";
            if($(e).text() === "-"){
                action = "sub";
            };
            if ($(e).text() === "+"){
                action = "add";
            }
            var quantity = input.val();
            if(quantity*1 <= 1  & action === "sub"){
                alert("亲不能再减了");
                input.val(1);

                return false;
            }
            if (quantity - 1 < 0){
                alert("亲不能再减了");
                input.val(1);
                return false;
            }
            if (action === "add"){
                input.val(++quantity);
            }
            if (action === "sub"){
                input.val(--quantity);
            }
            if (action === ""){
                input.val(quantity);
            }
            $.ajax({
                url:"${path}/updateQuantity",
                type:"get",
                data:{
                    cid:cid,
                    quantity:quantity,
                    action:action
                },
                success:function (res) {
                    if (res.success){
                        //成功
                        queryTotal();
                        price.text("￥"+res.price);
                    } else{
                        alert("库存不足,已经改为最大"+res.stock+"件");
                        input.val(res.stock);
                        queryTotal();
                    }
                }
            });
        }
        $(function (){
            $("#check").click(function () {
                $(":checkbox[name='commodityId']").prop("checked",this.checked);
                queryTotal();
            });
            $(":checkbox[name='commodityId']").click(function () {
                queryTotal();
                $("#check").prop("checked",$(":checkbox[name='commodityId']").length === $(":checkbox[name='commodityId']:checked").length);
            });
            $("#J_goCheckout").click(function () {
                var url = "${path}/checkout?"
                var input = $(":checkbox[name='commodityId']:checked");
                if (input.length === 0){
                    alert("请至少选中一个商品");
                    return;
                }
                input.each(function () {
                    url += "cid="+this.value+"&";
                });
                location = url
            });
            $("input[name='quantity']").blur(function () {
                updateQuantity(this);
            })
        });
    </script>
</head>
<body>
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
<div class="site-header site-mini-header">
    <div class="container">
        <div class="header-title has-more" id="J_miniHeaderTitle" style="margin-left: -300px">
            <h2>我的购物车</h2><p>温馨提示：产品是否购买成功，以最终下单为准哦，请尽快结算</p>
        </div>
    </div>
</div>
<script>
    var SiteCloseTipShow = 1;
</script>
<div class="page-main">

    <div class="container">
        <div class="cart-loading loading hide" id="J_cartLoading">
            <div class="loader"></div>
        </div>
        <div class="cart-empty hide" id="J_cartEmpty">
            <h2>您的购物车还是空的！</h2>
            <p class="login-desc">登录后将显示您之前加入的商品</p>
        </div>
        <div id="J_cartBox" class="">
            <div class="addonitems-tips hide J_addonitemsTips"></div>
            <div class="cart-goods-list">
                <div class="list-head clearfix">
                    <div class="col col-check">
                        <input class="iconfont icon-checkbox" id="check" type="checkbox" value="quanxuan" class="quanxuan" />全选
                        <%--<i class="iconfont icon-checkbox" id="J_selectAll">√</i>全选--%>
                    </div>
                    <div class="col col-img">&nbsp;</div>
                    <div class="col col-name">商品名称</div>
                    <div class="col col-price">单价</div>
                    <div class="col col-num">数量</div>
                    <div class="col col-total">小计</div>
                    <div class="col col-action">操作</div>
                </div>
                <c:forEach items="${requestScope.commodities}" var="commodities">
                <div class="list-body" id="J_cartListBody">
                    <div class="item-box">
                        <div class="item-table J_cartGoods" data-info="{ commodity_id:&#39;1173900157&#39;, gettype:&#39;buy&#39;, itemid:&#39;2173900152_0_buy&#39;, num:&#39;1&#39;} ">
                            <div class="item-row clearfix">
                                    <%--全选--%>
                                <div class="col col-check">
                                    <input class="iconfont icon-checkbox icon-checkbox  J_itemCheckbox" type="checkbox" name="commodityId" value="${commodities.commodity_id}" class="quanxuan"/>
                                        <%--<input type="checkbox" name="commodityId" value="${commodities.commodity_id}" class="quanxuan" />--%>
                                        <%--<i class="iconfont icon-checkbox icon-checkbox  J_itemCheckbox" value="${commodities.commodity_id}">√</i>--%>
                                </div>
                                    <%--图片--%>
                                <div class="col col-img">
                                    <a href="${path}/xiangqing?cid=${commodities.commodity_id}" target="_blank">
                                        <img src="${path}/${commodities.commodity_image3}" alt="">
                                            <%--<img alt="" src="./我的购物车-小米商城_files/pms_1506679420.98346728!80x80.jpg" width="80" height="80"> </a>--%>
                                </div>
                                    <%--介绍--%>
                                <div class="col col-name">
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
                                    <div class="change-goods-num clearfix J_changeGoodsNum">
                                        <a href="javascript:void(0)" onclick="updateQuantity(this)" class="J_minus"><i class="iconfont">-</i></a>
                                        <input tyep="text" name="quantity" value="${commodities.quantity}" class="goods-num J_goodsNum">
                                        <a href="javascript:void(0)" onclick="updateQuantity(this)" class="J_plus"><i class="iconfont">+</i></a>
                                    </div>
                                </div>
                                <div class="col col-total"><p id="price">￥${commodities.commodity_price}</p> </div>
                                    <%--删除--%>
                                <div class="col col-action"> <a id="2173900152_0_buy" onclick="del(this)" data-msg="确定删除吗？" href="javascript:void(0);" title="删除" class="del J_delGoods"><i class="iconfont">×</i></a></div>
                            </div>
                        </div>
                    </div>
                </div>
                </c:forEach>
            <!-- 加价购 -->
            <div class="raise-buy-box" id="J_raiseBuyBox"> </div>

            <div class="cart-bar clearfix" id="J_cartBar">
                <div class="section-left">
                    <a href="https://list.mi.com/0" class="back-shopping J_goShoping" data-stat-id="c074b1625b246f31" onclick="">继续购物</a>
                    <span class="cart-total"><%--共 <i id="quantity">0</i> 件商品，--%>已选择 <i id="J_selTotalNum">0</i> 件</span>
                </div>
                <span class="total-price">
                    合计：<em id="totalprice">0</em>元
                </span>
                <a href="javascript:void(0);" class="btn btn-a btn btn-primary" id="J_goCheckout" onclick="">去结算</a>
                <div class="no-select-tip" id="J_noSelectTip">
                    请勾选需要结算的商品
                    <i class="arrow arrow-a"></i>
                    <i class="arrow arrow-b"></i>
                </div>
            </div>
        </div>
        </div>
    </div>
</div>
</body>
</html>