<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>用户列表页</title>
    <link rel="stylesheet" href="${ctxPath}/layui/css/layui.css?t=1554901098009" media="all">
    <style>
        body {
            margin: 10px;
        }

        .demo-carousel {
            height: 200px;
            line-height: 200px;
            text-align: center;
        }
    </style>

    <style>
        #tbl {
            margin-top: 15px;
            margin-left: 25px;
        }

        #tbl th {
            height: 45px;
        }

        #tbl td {
            font-weight: normal;
            height: 45px;
            font-family: 微软雅黑;
            font-size: 17px;
        }

        #tbl [type='text'] {
            width: 195px;
            height: 28px;
            font-size: 17px;
            text-indent: 0.3em;
        }

        #tbl select {
            width: 200px;
            height: 32px;
            font-size: 17px;
        }

        #tbl td:nth-child(1) {
            width: 80px;
        }

        #tbl td:nth-child(2) {
            width: 350px;
        }
    </style>

</head>
<body>


<table class="layui-hide" id="demo" lay-filter="test"></table>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>


<script src="${ctxPath}/js/form.js"></script>
<script src="${ctxPath}/js/jquery-1.11.1.min.js"></script>
<script src="${ctxPath}/layui/layui.js?t=1554901098009"></script>

<script>
    //生成角色的下拉列表数据
    var role_data = [
        {text: "请选择角色", val: "-1"},
        {text: "酒店经理", val: "0"},
        {text: "酒店前台", val: "1"},
        {text: "保洁人员", val: "2"},
        {text: "维修人员", val: "3"},
        {text: "后勤人员", val: "4"}
    ];

    //生成性别的下拉列表数据
    var sex_data = [
        {text: "请选择性别", val: "0"},
        {text: "男", val: "男"},
        {text: "女", val: "女"}
    ];

    //方便使用弹窗 ...
    layui.use(
        'layer', function () {
            var $ = layui.jquery;
            var layer = layui.layer;
        }
    );


    function getUserById(userId) {
        $.ajax(
            {
                url: "${ctxPath}/Admin/getUser",
                type: "post",
                data: {id: userId},
                dataType: "json",
                success: function (json, status, xhr) {
                    console.log(json);
                    //传入 json 数据, 在弹窗中显示
                    onRecvMsg(json);
                }
            }
        );
    }

    function deleteUserById(userId) {
        $.ajax(
            {
                url: "${ctxPath}/Admin/deleteUser",
                type: "post",
                data: {id: userId},
                dataType: "json",
                success: function (json, status, xhr) {
                    console.log(json);
                    //后续设计懒得做
                }
            }
        );
    }

    //生成弹窗的表格 ...
    function makeTable(json) {
        var table = "<table id=\"tbl\">";
        //生成 6 项数据
        //1只读数据: account (input)
        table += makeInput('用户帐号', 'account', 'readonly', json['user']['account']);
        //2可改数据: 名称 (input)
        table += makeInput('用户名称', 'nickName', '', json['user']['nickName']);
        //3可改数据: 密码 (input)
        table += makeInput('用户密码', 'password', '', json['user']['password']);
        //4可改数据: 性别 (select)
        //makeSelect('性别','sex', 列表项的数组, val )
        table += makeSelect('性别', 'sex', sex_data, json['user']['sex']);
        //5可改数据: 角色 (select)
        table += makeSelect('角色', 'roleId', role_data, json['user']['roleId']);
        //{6} 隐藏数据: user.id (hidden)
        table += makeHide('id', json['user']['id']);
        table += "</table>";
        return table;
    }

    //保存用户
    function saveUser() {
        var _id = $("#id").val();
        var _account = $("#account").val();
        var _name = $("#nickName").val();
        var _pass = $("#password").val();
        var _sex = $("#sex").val();
        var _roleId = $("#roleId").val();
        $.ajax(
            {
                url: "${ctxPath}/Admin/updateUser",
                type: "post",
                data: {
                    id: _id,
                    account: _account,
                    nickName: _name,
                    password: _pass,
                    sex: _sex,
                    roleId: _roleId
                },
                dataType: "json",
                success: function (data) {

                    //1、成功 2、失败
                    var op = (data["result"] == 'success') ? '1' : '2';
                    window.location = "${ctxPath}/Admin/viewUserList?op=" + op;
                }
            });

    }


    function onRecvMsg(json) {
        //{1} 生成弹窗的表格
        var table = makeTable(json);

        //{2} 使用  LayUI 产生弹窗 ..
        layer.open({
            type: 1
            , title: '编辑用户'      //显示标题栏
            , closeBtn: false
            , area: ['450px', '350px']
            , shade: 0
            , id: 'LAY_layuipro'   //设定一个id, 防止重复弹出
            , btn: ['保存用户', '关闭对话框']
            , btnAlign: 'c'
            , moveType: 1          //拖拽模式, 0 或者 1
            , content: table
            , yes: function () {
                console.log("{DEBUG} 点击确认保存 ...");
                saveUser();
                //layer.closeAll();
            }
            , success: function (layero) {
                console.log("{DEBUG} success ...");
            }
        });
    }

</script>


