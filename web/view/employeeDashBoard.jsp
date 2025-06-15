<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="lk.ijse.model.bean.UserBean" %>
<%@ page import="lk.ijse.model.bean.ComplaintBean" %>
<%@ page import="java.util.List" %>


<%
    UserBean userBean = (UserBean) session.getAttribute("user");
    if (userBean == null) {
        response.sendRedirect(request.getContextPath() + "/view/signin.jsp");
        return;
    }

    String currentDateTime = java.time.LocalDateTime.now().format(java.time.format.DateTimeFormatter.ofPattern("E, MMM dd yyyy"));
%>






<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CMS - Employee Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
            rel="stylesheet"
    />
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.11.3/font/bootstrap-icons.min.css"
            integrity="sha512-dPXYcDub/aeb08c63jRq/k6GaKccl256JQy/AnOq7CAnEZ9FzSL9wSbcZkMp4R26vBsMLFYH4kQ67/bbV8XaCQ=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
    /></head>
<body class="bg-gray-50">

<%
    String message = (String) session.getAttribute("message");

    if (message != null) {
        if (message.contentEquals("NOT")) {
%>
<script>
    swal({
        title: "Error!",
        text: "<%= message %>",
        icon: "error",
        button: "OK"
    });
</script>
<%
} else {
%>
<script>
    swal({
        title: "Success!",
        text: "<%= message %>",
        icon: "success",
        timer: 1600,
        buttons: false
    });
</script>
<%}
    session.removeAttribute("message");
    }
%>



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


<div class="p-6 max-w-7xl mx-auto">
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
            <%
                List<ComplaintBean> complaints = (List<ComplaintBean>) request.getAttribute("complaintBeanList");
                if (complaints != null) {
                    for (ComplaintBean complaintBean : complaints) {
            %>
            <tr>
                <td class="border px-4 py-2"><%=complaintBean.getId()%></td>
                <td class="border px-4 py-2"><%=complaintBean.getTitle()%></td>
                <td class="border px-4 py-2"><%=complaintBean.getDescription()%></td>
                <td class="border px-4 py-2"><%=complaintBean.getDate()%></td>
                <td class="border px-4 py-2"><%=complaintBean.getTime()%></td>

                <%
                    String status = complaintBean.getStatus();
                    if (status.equalsIgnoreCase("PENDING")) {
                %>
                <td class="border px-4 py-2 text-amber-600">
                    <%= status %>
                    <i class="bi bi-clock text-amber-600 font-extrabold font-sm ml-2"></i>
                </td>
                <%
                } else if (status.equalsIgnoreCase("RESOLVED")) {
                %>
                <td class="border px-4 py-2 text-green-600">
                    <%= status %>
                    <i class="bi bi-check-circle-fill text-green-600 font-extrabold font-sm ml-2"></i>
                </td>
                <%
                } else if (status.equalsIgnoreCase("REJECTED")) {
                %>
                <td class="border px-4 py-2 text-red-600">
                    <%= status %>
                    <i class="bi bi-x-octagon-fill text-red-600 font-extrabold font-sm ml-2"></i>
                </td>
                <%
                } else {
                %>
                <td class="border px-4 py-2 text-gray-600"><%= status %></td>
                <% } %>


            <%-- <td class="border px-4 py-2 text-amber-600">Pending<i class="bi bi-clock text-amber-600 font-extrabold font-sm ml-2"></i></td>--%>
                <td class="border px-4 py-2 space-x-2">
                    <% if (!status.equalsIgnoreCase("RESOLVED")) { %>
                    <form action="<%= request.getContextPath() %>/complaint" method="post" class="inline">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" value="<%= complaintBean.getId() %>">
                        <button type="submit" title="Update"
                                class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-semibold rounded-md px-3 py-2 shadow-md">
                            <i class="fas fa-edit"></i>
                        </button>
                    </form>
                    <form action="<%= request.getContextPath() %>/complaint" method="post" class="inline">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= complaintBean.getId() %>">
                        <button type="submit" title="Delete"
                                class="text-white bg-red-600 hover:bg-red-700 focus:ring-4 focus:outline-none focus:ring-red-300 font-semibold rounded-md px-3 py-2 shadow-md">
                            <i class="fa-solid fa-trash"></i>
                        </button>

                    </form>
                    <% } else { %>
                    <span class="text-gray-400 italic">Read-only</span>
                    <% } %>
                </td>
            </tr>
            <% } %>
            <% } %>

            </tbody>
        </table>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>


</body>
</html>
