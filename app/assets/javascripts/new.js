
$(document).ready(function (){
    $(".link").click(function (){
        $('html, body').animate({
            scrollTop: $(".user").offset().top - 100
        }, 1500);
    });
});