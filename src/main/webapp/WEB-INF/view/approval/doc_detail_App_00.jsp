<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%	request.setCharacterEncoding("UTF-8");%>
<%	response.setContentType("text/html; charset=UTF-8");%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상신된 문서 결재 중 문서 보기</title>
</head>
<script src="./js/common/jquery-3.1.1.min.js"></script>
<script src="./js/common/bootstrap.min.js"></script>
<script src="./js/common/map.js"></script>
<script src="./js/approval/dragDropFile.js"></script>
<script type="text/javascript" src="js/approval/approvalLine.js"></script>

<script type="text/javascript" src="js/approval/detailApp.js"></script>
<script type="text/javascript" src='./js/common/sweetalert.min.js?ver=1'></script>
<script src="js/approval/approvalLine.js"></script>

<link rel="stylesheet" type="text/css"
	href='./css/common/sweetalert.css?ver=1.2'>
<link rel="stylesheet" href="./css/common/bootstrap.min.css">
<link rel="stylesheet" href="./css/common/bootstrap-theme.min.css">
<!-- <link rel="stylesheet" href="./css/board/dragDropFile.css"> -->
<link rel="stylesheet" type="text/css" href="css/approval/docWrite.css">
<link rel="stylesheet" type="text/css" href="css/approval/list.css">
<script type="text/javascript"
	src="./resources/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
$(function() {
		//전역변수
		var obj = [];
		//스마트에디터 프레임생성
		nhn.husky.EZCreator.createInIFrame({
			oAppRef : obj,
			elPlaceHolder : "editor",
			sSkinURI : "./resources/editor/SmartEditor2Skin.html",
			htParams : {
				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseToolbar : true,
				// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseVerticalResizer : true,
				// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				bUseModeChanger : true,
			}
		});
	});


//replyForm
function replyService(){
	var theForm = document.replyForm;
	var theData = $("#replyForm").serialize();

    if(theForm.ar_content.value==""){
		alert("답글 내용을 입력해주세요.");
	}else{
		$.ajax({
			type : 'post',
			url : './replyProcess.do',
			data : theData,
			success : function(data) {
				alert("성공");
				window.location.reload(true);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("페이지에 오류가 발생했습니다.");
			}
		});
	}
}

