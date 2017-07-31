<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>上传DEMO</title>
<link rel="stylesheet" type="text/css" href="js/uploadify/uploadify.css">
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/uploadify/jquery.uploadify.min.js"></script>
<script type="text/javascript">
    $(function() {
        $("#file_upload").uploadify({
            'height'        : 27,
            'width'         : 80, 
            'buttonText'    : '选择图片',
            'swf'           : '${pageContext.request.contextPath}/js/uploadify/uploadify.swf',
            'uploader'      : '${pageContext.request.contextPath}/uploadImage',
            'auto'          : true,
            'multi'         : false,
            'removeCompleted':false,
            'cancelImg'     : '${pageContext.request.contextPath}/js/uploadify/uploadify-cancel.png',
            'fileTypeExts'  : '*.jpg;*.jpge;*.gif;*.png',
            'fileSizeLimit' : '2MB',
            'onUploadSuccess':function(file,data,response){
                $('#' + file.id).find('.data').html('');
                $("#file_upload_name").val(data);
                $("#file_upload_img").attr("src","${pageContext.request.contextPath}/getImage?file="+data);  
                $("#file_upload_img").show();
            },
            //加上此句会重写onSelectError方法【需要重写的事件】
            'overrideEvents': ['onSelectError', 'onDialogClose'],
            //返回一个错误，选择文件的时候触发
            'onSelectError':function(file, errorCode, errorMsg){
                switch(errorCode) {
                    case -110:
                        alert("文件 ["+file.name+"] 大小超出系统限制的" + jQuery('#file_upload').uploadify('settings', 'fileSizeLimit') + "大小！");
                        break;
                    case -120:
                        alert("文件 ["+file.name+"] 大小异常！");
                        break;
                    case -130:
                        alert("文件 ["+file.name+"] 类型不正确！");
                        break;
                }
            }
        });
    });
</script>
</head>
<body>
	<input type="file" name="file_upload" id="file_upload" />
	<img style="display: none" id="file_upload_img" src="" width="150"
		height="150" />
	<input type="hidden" name="file_upload_name"
		id="file_upload_name" />
</body>
</html>