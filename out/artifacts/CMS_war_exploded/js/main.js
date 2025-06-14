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

    $(".logoutForm").on("submit", function(e){
        e.preventDefault();

        swal({
            title: "Are you sure?",
            text: "Do you really want to logout?",
            icon: "warning",
            buttons: ["No", "Yes"],
            dangerMode: true,
        }).then((willLogout) => {
            if (willLogout) {
                this.submit();
            }
        });
    })





});