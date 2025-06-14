<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CMS - Home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-blue-100 to-blue-300 min-h-screen flex items-center justify-center">

<div class="bg-white rounded-2xl shadow-xl w-full max-w-4xl p-10 text-center">
    <h1 class="text-4xl font-bold text-blue-800 mb-4">Welcome to Complaint Management System</h1>
    <p class="text-gray-700 mb-6 text-lg">
        Manage and track complaints efficiently in one place.
    </p>

    <div class="flex flex-col md:flex-row gap-6 justify-center">
        <a href="view/signin.jsp"
           class="bg-blue-600 text-white py-3 px-6 rounded-lg shadow hover:bg-blue-700 transition duration-200">
            Login
        </a>
        <a href="view/signup.jsp"
           class="bg-gray-200 text-blue-800 py-3 px-6 rounded-lg shadow hover:bg-gray-300 transition duration-200">
            Sign Up
        </a>
    </div>

    <div class="mt-10 text-sm text-gray-500">
        &copy; 2025 Complaint Management System. All rights reserved.
    </div>
</div>

</body>
</html>
