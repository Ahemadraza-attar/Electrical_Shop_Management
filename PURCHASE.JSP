<html>
<body bgcolor="lightgrey">

<center><b><font size=7>--:Purchase:--</font></b></center><br><br>
<form method="post" name="bookingForm"  >
<center>
Bill No.<input type="text" name="no">&nbsp;&nbsp;&nbsp;
Bill Date<input type="text" name="date"><br><br>
</center>
<center>
Supplier Id<input type="text" name="id"><br><br>
Supplier Name<input type="text" name="sname">
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

	<tr><th>SNo</th><th>Item Name</th><th>Quantity</th><th>Rate</th><th>Select To Delete</th></tr>
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
		<td><input type="text" name="Rate" autofocus="true" placeholder="Enter Rate"></td>
		<td><input name="delchk" type="checkbox"/></td>
	</tr>
</tbody>
</table><br><br>
</center>
<center>
<input type="button" value="Add more Entries" onclick="addPassanger('PDetailsTable')"/>
<input type="button" value="Delete Row" onclick="deletePassasngerRow('PDetailsTable')"/>
<input type="button" value="OK" onclick="get()"/>
</center><br><br>
<center>
<!--Total Amount<input type="text" name="amount"><br><br>-->
</center><center><input type="submit" value="Submit Bill"></center>
</form>



<%
 	String[] names=request.getParameterValues("item");
	String[] quantity=request.getParameterValues("Quantity");
	String[] rate=request.getParameterValues("Rate");
	String s1=request.getParameter("no");
	String s2=request.getParameter("date");
	String s3=request.getParameter("id");
	String s4=request.getParameter("sname");
	
	if(request.getMethod().equalsIgnoreCase("POST"))
	{
		int total=0;	

		for(int i=0;i<names.length;i++)
		{
			total=total+((Integer.parseInt(quantity[i]))*(Integer.parseInt(rate[i])));
		}
		
		Statement st=con.createStatement();
    		st.execute("insert into purchase_master values ("+s1+",'"+s2+"',"+total+","+s3+");");
	
		Statement st1=con.createStatement();
		Statement st2=con.createStatement();
		Statement st3=con.createStatement();	
		Statement st4=con.createStatement();			
		/*int mult[]=new int[names.length];
		int res[]=new int[names.length]; 

		int result[]=new int[names.length];
		
		for(int j=0;j<names.length;j++)
		{
			mult[j] = ((Integer.parseInt(quantity[j]))*(Integer.parseInt(rate[j])));
			ResultSet rs1=null;
			rs1=st1.executeQuery("select item_id from item_master where item_name='"+names[j]+" '");			
			rs1.next();
			st2.execute("insert into purchase_details values ("+s1+","+rs1.getInt(1)+","+quantity[j]+","+rate[j]+","+mult[j]+" );");
				
		}*/
		
		int mult,qua;
		ResultSet rs1=null,rs2=null;
		String sql1,sql2,sql3,sql4;
		for(int j=0;j<names.length;j++)
		{
			mult = ((Integer.parseInt(quantity[j]))*(Integer.parseInt(rate[j])));
			sql1 = "select item_id from item_master where item_name='"+names[j]+"'";			
			
			rs1=st1.executeQuery(sql1);			
			rs1.next();
			
			sql2 = "insert into purchase_details values ("+s1+","+rs1.getInt(1)+","+quantity[j]+","+rate[j]+","+mult+" );";
			
			st2.execute(sql2);
			
		}
		
		for(int k=0;k<names.length;k++)
		{
 			sql3="select quantity from item_master where item_name='"+names[k]+"'";
			
			rs2=st3.executeQuery(sql3);
			rs2.next();
			
			qua=rs2.getInt(1)+(Integer.parseInt(quantity[k]));
					
			sql4="update item_master set rate = "+rate[k]+" , quantity="+qua+" where item_name='"+names[k]+ "'";
		
			st3.execute(sql4);
				
		}
		out.print("<center>Bill Submitted Successfully With");
		out.println("Total Amount:"+total);
HttpSession ss = request.getSession(true);

	ss.setAttribute("no1",s1);
	ss.setAttribute("date1",s2);
	ss.setAttribute("id1",s3);
	ss.setAttribute("sname1",s4);
	
	String leng=""+names.length;
	ss.setAttribute("l1",leng);

	for(int i=0;i<names.length;i++)
	{
		ss.setAttribute("name1"+i,names[i]);
	}
	for(int z=0;z<names.length;z++)
	{
		ss.setAttribute("quantity1"+z,quantity[z]);
	}
       for(int r=0;r<names.length;r++)
	{ 	
	ss.setAttribute("rate1"+r,rate[r]);
        }
	String t=""+total;
	ss.setAttribute("total1",t);

			%>
                        <br>
                         <center><A HREF="bill2.jsp">PRINT</A></center> 
			<% out.print("</center>");
		out.print("</center>");
 	
%>

 
<%
}	
	
	con.close();	

}
catch(Exception e)
{
	out.print("Please Provide Proper Details");
}
%>
<A HREF="admin_menu.jsp">Back</A>
</body>
</html>

