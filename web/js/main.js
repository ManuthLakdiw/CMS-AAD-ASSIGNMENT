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

    $(".deleteComplaint").on("submit", function (e) {
        e.preventDefault();

        const form = this;

        swal({
            title: "Are you sure?",
            text: "You won't be able to revert this!",
            icon: "warning",
            buttons: {
                cancel: "Cancel",
                confirm: {
                    text: "Yes, delete it!",
                    value: true,
                    visible: true,
                    className: "bg-red-600 text-white px-3 py-2 rounded",
                    closeModal: true
                }
            },
            dangerMode: true,
        }).then((willDelete) => {
            if (willDelete) {
                form.submit(); // form එක manually submit කරනවා
            }
        });
    });







});