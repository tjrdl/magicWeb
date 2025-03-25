/**
 * 
 */

function check_ok() {
	var form = document.getElementById("reg_frm");
	if (!form) {
		alert("폼을 찾을 수 없습니다.");
		return;
	}
	if (form.b_name.value.trim() === "") {
		alert("이름을 입력해주세요.");
		form.b_name.focus();
		return;
	}
	if (form.b_email.value.trim() === "") {
		alert("이메일을 입력해주세요.");
		form.b_email.focus();
		return;
	}
	if (form.b_title.value.trim() === "") {
		alert("제목을 입력해주세요.");
		form.b_title.focus();
		return;
	}
	if (form.b_content.value.trim() === "") {
		alert("내용을 입력해주세요.");
		form.b_content.focus();
		return;
	}
	if(form.b_pwd.value.trim() === "") {
		alert("비밀번호를 입력해주세요.");
		form.b_pwd.focus();
		return;
	}
	form.submit(); // 폼 제출
}

function delete_ok() {
	var form = document.getElementById("del_frm");
	if(form.b_pwd.value.trim() === "") {
		alert("비밀번호를 입력해주세요.");
		form.b_pwd.focus();
		return;

	}
	form.submit(); // 폼 제출

}

