<html>
<head>

<center> <font size=6><b>--:Admin Menu Page:--</b></font> </center>
</head>
<body bgcolor="skyblue">
<form>
<font size=5>
<%@ page import="java.servlet.*"%>
<%@ page import="java.servlet.http.*"%>
<%
HttpSession hs=request.getSession();
String s=(String)hs.getAttribute("email");
out.print("Admin name: " +s);
%>
<br><br>
<A align="right" HREF="login.jsp">Log Out</A>
<center>
	<table><br><br>
		<tr><th>Entry</th><th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                    Reports</th></tr>
		<tr><td><br></td></tr>					<td> </td>
		<tr><td><A HREF="employee.jsp">Employee</A></td>	<td> </td>		<td><A HREF="employee_details.jsp">Employee Details</A></td></tr>
		<tr><td><br></td></tr>					<td> </td>
		<tr><td><A HREF="supplier.jsp">Supplier</A></td>	<td> </td>		<td><A HREF="supplier_details.jsp">Supplier Details</A></td></tr>
		<tr><th><br></th></tr>					<td> </td>
		<tr><td><A HREF="item.jsp">Item master</A></td>		<td> </td>		<td><A HREF="item_details.jsp">Item Details</A></td></tr>
		<tr><td><br></td></tr>					<td> </td>
		<tr><td><A HREF="purchase.jsp">Purchase</A></td>	<td> </td>		<td><A HREF="purchase_details.jsp">Purchase Details</A></td></tr>
		<tr><td><br></td></tr>					<td> </td>
		<tr><td>	</td>					<td> </td>		<td><A HREF="sales_details.jsp">Sales Details</A></td></tr>
	</table>
</center>
<img src="home1.png" height="400px" width="400px">

</form>
</body>
</html>
