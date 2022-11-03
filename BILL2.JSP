<html>
<body>
<h1><center>Purchase Bill</center></h1><br><br>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.servlet.*" %>
<%


HttpSession hs1=request.getSession();
	String no1=(String)hs1.getAttribute("no1");
	String date1=(String)hs1.getAttribute("date1");
	String id1=(String)hs1.getAttribute("id1");
	String name1=(String)hs1.getAttribute("sname1");
	String len1=(String)hs1.getAttribute("l1");
	
	int l1=Integer.parseInt(len1);
	String names1[]=new String[l1];
	String quantity1[]=new String[l1];
  	String rate1[]=new String[l1];

	for(int i=0;i<l1;i++)
	{
		names1[i]=(String)hs1.getAttribute("name1"+i);
	}
	for(int k=0;k<l1;k++)
	{
		quantity1[k]=(String)hs1.getAttribute("quantity1"+k);
	}
	String total1=(String)hs1.getAttribute("total1");
	for(int s=0;s<l1;s++)
  	{
	rate1[s]=(String)hs1.getAttribute("rate1"+s);
	}

	%> <center> <%
	out.println("Bill No.:"+no1);
	out.println("Bill Date:"+date1);%><br><br></center><center><%
	out.println("Supplier Id:"+id1);
	out.println("Supplier Name:"+name1);%><br></center><center><br><br><%
	%><table border=1><tr>
		<td><% out.println("Item Name ");%></td>
		<td><% out.println("Item Quantity");%></td>
		<td><% out.println("Item Rate:");%>
		</tr>
	<%
	for(int j=0;j<l1;j++)
	{%>
		<tr>
			<td><% out.println(names1[j]);%></td>
			<td><% out.println(quantity1[j]);%></td>
			<td><% out.println(rate1[j]);%></td>
		</tr>
	<%
	}
	%></table></center><center><br><br><%
	out.println("Total:"+total1);
	%><button onclick="print()">PRINT</button>
 </center>      
</body>
</html>




