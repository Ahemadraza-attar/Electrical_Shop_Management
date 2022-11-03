<html>
<body>
<h1><center>Sales Bill</center></h1><br><br>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.servlet.*" %>
<%


HttpSession hs=request.getSession();
	String no=(String)hs.getAttribute("no");
	String date=(String)hs.getAttribute("date");
	String id=(String)hs.getAttribute("id");
	String name=(String)hs.getAttribute("sname");
	String len=(String)hs.getAttribute("l");
	
	int l=Integer.parseInt(len);
	String names[]=new String[l];
	String quantity[]=new String[l];
	for(int i=0;i<l;i++)
	{
		names[i]=(String)hs.getAttribute("name"+i);
	}
	for(int k=0;k<l;k++)
	{
		quantity[k]=(String)hs.getAttribute("quantity"+k);
	}
	String total=(String)hs.getAttribute("total");
	
	%> <center> <%
	out.println("Bill No.:"+no);
	out.println("Bill Date:"+date);%><br><br></center><center><%
	out.println("Customer Id:"+id);
	out.println("Customer Name:"+name);%><br></center><center><br><br><%
	%><table border=1><tr>
		<td><% out.println("Item Name ");%></td>
		<td><% out.println("Item Quantity");%></td>
		
		</tr>
	<%
	for(int j=0;j<l;j++)
	{%>
		<tr>
			<td><% out.println(names[j]);%></td>
			<td><% out.println(quantity[j]);%></td>
		</tr>
	<%
	}
	%></table></center><center><br><br><%
	out.println("Total:"+total);
	%><button onclick="print()">PRINT</button>
	</center><center><br><br>
	
	 </center>      
</body>
</html>




