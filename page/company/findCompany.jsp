<%--
  Created by IntelliJ IDEA.
  User: SH
  Date: 2021/1/18
  Time: 12:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta charset="utf-8">
    <title>合作企业维护</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../../lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="../../css/public.css" media="all">
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <fieldset class="table-search-fieldset">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <div class="layui-input-inline">
                                <input id="cname" type="text" name="cname" placeholder="请输入企业名称" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <div class="layui-input-inline">
                                <input id="city" type="text" name="city" placeholder="请输入企业名称" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <div class="layui-input-inline">
                                <select name="status">
                                    <option value="0">--请选择合作状态--</option>
                                    <option value="1">合作中</option>
                                    <option value="2">暂停合作</option>
                                </select>
                            </div>
                        </div>


                        <div class="layui-inline">
                            <button type="submit" class="layui-btn layui-btn-primary"  lay-submit lay-filter="data-search-btn"><i class="layui-icon"></i> 搜 索</button>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>



        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>
        <!--实现表格的序号自增-->
        <script type="text/html" id="zizeng">
            {{d.LAY_TABLE_INDEX+1}}
        </script>
        <script type="text/html" id="status">
            {{d.status == 1?'合作中':'暂停合作'}}
        </script>
        <!--自定义的列模板-->
        <script type="text/html" id="statusTableBar">
            <input type="checkbox" name="status" value="{{d.userid}}" checked lay-skin="switch" lay-text="启用|禁用" lay-event="open" lay-filter="modifystatus" {{ d.status == '1'? 'checked' : '' }}/>
        </script>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn  layui-btn-xs data-count-edit" lay-event="edit">修改</a>
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="add">添加招聘记录</a>
            <a class="layui-btn  layui-btn-xs layui-btn-danger" lay-event="delete">删除</a>
        </script>

    </div>
</div>
<script src="../../lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;

        table.render({
            elem: '#currentTableId',
            url: '/CompanyServlet?method=findAll',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                {field: 'zizeng', width: 80, title: '序号',templet:'#zizeng'},
                {field: 'cname', width: 80, title: '企业名称'},
                {field: 'city', width: 80, title: '总部城市'},
                {field: 'address', width: 100, title: '总部地址'},
                {field: 'trade', width: 120, title: '所属行业'},
                {field: 'leader', width: 80, title: '招聘负责人',sort:true},
                {field: 'telephone', width: 120, title: '联系电话'},
                {field: 'job', width: 120, title: '招聘岗位'},
                {field: 'joinDate', width: 100, title: '合作时间'},
                {field: 'status', width:80, title: '合作状态' ,templet:'#status'},
                {title: '操作', minWidth: 120, toolbar: '#currentTableBar', align: "center"}
            ]],
            limits: [10, 15, 20, 25, 50, 100],
            limit: 15,
            page: true
        });

        // 监听搜索操作
        form.on('submit(data-search-btn)', function (data) {
            var result = JSON.stringify(data.field);
            layer.alert(result, {
                title: '最终的搜索信息'
            });

            //执行搜索重载
            table.reload('currentTableId', {
                page: {
                    curr: 1
                }
                , where: {
                    searchParams: result
                }
            }, 'data');

            return false;
        });

        form.on('switch(modifystatus)', function(obj){
            console.log(obj);
            var param = obj.value;
        });

        /**
         * toolbar监听事件
         */
        /*	table.on('toolbar(currentTableFilter)', function (obj) {
                if (obj.event === 'add') {  // 监听添加操作
                    var index = layer.open({
                        title: '添加成员信息',
                        type: 2,
                        shade: 0.2,
                        maxmin:true,
                        shadeClose: true,
                        area: ['100%', '100%'],
                        content: 'addClass.html',
                    });
                    $(window).on("resize", function () {
                        layer.full(index);
                    });
                } else if (obj.event === 'delete') {  // 监听批量删除操作
                    var checkStatus = table.checkStatus('currentTableId')
                            , data = checkStatus.data;
                    layer.alert(JSON.stringify(data));
                }
            });
    */
        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });

        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'edit') {

                var index = layer.open({
                    title: '修改',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['85%', '85%'],
                    content: '/CompanyServlet?method=findCompanyById&id='+data.id,
                    end:function () {
                        layer.close(index);
                        //关闭修改页面时，重新加载查询列表页面
                        location.reload()
                    }
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } else if (obj.event === 'delete') {
                layer.confirm('真的删除行么', function (index) {
                    //obj.del();
                    $.get("/CompanyServlet",{"method":"removeById","id":data.id},function (data) {
                        if (data == 1){
                            layer.msg("删除成功",{icon:1,time:1500});
                        }else {
                            layer.msg("删除失败",{icon:2,time:1500});
                        }
                    })
                    //执行搜索重载
                    table.reload('currentTableId', {
                        page: {
                            curr: 1
                        }

                    });
                    layer.close(index);
                });
            }else if(obj.event === 'add'){
                var index = layer.open({
                    title: '添加招聘记录',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['85%', '85%'],
                    content: 'addHiringRecord.html',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            }
        });

    });

    // 年选择器（选择入学年份）
    layui.use('laydate', function(){
        var laydate = layui.laydate;
        var initYear;
        laydate.render({
            elem: '#year',
            type: 'year',
            /* ready和change函数是为了实现选择年份时不用点确定直接关闭  */
            ready: function(date){ // 控件在打开时触发，回调返回一个参数：初始的日期时间对象
                initYear = date.year;
            },
            change: function(value, date, endDate){ // 年月日时间被切换时都会触发。回调返回三个参数，分别代表：生成的值、日期时间对象、结束的日期时间对象
                var selectYear = date.year;
                var differ = selectYear-initYear;
                if (differ != 15 && differ != -15) {
                    if($(".layui-laydate").length){
                        $("#year").val(value);
                        $(".layui-laydate").remove();
                    }
                }
                initYear = selectYear;
            }
        });
    });

</script>

</body>
</html>
