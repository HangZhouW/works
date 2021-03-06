<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.text.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<style type="text/css">
	#plost{width:100%;}
	#lostTable{margin-top:30px;margin:10px auto;font-family:"Arial","Microsoft YaHei","黑体","宋体",sans-serif;color:#000080;}
	#lostTable td{padding-top:10px;}
	#publishLost{margin-top:30px;width:120px;height:28px;border-radius:10px;border:solid rgb(100,100,100) 1px;outline:none; -webkit-appearance:none;cursor: pointer;background:#68228B;color:#fff;}
	span{font: 13px/1 Tahoma,Helvetica,Arial,"\5b8b\4f53",sans-serif;margin-left:5px;}
	.warn{border:1px solid #FF0000;background:#FFD2D2;}
</style>
<script type="text/javascript" src="<%=basePath %>js/jquery-1.8.3.js"></script>
<script type="text/javascript">
	function clickLost(){
		var flag=true;
		var thing=$("#thing").val();
		var des=$("#des").val();
		var phone=$("#phone").val();
		
		if ($.trim(des).length==0) {
			$("#des_tip").html("<font color='red'>请详细描述</font>");
			$("#des").addClass("warn");
			$("#des").focus();
			flag=false;
		}
		
		if ($.trim(thing).length==0) {
			$("#thing_tip").html("<font color='red'>请填写失物名称</font>");
			$("#thing").addClass("warn");
			$("#thing").focus();
			flag=false;
		}
		
		if ($.trim(phone).length==0) {
			$("#phone_tip").html("<font color='red'>请填写联系电话</font>");
			$("#phone").addClass("warn");
			$("#phone").focus();
			flag=false;
		}
		if ($.trim(phone).length!=0) {
			if (!(/^1[34578]\d{9}$/.test(phone))) {
				$("#phone").focus();
				$("#phone").addClass("warn");
				$("#phone_tip").html("<font color='red'>请填写正确的电话号码</font>");
				flag=false;
			}
		}
		if (flag) {
			$("#lostForm").submit();
		}
	}
	
	function checkNull() {
		var thing=$("#thing").val();
		var des=$("#des").val();
		var phone=$("#phone").val();
		if ($.trim(thing).length > 0) {
			$("#thing_tip").html("");
			$("#thing").removeClass("warn");
		}
		if ($.trim(des).length > 0) {
			$("#des_tip").html("");
			$("#des").removeClass("warn");
		}
		if ($.trim(phone).length > 0) {
			$("#phone_tip").html("");
			$("#phone").removeClass("warn");
		}
	}
</script>
<%
	String datetime=new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
 %>
<div id="plost">
	<a style="margin-left:20px;" href="<%=basePath %>getLosts" target="welRight">
		<img src="<%=basePath %>images/icons/welright.png"></img>
	</a>
	<form id="lostForm" action="<%=basePath %>addLost.action" method="post" oninput="checkNull()">
		<input type="hidden" name="lostAndFound.status" value="0"/>
		<input type="hidden" name="lostAndFound.publishDate" value="<%=datetime%>"/>
		<table id="lostTable">
			<tr>
				<td colspan="2" style="text-align:center;"><font size="5">寻物启事</font></td>
			</tr>
			<tr>
				<td><img src="<%=basePath%>images/icons/thingname.png" align="absmiddle">物品名称</td>
				<td><input id="thing" type="text" name="lostAndFound.name"/></td>
				<td><span id="thing_tip"></span></td>
			</tr>
			<tr>
				<td style="margin-top:-20px;"><img src="<%=basePath%>images/icons/desc.png" align="absmiddle">详情描述</td>
				<td><textarea id="des" rows="4" cols="30"  name="lostAndFound.description"></textarea></td>
				<td><span id="des_tip"></span></td>
			</tr>
			<tr>
				<td><img src="<%=basePath%>images/phone.png" align="absmiddle">联系电话</td>
				<td><input id="phone" type="text" value="${user.phone }"/></td>
				<td><span id="phone_tip"></span></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align:center;">
					<input type="button" id="publishLost" onclick="clickLost()" value="提交"/>
				</td>
			</tr>
		</table>
	</form>
</div>
