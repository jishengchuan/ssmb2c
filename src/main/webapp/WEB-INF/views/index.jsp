<%--
  Created by IntelliJ IDEA.
  User: JSC
  Date: 2019/6/6
  Time: 10:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <meta charset="UTF-8">
  <title>网上商城</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css"/>
  <link rel="stylesheet" type="text/css" href="${path}/static/css/style.css">
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

<!-- start banner_y -->
<div class="banner_y center" href="${path}/xiangqing?cid=3008">

  <div class="nav">
    <ul>
      <li style="color:#04155a;margin-left: 30px;height: 400px;" >
        <div style="height:400px;width: 100px;font-size: 5em;color: #f0f0f0;text-align:center;line-height:200px">
          ${requestScope.quot.quot_name}
        </div>
        <div class="pop" style="font-size: 2.5em;color: #fff;line-height:100px">
          ${requestScope.quot.quot_info}
        </div>
      </li>
    </ul>
  </div>

</div>

<div class="sub_banner center">
  <div class="sidebar fl">
    <div class="fl"><a href="${path}/list"><img src="${path}/static/image/hjh_01.gif"></a></div>
    <div class="fl"><a href=""><img src="${path}/static/image/hjh_02.gif"></a></div>
    <div class="fl"><a href=""><img src="${path}/static/image/hjh_03.gif"></a></div>
    <div class="fl"><a href=""><img src="${path}/static/image/hjh_04.gif"></a></div>
    <div class="fl"><a href=""><img src="${path}/static/image/hjh_05.gif"></a></div>
    <div class="fl"><a href=""><img src="${path}/static/image/hjh_06.gif"></a></div>
    <div class="clear"></div>
  </div>
  <div class="datu fl"><a href="${path}/xiangqing?cid=3012"><img src="${path}/static/image/xmad_15604015684049_SOHVF.jpg" alt=""></a></div>
  <div class="datu fl"><a href="${path}/list"><img src="${path}/static/image/xmad_15602576047114_PRhSj.jpg" alt=""></a></div>
  <div class="datu fr"><a href="${path}/list"><img src="${path}/static/image/xmad_15603970448956_BRrDT.jpg" alt=""></a></div>
  <div class="clear"></div>


</div>
<!-- end banner -->

<!-- start danpin -->
<div class="danpin center">

  <div class="biaoti center">小米明星单品</div>
  <div class="main center">
    <div class="mingxing fl">
      <div class="sub_mingxing"><a href="${path}/xiangqing?cid=3009"><img src="${pageContext.request.contextPath}/static/image/pinpai1.png" alt=""></a></div>
      <div class="pinpai"><a href="">小米MIX3</a></div>
      <div class="youhui">5月9日-21日享花呗12期分期免息</div>
      <div class="jiage">3499元起</div>
    </div>
    <div class="mingxing fl">
      <div class="sub_mingxing"><a href="${path}/xiangqing?cid=3007"><img src="${pageContext.request.contextPath}/static/image/pinpai2.png" alt=""></a></div>
      <div class="pinpai"><a href="">小米6x</a></div>
      <div class="youhui">5月9日-10日，下单立减200元</div>
      <div class="jiage">1999元</div>
    </div>
    <div class="mingxing fl">
      <div class="sub_mingxing"><a href="${path}/xiangqing?cid=3010"><img src="${pageContext.request.contextPath}/static/image/pinpai3.png" alt=""></a></div>
      <div class="pinpai"><a href="">小米手机8</a></div>
      <div class="youhui">5月9日-10日，下单立减100元</div>
      <div class="jiage">1799元</div>
    </div>
    <div class="mingxing fl">
      <div class="sub_mingxing"><a href="${path}/xiangqing?cid=3012"><img src="${pageContext.request.contextPath}/static/image/pinpai4.png" alt=""></a></div>
      <div class="pinpai"><a href="">小米电视4a 55英寸</a></div>
      <div class="youhui">5月9日，下单立减200元</div>
      <div class="jiage">3999元</div>
    </div>
    <div class="mingxing fl">
      <div class="sub_mingxing"><a href="${path}/xiangqing?cid=3013"><img src="${pageContext.request.contextPath}/static/image/pinpai5.png" alt=""></a></div>
      <div class="pinpai"><a href="">小米笔记本</a></div>
      <div class="youhui">更轻更薄，像杂志一样随身携带</div>
      <div class="jiage">3599元起</div>
    </div>
    <div class="clear"></div>
  </div>
</div>
<div class="peijian w">
  <div class="biaoti center">商品推荐</div>
  <div class="main center" style="height: auto">
    <div class="content">
      <c:forEach items="${requestScope.list}" var="list">
        <div class="remen fl" style="margin: 25px">
          <%--<div class="xinpin"><span></span></div>--%>
          <div class="tu"><a href="${path}/xiangqing?cid=${list.commodity_id}"><img style="width: 180px;height: 180px;" src="${path}/${list.commodity_image}"></a></div>
          <div class="miaoshu"><a href="${path}/xiangqing?cid=${list.commodity_id}">${list.commodity_name}</a></div>
          <div class="jiage"><fmt:formatNumber value="${list.commodity_price}" type="CURRENCY"></fmt:formatNumber></div>
          <div class="pingjia">评价</div>
          <div class="piao">
            <a href="">
              <span>${list.commodity_apprise}</span>
            </a>
          </div>
        </div>
      </c:forEach>
      <div class="remenlast fl" style="margin: 20px">
        <div class="liulangengduo"><a href="${path}/list"><img src="${path}/static/image/liulangengduo.png" alt=""></a></div>
      </div>
    </div>
    <div class="clear"></div>
    </div>
  </div>
</div>
</div>
</body>
</html>