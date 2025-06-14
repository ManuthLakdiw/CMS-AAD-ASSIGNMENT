<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="lk.ijse.model.bean.UserBean" %>
<%
    UserBean userBean = (UserBean) session.getAttribute("user");
    if (userBean == null) {
        response.sendRedirect(request.getContextPath() + "/view/signin.jsp");
        return;
    }

    String currentDateTime = java.time.LocalDateTime.now().format(java.time.format.DateTimeFormatter.ofPattern("E, MMM dd yyyy"));
%>

<%
    String message = (String) request.getAttribute("message");
%>

<script>
    <% if (message != null) { %>
    swal({
        title: "Success!",
        text: "<%= message %>",
        icon: "success",
        timer: 1300,
        buttons: false
    });
    <% } else { %>
    swal({
        title: "Error!",
        text: "Complaint submission failed. Please try again.",
        icon: "error",
        button: "OK"
    });
    <% } %>
</script>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CMS - Employee Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.11.3/font/bootstrap-icons.min.css" integrity="sha512-dPXYcDub/aeb08c63jRq/k6GaKccl256JQy/AnOq7CAnEZ9FzSL9wSbcZkMp4R26vBsMLFYH4kQ67/bbV8XaCQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body class="bg-gray-50">



<div class="bg-blue-600 text-white px-6 py-4 flex justify-between items-center shadow-md">
    <div class="text-lg font-semibold">Complaint Management System</div>

    <div class="flex items-center space-x-8">
        <!-- User icon with username -->
        <span class="flex items-center space-x-2">
            <i class="bi bi-person-circle text-xl"></i>
            <span><%=userBean.getId()%> - <span class="text-lg font-bold"><%= userBean.getUserName() %></span></span>
        </span>

        <span class="flex items-center space-x-2">
            <i class="bi bi-calendar-minus-fill text-xl"></i>
            <span><%= currentDateTime %></span>
        </span>


        <form class="logoutForm" action="<%= request.getContextPath() %>/logout" method="get">
            <button type="submit" class="bg-red-500 hover:bg-red-600 px-4 py-2 rounded-md">
                Logout
            </button>
        </form>
    </div>
</div>


<div class="p-6 max-w-6xl mx-auto">
    <div class="bg-white p-6 rounded-lg shadow mb-6">
        <h2 class="text-xl font-bold mb-4 text-blue-700">Add New Complaint</h2>
        <form action="<%= request.getContextPath() %>/complaint" method="post" class="space-y-4">
            <input type="hidden" name="employeeId" value="<%= userBean.getId() %>">
            <div>
                <label class="block text-sm font-medium mb-1">Complaint Title</label>
                <input type="text" name="title" class="w-full border rounded px-3 py-2" required>
            </div>
            <div>
                <label class="block text-sm font-medium mb-1">Description</label>
                <textarea name="description" class="w-full border rounded px-3 py-2" required></textarea>
            </div>
            <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">Submit Complaint</button>
        </form>
    </div>

    <div class="bg-white p-6 rounded-lg shadow">
        <h2 class="text-xl font-bold mb-4 text-blue-700">Your Complaints</h2>
        <table class="min-w-full border">
            <thead class="bg-blue-100">
            <tr>
                <th class="border px-4 py-2 text-left">ID</th>
                <th class="border px-4 py-2 text-left">Title</th>
                <th class="border px-4 py-2 text-left">Description</th>
                <th class="border px-4 py-2 text-left">Date</th>
                <th class="border px-4 py-2 text-left">Time</th>
                <th class="border px-4 py-2 text-left">Status</th>
                <th class="border px-4 py-2 text-left">Actions</th>
            </tr>
            </thead>
            <tbody>
            <!-- Sample complaint -->
            <tr>
                <td class="border px-4 py-2">1</td>
                <td class="border px-4 py-2">Network Issue</td>
                <td class="border px-4 py-2">Internet not working</td>
                <td class="border px-4 py-2">2025-06-13</td>
                <td class="border px-4 py-2">14:30:00</td>
                <td class="border px-4 py-2 text-amber-600">Pending<i class="bi bi-clock text-amber-600 font-extrabold font-sm ml-2"></i></td>
                <td class="border px-4 py-2 space-x-2">
                    <form action="<%= request.getContextPath() %>/complaint" method="post" class="inline">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" value="1">
                        <button class="text-blue-600 hover:underline">Edit</button>
                    </form>
                    <form action="<%= request.getContextPath() %>/complaint" method="post" class="inline">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="1">
                        <button class="text-red-600 hover:underline">Delete</button>
                    </form>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
