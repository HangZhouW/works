<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="java.text.*" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<script type="text/javascript" src="<%=basePath%>js/jquery-1.8.3.js"></script>
<style type="text/css">
body {
	font: 16px 宋体;
	font-weight: bold;
}

.register-area {
	margin: 0px auto;
	margin-top:10px;
	width: 600px;
}

.register-sub {
	background: #EE4000;
	width: 100px;
	height: 30px;
	color: #fff;
	margin-top: 25px;
	margin-left: 90px;
	cursor:pointer;
	border:1px solid #ccc;
}

.register-reset {
	background: #EE4000;
	width: 100px;
	height: 30px;
	color: #fff;
	margin-top: 25px;
	margin-left: 30px;
	cursor:pointer;
	border:1px solid #ccc;
}

.checkAcceptReg {
	background: #8B8386;
	width: 100px;
	height: 30px;
	color: #fff;
	margin-top: 25px;
	margin-left: 90px;
	cursor:pointer;
	border:1px solid #ccc;
}

.checkReset {
	background: #8B8386;
	width: 100px;
	height: 30px;
	color: #fff;
	margin-top: 25px;
	margin-left: 30px;
	cursor:pointer;
	border:1px solid #ccc;
}

#ulRegister li {
	margin-top: 17px;
}

input {
	margin-left: 4px;
}
#accept{font-size: 12px;margin-left:10px;color:#878787;}
span{font: 13px/1 Tahoma,Helvetica,Arial,"\5b8b\4f53",sans-serif;margin-left:5px;}
.warn{border:1px solid #FF0000;background:#FFD2D2;}
.inputRegister{border-radius:10px;border:solid rgb(100,100,100) 1px;width:220px;height:25px;outline:none;padding-left:4px;font-size:14px;}
.inputRegister:focus {border:1px solid #009ACD;}
.loginORregisterButtom{border-bottom:3px solid #009ACD;}
</style>
<script type="text/javascript">
	$(function(){
		top.window.document.getElementById("registerBorder").click();
	});
	
	
	function validateReg(){
		var userName=$("#userName").val();
		var realName=$("#realname").val();
		var password=$("#password").val();
		var confirmPwd=$("#confirmPwd").val();
		var phone=$("#phone").val();
		var address=$("#address").val();
		var email=$("#email").val();
		var flag=true;
		
		if ($.trim(address).length==0) {
			$("#address").focus();
			$("#address").addClass("warn");
			$("#address_tip").html("<font color='red'>地址不能为空</font>");
			flag=false;
		}
		if ($.trim(phone).length==0) {
			$("#phone").focus();
			$("#phone").addClass("warn");
			$("#phone_tip").html("<font color='red'>电话号码不能为空</font>");
			flag=false;
		}
		if ($.trim(confirmPwd).length==0) {
			$("#confirmPwd").focus();
			$("#confirmPwd").addClass("warn");
			$("#confirmPwd_tip").html("<font color='red'>确认密码不能为空</font>");
			flag=false;
		}
		if ($.trim(password).length==0) {
			$("#password").focus();
			$("#password").addClass("warn");
			$("#password_tip").html("<font color='red'>密码不能为空</font>");
			flag=false;
		}
		if ($.trim(realName).length==0) {
			$("#realname").focus();
			$("#realname").addClass("warn");
			$("#realname_tip").html("<font color='red'>真实姓名不能为空</font>");
			flag=false;
		}
		if ($.trim(userName).length==0) {
			$("#userName").focus();
			$("#userName").addClass("warn");
			$("#userName_tip").html("<font color='red'>昵称不能为空</font>");
			flag=false;
		}
		
		/* 判断输入格式是否符合标准 */
		if ($.trim(userName).length>30) {
			$("#userName").focus();
			$("#userName").addClass("warn");
			$("#userName_tip").html("<font color='red'>昵称长度不能超过30位</font>");
			flag=false;
		}
		if ($.trim(password).length!=0) {
			if ($.trim(password).length<6||$.trim(password).length>16) {
				$("#password").focus();
				$("#password").addClass("warn");
				$("#password_tip").html("<font color='red'>长度需在6~16位之间</font>");
				flag=false;
			}
		}
		if ($.trim(phone).length!=0) {
			if (!(/^1[34578]\d{9}$/.test(phone))) {
				$("#phone").focus();
				$("#phone").addClass("warn");
				$("#phone_tip").html("<font color='red'>请填写正确的电话号码</font>");
				flag=false;
			}
		}
		if ($.trim(address).length>100) {
			$("#address").focus();
			$("#address").addClass("warn");
			$("#address_tip").html("<font color='red'>地址长度超出支持范围</font>");
			flag=false;
		}
		if ($.trim(email).length!=0) {
			if (!(/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/.test(email))) {
				$("#email").focus();
				$("#email").addClass("warn");
				$("#email_tip").html("<font color='red'>邮箱格式有误</font>");
				flag=false;
			}
		}
		
		
		/* 判断两次密码输入是否一致 */
		if ($.trim(password).length>0&$.trim(confirmPwd).length>0) {
			if (confirmPwd!=password) {
				$("#confirmPwd").focus();
				$("#confirmPwd").addClass("warn");
				$("#confirmPwd_tip").html("<font color='red'>两次输入密码不一致</font>");
				flag=false;
			}
		}
		
		/* 非空验证过后 */
		if(flag){
			var data={"user.name":$("#userName").val(),"user.realname":$("#realname").val(),
				"user.password":$("#password").val(),"user.phone":$("#phone").val(),
				"user.address":$("#address").val(),"user.email":$("#email").val(),
				"user.regdate":$("#regdate").val(),"user.status":"0","user.integration":"0"};
			$.ajax({
				url:"<%=basePath%>register",
				type : "post",
				data : data,
				dataType : "json",
				error : function() {
					alert("连接失败");
				},
				success : function(data) {
					if (data.code == 0) {
						$("#userName").focus();
						$("#userName").addClass("warn");
						$("#userName_tip").html("<font color='red'>" + data.msg + "</font>");
					} else {
						alert(data.msg+",点击确定进入登录");
						top.location.href="<%=basePath%>toGetIn";
					}
				}
			});
		}
		;
	}
	/* 相应Enter */
	function go() {
		if (event.keyCode == 13) {
			$("#register").click();
		}
	}
	/* 键盘输入时判断输入框是否为空 */
	function checkNull(){
		var userName=$("#userName").val();
		var realName=$("#realname").val();
		var password=$("#password").val();
		var confirmPwd=$("#confirmPwd").val();
		var phone=$("#phone").val();
		var address=$("#address").val();
		var email=$("#email").val();
		
		if ($.trim(userName).length!=0) {
			$("#userName").removeClass("warn");
			$("#userName_tip").html("");
		}
		if ($.trim(realName).length!=0) {
			$("#realname").removeClass("warn");
			$("#realname_tip").html("");
		}
		if ($.trim(password).length!=0) {
			$("#password").removeClass("warn");
			$("#password_tip").html("");
		}
		
		if ($.trim(confirmPwd).length!=0) {
			$("#confirmPwd").removeClass("warn");
			$("#confirmPwd_tip").html("");
		}
		if ($.trim(phone).length!=0) {
			$("#phone").removeClass("warn");
			$("#phone_tip").html("");
		}
		if ($.trim(address).length!=0) {
			$("#address").removeClass("warn");
			$("#address_tip").html("");
		}
		if ($.trim(email).length!=0) {
			$("#email").removeClass("warn");
			$("#email_tip").html("");
		}
	}
	
	$(function(){
	    var regBtn = $("#register");
	    var reset=$("#reset");
	    $("#checkAccept").change(function(){
	        var that = $(this);
	        that.prop("checked",that.prop("checked"));
	        if(that.prop("checked")){
	            regBtn.prop("disabled",false);
	            reset.prop("disabled",false);
	            regBtn.removeClass("checkAcceptReg");
	        	reset.removeClass("checkReset");
	        }else{
	            regBtn.prop("disabled",true);
	            reset.prop("disabled",true);
	        	regBtn.addClass("checkAcceptReg");
	        	reset.addClass("checkReset");
	        	$("#userName").removeClass("warn");
				$("#userName_tip").html("");
				$("#realname").removeClass("warn");
				$("#realname_tip").html("");
				$("#password").removeClass("warn");
				$("#password_tip").html("");
				$("#confirmPwd").removeClass("warn");
				$("#confirmPwd_tip").html("");
				$("#phone").removeClass("warn");
				$("#phone_tip").html("");
				$("#address").removeClass("warn");
				$("#address_tip").html("");
				$("#email").removeClass("warn");
				$("#email_tip").html("");
	        }
	    });
	});
</script>
<%
	String datetime=new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
 %>
<div id="main-login">
	<div class="register-area" onkeypress="go()">
			<form id="fromReg" style="margin-left:100px;padding:0px auto;margin-top:35px;;width:500px;" oninput="checkNull()">
				<input type="hidden" id="regdate" value="<%=datetime %>" />
				<ul id="ulRegister" style="list-style: none;">
					<li><label for="userName"><img
							src="<%=basePath%>images/userName.png" align="absmiddle"></img>昵&nbsp;&nbsp;称<font color="#FF2626">*</font></label><input
						type="text" id="userName" class="inputRegister"/><span
						id="userName_tip"></span>
					</li>
					<li style="margin-left:-2px;"><label for="realName"><img
							src="<%=basePath%>images/realname.png" align="absmiddle"></img>真实姓名<font color="#FF2626">*</font></label><input
						type="text" id="realname" class="inputRegister" /><span
						id="realname_tip"></span>
					</li>
					<li style="margin-left:-2px;"><label for="password"><img
							src="<%=basePath%>images/password.png" align="absmiddle"></img>密&nbsp;&nbsp;码<font color="#FF2626">*</font></label><input
						type="password" id="password" class="inputRegister" /><span
						id="password_tip"></span></li>
					<li style="margin-left:-4px;"><label for="confirm"><img
							src="<%=basePath%>images/confirm.png" align="absmiddle"></img>确认密码<font color="#FF2626">*</font></label><input
						type="password" id="confirmPwd" class="inputRegister"/><span
						id="confirmPwd_tip"></span>
					</li>
					<li style="margin-left:-2px;"><label for="phone"><img
							src="<%=basePath%>images/phone.png" align="absmiddle"></img>电话号码<font color="#FF2626">*</font></label><input
						type="text" id="phone" class="inputRegister" /><span id="phone_tip"></span>
					</li>
					<li><label for="address"><img
							src="<%=basePath%>images/address.png" align="absmiddle"></img>地&nbsp;&nbsp;址<font color="#FF2626">*</font></label><input
						type="text" id="address"  class="inputRegister"/><span
						id="address_tip"></span></li>
					<li><label for="email"><img
							src="<%=basePath%>images/email.png" align="absmiddle"></img>电子邮件<font color=""> </font></label><input
						type="text" id="email" class="inputRegister" /><span id="email_tip"></span>
					</li>
					<li id="accept"><input type="checkbox" id="checkAccept" checked="checked"/>我已阅读并同意<a href="javascript:;" onclick="top.location.href='<%=basePath%>accept'">服务条框</a>(Accept)</li>
				</ul>
				<input type="button" id="register" class="register-sub" value="注册"
					onclick="validateReg()" />&nbsp; <input id="reset" class="register-reset"
					type="reset" onclick="location.href='<%=basePath%>toRegister'"/>
			</form>
			<img style="margin-left:500px;" src="<%=basePath%>images/register.png"></img>
	</div>
</div>
