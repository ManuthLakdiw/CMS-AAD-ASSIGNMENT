<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>
<%@ page import="lk.ijse.model.bean.UserBean" %>
<%
    UserBean userBean = (UserBean) session.getAttribute("user");
    if (userBean == null) {
        response.sendRedirect(request.getContextPath() + "/view/signin.jsp");
        return;
    }

    String currentDateTime = java.time.LocalDateTime.now().format(java.time.format.DateTimeFormatter.ofPattern("E, MMM dd yyyy"));
%>
<html>
<head>
    <title>CMS - Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.11.3/font/bootstrap-icons.min.css" integrity="sha512-dPXYcDub/aeb08c63jRq/k6GaKccl256JQy/AnOq7CAnEZ9FzSL9wSbcZkMp4R26vBsMLFYH4kQ67/bbV8XaCQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />

</head>
<body class="bg-gray-100">


<!-- Top Bar -->
<div class="bg-blue-600 text-white px-6 py-4 flex justify-between items-center shadow-md">
    <div class="text-lg font-bold">Admin Dashboard</div>
    <div class="flex items-center space-x-6">
        <span><%=userBean.getId()%> - <span class="text-lg font-bold"><%= userBean.getUserName() %></span></span>
        <span><i class="bi bi-calendar-minus-fill text-xl"></i> <%= currentDateTime %></span>
        <form class="logoutForm" action="<%= request.getContextPath() %>/logout" method="get">
            <button type="submit" class="bg-red-500 hover:bg-red-600 px-4 py-2 rounded-md">Logout</button>
        </form>
    </div>
</div>

<!-- Employee Management Table -->
<div class="p-6">
    <h2 class="text-xl font-bold mb-4 text-blue-700">Employee Management</h2>
    <table class="min-w-full bg-white border">
        <thead class="bg-blue-100">
        <tr>
            <th class="border px-4 py-2 text-left">ID</th>
            <th class="border px-4 py-2 text-left">Name</th>
            <th class="border px-4 py-2 text-left">Email</th>
            <th class="border px-4 py-2 text-left">Actions</th>
        </tr>
        </thead>
        <tbody>
        <!-- Sample row -->
        <tr>
            <td class="border px-4 py-2">1</td>
            <td class="border px-4 py-2">John Doe</td>
            <td class="border px-4 py-2">john@example.com</td>
            <td class="border px-4 py-2">
                <form action="${pageContext.request.contextPath}/employee" method="post" class="inline">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="1">
                    <button class="text-red-600 hover:underline">Delete</button>
                </form>
            </td>
        </tr>
        </tbody>
    </table>
</div>

<!-- Complaint Management Table -->
<div class="p-6">
    <h2 class="text-xl font-bold mb-4 text-blue-700">Complaints</h2>
    <table class="min-w-full bg-white border">
        <thead class="bg-blue-100">
        <tr>
            <th class="border px-4 py-2 text-left">ID</th>
            <th class="border px-4 py-2 text-left">Title</th>
            <th class="border px-4 py-2 text-left">Description</th>
            <th class="border px-4 py-2 text-left">Date</th>
            <th class="border px-4 py-2 text-left">Status</th>
            <th class="border px-4 py-2 text-left">Answer</th>
            <th class="border px-4 py-2 text-left">Actions</th>
        </tr>
        </thead>
        <tbody>
        <!-- Sample row -->
        <tr>
            <td class="border px-4 py-2">1</td>
            <td class="border px-4 py-2">System Bug</td>
            <td class="border px-4 py-2">Cannot login to the portal</td>
            <td class="border px-4 py-2">2025-06-13</td>
            <td class="border px-4 py-2">Pending</td>
            <td class="border px-4 py-2">
                <form action="<%= request.getContextPath() %>/complaint" method="post">
                    <input type="hidden" name="action" value="resolve">
                    <input type="hidden" name="id" value="1">

                    <!-- Only dropdown to set the answer/status -->
                    <select name="answer" class="w-full border px-2 py-1 rounded">
                        <option value="">-- Select Status --</option>
                        <option value="In Progress">In Progress</option>
                        <option value="Resolved">Resolved</option>
                        <option value="Rejected">Rejected</option>
                    </select>

                    <button type="submit" class="mt-2 bg-green-500 hover:bg-green-600 text-white px-3 py-1 rounded">
                        Submit
                    </button>
                </form>
            </td>

            <td class="border px-4 py-2">
                <form action="<%= request.getContextPath() %>/complaint" method="post">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="1">
                    <button class="text-red-600 hover:underline">Delete</button>
                </form>
            </td>
        </tr>
        </tbody>
    </table>
</div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
