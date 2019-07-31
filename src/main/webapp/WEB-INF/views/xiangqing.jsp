<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
	<head>
		<meta charset="UTF-8">
		<title>${requestScope.commodity.commodity_name}-网上商城</title>
		<link rel="stylesheet" type="text/css" href="${path}/static/css/style.css">
		<script type="text/javascript" src="${path}/static/js/jquery-1.8.3.min.js"></script>
		<script type="text/javascript">
			$(function () {
				$("#add2shop").click(function () {
					//获取商品编号
					var cid = "${param.cid}";
					//获取数量
					var quantity = $("input[name='quantity']").val();
					//发起请求，添加商品到购物车
					$.ajax({
						url:"${path}/add2shop",
						type:"get",
						data:{
							cid:cid,
							quantity:quantity
						},
						success:function (res) {
							if(res.success){
								alert("添加成功");
								location="${path}/shop";
							}else{
								alert("请登录账号");
								location="${path}/add2shop?cid="+cid;
							}
						}
					});
				});
				$("input[name='quantity']").blur(function () {
					var stock = $("input[name='stock']").val();
					var quantity = $("input[name='quantity']").val();
					if (quantity - 1 < 0){
						alert("商品数不能为负");
						$("input[name='quantity']").val(1);
					}
					if (stock - quantity < 0){
						alert("库存不足,已经改为最大"+stock+"件");
						$("input[name='quantity']").val(stock);
					}
				});
				$("input[name='instance']").click(function () {
					var cid = $("input[name='cid']").val();
					location = "${path}/instanceCheckout?cid="+cid+"&quantity="+$("input[name='quantity']").val();
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
			<a href="${path}/index"><div class="logo fl"></div></a>
			<%--<a href=""><div class="ad_top fl"></div></a>--%>
			<div class="nav fl">
				<ul>
					<li><a href="${path}/index" >首页</a></li>
					<c:forEach items="${requestScope.nav}" var="nav">
						<li><a href="${path}/list?sid=${nav.sortId}">${nav.sortName}</a></li>
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

	
	<!-- xiangqing -->
	<form action="post" method="">
	<div class="xiangqing">
		<div class="neirong w">
			<div class="xiaomi6 fl">${requestScope.commodity.commodity_name}</div>
			<div class="clear"></div>
		</div>	
	</div>
	<div class="jieshao mt20 w">
		<div class="left fl"><img src="${path}/${requestScope.commodity.commodity_image2}"></div>
		<div class="right fr">
			<div class="h3 ml20 mt20">${requestScope.commodity.commodity_name}</div>
			<div class="jianjie mr40 ml20 mt10">${requestScope.commodity.commodity_info}</div>
			<%--<div class="jiage ml20 mt10">${requestScope.commodity.commodityPrice}</div>--%>
			<div class="ft20 ml20 mt20">商品编号:${requestScope.commodity.commodity_id}</div>
			<div class="xzbb ml20 mt10">
				<div class="banben fl">
					<span><a href="${path}/list?bid=${requestScope.brand.brand_id}">品牌:${requestScope.brand.brand_name}</a></span>
				</div>
				<div class="banben fl" style="width: 130px;text-align: center">
					<span><a href="${path}/list?sid=${requestScope.sort.sort_id}">&nbsp;分类:${requestScope.sort.sort_name}</a></span>
				</div>
				<div class="banben fl">
					<a href="${path}/bangdan?stock=1"><span class="yanse">&nbsp;&nbsp;库存:${requestScope.commodity.stock}</span></a>
				</div>
				<div class="banben fl">
					<a href="${path}/bangdan?sale=1"><span class="yanse">&nbsp;&nbsp;销量:${requestScope.commodity.sale}</span></a>
				</div>
				<div class="clear"></div>
			</div>
			<div class="ft20 ml20 mt20">数量</div>
			<div class="xzbb ml20 mt10">
				<div class="sub_content fl">
					<input type="hidden" name="stock" value="${requestScope.commodity.stock}">
					<input style="height: 58px;line-height: 58px;width: 120px;cursor:pointer;margin-right: 5px;border:1px solid #bbb;font-size: 2em;text-align: center"
						   name="quantity" class="shuliang" type="number" value="1" step="1" min="1" >
				</div>
			</div>
			<div class="xqxq mt20 ml20" style="width: auto;">
				<div class="top1 mt10">
					<div class="left1 fl">${requestScope.commodity.commodity_name}</div>
					<div class="right1 fr"><fmt:formatNumber value="${requestScope.commodity.commodity_price}" type="CURRENCY"></fmt:formatNumber></div>
					<div class="clear"></div>
				</div>
				<%--<div class="bot mt20 ft20 ftbc">总计：${requestScope.commodity.commodity_price}元</div>--%>
			</div>
			<div class="xiadan ml20 mt20">
				<input name="cid" type="hidden" value="${requestScope.commodity.commodity_id}">
				<input class="jrgwc"  type="button" name="instance" value="立即选购" />
				<input id="add2shop" class="jrgwc" type="button" name="jrgwc" value="加入购物车" />
			</div>
		</div>
		<div class="clear"></div>
	</div>
	</form>
	</body>
</html>