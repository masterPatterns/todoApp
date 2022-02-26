<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</head>
<body class="vsc-initialized">
	<div class="container">
		<div class="col-md-5 col-lg-4 order-md-last">
			<div class="input-group">
		      <input type="text" id="titleTodo" class="form-control" placeholder="Add Todo here">
		      <button type="submit" id="addTodo" class="btn btn-secondary"><span class="">+</span></button>
		    </div>
		</div>
		<div id="todoList">
<!-- 			<div class="form-check"> -->
<!-- 				<input type="checkbox" id="todo0" class="form-check-input" name="todo0" value="todo0"> -->
<!-- 				<label class="form-check-label" for="todo0">Todo 컴포넌트 만들기1</label> -->
<!-- 				<button type="submit" class="btn btn-secondary delBtn"><span>삭제</span></button> -->
<!-- 			</div> -->
<!-- 			<div class="form-check"> -->
<!-- 				<input type="checkbox" id="todo0" class="form-check-input" name="todo0" value="todo0"> -->
<!-- 				<label class="form-check-label" for="todo0">Todo 컴포넌트 만들기2</label> -->
<!-- 				<button type="submit" class="btn btn-secondary delBtn"><span>삭제</span></button> -->
<!-- 			</div> -->
		</div>
	</div>
</body>

<script type="text/javascript">
	var newTodoNum = 0;
	document.addEventListener("DOMContentLoaded", () => {
		httpSend("GET", "/todo?userId=user1", null);
		
		var testList = new Array() ;
		document.getElementById("addTodo").addEventListener("click", function(e) {
			var title = document.getElementById("titleTodo").value;
			
// 			var list = "";
// 			list += '<div class="form-check">';
// 			list += '	<input type="checkbox" id="newTodo' + newTodoNum + '" class="form-check-input" name="newTodo' + newTodoNum + '">';
// 			list += '	<label class="form-check-label" for="newTodo' + newTodoNum + '">' + title + '</label>';
// 			list += '	<button type="submit" class="btn btn-secondary delBtn">삭제</button>';
// 			list += '</div>';
// 			document.getElementById("todoList").innerHTML += list;
// 			newTodoNum++;
			
			var data = new Object() ;
			data.title = title;
			httpSend("POST", "/todo?userId=user1", data);
		});
		
		document.querySelector('#todoList').addEventListener("click", function(e) {
			var childs = e.target.parentNode.childNodes;
			if(e.target.tagName == "BUTTON") {
				var data = new Object() ;
				data.id = childs[0].value;
				data.done = childs[0].checked;
				data.title = childs[1].outerText;
				
// 				e.target.parentNode.remove();
				httpSend("DELETE", "/todo?userId=user1", data);
			} else if(e.target.tagName == "INPUT") {
				var data = new Object() ;
				data.id = childs[0].value;
				data.done = childs[0].checked;
				data.title = childs[1].outerText;
				
				httpSend("PUT", "/todo?userId=user1", data);
			}
		});

	});
	
	
	function httpSend(http, url, data) {
		const req = new XMLHttpRequest();
		req.open(http, url, true);
		req.responseType = 'json';
		req.setRequestHeader('Content-Type', 'application/json; charset=UTF-8;');
		
		req.onreadystatechange = (e) => {
			const { target } = event;
			
			if(req.readyState === XMLHttpRequest.DONE) {
				const { status } = target;
				
				if (status === 0 || (status >= 200 && status < 400)) {
					success(http);
				} else {
					faile();
				}
			}
		}
		
		if(data != null && data != "") {
			console.log(data + " : " + JSON.stringify(data));
			req.send(JSON.stringify(data));
		} else {
			console.log("data 없음");
			req.send();
		}
		
		function success(http) {
			var list = req.response;
			var data = list.data;
			console.log(JSON.stringify(list));
			console.log(list.error);
			console.log(data.length);
			if(list.error == null && http == "GET") {
				document.getElementById("todoList").innerHTML = "";
				var list = "";
				for(var i = 0; i < data.length; i++) {
// 					data[i].done;
					list += '<div class="form-check">';
					if(data[i].done == true) {
						list += '<input type="checkbox" id="todo' + i + '" class="form-check-input" name="todo' + i + '" value="' + data[i].id + '" checked>';
					} else {
						list += '<input type="checkbox" id="todo' + i + '" class="form-check-input" name="todo' + i + '" value="' + data[i].id + '">';
					}
					list += '<label class="form-check-label" for="todo' + i + '">' + data[i].title + '</label>';
					list += '<button type="submit" class="btn btn-secondary delBtn">삭제</button>';
					list += '</div>';
				}
				document.getElementById("todoList").innerHTML = list;
			} else if(list.error == null && (http == "POST" || http == "DELETE")) {
				document.getElementById("titleTodo").value = "";
				httpSend("GET", "/todo?userId=user1", null);
			}
		}
		
		function faile() {
			alert("실패");
		}
	}
	
	
	
</script>
</html>