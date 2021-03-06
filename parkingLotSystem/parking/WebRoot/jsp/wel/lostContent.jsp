<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<style type="text/css">
	#lostAndFound{width:100%;}
	#lostAndFound .noticeUl{list-style: none;}
	#lostAndFound a{margin-left:20px;}
	#lostTable{margin:15px auto;width:95%;font-family:"Arial","Microsoft YaHei","黑体","宋体",sans-serif;color:#000080;}
	#lostTable td{padding-top:10px;}
</style>
<script>
	function deleteLost(id){
		top.$.messager.confirm('提示','确定删除当前寻物启事吗？',function(r){    
		    if (r){
		       location.href="<%=basePath %>adminDelLost.action?lost_id="+id;
		    }
		});
	}
</script>
<div id="lostAndFound">
	<a href="<%=basePath %>getLosts" target="welRight">
		<img src="<%=basePath %>images/icons/welright.png"></img>
	</a>
	<s:if test="%{#session.user.status==1}">
		<div style="float:right;margin-right:25px;"><a style="text-decoration:none;color:#000080;" href="javascript:;" onclick="deleteLost(<s:property value='lostAndFound.id'/>)"/><img align="absmiddle" src="<%=basePath %>images/icons/delNotice.png"></img>删除</a></div>
	</s:if>
	<table id="lostTable">
	<tr>
		<td><img src="<%=basePath%>images/icons/thingIcon.png" align="absmiddle">失物:</td>
		<td><s:property value="lostAndFound.name"/></td>
	</tr>
	<tr>
		<td style="width:70px;"><img src="<%=basePath%>images/userName.png" align="absmiddle">失主:</td>
		<td><s:property value="lostAndFound.user.name"/></td>
	</tr>
	<tr>
		<td style="width:70px;"><img src="<%=basePath%>images/icons/publishTime.png" align="absmiddle">时间:</td>
		<td><s:date name="lostAndFound.publishDate" format="yyyy-MM-dd"/></td>
	</tr>
	<tr>
		<td style="width:70px;"><img src="<%=basePath%>images/phone.png" align="absmiddle">电话:</td>
		<td><s:property value="lostAndFound.user.phone"/></td>
	</tr>
	<tr>
		<td><img src="<%=basePath%>images/icons/content.png" align="absmiddle">详情:</td>
		<td>
			<s:property value="lostAndFound.description"/>
		</td>
	</tr>
</table>
</div>
