$(document).ready(function(){

    $("#userSignUpForm").on("submit", function(e){
        const password = $("#password").val()
        const confirmPassword = $("#confirmPassword").val()

        if(password !== confirmPassword) {
            swal({
                title: "Warning!",
                text: "Password and Confirm Password must be exactly the same",
                icon: "warning",
                button: "OK",
                dangerMode: true,
            })
            e.preventDefault()
        }
    })



});