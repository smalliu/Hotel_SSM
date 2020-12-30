<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>新增用户</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="${ctxPath}/layui/css/layui.css?t=1554901098009" media="all">
    <script src="${ctxPath}/js/jq.js"></script>
    <script src="${ctxPath}/layui/layui.js?t=1554901098009"></script>
</head>
<style>
    #mainbox {
        margin-top: 10px;
        width: 50%;
        height: 80%;
    }

</style>
<body>

<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>用户管理 > 新增用户</legend>
</fieldset>
<script>
    layui.use(
        ['layer', 'table', 'element',],
        function () {
            var layer = layui.layer //弹层
                , table = layui.table //表格
                , element = layui.element
                , form = layui.form;//元素操作
        });

</script>
<div id="mainbox">
    <form class="layui-form" action="${ctxPath}/Admin/insertUser">
        <label class="layui-form-label">用户名</label>
        <div class="layui-input-block">
            <input type="text" name="account" required lay-verify="required" placeholder="请输入用户名" autocomplete="off"
                   class="layui-input">
        </div>
        <label class="layui-form-label">别名</label>
        <div class="layui-input-block">
            <input type="text" name="nickName" required lay-verify="required" placeholder="请输入别名" autocomplete="off"
                   class="layui-input">
        </div>
        <label class="layui-form-label">密码</label>
        <div class="layui-input-block">
            <input type="password" name="password" required lay-verify="required" placeholder="请输入密码" autocomplete="off"
                   class="layui-input">
        </div>
        <label class="layui-form-label">工号</label>
        <div class="layui-input-block">
            <input type="text" name="no" required lay-verify="required" placeholder="请输入工号" autocomplete="off"
                   class="layui-input">
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">角色</label>
            <div class="layui-input-block">
                <select name="roleId" lay-verify="required">
                    <option value="-1">请选择角色</option>
                    <option value="0">酒店经理</option>
                    <option value="1">前台营业员</option>
                    <option value="2">保洁人员</option>
                    <option value="3">维修人员</option>
                    <option value="4">后勤人员</option>
                </select>
            </div>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-block">
                <input type="radio" name="sex" value="男" title="男" checked>
                <input type="radio" name="sex" value="女" title="女">
            </div>

        </div>


        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
</body>
</html>
