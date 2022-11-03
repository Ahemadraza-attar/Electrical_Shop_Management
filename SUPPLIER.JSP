<html>
<head>

<center> <font size=6><b>--:Supplier Details:--</b></font> </center>
<br><br>
<script type="text/javascript">
function validate()
{
	if(document.myform.phone.value == "" ||
	   isNaN(document.myform.phone.value) ||
	   document.myform.phone.value.length != 10)
	{
		alert("Please Provide numeric values of length '10'");
		document.myform.phone.focus();
		return false
	}
	
        var pat=/^[a-zA-Z \ ]+$/;
	var n=document.myform.cname.value;
	if((!pat.test(n))||(n.length>20))
	{
		alert("Invalid Name");
		return false;
	}

	var patt=/^([A-Za-z0-9](\.)?(\-)?)+([A-Za-z0-9])*\@([A-Za-z0-9](\-)?)+([A-Za-z0-9])+\.([A-Za-z0-9]{2,4})$/;
	var e=document.myform.email.value;
	if(!patt.test(e))
	{
		alert("Invalid Email");
		return false;
	}
alert("ok");	
}
//var x=document.myform.email.value;
//var atposition=x.indexOf("@");
//var dotposition=x.lastIndexOf(".");
//if (atposition<1 || dotposition<atposition+2||dotposition+2>=x.length)
//{
//alert("Please enter a valid email address"):
//return false;}}
</script>
</head>

<body bgcolor="lightgrey">
<form method="post" name="myform" >
<font size=5>
<center>
	<table>
		<tr><td>Supplier Id</td>	<td><input type="text" name="customer Id" autofocus="true" placeholder="Enter Id"></td>
					<td><input type="submit" name="Show Details" value="Show Details"></td></tr>
		<tr><td>Supplier Name</td>	<td><input type="text" name="customer Name" id="cname" autofocus="true" placeholder="Enter Your customer name"></td></tr>
		<tr><td>Phone Number</td>	<td><input type="text" name="Phone Number" id="phone" value=""></td></tr>
		<tr><td>Address</td>		<td><input type="text" name="Address" autofocus="true" placeholder="Enter Address"></td></tr>
		<tr><td>Email Id</td>		<td><input type="text" name="email" id="email" value="@gmail.com" autofocus="true" placeholder="Enter email"></td><tr>
		<tr><td><br></td></tr>
		<tr><th><input type="radio" name="r" value="new">NEW
			</th><th><input type="radio" name="r" value="Update">UPDATE</th></tr>
	</table>
</center>
</font>
<br><br>
<center>
	<input type="submit" name="submit" value="submit" onclick="return validate();" >&nbsp;&nbsp;
 	<input type="submit" name="cancel" value="cancel">&nbsp;&nbsp;
</center>

</form>




<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%
try{
Class.forName("org.postgresql.Driver");
Connection con=DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb9","ty9"," " );

String s1=request.getParameter("customer Id");
String s2=request.getParameter("customer Name");
String s3=request.getParameter("Address");
String s4=request.getParameter("Phone Number");
String s5=request.getParameter("email");
String s8=request.getParameter("Show Details");
if(s8!=null)
{
  Statement st=con.createStatement();
  
  ResultSet rs1= st.executeQuery("select * from supplier_master where supp_id="+s1+"");
  if(rs1.next())
  {
  
 	 out.println("<center> <font color=\"green\" > Supplier Details Of Given Supplier Id: </font></center> ");
  %><center><table border><tr><td>Id</td><td>Name</td><td>Phone No</td><td>Email</td><td>Address</td></tr>
	    <tr><td><% out.println(rs1.getInt(1));%></td>
		<td><% out.println(rs1.getString(2));%></td>
		<td><% out.println(rs1.getString(3));%></td>
		<td><% out.println(rs1.getString(4));%></td>
		<td><% out.println(rs1.getString(5));%></td>
	    </tr>
     </table></center>
   <%
  }
 else
 {
	out.println("<center><font color=\"red\">Supplier Not Available</font></center>");
 }
}
else 
{

String choice=request.getParameter("r");


if(request.getMethod().equalsIgnoreCase("POST"))
{
if(choice.equals("new"))
{
	//out.print("New");
	if(s1.isEmpty() || s2.isEmpty() || s3.isEmpty() || s4.isEmpty() || s5.isEmpty())
	{
	 
         out.print("<center> <font color=\"red\" > Incorrect Details </font></center> ");
	}
	else if((s2.charAt(0)==' ') || (s1.charAt(0)==' ') || (s3.charAt(0)==' ') || (s4.charAt(0)==' ') || (s5.charAt(0)==' '))
	{	
		out.print("<center> <font color=\"red\" > Space must not be first character </font></center> ");
	}
	//else if
	else
	{
	//out.print("else");
	//String sql = "insert into employee values ("+s1+","+s6+",'"+s7+"','"+s2+"',"+s4+",'"+s3+"','"+s5+"');";
	//out.print(sql);
	Statement st=con.createStatement();
	st.execute("insert into supplier_master values ("+s1+",'"+s2+"',"+s4+",'"+s5+"','"+s3+"');");

                                                //response.sendRedirect("supplier.jsp");
        
	out.print("<center> <font color=\"green\" > Supplier Details Added </font></center> ");
	
	}
	//out.print("iiii");	
}
else if(choice.equals("Update"))
{	
	//out.print("Update ");
	if(s1.isEmpty() || s2.isEmpty() || s3.isEmpty() || s4.isEmpty() || s5.isEmpty() )
        {
	
         out.print("<center> <font color=\"red\" > Incorrect Details </font></center> ");

	}
	else if((s2.charAt(0)==' ') || (s1.charAt(0)==' ') || (s3.charAt(0)==' ') || (s4.charAt(0)==' ') || (s5.charAt(0)==' '))
	{	
		out.print("<center> <font color=\"red\" > Space must not be first character </font></center> ");
	}
	//else if
	else
	{
       	Statement st1=con.createStatement();
	st1.execute("update supplier_master set supp_name='"+s2+"',phone_no="+s4+",email='"+s5+"',address='"+s3+"' where supp_id="+s1+" ;");  
                                                //response.sendRedirect("supplier.jsp");
        out.print("<center> <font color=\"green\" > Supplier Details Updated </font></center> ");

        }
        
}}

}
con.close();
}
catch(Exception e)
{
	out.print("Please Provide Proper Details");
}	



%>

<br><br><A HREF="admin_menu.jsp">Back</A>


</body>
</html>
