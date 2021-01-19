<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2021/1/14
  Time: 9:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改合作企业</title>
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
        <label class="layui-form-label required">ID</label>
        <div class="layui-input-block" >
            <input id="id" type="text" name="id" class="layui-input" value="${company.id}" readonly>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">企业名称</label>
        <div class="layui-input-block" >
            <input id="cname" type="text" name="cname" lay-verify="required" lay-reqtext="企业不能为空"  value="${company.cname}" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label ">总部所在城市</label>
        <div class="layui-input-block" >
            <input id="city" type="text" name="city"  value="${company.city}" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label ">总部详细地址</label>
        <div class="layui-input-block" >
            <input id="address" type="text" name="address" value="${company.address}" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label ">企业所属行业</label>
        <div class="layui-input-block" >
            <input id="trade" type="text" name="trade"   value="${company.trade}" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label ">招聘负责人</label>
        <div class="layui-input-block" >
            <input id="leader" type="text" name="leader"  value="${company.leader}" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label ">负责人电话</label>
        <div class="layui-input-block" >
            <input id="telephone" type="text" name="telephone"   value="${company.telephone}" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label ">主要招聘岗位</label>
        <div class="layui-input-block" >
            <input id="job" type="text" name="job" value="${company.job}" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label ">开始合作时间</label>
        <div class="layui-input-block" >
            <input id="joinDate" type="text" name="joinDate" placeholder="请选择开始合作时间" value="${company.joinDate}" class="layui-input" readonly>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label ">合作状态</label>
        <div class="layui-input-block" >
            <select id="status" name="status">
                <option value="">--请选择合作状态--</option>
                <option value="1" ${company.status == 1 ? 'selected':''}>合作中</option>
                <option value="0" ${company.status == 0 ? 'selected':''}>暂停合作</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">修改合作企业信息</button>
            <button id="reset" class="layui-btn layui-btn-primary" type="reset" ><i class="layui-icon layui-icon-refresh"></i>重置信息</button>
        </div>
    </div>
</div>
<script src="../../lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script src="../../js/lay-config.js"></script>
<script>
    layui.use(['form'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.$;

        $("#reset").click(function () {
            $("#cname").val("");
            $("#city").val("");
            $("#address").val("");
            $("#trade").val("");
            $("#leader").val("");
            $("#telephone").val("");
            $("#job").val("");
            $("#joinDate").val("");
            $("#status").val("");
            form.render();
        });

        //监听提交
        form.on('submit(saveBtn)', function (data) {
          /*  var index = layer.alert(JSON.stringify(data.field), {
                title: '最终的提交信息'
            }, function () {

                // 关闭弹出层
                layer.close(index);

                var iframeIndex = parent.layer.getFrameIndex(window.name);
                parent.layer.close(iframeIndex);

            });
            */
             var data = JSON.stringify(data.field);
             $.post("/CompanyServlet",{"method":"editCompany","data":data},function (data) {
               if(data == 1) {
                   layer.msg("修改成功",{icon:1,time:1500});
               }else{
                   layer.msg("修改失败",{icon:2,time:1500});
               }
          })
            return false;
        });

    });


    // 年月日选择器（加入时间）
    layui.use('laydate',function () {
        var laydate = layui.laydate;
        laydate.render({
            elem: '#joinDate',
            trigger: 'click'
        });

    })



</script>
</body>
</html>