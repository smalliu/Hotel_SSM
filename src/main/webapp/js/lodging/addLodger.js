var LodgerCnt = 1;
var lodgerList = ['', 'first'];

function Lodger(_lodgerName, _certificate,
                _certificateNo, _sex, _phone) {
    this.lodgerName = _lodgerName;
    this.certificate = _certificate;
    this.certificateNo = _certificateNo;
    this.sex = _sex;
    this.phone = _phone;
    this.isRegister = "0";

    this.toJson = function () {
        var json = "{" +
            "\"lodgerName\":\"" + this.lodgerName + "\"," +
            "\"certificate\":\"" + this.certificate + "\"," +
            "\"certificateNo\":\"" + this.certificateNo + "\"," +
            "\"sex\":\"" + this.sex + "\"," +
            "\"phone\":\"" + this.phone + "\"," +
            "\"isRegister\":\"" + this.isRegister + "\"" +
            "}";
        return json;
    }
}

function updateLodger() {
    var lodgerName, certificate, certificateNo, sex, phone;
    for (var i = 1; i <= LodgerCnt; i++) {
        lodgerName = getE("lodgerName" + i);
        console.log("{addLodger.js} updateLodger: i=[%d], lodgerName=[%s]",
            i, lodgerName.value);
        certificate = getE("certificate" + i);
        certificateNo = getE("certificateNo" + i);
        sex = getE("sex" + i);
        phone = getE("phone" + i);

        lodgerList[i] = new Lodger(lodgerName.value,
            certificate.value,
            certificateNo.value,
            sex.value, phone.value);

        console.log("{addLodger.js} lodgerList[" + i + "]");
        console.log(lodgerList[i]);

        if (i == 1) {
            lodgerList[i].isRegister = 1;
        }
    }
}

function getE(id) {
    return document.getElementById(id);
}

function addLodger() {
    updateLodger();	   //{ps} 调用了: updateLodger();
    var list = $("#list");
    var html = makeHead();
    for (var i = 2; i <= LodgerCnt; i++) {
        console.log("{addLodger.js} addLodger: i=[%d]", i);
        html += makeRow(i, lodgerList[i]);
    }
    LodgerCnt++;
    var newLodger = new Lodger("", "", "", "", "");
    html += makeRow(LodgerCnt, newLodger);
    html += makeFoot();
    list.html(html);
}

function makeHead() {
    var html = "<caption style=\"color:gray;\">同来宾客</caption>" +
        "<tr>\r\n" +
        "<th>用户名称</th>\r\n" +
        "<th>证件号码</th>\r\n" +
        "<th>性别</th>\r\n" +
        "<th>操作</th>\r\n" +
        "</tr>\r\n"
    return html;
}

function makeFoot() {
    return "<tr>\r\n" +
        "<td colspan=\"4\" style=\"text-align:center;height:42px;\">\r\n" +
        "<input type=\"button\" value=\"添加宾客\" onclick=\"addLodger();\"/>\r\n" +
        "<input type=\"button\" value=\"添加备注\" />\r\n" +
        "</td>\r\n" +
        "</tr>\r\n";
}

/* http://localhost:8080/images/common/cancel.png */
function makeRow(cnt, lodger) {
    console.log("{1} lodger: " + lodger);
    var html = "<tr>\r\n";
    html += makeTD("lodgerName" + cnt, lodger.lodgerName);
    html += makeTD("certificateNo" + cnt, lodger.certificateNo);
    html += makeSex("sex" + cnt, lodger.sex);

    html += "<td>\r\n" +
        "<img src=\"../images/common/cancel.png\"/>\r\n" +
        "<input type=\"hidden\" id=\"certificate" +
        cnt + "\" value=\"1\" />\r\n" +
        "<input type=\"hidden\" id=\"phone" + cnt + "\" />\r\n" +
        "</td>\r\n";

    html += "</tr>\r\n";
    console.log(html);
    return html;
}


function makeTD(id, val) {
    var td = "";
    td += "<td class=\"blk_td\">\r\n";
    td += "<input class=\"blank\" type=\"text\" id=\"" + id +
        "\" value=\"" + val + "\" onfocus=\"setBack(this);\" />\r\n"
    td += "</td>\r\n";
    return td;
}

function makeSex(id, val) {
    var td = "<td class=\"blk_td\">\r\n";
    td += "<select id=\"" + id + "\">\r\n";
    td += "<option value=\"0\">请选择性别</option>\r\n";
    td += "<option value=\"男\">男</option>\r\n";
    td += "<option value=\"女\">女</option>\r\n";
    td += "</select>\r\n";
    td += "</td>\r\n";
    return td;
}


var lastTD = undefined;

function setBack(obj) {
    //console.log("setBack: "+ obj.name );
    var par = $(obj).parent();
    if (lastTD) {
        lastTD.css("background", "white");
    }
    par.css("background", "blue");
    lastTD = par;
}


