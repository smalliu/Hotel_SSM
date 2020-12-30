function makeInput(title, id, readonly, val) {
    readonly = (readonly) ? readonly : "";
    console.log("{makeInput} val = " + val);
    val = (val) ? val : "";
    return "<tr>\r\n" +
        "<td>" + title + "</td>\r\n" +
        "<td>\r\n" +
        "<input type=\"text\" id=\"" + id + "\" name=\"" + id +
        "\" " + readonly + " value=\"" + val + "\"/>\r\n</td>\r\n" +
        "</tr>\r\n";
}


function makeSelect(title, id, data, val) {
    var html = "<tr><td>" + title + "</td>";
    html += "<td><select id=\"" + id + "\" name=\"" + id + "\">";
    for (var i = 0; i < data.length; i++) {
        var d = data[i];
        var selected = (val == d['val']) ? "selected" : "";
        html += "<option value=\"" + d['val'] + "\" " + selected + ">" +
            d['text'] + "</option>";
    }
    html += "</select></td></tr>";
    return html;
}


/*
 * {ps} 创建一个隐藏域
 * <input type="hidden" id="" ... />
 */
function makeHide(id, val) {
    return "<input type=\"hidden\" id=\"" + id
        + "\" value=\"" + val + "\"/>\r\n";
}
