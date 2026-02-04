<%--
  Created by IntelliJ IDEA.
  User: manuthlakdiv
  Date: 6/12/25
  Time: 16:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>CMS-Sign-Up</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


</head>
<body class="bg-gray-50 h-screen flex items-center justify-center">

<%
    String message = (String) request.getAttribute("message");
    if (message != null) {
%>
<script>
    swal({
        title: "Success!",
        text: "<%= message %>",
        icon: "success",
        button: false,
        timer: 1500,
        closeOnClickOutside: false,
        successMode: true,
    }).then(function () {
        window.location.href = "<%= request.getContextPath() %>/view/signin.jsp";
    });
</script>
<%
    }
%>

<div class="w-full max-w-6xl bg-white rounded-xl shadow-lg overflow-hidden flex flex-col md:flex-row">

    <!-- Left Side: Form -->
    <div class="w-full md:w-1/2 p-8 md:p-12 overflow-y-auto">
        <div class="text-center mb-6">
            <h1 class="text-3xl font-bold text-gray-800">Create Account</h1>
            <p class="text-gray-600 mt-2">Join us today and get started</p>
        </div>

        <form id="userSignUpForm" class="space-y-4" METHOD="POST" action="${pageContext.request.contextPath}/signup">
            <div>
                <label for="fullName" class="block text-sm font-medium text-gray-700 mb-1">Full Name</label>
                <input
                        type="text"
                        pattern="^([A-Za-z]+\.)*[A-Za-z]+( [A-Za-z]+)*$"
                        title="Please enter a valid name. Only letters, spaces, and optional dots are allowed."
                        id="fullName"
                        name="fullName"
                        autocomplete="off"
                        required
                        class="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-1 focus:ring-blue-500 focus:border-blue-500 outline-none transition duration-200"
                        placeholder="John Doe"
                >
            </div>

            <div>
                <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                <input
                        type="email"
                        id="email"
                        name="email"
                        autocomplete="off"
                        required
                        class="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-1 focus:ring-blue-500 focus:border-blue-500 outline-none transition duration-200"
                        placeholder="john@example.com"
                >
                <label id="emailError" class="text-red-500 text-sm "></label>

            </div>

            <div>
                <label for="username" class="block text-sm font-medium text-gray-700 mb-1">Username</label>
                <input
                        pattern="^[A-Za-z0-9]{4,}$"
                        title="Username must be at least 4 characters long and contain only letters and numbers."
                        type="text"
                        id="username"
                        name="username"
                        autocomplete="off"
                        required
                        class="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-1 focus:ring-blue-500 focus:border-blue-500 outline-none transition duration-200"
                        placeholder="johndoe123"
                >

            </div>

            <div>
                <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Password</label>
                <input
                        type="password"
                        pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{6,}$"
                        title="Password must be at least 6 characters, include uppercase and lowercase letters, a number, and a special character."
                        id="password"
                        name="password"
                        required
                        class="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-1 focus:ring-blue-500 focus:border-blue-500 outline-none transition duration-200"
                        placeholder="••••••••"
                >

            </div>

            <div>
                <label for="confirmPassword" class="block text-sm font-medium text-gray-700 mb-1">Confirm Password</label>
                <input
                        type="password"
                        id="confirmPassword"
                        name="confirmPassword"
                        required
                        class="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-1 focus:ring-blue-500 focus:border-blue-500 outline-none transition duration-200"
                        placeholder="••••••••"
                >
            </div>

            <button
                    type="submit"
                    class="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-4 rounded-lg transition duration-200 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2"
            >
                Sign Up
            </button>
        </form>

        <div class="mt-6 text-center">
            <p class="text-sm text-gray-600">
                Already have an account?
                <a href="${pageContext.request.contextPath}/view/signin.jsp" class="text-blue-600 hover:text-blue-800 font-medium">Log in</a>
            </p>
        </div>
    </div>

    <div class="hidden md:block md:w-1/2 bg-blue-600 relative">
        <div class="absolute inset-0 bg-gradient-to-br from-blue-600 to-blue-800 opacity-90"></div>
        <div class="relative h-full flex items-center justify-center">
            <div class="text-center text-white p-8">
                <h2 class="text-4xl font-bold mb-4">Welcome!</h2>
                <p class="text-xl mb-8">Join our community and discover amazing features</p>
                <div class="w-16 h-1 bg-white mx-auto mb-8"></div>
                <p class="text-blue-100">"The best way to predict the future is to create it."</p>
                <p class="text-blue-200 mt-2">- Peter Drucker</p>
            </div>
        </div>
    </div>

</div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
