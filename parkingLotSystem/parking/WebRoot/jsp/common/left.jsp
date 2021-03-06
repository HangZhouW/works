<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<style>
#mgr{background:#6FB7FF;}
#mgr:hover{background:#0080FF;}
#query{background:#8BF3AA;}
#query:hover{background:#3CEA67;}
#integration{background:#E0A7DF;}
#integration:hover{background:#C161DA;}
#welcome{background:#FFA980;}
#welcome:hover{background:#EE9A49;}
#userCenter{background:#C0C0C0;}
#userCenter:hover{background:#7F7F7F;}
.leftDiv{border-radius:20px;width:260px;height:100px;border:1px solid #6B6B6B;margin:15px auto;line-height: 100px;font-size: 24px;}
.leftDiv:hover{border:2px solid #FFFFFF;}
.leftA{text-decoration: none;color:#fff;font-family:"Arial","Microsoft YaHei","黑体","宋体",sans-serif;}

#ctrlUsers{background:#FF8C69;}
#ctrlUsers:hover{background:#FF6347;}

#setting{background:#C0C0C0;}
#setting:hover{background:#969696;}

#first{background:#4EEE94;}
#first:hover{background:#00FA9A;}

#performanceQuery{background:#40E0D0;}
#performanceQuery:hover{background:#00CED1;}

#ctrlParkingLot{background:#8470FF;}
#ctrlParkingLot:hover{background:#8A2BE2;}
</style>
<s:if test="%{#session.user.status!=1}">
	<a class="leftA" href="<%=basePath%>toWel" target="rightFrame">
		<div id="welcome" class="leftDiv">公告通知</div>
	</a>
	<a class="leftA" href="<%=basePath%>getSpace" target="rightFrame">
		<div id="mgr" class="leftDiv">停车</div>
	</a>
	<a class="leftA" href="<%=basePath%>toQuery" target="rightFrame">
		<div id="query" class="leftDiv">查询</div>
	</a>
	<a class="leftA" href="<%=basePath%>toIntegration" target="rightFrame">
		<div id="integration" class="leftDiv">积分抽奖</div>
	</a>
	<a class="leftA" href="<%=basePath%>toUserCenter" target="rightFrame">
		<div id="userCenter" class="leftDiv">用户中心</div>
	</a>
</s:if>
<s:else>
	<a class="leftA" href="<%=basePath%>toWel" target="rightFrame">
		<div id="first" class="leftDiv">首页</div>
	</a>
	<a class="leftA" href="<%=basePath%>toCtrlUser" target="rightFrame">
		<div id="ctrlUsers" class="leftDiv">用户管理</div>
	</a>
	<a class="leftA" href="<%=basePath%>toOutStanding" target="rightFrame">
		<div id="performanceQuery" class="leftDiv">业绩查询</div>
	</a>
	<a class="leftA" href="<%=basePath%>toSettings" target="rightFrame">
		<div id="setting" class="leftDiv">保护伞</div>
	</a>
	<a class="leftA" href="<%=basePath%>toCtrlPS" target="rightFrame">
		<div id="ctrlParkingLot" class="leftDiv">车库管理</div>
	</a>
</s:else>