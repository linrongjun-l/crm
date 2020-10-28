<%
String beasepath=request.getScheme()+"://"+
request.getServerName()+":"+
request.getServerPort()+
request.getContextPath()+"/";
%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  %>
<!DOCTYPE html>
<html>
<head>
<base href="<%=beasepath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function (){
		if (window.top!=window){
			window.top.location=window.location;
		}
		//清空文本框中内容
		$("#loginAct").val("");
		$("#loginPwd").val("");

		//页面加载完成，获取焦点
		$("#loginAct").focus();
		//绑定按钮，控制提交表单
		$("#loginbtn").click(function (){
			Login();
		})

		$(document).keydown(function (event){
			var code=event.keyCode;
			if (code==13){
				Login();
			}
		})
	})
	//普通自定义的方法必须在$(function)外面
	//登录操作
	function Login(){
		//验证账号密码不能为空
		//去除文本中的左右空格，使用$.trim(文本)
		var loginAct=$.trim($("#loginAct").val());
		var loginPwd=$.trim($("#loginPwd").val());
		if (loginAct==""||loginPwd==""){
			$("#msg").html("账号密码不能为空");
			return  false;
		}

		$.ajax({
				url:"settings/use/login.do",
				dataType:"json",
				data:{
					"loginAct":loginAct,
					"loginPwd":loginPwd
				},
				type:"post",
				success:function (data){
						if (data.success){

							window.location.href="workbench/index.jsp";
						}else {
							$("#msg").html(data.msg);
						}
				}
		})

	}
</script>
</head>
<body>
	<div style="position: absolute; top: 0px; left: 0px; width: 60%;">
		<img src="image/IMG_7114.JPG" style="width: 100%; height: 90%; position: relative; top: 50px;">
	</div>
	<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
		<div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: #ffffff; font-family: 'times new roman'">CRM &nbsp;<span style="font-size: 12px;">&copy;2017&nbsp;动力节点</span></div>
	</div>
	
	<div style="position: absolute; top: 120px; right: 100px;width:450px;height:400px;border:1px solid #D5D5D5">
		<div style="position: absolute; top: 0px; right: 60px;">
			<div class="page-header">
				<h1>登录</h1>
			</div>
			<form action="workbench/index.html" class="form-horizontal" role="form">
				<div class="form-group form-group-lg">
					<div style="width: 350px;">
						<input class="form-control" type="text" placeholder="用户名" id="loginAct">
					</div>
					<div style="width: 350px; position: relative;top: 20px;">
						<input class="form-control" type="password" placeholder="密码" id="loginPwd">
					</div>
					<div class="checkbox"  style="position: relative;top: 30px; left: 10px;">
						
							<span id="msg" style="color: red"></span>
						
					</div>
					<button type="button" id="loginbtn" class="btn btn-primary btn-lg btn-block"  style="width: 350px; position: relative;top: 45px;">登录</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>