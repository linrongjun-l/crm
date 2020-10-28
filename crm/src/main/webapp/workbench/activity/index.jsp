<%
String beasepath=request.getScheme()+"://"+
request.getServerName()+":"+
request.getServerPort()+
request.getContextPath()+"/";
%>
<%@ page contentType="text/html;charset=UTF-8" language="java"   %>

<html>
<head>
	<base href="<%=beasepath%>">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript "src="jquery/jquery-3.5.1.js"></script>
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>

<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
<link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
<script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
<script type="text/javascript" src="jquery/bs_pagination/en.js"></script>
<script type="text/javascript">

	$(function(){
		//为创建按钮绑定单击事件
		$("#addBtn").click(function (){

			//时间插件（由bootstart前端框架提空）
			$(".time").datetimepicker({
				minView: "month",
				language:  'zh-CN',
				format: 'yyyy-mm-dd',
				autoclose: true,
				todayBtn: true,
				pickerPosition: "bottom-left"
			});

			$.ajax({
				url:"workbeanch/activity/getuserlist.do",
				type:"get",
				dataType:"json",
				success:function (data){

					$.each(data,function (i,n){
						$("#create-owner").append("<option   value='"+n.id+"'>"+n.name+"</option>")
					})
					//在js中使用el表达式，一定要加""
					//默认选择登录的用户(session中获取的)
					var id="${user.id}";
					$("#create-owner").val(id);

				}
			})

			//打开模态窗口
			$("#createActivityModal").modal("show");
		})

		//市场活动添加操作
		$("#savebtn").click(function (){
			$.ajax({
				url:"workbeanch/activity/saveuser.do",
				data:{
					"owner":$.trim($("#create-owner").val()),
					"name":$.trim($("#create-name").val()),
					"startDate":$.trim($("#create-startDate").val()),
					"endDate":$.trim($("#create-endDate").val()),
					"cost":$.trim($("#create-cost").val()),
					"description":$.trim($("#create-description").val())
				},
				type:"post",
				dataType:"json",
				success:function (data){
					if (data.success){
						//清空创建表单
						$("#addAvtivityform")[0].reset();
						//关闭模态窗口
						$("#createActivityModal").modal("hide");
					}else{
						alert("添加失败")
					}
				}
			})
			paginList(1,2);
		})

		//查询按钮
		$("#seachbtn").click(function (){
			$("#hidden-name").val($.trim($("#seach-name").val()))
			$("#hidden-owner").val($.trim($("#seach-owner").val()))
			$("#hidden-startDate").val($.trim($("#seach-startDate").val()))
			$("#hidden-endDate").val($.trim($("#seach-endDate").val()))

			$("#seach-tbody").empty();
			paginList(1,2)
		})

		//复选框全选和反全选
		$("#chose").click(function (){
			//全选
			$("[name=xz]:checkbox").prop("checked",this.checked)
			/*
			* 因为动态生成的元素，是不能以普通绑定事件的形式来就进行操作
			*
			* 动态生成元素，我们要以on方法的形式来触发事件
			* 语法：
			* 	$(需要绑定元素的有效的外层元素).on(绑定事件的方式，需要绑定元素的jquery对象，回调函数)
			* */
			//反选
			$("#seach-tbody").on("click",$("[name=xz]:checkbox"),function (){
				$("#chose").prop("checked",$("[name=xz]:checkbox").length==$("[name=xz]:checkbox:checked").length)
			})
		})

		//删除操作
		$("#deleteBtn").click(function (){
			var $xz=$("[name=xz]:checkbox:checked");
			if ($xz.length==0){
				alert("请选择需要删除的记录！");
			}else{
				if (confirm("确认删除？")){
					var param="";
					for (var i=0;i<$xz.length;i++){
						param+="id="+$($xz[i]).val();
						if (i<$xz.length-1){
							param+="&";
						}

					}

					$.ajax({
						url:"workbeanch/activity/deleteactivity.do",
						type:"post",
						dataType:"json",
						data:param,
						success:function (data){
							if (data.success){
								paginList(1,2);
								$("#chose:checked").prop("checked",false)
							}else{
								alert("删除失败！");
							}
						}
					})
				}

			}
		})

		//修改按钮模态窗口
		$("#editBtn").click(function (){
			var $xz=$("[name=xz]:checkbox:checked");
			if ($xz.length==0){
				alert("请选择需要修改的记录！");
			}else if($xz.length>1){
				alert("不能同时选择两个修改！")
			}else {
				$.ajax({
					url:"workbeanch/activity/getUserlistAndActivity.do",
					type:"get",
					dataType:"json",
					data:{
						"id":$("[name=xz]:checkbox:checked").val()
					},
					success:function (data){
						/*需要userlist 和活动记录
						  {userList:{用户1}{用户2}{...},a{活动记录}}
						* */
						$.each(data.uList,function (i,n){
							$("#edit-owner").append("<option   value='"+n.id+"'>"+n.name+"</option>")
						})
						//默认选择登录的用户(session中获取的)
						var id="${user.id}";
						$("#edit-owner").val(id);
						alert(data.activaty.id)
						$("#edit-id").val(data.activaty.id);
						$("#edit-name").val(data.activaty.name);
						$("#edit-startDate").val(data.activaty.startDate);
						$("#edit-endDate").val(data.activaty.endDate);
						$("#edit-cost").val(data.activaty.cost);
						$("#edit-description").val(data.activaty.description);
					}
				})
				//打开模态窗口
				$("#editActivityModal").modal("show");
			}
		})

		//为更新按钮添加绑定事件，修改操作
		$("#updateBtn").click(function (){
			$.ajax({
				url:"workbeanch/activity/update.do",
				data:{
					"id":$.trim($("#edit-id").val()),
					"owner":$.trim($("#edit-owner").val()),
					"name":$.trim($("#edit-name").val()),
					"startDate":$.trim($("#edit-startDate").val()),
					"endDate":$.trim($("#edit-endDate").val()),
					"cost":$.trim($("#edit-cost").val()),
					"description":$.trim($("#edit-description").val())
				},
				type:"post",
				dataType:"json",
				success:function (data){
					if (data.success){
						//关闭模态窗口
						$("#editActivityModal").modal("hide");
					}else{
						alert("修改失败！")
					}
				}
			})

			paginList(1,2);
		})

	});
	//分页操作
	paginList(1,2);
	function paginList(paginNo,paginSize){
		$("#seach-name").val($.trim($("#hidden-name").val()))
		$("#seach-owner").val($.trim($("#hidden-owner").val()))
		$("#seach-startDate").val($.trim($("#hidden-startDate").val()))
		$("#seach-endDate").val($.trim($("#hidden-endDate").val()))
		$.ajax({
			url:"workbeanch/activity/paginlist.do",
			data: {
				"paginNo":paginNo,
				"paginSize":paginSize,
				"name":$("#seach-name").val(),
				"owner":$("#seach-owner").val(),
				"startDate":$("#seach-startDate").val(),
				"endDate":$("#seach-endDate").val()
			},
			dataType:"json",
			type:"post",
			success:function (data){
				/*
					1.需要获取到total总条数
					2. 活动表
					{total:"100",Activaty:[{活动1},{活动2}...]}
				*/
				$("#seach-tbody").empty();
				var totalPages=data.total%paginSize==0?data.total/paginSize:parseInt(data.total/paginSize)+1;
				$.each(data.dataList,function(i,n){

					$("#seach-tbody").append("<tr class='active'>")
							.append("<td>&nbsp;&nbsp;<input type='checkbox' value='"+n.id+"' name='xz'/></td>")
							.append("<td>&nbsp;&nbsp;<a style=\"text-decoration: none; cursor: pointer;\" onclick=\"window.location.href='workbench/activity/detail.jsp';\">"+n.name+"</a></td>")
							.append("<td>&nbsp;&nbsp;"+n.owner+"</td>")
							.append("<td>&nbsp;&nbsp;"+n.startDate+"</td>")
							.append("<td>&nbsp;&nbsp;"+n.endDate+"</td>")
							.append("</tr>")
				})

				//数据加载完成，用分页插件，完成分页
				$("#activityPage").bs_pagination({
					currentPage: paginNo, // 页码
					rowsPerPage: paginSize, // 每页显示的记录条数
					maxRowsPerPage: 20, // 每页最多显示的记录条数
					totalPages: totalPages, // 总页数
					totalRows: data.total, // 总记录条数

					visiblePageLinks: 3, // 显示几个卡片

					showGoToPage: true,
					showRowsPerPage: true,
					showRowsInfo: true,
					showRowsDefaultInfo: true,

					onChangePage : function(event, data){
						paginList(data.currentPage , data.rowsPerPage);
					}
				});

			}
		})
	}

