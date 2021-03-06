<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>上传DEMO</title>
<link rel="stylesheet" type="text/css" href="lib/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="lib/bootstrap-3.3.7-dist/css/bootstrap-theme.min.css">
<link rel="stylesheet" type="text/css" href="lib/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="style/style.css">
<link rel="stylesheet" type="text/css" href="lib/webuploader-0.1.5/webuploader.css">
<script type="text/javascript" src="lib/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="lib/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="lib/webuploader-0.1.5/webuploader.js"></script>
<script type="text/javascript">
	//图片上传demo
	jQuery(function() {
		var $ = jQuery;
		var $list = $('#fileList');
		// 优化retina, 在retina下这个值是2
		var ratio = window.devicePixelRatio || 1;
		// 缩略图大小
		var thumbnailWidth = 100 * ratio;
		var thumbnailHeight = 100 * ratio;
		// 初始化Web Uploader
		var uploader = WebUploader.create({
			// 自动上传。
			auto : true,
			// swf文件路径
			swf : 'lib/webuploader-0.1.5/Uploader.swf',
			// 文件接收服务端。
			server : 'uploadImage',
			// 选择文件的按钮。可选。
			// 内部根据当前运行是创建，可能是input元素，也可能是flash.
			pick : '#filePicker',
			// 只允许选择文件，可选。
			accept : {
				title : 'Images',
				extensions : 'jpg,jpeg,png',
				mimeTypes : 'image/jpg,image/jpeg,image/png'
			}
		});

		// 当有文件添加进来的时候
		uploader.on('fileQueued', function(file) {
			var $li = $('<div id="' + file.id + '" class="file-item thumbnail"><img><div class="info">' + file.name + '</div></div>');
			var $img = $li.find('img');
			$list.append($li);
			// 创建缩略图
			uploader.makeThumb(file, function(error, src) {
				if (error) {
					$img.replaceWith('<span>不能预览</span>');
					return;
				}
				$img.attr('src', src);
			}, thumbnailWidth, thumbnailHeight);
		});

		// 文件上传过程中创建进度条实时显示。
		uploader.on('uploadProgress', function(file, percentage) {
			var $li = $('#' + file.id);
			var $percent = $li.find('.progress span');
			// 避免重复创建
			if (!$percent.length) {
				$percent = $('<p class="progress"><span></span></p>').appendTo($li).find('span');
			}
			$percent.css('width', percentage * 100 + '%');
		});

		// 文件上传成功，给item添加成功class, 用样式标记上传成功。
		uploader.on('uploadSuccess', function(file, response) {
			alert('getImage?file=' + response.fileName);
			$('#' + file.id).addClass('upload-state-done');
		});

		// 文件上传失败，现实上传出错。
		uploader.on('uploadError', function(file) {
			var $li = $('#' + file.id);
			var $error = $li.find('div.error');
			// 避免重复创建
			if (!$error.length) {
				$error = $('<div class="error"></div>').appendTo($li);
			}
			$error.text('上传失败');
		});

		// 完成上传完了，成功或者失败，先删除进度条。
		uploader.on('uploadComplete', function(file) {
			$('#' + file.id).find('.progress').remove();
		});
	});
</script>
</head>
<body>
	<div id="uploader-demo">
		<div id="fileList" class="uploader-list"></div>
		<div id="filePicker">选择图片</div>
	</div>
</body>
</html>