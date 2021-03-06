<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@include file="debugFile.inc"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!-- <link href="css/Mystyle.css" rel="stylesheet" type="text/css" > -->
<!-- PAGE TITLE & BREADCRUMB-->
<div class="row-fluid">
	<h3 class="page-title">机构管理</h3>
	<ul class="breadcrumb">
		<li><i class="icon-home"></i> <a href="index.jsp">主页</a> <i class="icon-angle-right"></i></li>
		<li><a href="#">组织管理</a> <i class="icon-angle-right"></i></li>
		<li><a href="#">人员管理</a></li>
	</ul>
</div>
<div class='portlet-body form'>
	<form name="formSelect" id="form_Select" method="post" action="FindAction!findByCondition">
		<div class="row-fluid">
			<div class="span6">
				<div class="control-group">
					<div class="controls">
						<select id="findCondition" name="findCondition">
							<option value="name">按员工姓名</option>
							<option value="phone">按员工联系电话</option>
						</select> <input id="className" name="className" type="hidden" value="Person" /> <input id="textfield" name="textfield" type="text" />
					</div>
				</div>
			</div>
			<div class="span6">
				<div class="control-group">
					<div class="controls">
						<button id="select" type="button" class="btn btn-primary">查 询</button>
						<button id="Submit" class="btn btn-primary" type="button">高级搜索</button>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>
<div class='row-fluid'>
	<form name="fom" id="fom" method="post" action="">
		<table class="table table-striped">
			<div class="row-fluid">
				<span>选择： <a href="#" id="selectAll">全选</a>- <a href="#" id="unselect">反选</a>
				</span>
				<button type="button" class="btn" id="deleteChose" data-action="PersonAction!deletePerson|${url }&method=8">删除所选 信息</button>
				<a href="JSP/yuangong.jsp" class="btn" data-toggle="modal" data-target="#myModal">添加人员信息</a>
			</div>
			<div class="row-fluid" style="text-align: center; font-size: 20px; background-color: #EEEEEE">员工详细列表</div>
			<table class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th>选择</th>
						<th>员工编号</th>
						<th>真实姓名</th>
						<th>职位</th>
						<th>员工类型</th>
						<th>性别</th>
						<th>年龄</th>
						<th>出生年月</th>
						<th>联系电话</th>
						<th>部门名称</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<s:iterator var="person" value="#request.listObject">
						<tr>
							<td><input type="checkbox" name="delid" value="${person.id }" /></td>
							<td><a class="ajaxify" href="PersonAction!edit?person.id=${person.id }">${person.id }</a></td>
							<td><a class="ajaxify" href="PersonAction!edit?person.id=${person.id }">${person.name }</a></td>
							<td>${person.personPosition.name }</td>
							<td>${person.personType.name }</td>
							<td>${person.sex }</td>
							<td>${person.age }</td>
							<td>${person.birthday }</td>
							<td>${person.phone }</td>
							<td>${person.organization.name}</td>
							<td><a class="ajaxify" href="PersonAction!edit?person.id=${person.id }&method=4">编辑</a>&nbsp;|&nbsp; <a class="ajaxify" href="yuangongsalary.html">发工资</a>&nbsp;|&nbsp; <a
								href="yuangongxiangmu.html">项目</a>&nbsp;|&nbsp; <a class="deleteOne" href="javascript:void(0)"
								data-action="PersonAction!deletePerson?person.id=${person.id}&method=8|${url}?index=${requestScope.currentIndex}">删除</a></td>
						</tr>
					</s:iterator>
				</tbody>
			</table>
		</table>
		<div class="row-fluid">
			<s:set var="pageCount" value="(#request.totalSize-1)/10+1" />
			<s:set var="url" value="#request.url" />
			<div class="span4" style="margin: 20px 0px 20px 0px;">
				共 <span>${requestScope.pageCount}</span> 页 | 第 <span>${requestScope.currentIndex}</span> 页
			</div>
			<div class="pagination pull-right">
				<ul>
					<li class="active"><a class="ajaxify" href="${url }?index=1">首页</a></li>
					<s:if test='(#request.currentIndex) > 1'>
						<li class="active"><a class="ajaxify" href="${url }?index=${requestScope.currentIndex-1}">上页</a></li>
					</s:if>
					<s:else>
						<li class="disabled"><a href="javascript::">上页</a></li>
					</s:else>
					<s:if test='(#request.currentIndex) < #pageCount'>
						<li class="active"><a class="ajaxify" href="${url }?index=${requestScope.currentIndex+1}">下页</a></li>
					</s:if>
					<s:else>
						<li class="disabled"><a href="javascript::">下页</a></li>
					</s:else>
					<li class="active"><a class="ajaxify" href="${url }?index=${pageCount }">末页</a></li>
				</ul>
			</div>
		</div>
	</form>
	<div id="myModal" class="modal hide fade">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">&times;</button>
			<h3>对话框标题</h3>
		</div>
		<div class="modal-body">
			<p></p>
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">取消</a> <a href="#" class="btn btn-primary" id="submit1" data-dismiss="modal">确定</a>
		</div>
	</div>
</div>
<script src="js/myAjaxify.js" type="text/javascript" />
<script type="text/javascript">
	$("#myModal").on("hidden", function() {
		$(this).removeData("modal");
	});

	console.log("submit ren yuan");
	$("#submit1").click(function(e) {
		if ($("#modal_form").valid(this, '填写信息不完整。') == false) {
			return false;
		}
		$.ajax({
			url : $('#modal_form').attr('action'),
			data : $('#modal_form').serialize(),
			success : function() {
				//			$('myModal').modal('hide');
				$('myModal').removeData("modal");

				// 			e.preventDefault();
				pageContent = $('.page-content .page-content-body');

				$.ajax({
					url : 'PersonAction!personList',
					success : function(res) {
						pageContent.html(res);
					}
				});
			}
		});
	});

	
</script>