function ExitAlert() {
    return confirm("您确定要退出登陆吗？");
}

function ShowPreview(file) {
    var file = file.files[0];
    var reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = function (e) {
        var pic = document.getElementById("preview");
        pic.src = this.result;
    }
}

function setTitle(iframe) {
    document.title = iframe.contentWindow.document.title + " - 梦之队云课堂";
}

function SelectFile() {
    document.getElementById("FileUpload").click();
}

function showEdit() {
    var edit = document.getElementById("EditUser");
    edit.classList.replace("hide", "show");
}

function SelectFile1(image,id) {
    document.getElementById(id).click();
    previewElem = image;
}

var previewElem;

function ShowPreview1(file) {
    var file = file.files[0];
    var reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = function (e) {
        var pic = previewElem;
        pic.src = this.result;
    }
}

function ShowPreview2(file) {
    var isPicChanged = document.getElementById("IsPicChanged");
    var file = file.files[0];
    var reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = function (e) {
        var pic = previewElem;
        pic.src = this.result;
        isPicChanged.value = 1;
    }
}

function UserInfo() {
    var p = this.document.getElementsByClassName("IsProcessed");
    for (i = 0; i < p.length; i++) {
        if (p[i].innerText == "已处理") {
            p[i].style.color = "green";
        } else {
            p[i].style.color = "orange";
        }
    }
    
}