<script>
    layui.config({
        version: '1554901098009'      //为了更新 js 缓存，可忽略
    });

    layui.use(
        ['laydate', 'laypage', 'layer', 'table', 'carousel', 'upload', 'element', 'slider'],
        function () {
            var laydate = layui.laydate //日期
                , laypage = layui.laypage //分页
                , layer = layui.layer //弹层
                , table = layui.table //表格
                , carousel = layui.carousel //轮播
                , upload = layui.upload //上传
                , element = layui.element //元素操作
                , slider = layui.slider //滑块

            //监听Tab切换
            element.on('tab(demo)', function (data) {
                layer.tips('切换了 ' + data.index + '：' + this.innerHTML, this, {
                    tips: 1
                });
            });

            //执行一个 table 实例
            table.render({
                elem: '#demo'
                , height: 600

                /*  这是一个数据接口，拿到 json 数据，重新绘制表格   */
                , url: '${ctxPath}/Admin/userList'

                , title: '用户表'
                , page: true //开启分页
                , toolbar: 'default' //开启工具栏，此处显示默认图标，可以自定义模板，详见文档
                , totalRow: false //开启合计行

                , cols: [[     //设置表头
                    {type: 'checkbox', fixed: 'left'}
                    , {field: 'id', title: 'ID', width: 100, sort: true, fixed: 'left'}
                    , {field: 'account', title: '用户帐号', width: 120}
                    , {field: 'nickname', title: '名称', width: 120, sort: true}
                    , {field: 'sex', title: '性别', width: 80, sort: true}
                    , {field: 'no', title: '工号', width: 80, sort: true}
                    , {field: 'roleName', title: '角色名称', width: 150}
                    , {field: 'createDate', title: '创建日期', width: 200}
                    , {fixed: 'right', width: 165, align: 'center', toolbar: '#barDemo'}
                ]]
            });


            //{ps} 监听头工具栏事件
            table.on('toolbar(test)', function (obj) {
                var checkStatus = table.checkStatus(obj.config.id)
                    , data = checkStatus.data; //获取选中的数据
                switch (obj.event) {
                    case 'add':
                        layer.msg('添加');
                        break;
                    case 'update':
                        if (data.length === 0) {
                            layer.msg('请选择一行');
                        } else if (data.length > 1) {
                            layer.msg('只能同时编辑一个');
                        } else {
                            layer.alert('编辑 [id]：' + checkStatus.data[0].id);
                        }
                        break;
                    case 'delete':
                        if (data.length === 0) {
                            layer.msg('请选择一行');
                        } else {
                            layer.msg('删除');
                        }
                        break;
                }
                ;
            });

            //{ps} 监听行工具事件
            //  这就是右边工具条的点击事件处理位置
            table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
                var data = obj.data     //获得当前行数据
                    , layEvent = obj.event; //获得 lay-event 对应的值
                if (layEvent === 'detail') {
                    layer.msg('查看操作');
                } else if (layEvent === 'del') {
                    layer.confirm('真的删除行么', function (index) {
                        obj.del(); //删除对应行（tr）的DOM结构
                        layer.close(index);
                        //向服务端发送删除指令
                        //向控制台发送id
                        console.log('{ps} id = ' + data['id']);
                        deleteUserById(data['id']);
                    });
                } else if (layEvent === 'edit') {
                    //layer.msg('编辑操作');
                    //{ps} 拿到 a001 这个 id
                    console.log('{ps} id = ' + data['id']);
                    //{ps} 调用 ajax 发送一个请求
                    getUserById(data['id']);
                }
            });

            //执行一个轮播实例
            carousel.render({
                elem: '#test1'
                , width: '100%' //设置容器宽度
                , height: 200
                , arrow: 'none' //不显示箭头
                , anim: 'fade' //切换动画方式
            });

            //将日期直接嵌套在指定容器中
            var dateIns = laydate.render({
                elem: '#laydateDemo'
                , position: 'static'
                , calendar: true //是否开启公历重要节日
                , mark: { //标记重要日子
                    '0-10-14': '生日'
                    , '2018-08-28': '新版'
                    , '2018-10-08': '神秘'
                }
                , done: function (value, date, endDate) {
                    if (date.year == 2017 && date.month == 11 && date.date == 30) {
                        dateIns.hint('一不小心就月底了呢');
                    }
                }
                , change: function (value, date, endDate) {
                    layer.msg(value)
                }
            });

            //分页
            laypage.render({
                elem: 'pageDemo' //分页容器的id
                , count: 8        //总页数
                , skin: '#1E9FFF' //自定义选中色值
                //,skip: true    //开启跳页
                , jump: function (obj, first) {
                    if (!first) {
                        layer.msg('第' + obj.curr + '页', {offset: 'b'});
                        alert("TTTTTTTTT");
                    }
                }
            });

            //上传
            upload.render({
                elem: '#uploadDemo'
                , url: '' //上传接口
                , done: function (res) {
                    console.log(res)
                }
            });

            slider.render({
                elem: '#sliderDemo'
                , input: true //输入框
            });

            //底部信息
            //var footerTpl = lay('#footer')[0].innerHTML;
            //lay('#footer').html(layui.laytpl(footerTpl).render({}))
            //.removeClass('layui-hide');
        });
</script>
</body>
</html>        
        