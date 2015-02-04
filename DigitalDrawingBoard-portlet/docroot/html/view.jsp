<%@ include file="init.jsp" %>

<div id="<portlet:namespace />mainDiv">
	<div class="tab-pane">
		<img src="<%= request.getContextPath()%>/images/pen.png" id="draw" title='<liferay-ui:message key='com-scalsys-tooltip-pen' />'>
		<img src="<%= request.getContextPath()%>/images/rectangle.png" id="rect"  title='<liferay-ui:message key='com-scalsys-tooltip-rectangle' />'>
		<img src="<%= request.getContextPath()%>/images/circle.png" id="circle" title='<liferay-ui:message key='com-scalsys-tooltip-circle' />'>
		<img src="<%= request.getContextPath()%>/images/line.png" id="line" title='<liferay-ui:message key='com-scalsys-tooltip-line' />'>
		<img src="<%= request.getContextPath()%>/images/text.png" id="text_input" title='<liferay-ui:message key='com-scalsys-tooltip-text' />'>
		<img src="<%= request.getContextPath()%>/images/background.png" id="background" title='<liferay-ui:message key='com-scalsys-tooltip-background' />'>
		<img src="<%= request.getContextPath()%>/images/trash.png" id="remove" title='<liferay-ui:message key='com-scalsys-tooltip-remove-selected' />' >
		<img src="<%= request.getContextPath()%>/images/cross.png" id="clear" title='<liferay-ui:message key='com-scalsys-tooltip-clear' />'>
		<img src="<%= request.getContextPath()%>/images/print.png" id="print" title='<liferay-ui:message key='com-scalsys-tooltip-print' />'>
	</div>
	<div style="display: none;" id="text_div">
		<input id="text" name="text" class="cg-form-control" type="text" size="40" placeholder='<liferay-ui:message key='com-scalsys-input-text-here' />' value=""> 
		<input id="size" class="cg-form-control" style="width: 30px;" name="size" type="text" size="3" value="18"> 
		<img src="<%= request.getContextPath()%>/images/done.png" id="text_done" title='<liferay-ui:message key='com-scalsys-done-changes' />' class="icon_style">
		<img src="<%= request.getContextPath()%>/images/cross.png" id="text_cancle" title='<liferay-ui:message key='com-scalsys-cancle' />' class="icon_style">
	</div>
	
	<div style="display: none;" id="bg_div">
		<input type="file" id="upload" class="cg-form-control" title='<liferay-ui:message key='com-scalsys-tooltip-select-background-img' />'>
		<img src="<%= request.getContextPath()%>/images/reset.png" id="bg_reset" title='<liferay-ui:message key='com-scalsys-tooltip-reset-background' />' class="icon_style2">
		<img src="<%= request.getContextPath()%>/images/cross.png" id="bg_cancle" title='<liferay-ui:message key='com-scalsys-cancle' />' class="icon_style2">
	</div>
	<div style="width: 100%;height: 500px;" class="canvasDiv">
		<canvas id="canvas" ></canvas>
	</div>
</div>
<%@ include file="view_js.jsp" %>
