//1.获取元素
var oBox = document.querySelector('.box');   //获取.box元素
var oCon = document.querySelector('.con');   //获取input框
var oBtn = document.querySelector('.send-btn');   //获取发送按钮
var cW = oBox.offsetWidth;   //获取box的宽度
var cH = oBox.offsetHeight;   //获取box的高度
var message = '';   //弹幕内容初始化
var video = document.querySelector('#videoplay');
var currentTime = document.querySelector('#currentTime');
video.addEventListener("play", function() {
    
})

video.addEventListener("timeupdate", function () {
    var ct = video.currentTime;
    currentTime.value = ct;
    showCurrentTimeDanMu(ct);
})

oBtn.onclick = send;   //点击发送
oCon.onkeydown = function (e) {
    e = e || window.event;
    if (e.keyCode === 13) {
        //回车键
        send();
    }
};

function showCurrentTimeDanMu(time) {
    var DanMuTable = document.querySelector('#DanMuList');
    var rows = DanMuTable.rows;
    for (var i = 0; i < rows.length; i++) {
        var videoTimeLabel = rows[i].cells[0].getElementsByClassName("VideoTimeLabel");
        var isPlayedLabel = rows[i].cells[0].getElementsByClassName("isPlayed");
        if (time <= videoTimeLabel[0].innerText + 0.0001 && time >= videoTimeLabel[0].innerText - 0.0001 && isPlayedLabel[0].innerText == 0) {
            var contentLabel = rows[i].cells[0].getElementsByClassName("ContentLabel");
            createEle(contentLabel[0].innerText);
            isPlayedLabel[0].innerText = 1;
        } else if ((time > videoTimeLabel[0].innerText + 0.0001 || time < videoTimeLabel[0].innerText - 0.0001) && isPlayedLabel[0].innerText == 1) {
            isPlayedLabel[0].innerText = 0;
        }
    }
}

function send() {
    //获取oCon的内容
    if (oCon.value.length <= 0 || (/^\s+$/).test(oCon.value)) {
        alert('请输入弹幕');
        return false;
    }
    message = oCon.value;
    console.log(message);
    //生成标签
    createEle(message);   //执行节点创建模块
    oCon.value = '';   //收尾工作清空输入框
}
function createEle(txt) {
    //动态生成span标签
    var oMessage = document.createElement('span');   //创建标签
    oMessage.innerHTML = txt;   //接收参数txt并且生成替换内容
    oMessage.style.left = cW + 'px';  //初始化生成位置x
    oBox.appendChild(oMessage);   //把标签塞到oBox里面
    roll.call(oMessage, {
        //call改变函数内部this的指向
        timing: ['linear', 'ease-out'][~~(Math.random() * 2)],
        color: '#' + (~~(Math.random() * (1 << 24))).toString(16),
        top: random(0, 600),
        fontSize: random(16, 32)
    });
}
function roll(opt) {
    //弹幕滚动
    //如果对象中不存在timing 初始化
    opt.timing = opt.timing || 'linear';
    opt.color = opt.color || '#fff';
    opt.top = opt.top || 0;
    opt.fontSize = opt.fontSize || 16;
    this._left = parseInt(this.offsetLeft);   //获取当前left的值
    var endpos = -this.offsetWidth;
    this.style.color = opt.color;   //初始化颜色
    this.style.top = opt.top + 'px';
    this.style.fontSize = opt.fontSize + 'px';
    this.timer = setInterval(function () {
        if (this._left <= endpos) {
            clearInterval(this.timer);   //终止定时器
            this.parentNode.removeChild(this);
            return;   //终止函数
        }
        this._left += -2;
        this.style.left = this._left + 'px';
    }.bind(this), 1000 / 60);
}
function random(start, end) {
    //随机数封装
    return start + ~~(Math.random() * (end - start));
}
var aLi = document.querySelectorAll('li');   //10

function forEach(ele, cb) {
    for (var i = 0, len = aLi.length; i < len; i++) {
        cb && cb(ele[i], i);
    }
}
forEach(aLi, function (ele, i) {
    ele.style.left = i * 100 + 'px';
});
//产生闭包
var obj = {
    num: 1,
    add: function () {
        this.num++;   //obj.num = 2;
        (function () {
            console.log(this.num);
        })
    }
};
obj.add();  //window