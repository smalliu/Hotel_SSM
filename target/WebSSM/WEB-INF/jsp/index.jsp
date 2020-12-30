<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="com.gec.domain.User"
         import="java.util.*"
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>

<%
    //String MENU_KEY = "menu_角色id";
    User user = (User) session.getAttribute("user");
    if (user != null) {
        String MENU_KEY = "menu_" + user.getRoleId();
        //把：menu_key存入请求域
        request.setAttribute("MENU_KEY", MENU_KEY);
    }
%>
<%--
<h3>尝试取出应用程序域的数据</h3>
${applictionScope[MENU_KEY]};


 <h3>尝试迭代角色菜单</h3>
 <c:forEach items="${applicationScope[MENU_KEY]}" var="entry" >
 	(主菜单)${ entry.value } <br/> 
 	<h4>(二级菜单)<h4>
 	<c:forEach items="${entry.value.menuItems}" var="item">
 		${ item.itemName } <br/> 
 	</c:forEach>
 	<br/>	
 </c:forEach>
 --%>

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>酒店后台管理系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">

    <link rel="stylesheet" href="${ctxPath}/layui/css/layui.css?t=1554901098009" media="all">
</head>
<style>
    #primaryWin {
        width: 100%;
        height: 100%;
    }
</style>


<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">酒店后台管理</div>
        <!-- 头部区域 (可配合 layui 已有的水平导航) -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="">控制台</a></li>
            <li class="layui-nav-item"><a href="">商品管理</a></li>
            <li class="layui-nav-item"><a href="">用户</a></li>
            <li class="layui-nav-item">
                <a href="javascript:;">其它系统</a>
                <dl class="layui-nav-child">
                    <dd><a href="">邮件管理</a></dd>
                    <dd><a href="">消息管理</a></dd>
                    <dd><a href="">授权管理</a></dd>
                </dl>
            </li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="${ctxPath}/layui/1.jpg" class="layui-nav-img">
                    ${user.nickName}
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="">基本资料</a></dd>
                    <dd><a href="">安全设置</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="${ctxPath}/User/logout">退出登录</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">

            <!-- 左侧导航区域 (可配合 layui 已有的垂直导航) -->
            <ul class="layui-nav layui-nav-tree" lay-filter="test">

                <c:forEach items="${applicationScope[MENU_KEY]}" var="entry">
                    <li class="layui-nav-item layui-nav-itemed">
                        <!-- 一级菜单名称: menuName -->
                        <a class="">${ entry.value.menuName }</a>
                        <!--
                                 获取二级菜单的 Set
                              Set<MenuItem> menuItems
                        -->
                        <c:forEach items="${entry.value.menuItems}" var="item">
                            <c:if test="${item.visible=='1'}">
                                <dl class="layui-nav-child">
                                    <dd>
                                        <!-- 二级菜单名称: itemName
                                        showPage( 传入映射地址 );  <== mi.urlLink
                                     -->
                                        <a href="#" onclick="showPage('${item.urlLink}');">
                                                ${ item.itemName }
                                        </a>
                                    </dd>
                                </dl>
                            </c:if>
                        </c:forEach>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <!--  主体区域  -->
    <div class="layui-body">
        <iframe id="primaryWin" src="${ctxPath}/table.jsp"
                frameborder="0" scrolling="no"></iframe>
    </div>

    <!--   底部固定区域    -->
    <div class="layui-footer">
        WWW.ALECTER.IT.COM
    </div>
</div>
<script src="${ctxPath}/layui/layui.js?t=1554901098009" charset="utf-8"></script>
<script>
    //{ps} JavaScript 代码区域
    layui.use('element', function () {
        var element = layui.element;
    });

    function showPage(urlLink) {
        //{1} 获取一个 内联框架组件, id="primaryWin"
        var pWin = document.getElementById("primaryWin");
        //urlLink = "/User/userList", 其它 ...
        pWin.src = '${ctxPath}' + urlLink;
    }
</script>
</body>
</html>

