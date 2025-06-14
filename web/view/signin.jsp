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
    <title>CMS-Sign-In</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


</head>
<body class="bg-gray-50 h-screen flex items-center justify-center">

<%
    String message = (String) request.getAttribute("message");
    if (message != null) {
%>
<script>
    swal({
        title: "Error!",
        text: "<%= message %>",
        icon: "error",
        button: "OK",
        successMode: true,
    }).then(function () {
        window.location.href = "<%= request.getContextPath() %>/view/signin.jsp";
    });
</script>
<%
    }
%>
<div class="w-full max-w-6xl h-[90vh] bg-white rounded-xl shadow-lg overflow-hidden flex flex-col md:flex-row">

    <div class="w-full md:w-1/2 p-8 md:p-12 overflow-y-auto">
        <div class="text-center mb-6">
            <h1 class="text-3xl font-bold text-gray-800">Welcome Back</h1>
            <p class="text-gray-600 mt-2">Login to your account</p>
        </div>

        <form class="space-y-4" action="${pageContext.request.contextPath}/signin" method="post">
            <div>
                <label for="username" class="block text-sm font-medium text-gray-700 mb-1">Username</label>
                <input
                        type="text"
                        id="username"
                        name="username"
                        required
                        class="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-1 focus:ring-blue-500 focus:border-blue-500 outline-none transition duration-200"
                        placeholder="johndoe123"
                >
            </div>

            <div>
                <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Password</label>
                <input
                        type="password"
                        id="password"
                        name="password"
                        required
                        class="w-full px-4 py-2 rounded-md border border-gray-300 focus:ring-1 focus:ring-blue-500 focus:border-blue-500 outline-none transition duration-200"
                        placeholder="••••••••"
                >
            </div>

            <button
                    type="submit"
                    class="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-4 rounded-lg transition duration-200 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2"
            >
                Log In
            </button>
        </form>

        <div class="mt-6 text-center">
            <p class="text-sm text-gray-600">
                Don't have an account?
                <a href="${pageContext.request.contextPath}/view/signup.jsp" class="text-blue-600 hover:text-blue-800 font-medium">Sign Up</a>
            </p>
        </div>
    </div>

    <!-- Right Side -->
    <div class="hidden md:block md:w-1/2 bg-blue-600 relative">
        <div class="absolute inset-0 bg-gradient-to-br from-blue-600 to-blue-800 opacity-90"></div>
        <div class="relative h-full flex items-center justify-center">
            <div class="text-center text-white p-8">
                <h2 class="text-4xl font-bold mb-4">Hello Again!</h2>
                <p class="text-xl mb-8">We're happy to see you back.</p>
                <div class="w-16 h-1 bg-white mx-auto mb-8"></div>
                <p class="text-blue-100">"Success usually comes to those who are too busy to be looking for it."</p>
                <p class="text-blue-200 mt-2">- Henry David Thoreau</p>
            </div>
        </div>
    </div>

</div>
</body>
</html>
