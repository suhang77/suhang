<%--
  Created by IntelliJ IDEA.
  User: SH
  Date: 2021/1/20
  Time: 0:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta charset="utf-8">
    <title>添加学生信息</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../../lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="../../css/public.css" media="all">

    <style>
        body {
            background-color: #ffffff;
        }
    </style>
</head>
<body>
<div class="layui-form layuimini-form">
    <div class="layui-form-item">
        <label class="layui-form-label required">班号</label>
        <div class="layui-input-block" >
            <select lay-verify="required" name="cno" id="cno">
                <option>--请选择班级编号--</option>
                <option value="1" >1001</option>
                <option value="2">1002</option>
                <option value="3">1003</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">学号</label>
        <div class="layui-input-block" >
            <input id="sno" type="text" name="sno" lay-verify="required" lay-reqtext="学号不能为空" placeholder="请输入学号" value="" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">姓名</label>
        <div class="layui-input-block" >
            <input id="name" type="text" name="name" lay-verify="required" lay-reqtext="姓名不能为空" placeholder="请输入姓名" value="" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">性别</label>
        <div class="layui-input-block" >
            <input type="radio" name="sex" value="男" title="男" checked="" lay-verify="required" lay-reqtext="性别不能为空">
            <input type="radio" name="sex" value="女" title="女">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">出生日期</label>
        <div class="layui-input-block" >
            <input id="birthday" type="text" name="birthday" placeholder="请选择出生日期" value="" class="layui-input" lay-verify="required" lay-reqtext="入学时间不能为空" readonly>
        </div>
    </div>

    <!--    省市区三级联动开始-->
    <div class="layui-form-item" id="area-picker">
        <label class="layui-form-label required">籍贯</label>
        <div class="layui-input-inline" >
            <select  id="province" name="province" class="province-selector" lay-filter="province-1" lay-verify="required" lay-reqtext="籍贯不能为空" readonly>
                <option value="">请选择省</option>
            </select>
        </div>
        <div class="layui-input-inline" >
            <select id="city" name="city" class="city-selector" lay-filter="city-1" readonly>
                <option value="">请选择市</option>
            </select>
        </div>
        <div class="layui-input-inline" >
            <select id="county" name="county" class="county-selector"  lay-filter="county-1">
                <option value="">请选择区</option>
            </select>
        </div>
    </div>
    <!--  省市区三级联动结束  -->


    <div class="layui-form-item">
        <label class="layui-form-label required">QQ</label>
        <div class="layui-input-block" >
            <input id="qq" type="text" name="qq"  placeholder="请输入QQ号码" value="" class="layui-input" lay-verify="required" lay-reqtext="QQ不能为空">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">微信号</label>
        <div class="layui-input-block" >
            <input id="weixin" type="text" name="weixin"  placeholder="请输入微信号" value="" class="layui-input" lay-verify="required" lay-reqtext="微信号不能为空">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">联系方式</label>
        <div class="layui-input-block">
            <input id="telephone" type="number" name="telephone" lay-verify="required" lay-reqtext="手机号码不能为空" placeholder="请输入手机号码" value="" class="layui-input">
        </div>
    </div>


    <div class="layui-form-item">
        <label class="layui-form-label ">是否就业</label>
        <div class="layui-input-block" >
            <select id="isGetJob" name="isGetJob">
                <option value="">--请选择是否就业--</option>
                <option value="1">是</option>
                <option value="0">否</option>
            </select>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认保存</button>
            <button id="reset" class="layui-btn layui-btn-primary" type="reset" ><i class="layui-icon layui-icon-refresh"></i>重置信息</button>
        </div>
    </div>
</div>
<script src="../../lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.$;

        $("#reset").click(function () {
            $("#cno").val("");
            $("#sno").val("");
            $("#name").val("");
            $("input[name='sex']").prop('checked',false);
            $("#birthday").val("");
            $("#province").val("");
            $("#city").val("");
            $("#telephone").val("");
            $("#county").val("");
            $("#qq").val("");
            $("#weixin").val("");
            $("#telephone").val("");
            $("#remark").val("");
            form.render();
        });


        // 3. 验证姓名，失去焦点时触发
        $("#name").blur(function(){
            var name = $("#name").val();
            var reg = /^[\u4e00-\u9fa5]{2,5}$/;//正则表达式,2-5个汉字
            if(name.length == 0|| name==null || name == '') {
                layer.msg('姓名不能为空', {icon: 5});
            }else{
                if(!reg.test(name)) {
                    layer.msg('格式不对，姓名为2-5个汉字', {icon: 5});
                }
            }
        });

        // 2. 验证学号，失去焦点时触发
        $("#sno").blur(function(){
            var sno = $("#sno").val();
            var reg = /^\d{9}$/;//正则表达式
            if(sno.length == 0|| sno==null || sno == '') {
                layer.msg('学号不能为空', {icon: 5});
            }else{
                if(!reg.test(sno)) {
                    layer.msg('学号格式不对', {icon: 5});
                }
            }
        });


        // 3. 验证手机号码，失去焦点时触发
        $("#telephone").blur(function(){
            var telephone = $("#telephone").val();
            var reg = /^1[3456789]\d{11}$/;//正则表达式
            if(telephone.length == 0|| telephone==null || telephone == '') {
                layer.msg('手机号码不能为空', {icon: 5});
            }else{
                if(!reg.test(telephone)) {
                    layer.msg('手机号码格式不对', {icon: 5});
                }
            }
        });



        //监听提交
        form.on('submit(saveBtn)', function (data) {
            // var index = layer.alert(JSON.stringify(data.field), {
            //     title: '最终的提交信息'
            // }, function () {
            //
            //     // 关闭弹出层
            //     layer.close(index);
            //
            //     var iframeIndex = parent.layer.getFrameIndex(window.name);
            //     parent.layer.close(iframeIndex);
            //
            // });
            var data = JSON.stringify(data.field);
             //alert(data);
            $.post("/StudentServlet",{"method":"addStudent","data":data},function (data) {
                if (data==1){
                    layer.msg("添加成功",{icon:1,time:1500});
                }else {
                    layer.msg("添加失败",{icon:2,time:1500});
                }

            })

            return false;
        });

    });

    // 年选择器 （入学年份）
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

    // 年月日选择器（加入时间）
    layui.use('laydate',function () {
        var laydate = layui.laydate;
        laydate.render({
            elem: '#joinDate',
            trigger: 'click'
        });

        laydate.render({
            elem: '#birthday',
            trigger: 'click'
        });
    })



    // 三级联动的JS代码

    //配置插件目录
    layui.config({
        base: '../../js/lay-module/layarea/'
        , version: '1.0'
    });
    //一般直接写在一个js文件中
    layui.use(['layer', 'form', 'layarea'], function () {
        var layer = layui.layer
            , form = layui.form
            , layarea = layui.layarea;

        layarea.render({
            elem: '#area-picker',
            change: function (res) {
                //选择结果
                console.log(res);
            }
        });
    });

</script>
</body>
</html>
