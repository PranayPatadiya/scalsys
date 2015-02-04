<script type="text/javascript">

window.onload = function() {

var canvas = new fabric.Canvas('canvas');
canvas.setHeight($(".canvasDiv").height());
canvas.setWidth($(".canvasDiv").width());

$("#canvas").css("border","1px solid black");
canvas.renderAll();

jQuery(document).ready( function() {

$("#draw").click(function(){
	$("#text_div").hide(); $("#bg_div").hide();
	canvas.isDrawingMode = true;
	canvas.freeDrawingLineWidth = 5;
	canvas.renderAll();
	canvas.calcOffset();
});
	
$("#rect").click(function(){
	$("#text_div").hide(); $("#bg_div").hide();
	  var mouse_pos = { x:0 , y:0 };
	  canvas.isDrawingMode = false;
	  canvas.observe('mouse:down', function(e) {
	  mouse_pos = canvas.getPointer(e.e);
	  canvas.add(new fabric.Rect({
	    left: mouse_pos.x,
	    top: mouse_pos.y,
	    width: 75,
	    height: 50,
	    fill: '',
	    stroke: 'black',
	    strokeWidth: 3,
	    padding: 10
	 }));
		 canvas.off('mouse:down');
	});
});
	
$("#circle").click(function(){
	$("#text_div").hide(); $("#bg_div").hide();
	  var mouse_pos = { x:0 , y:0 };
	  canvas.isDrawingMode = false;
	  canvas.observe('mouse:down', function(e) {
	  mouse_pos = canvas.getPointer(e.e);
	  canvas.add(new fabric.Circle({
	    left: mouse_pos.x,
	    top: mouse_pos.y,
	    radius: 30,
	    fill: '',
	    stroke: 'black',
	    strokeWidth: 3
	  }));
	  canvas.off('mouse:down');
	  });
});	
	
$("#line").click(function(){
	$("#text_div").hide(); $("#bg_div").hide();
	
	canvas.isDrawingMode = false;
	if (canvas.getContext) {
	    var context = canvas.getContext('2d');
	}

	canvas.observe('mouse:down', function(e) { mousedown(e); });
	canvas.observe('mouse:move', function(e) { mousemove(e); });
	canvas.observe('mouse:up', function(e) { mouseup(e); });

	var started = false;
	var startX = 0;
	var startY = 0;

	/* Mousedown */
	function mousedown(e) {
	    var mouse = canvas.getPointer(e.e);
	    started = true;
	    startX = mouse.x;
	    startY = mouse.y;
	    canvas.off('mouse:down');
	}

	/* Mousemove */
	function mousemove(e) {
	    if(!started) {
	        return false;
	    }
	    canvas.off('mouse:move');
	}

	/* Mouseup */
	function mouseup(e) {
	    if(started) {
	        var mouse = canvas.getPointer(e.e);
	        canvas.add(new fabric.Line([startX, startY, mouse.x, mouse.y],{ stroke: "#000000", strokeWidth: 2 }));
	        canvas.renderAll();
	        canvas.calcOffset(); 

	        started = false;
	        canvas.off('mouse:up');
	    }   
	 }
});	
	

$("#text_done").click(function(){
	if($('#text').val() == ''){
		alert('<liferay-ui:message key="com-scalsys-alert-enter-text" />');
		return;
	}
	
	canvas.isDrawingMode = false;
    if (canvas.getContext) {
        var context = canvas.getContext('2d');
    }

    var text, size, color;
    var mouse_pos = { x:0 , y:0 };

    text = $('#text').val();
    size = $('#size').val();
    color = $('#color').val();

    canvas.observe('mouse:down', function(e) {

    mouse_pos = canvas.getPointer(e.e);
    size = parseInt(size, 10);

    canvas.add(new fabric.Text(text, {
    	fontFamily: 'Arial',
        fontSize: size,
        left: mouse_pos.x,
        top: mouse_pos.y,
        textAlign: "left",
        fontWeight: 'bold'
      }));
        canvas.off('mouse:down');
        canvas.renderAll();
        canvas.calcOffset();
     });
    $('#text').val(''); 
});
	
$("#text_cancle").click(function(){
	$('#text').val(''); $("#text_div").hide();
});

$("#text_input").click(function(){
	 $("#bg_div").hide();  $("#text_div").show();
});

$("#remove").click(function(){
	$("#text_div").hide(); $("#bg_div").hide();

	canvas.isDrawingMode = false;

    var activeObject = canvas.getActiveObject(),
    activeGroup = canvas.getActiveGroup();
    if (activeObject) {
        if (confirm('<liferay-ui:message key="com-scalsys-alert-are-you-sure" />')) {
            canvas.remove(activeObject);
        }
    }
    else if (activeGroup) {
        if (confirm('<liferay-ui:message key="com-scalsys-alert-are-you-sure" />')) {
            var objectsInGroup = activeGroup.getObjects();
            canvas.discardActiveGroup();
            objectsInGroup.forEach(function(object) {
            canvas.remove(object);
            });
        }
    }
});

$("#clear").click(function(){
	$("#text_div").hide(); $("#bg_div").hide();
	
    canvas.isDrawingMode = false;
    if (confirm('Are you sure?')) {
        canvas.clear();
        resetBackground();
    }
});

$("#background").click(function(){
	$("#bg_div").show(); $("#text_div").hide();
});

$("#upload").change(function(e) {
	//var file = e.target.files[0],
	//imageType = /image.*/;

	/* if (!file.type.match(imageType))
   		return;
	
	var reader = new FileReader();
	reader.onload = fileOnload;
	reader.readAsDataURL(file); */
	
	 var reader = new FileReader();
     reader.onload = function (event){
     	var imgObj = new Image();
     	imgObj.src = event.target.result;
		imgObj.onload = function () {
     		var image = new fabric.Image(imgObj);
		     image.set({
		         angle: 0,
		         padding: 10,
		         cornersize:10,
		      });
		     
			var center = canvas.getCenter();
		     canvas.setBackgroundImage(imgObj.src, canvas.renderAll.bind(canvas), {
		             scaleX: canvas.width / imgObj.width,
		             scaleY: canvas.height / imgObj.height,
		             top: center.top,
		             left: center.left,
		             originX: 'center',
		             originY: 'center'
		         });
		         canvas.renderAll();
		     }
 		}
 	reader.readAsDataURL(e.target.files[0]);
 	$("#upload").val('');
	$("#bg_div").hide();
});

function fileOnload(e) {
	canvas.setBackgroundImage(e.target.result, canvas.renderAll.bind(canvas));
	$("#upload").val('');
	$("#bg_div").hide();
}

$("#print").click(function(e) {
	$("#text_div").hide(); $("#bg_div").hide();
	var canvas1 = document.getElementById("canvas");
	var win=window.open();
	win.document.write("<img src='"+canvas.toDataURL()+"'></img>");
    win.print();
 });
 
$("#bg_reset").click(function(e) {
	resetBackground();
});

$("#bg_cancle").click(function(e) {
	$("#upload").val('');
	$("#bg_div").hide();
});

function resetBackground(){
	canvas.backgroundImage = 0;
	canvas.backgroundColor = '#FFFFFF';
	canvas.renderAll();
}
});
}
</script>