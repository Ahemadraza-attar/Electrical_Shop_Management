<html>
<body>

<center><b><font size=7>--:Sales:--</font></b></center><br><br>
<form method="post" name="bookingForm"  >
<center>
Bill No.<input type="text" name="no">&nbsp;&nbsp;&nbsp;
Bill Date<input type="text" name="date"><br><br>
</center>
<center>
Customer Id<input type="text" name="id"><br><br>
Customer Name<input type="text" name="sname">
</center>

<script type="text/javascript">

	function arrangeSno(tableId)
	{
		var tblObj = document.getElementById(tableId);
		var no_of_rows = tblObj.rows.length;
		
		for(var i=0; i< no_of_rows-1;i++)
		{
			tblObj.rows[i+1].cells[0].innerHTML=i+1;
		}
	}
	
	function addPassanger(tableId)
	{
		var tblObj=document.getElementById(tableId);
		var no_of_rows=tblObj.rows.length;
	
		var row_in_table=tblObj.insertRow(no_of_rows);
		var colCount=tblObj.rows[0].cells.length;
		var rno=eval(tblObj.rows[no_of_rows-1].cells[0].innerHTML)+1;
		for(var i=0;i<colCount;i++)
		{
			var column_in_row=row_in_table.insertCell(i);
			column_in_row.innerHTML=tblObj.rows[1].cells[i].innerHTML;
			if(i==0) column_in_row.innerHTML=rno;
	
			switch(column_in_row.childNodes[0].type)
			{
				case "text":
						column_in_row.childNodes[0].value="";
						break;
				case "checkbox":
						column_in_row.childNodes[0].checked=false;
						break;
				case "select-one":
						column_in_row.childNodes[0].selectedIndex=0;
						break;
			}
		}
	}

	function deletePassasngerRow(tableId)
	{
		var tblObj=document.getElementById(tableId);
		var delchkbox=document.bookingForm.delchk; 	
		var no_of_rows=delchkbox.length;
	
		for(var i=0;i<no_of_rows;i++)
		{
			if(delchkbox[i].checked && tblObj.rows.length>=3)
			{
				tblObj.deleteRow(i+1);
				no_of_rows--;
				i--;
			}
		}
		arrangeSno(tableId);
	}
</script>

<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.servlet.*" %>
<%
try{
Class.forName("org.postgresql.Driver");
Connection con=DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb9","ty9"," " );
String str="select * from item_master";
PreparedStatement ps=con.prepareStatement(str);
ResultSet rs=ps.executeQuery();

%>


<center><table id="PDetailsTable" border="1" width="350px">
<tbody>

	<tr><th>SNo</th><th>Item Name</th><th>Quantity</th><<th>Select To Delete</th></tr>
	<tr><td>1</td>
		<td>
			<select name="item">
			<%
			while(rs.next())
			{
				String name=rs.getString("item_name");
			%>
			<option value="<%=name%>"><%=name%> </option>
			<%
			}%>
			</select>
		</td>
		<td><input type="text" name="Quantity" autofocus="true" placeholder="Enter Quantity"></td>
		
		<td><input name="delchk" type="checkbox"/></td>
	</tr>
</tbody>
</table><br><br>
</center>
<center>
<input type="button" value="Add more Entries" onclick="addPassanger('PDetailsTable')"/>
<input type="button" value="Delete Row" onclick="deletePassasngerRow('PDetailsTable')"/>

</center><br><br>
<center>
<!--Total Amount<input type="text" name="amount"><br><br>-->
</center><center><input type="submit" value="Submit Bill"></center>
</form>


<%
 	String[] names=request.getParameterValues("item");
	String[] quantity=request.getParameterValues("Quantity");
	//String[] rate=request.getParameterValues("Rate");
	String s1=request.getParameter("no");
	String s2=request.getParameter("date");
	String s3=request.getParameter("id");
	String s4=request.getParameter("sname");
	
	if(request.getMethod().equalsIgnoreCase("POST"))
	{
		int total=0;	
		String sql1,sql2,sql3,sql4,sql5,sql6;
		ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null;
		Statement st1=con.createStatement();
		Statement st2=con.createStatement();
		Statement st3=con.createStatement();	
		Statement st4=con.createStatement();	
		Statement st5=con.createStatement();
		Statement st6=con.createStatement();		
		int arr[]=new int[names.length];	
	
		for(int i=0;i<names.length;i++)
		{
			sql1="select rate from item_master where item_name='"+names[i]+"'";
			rs1=st1.executeQuery(sql1);
			rs1.next();		
			arr[i]=rs1.getInt(1);
			total=total+((Integer.parseInt(quantity[i]))*(arr[i]));
		}
		
		Statement st=con.createStatement();
    		
			
		int n,mult,q,flag=0;
		int qua[]=new int[names.length];
	
		
		for(int j=0;j<names.length;j++)
		{
			
			mult = ((Integer.parseInt(quantity[j]))*(arr[j]));
			
			sql4="select quantity from item_master where item_name='"+names[j]+"'";
			
			rs4=st4.executeQuery(sql4);
			rs4.next();
				qua[j]=((rs4.getInt(1))-(Integer.parseInt(quantity[j])));
						
			out.print(qua[j]);
			if(qua[j] < 0)
			{
				flag=0;
				break;
			}
			else
			{
				flag=1;
			}
		}
		
		if( flag == 0)
		{
			out.println("<center>Quantity is not Sufficient</center>");
		}
		else
		{
		  sql6="insert into bill_master values ("+s1+",'"+s2+"',"+total+","+s3+");";
		  st6.execute(sql6);
		  
		  for(n=0;n<names.length;n++)
		  {
			sql5="update item_master set quantity="+qua[n]+" where item_name='"+names[n]+"'";
			st5.execute(sql5);
		  }
		  for(int m=0;m<names.length;m++)
		  {
			sql2 = "select item_id from item_master where item_name='"+names[m]+"'";			
			rs2=st2.executeQuery(sql2);			
			rs2.next();
			sql3 = "insert into bill_details values ("+s1+","+rs2.getInt(1)+","+quantity[m]+","+arr[m]+" );";
			st3.execute(sql3);
		  }
		
		
		 		
		  out.print("<center>Bill Submitted Successfully With ");
                          
			HttpSession s = request.getSession(true);

			s.setAttribute("no",s1);
			s.setAttribute("date",s2);
			s.setAttribute("id",s3);
			s.setAttribute("sname",s4);
		
			String leng=""+names.length;
			s.setAttribute("l",leng);

			for(int i=0;i<names.length;i++)
			{
				s.setAttribute("name"+i,names[i]);
			}	
			for(int z=0;z<names.length;z++)
			{
				s.setAttribute("quantity"+z,quantity[z]);
			}
			String t=""+total;
			s.setAttribute("total",t);

			out.println(" Total Amount:"+total);%>
                        <br>
                         <center><A HREF="bill1.jsp">VIEW</A></center> 
			<% out.print("</center>");
		  }
			
		}
		
		
	con.close();	

}
catch(Exception e)
{
	out.print(e);
	out.print("Please Provide Proper Details");
}
%>
<br><center><A HREF="employee_menu.jsp">Back</A></center>
</body>
</html>

