<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>
<%@ page import="lk.ijse.model.bean.UserBean" %>
<%@ page import="lk.ijse.model.bean.ComplaintBean" %>
<%@ page import="java.util.List" %>
<%
    UserBean userBean = (UserBean) session.getAttribute("user");
    if (userBean == null) {
        response.sendRedirect(request.getContextPath() + "/view/signin.jsp");
        return;
    }

    String currentDateTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("E, MMM dd yyyy"));
%>

<%
    List<ComplaintBean> complaints = (List<ComplaintBean>) request.getAttribute("complaintBeanList");
%>
<html>
<head>
    <title>CMS - Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.11.3/font/bootstrap-icons.min.css" />

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
</head>

<body class="bg-gray-100">

<%
    String message = (String) session.getAttribute("message");
    if (message != null) {
%>

<script>
    swal({
        title: "Success!",
        text: "<%= message %>",
        icon: "success",
        button: "OK",
    });
</script>
<%
        session.removeAttribute("message");
    }
%>

<!-- Top Bar -->
<div class="bg-blue-600 text-white px-6 py-4 flex justify-between items-center shadow-md">
    <div class="text-lg font-bold">Complaint Management System - Admin</div>
    <div class="flex items-center space-x-6">
        <span><%= userBean.getId() %> - <span class="text-lg font-bold"><%= userBean.getUserName() %></span></span>
        <span><i class="bi bi-calendar-minus-fill text-xl"></i> <%= currentDateTime %></span>


        <form class="logoutForm" action="<%= request.getContextPath() %>/logout" method="get">
            <button type="submit" class="bg-red-500 hover:bg-red-600 px-4 py-2 rounded-md">Logout</button>
        </form>
    </div>
</div>

<!-- View All Employees Button -->
<div class="p-6">
    <a href="<%= request.getContextPath() %>/allEmployees"
       target="_blank"
       class="inline-block bg-blue-700 hover:bg-blue-800 text-white font-semibold py-2 px-4 rounded shadow-md transition duration-200">
        <i class="bi bi-person-lines-fill mr-2"></i> View All Employees
    </a>
</div>
<!-- Complaint Management Table -->
<div class="p-6">
    <h2 class="text-xl font-bold mb-4 text-blue-700">Complaints</h2>
    <table class="min-w-full bg-white border">
        <thead class="bg-blue-100">
        <tr>
            <th class="border px-4 py-2 text-left">ID</th>
            <th class="border px-4 py-2 text-left">Employee</th>
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
        <% if (complaints != null && !complaints.isEmpty()) { %>
        <% for (ComplaintBean c : complaints) {
            boolean isResolved = "Resolved".equalsIgnoreCase(c.getStatus());
        %>
        <!-- table row here -->
        <tr>
            <td class="border px-4 py-2"><%= c.getId() %></td>
            <td class="border px-4 py-2"><%= c.getEmployeeId() %></td>
            <td class="border px-4 py-2"><%= c.getTitle() %></td>
            <td class="border px-4 py-2"><%= c.getDescription() %></td>
            <td class="border px-4 py-2"><%= c.getDate() %></td>
            <td class="border px-4 py-2"><%= c.getStatus() %></td>

            <td class="border px-4 py-2">
                <form action="<%= request.getContextPath() %>/complaint" method="post">
                    <input type="hidden" name="action" value="resolve">
                    <input type="hidden" name="id" value="<%= c.getId() %>">

                    <select name="answer" class="w-full border px-2 py-1 rounded" <%= isResolved ? "disabled" : "" %>>
                        <option value="">-- Select Status --</option>
                        <option value="In Progress">In Progress</option>
                        <option value="Resolved">Resolved</option>
                        <option value="Rejected">Rejected</option>
                    </select>

                    <button type="submit"
                            class="mt-2 bg-green-500 hover:bg-green-600 text-white px-3 py-1 rounded"
                            <%= isResolved ? "disabled class='opacity-50 cursor-not-allowed'" : "" %>>
                        Submit
                    </button>
                </form>
            </td>

            <td class="border px-4 py-2">
                <form class="deleteComplaint" action="<%= request.getContextPath() %>/complaint" method="post">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="id" value="<%= c.getId() %>">
                <button type="submit" title="Delete"
                        class="inline-flex items-center justify-center w-10 h-10 text-white bg-red-600 hover:bg-red-700 focus:ring-4 focus:outline-none focus:ring-red-300 font-semibold rounded-md shadow-md transition-all duration-200 ml-2">
                    <i class="fa-solid fa-trash text-sm"></i>
                </button>
            </form>
            </td>
        </tr>
        <% } %>
        <% } else { %>
        <tr>
            <td colspan="8" class="text-center py-4 text-gray-500">No complaints found.</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

<!-- JS -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>

</body>
</html>