</script>
<%--<script type="text/javascript">
	$(function (){
		alert("nba")
	})
</script>--%>
</head>
<body>
	<p><%=beasepath%>
	<input type="hidden" id="hidden-name">
	<input type="hidden" id="hidden-owner">
	<input type="hidden" id="hidden-startDate">
	<input type="hidden" id="hidden-endDate">
	<!-- 创建市场活动的模态窗口 -->
    <p>
	<div class="modal fade" id="createActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form id="addAvtivityform" class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="create-owner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-owner">

								</select>
							</div>
                            <label for="create-name" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-name">
                            </div>
						</div>
						
						<div class="form-group">
							<label for="create-startDate" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-startDate" >
							</div>
							<label for="create-endDate" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-endDate" >
							</div>
						</div>
                        <div class="form-group">

                            <label for="create-cost" class="col-sm-2 control-label">成本</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-cost">
                            </div>
                        </div>
						<div class="form-group">
							<label for="create-description" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-description"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="savebtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改市场活动的模态窗口 -->
	<div class="modal fade" id="editActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
						//存储id
						<input type="hidden" id="edit-id">
						<div class="form-group">
							<label for="edit-owner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-owner">

								</select>
							</div>
                            <label for="edit-name" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-name" value="">
                            </div>
						</div>

						<div class="form-group">
							<label for="edit-startDate" class="col-sm-2 control-label"  >开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control " id="edit-startDate"  value="">
							</div>
							<label for="edit-endDate" class="col-sm-2 control-label" >结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control " id="edit-endDate" value="">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-cost" class="col-sm-2 control-label">成本</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-cost" value="5,000">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-description" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-description"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateBtn">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>市场活动列表</h3>
			</div>
		</div>
	</div>
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" type="text" id="seach-name">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="seach-owner">
				    </div>
				  </div>


				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">开始日期</div>
					  <input class="form-control time" type="text" id="seach-startDate"  />
				    </div>
				  </div>
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">结束日期</div>
					  <input class="form-control time" type="text" id="seach-endDate" />
				    </div>
				  </div>
				  
				  <button type="button" id="seachbtn" class="btn btn-default">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">

					<%--
					data-toggle="modal"
						触发开启一个模态窗口
					data-target="#createActivityModal"
						表示打开那个模态窗口，通过#id的形式找到该窗口

					现在我们是以属性和属性值得方式写在了button元素中，用来打开模态窗口
					但是这样做是有问题的：
							问题在于没有办法对按钮的功能进行扩充
					在实际开发中，对于触发模态窗口操作不要写死，应该由我们自己写js代码来操作

					$("#createActivityModal").modal("show");打开模态窗口
					$("#createActivityModal").modal("hide");关闭模态窗口
					--%>
				  <button type="button" class="btn btn-primary" id="addBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox"  id="chose"/></td>
							<td>名称</td>
                            <td>所有者</td>
							<td>开始日期</td>
							<td>结束日期</td>
						</tr>
					</thead>
					<tbody id="seach-tbody">

					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 30px;">

				<div id="activityPage"> </div>
			</div>
			
		</div>
		
	</div>
</body>
</html>