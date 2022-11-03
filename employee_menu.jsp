<html>
<head>

<center> <font size=6><b>--:Employee Login:--</b></font> </center>
</head>
<%@ page import="java.servlet.*"%>
<%@ page import="java.servlet.http.*"%>
<%
HttpSession hs=request.getSession();
String s=(String)hs.getAttribute("email");
out.print("Employee name:"+s);
%>
<body>
<form>
<br><br>
<center>

</center>
<br><br>
<center>
<font size=5>
<A HREF="sales.jsp">SALES ENTRY
<br><br><A HREF="customer.jsp">CUSTOMER ENTRY</A>
<br><br><A HREF="cutomer_details.jsp">Customer Details</A>

<br><br><A HREF="item_details.jsp">Item Details</A>
<br><br><A HREF="login.jsp">Log Out</A>
</font>
</center>
</body>
</html>