function replydelete(ar_no){
	var yn = confirm("삭제하시겠습니까?");
	alert(ar_no);
	var doc_mngno = ${doclist[0].doc_mngno};
	alert(doc_mngno);
	
	if(yn){
		$.ajax({
			type : 'post',
			url : './replydeleteProcess.do',
			data : "ar_no="+ar_no+"&doc_mngno="+doc_mngno,
			success : function(data) {
				alert("성공");
				window.location.reload(true);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("페이지에 오류가 발생했습니다.");
			}
		});
	}
}
</script>
<body>
	<div class="container">
		<h1>결 재</h1>
		<table class="table table-bordered">
			<tr>
				<td colspan="4" style="text-align:right;"><input type="button" class="btn btn-primary" value="완료"
					onclick="appSave()" /></td>
			</tr>
			<form name="approvalForm" id="approvalForm">
				<tr>
				<%-- 	<td colspan="2"><input type="text" id="doc_Template_title"
						name="doc_Template_title" value="${doclist[0].temp_no}" readonly="readonly" /> --%>
					<input type="hidden" id="session_memno" value="${memDto.mem_no}" />
					<input type="hidden" id="doclist1_memno" value="${doclist[1].mem_no}" />
					<input type="hidden" id="doclist2_memno" value="${doclist[2].mem_no}" />
						</td> 
					<td colspan="4">
						<table class="table table-bordered center">
							<tr>
								<td style="width:33%;">담당자</td>
								<td style="width:33%;">결재자</td>
								<td style="width:33%;">책임자</td>
							</tr>
							<tr>
								<td><p id="app_order_002">
										<input type='text' id='app2' name='app2' readonly="readonly"
											value="${doclist[0].doc_writer}" /><br>
									<div id="demo00"></div>
									</p></td>
								<td><p id="app_order_001">
										<input type="text" id="mem_no_1" name="mem_no_1"
											readonly="readonly" value="${doclist[1].mem_no}" />
									<div id="demo">${doclist[1].app_status}</div>
									</p></td>
								<td><p id="app_order_000">
										<input type="text" id="mem_no_2" name="mem_no_2"
											readonly="readonly" value="${doclist[2].mem_no}" />
									<div id="demo2">${doclist[2].app_status}</div>
									</p></td>
							</tr>
						</table>
					</td>
				</tr>
			</form>



			<form name="documentForm" id="documentForm">
				<tr>
					<td>문서번호</td>
					<td colspan="3"><input type="text" id="doc_no" name="doc_no"
						value="${doclist[0].doc_no}" readonly="readonly">
						<input type="hidden" id="doc_mngno" name="doc_mngno"
					value="${doclist[0].doc_mngno}" /></td>
				</tr>
				<tr>
					<td>기안부서</td>
					<td colspan="3"><input type="text" id="doc_deptnm"
						name="doc_deptnm" value="${doclist[0].doc_deptnm}"
						readonly="readonly"></td>
				</tr>
				<tr>
					<td>기안자</td>
					<td colspan="3"><input type="text" id="doc_writer"
						name="doc_writer" value="${doclist[0].doc_writer}"
						readonly="readonly"></td>
				</tr>
				<tr>
					<td style="width: 17%;">작성일</td>
					<td style="width: 33%;"><input type="text" id="doc_regdate" name="doc_regdate"
						value="${doclist[0].doc_regdate}" readonly="readonly"></td>
					<td style="width: 17%;">종료일</td>
					<td style="width: 33%;"><input type="text" id="doc_lastdate" name="doc_lastdate"
						value="${doclist[0].doc_lastdate}" readonly="readonly"></td>
				</tr>
				<tr>
					<td>참조</td>
					<td colspan="3"><input type="text" id="doc_reperence"
						name="doc_reperence" readonly="readonly"
						value="${doclist[0].doc_reperence}" size="56" /></td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="3"><input type="text" id="doc_title"
						readonly="readonly" name="doc_title"
						value="${doclist[0].doc_title}" size="65"></td>
				</tr>
				<tr>
					<td colspan="4"><div>내 &nbsp;&nbsp;&nbsp;&nbsp; 용</div></td>
				<tr>
				<tr>
						<td colspan="4"><div>${doclist[0].doc_content}</div></td>
				</tr>
				<tr>
					<td colspan='4' style="text-align:right;"><input type="button" class="btn btn-danger" value="반려"
						onclick="appBan()" /></td>
				</tr>
			</form>
		</table>
			<form name="replyForm" id="replyForm">
				<table class="table table-bordered">
					<tr><td colspan="3" style="text-align:center;"> 코멘트 </td> </tr>
					<tr>
						<td style="width: 17%; text-align:center;">
						<span>${memDto.mem_name}</span>
						<input type="hidden" id="doc_mngno" name="doc_mngno" value="${doclist[0].doc_mngno}">
						<input type="hidden" id="ar_writer" name="ar_writer" value="${memDto.mem_name}">
						</td>
						<td style="width: 66%;"><input type="text" id="ar_content"
							name="ar_content" value="" size="70"></td>
						<td style="width: 9%;"><input
							type="button" value="답글달기" class="btn btn-primary" onclick="replyService()" /></td>
					</tr>
				</table>
			</form>
			
			<table class="table table-bordered">
				<c:forEach items="${replylist}" var="re">
					<tr>
						<td rowspan='2' style="width:17%;">${re.ar_writer}</td>
						<td>${re.ar_regdate}</td>
						<td rowspan='2'>
							<input type="button" id="replydeletebtn" class="btn btn-primary replydeletebtn" value="삭제" class="btn btn-primary" onclick="replydelete(${re.ar_no})">
						</td>
					</tr>
					<tr>
						<td>${re.ar_content}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
</body>
</html>