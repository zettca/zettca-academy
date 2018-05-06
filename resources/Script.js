$(document).ready(function () {
    doResizements();
    $(window).resize(function () {
        doResizements();
    });

    //window.history.replaceState("", "ZETTCA Academy", "/ZA/");

    $("#footer").on("click", function () {
        $("body").css("background-image", "none");
        $("body").css("background-color", getColor());
    });

    $(".accordine").accordion({ collapsible: true, active: false, heightStyle: "content" });
    $(".wrongAnswer").parent().effect("shake");
    $(".submenu").width($("#userArea").width() - 10);

    var rx = /INPUT|SELECT|TEXTAREA/i;
    $(document).bind("keydown keypress", function (e) {
        if (e.which == 8) { // 8 == backspace
            if (!rx.test(e.target.tagName) || e.target.disabled || e.target.readOnly) {
                e.preventDefault();
            }
        }
    });
});

window.onblur = function () {
    try {
        $(".hfFocus").attr("value", "BLUR")
    }
    catch (err) {
        //Handle errors here
    }
};

function doResizements() {
    if ($(window).width() < 1350)
        $("#wrapper").css("width", "90%");
    else
        $("#wrapper").css("width", "1200px");
    if ($(window).width() < 800)
        $("#menubar").css("width", "800px");
    else
        $("#menubar").css("width", "100%");
}

function getColor() {
    var colors = ["red","blue","green","lime","orange","fuchsia","aqua","purple","maroon","gray","olive","silver"]
    var x = Math.round(Math.random() * 11);

    var R = Math.round(Math.random() * 120);
    var G = Math.round(Math.random() * 120);
    var B = Math.round(Math.random() * 120);

    return "rgb(" + R + "," + G + "," + B + ")";
    //return colors[x];
}