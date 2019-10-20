// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function (){
    $(".more").click(function (){
        $('html, body').animate({
            scrollTop: $(".album").offset().top
        }, 1500);
    });

    $(".top-login").click(function (){
        console.log('a')
        $('html, body').animate({
            scrollTop: $(".container").offset().top +100
        }, 1500);
    });
});