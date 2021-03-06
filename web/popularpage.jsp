<%@page import="java.sql.*"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="connectionpack.Config"%>


<html>
	<head>
		<title>Mini Stack Exchange</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<meta name="description" content="" />
		<meta name="keywords" content="" />
		<link rel="stylesheet" href="assets/css/main.css" />
	<script language="javascript">
function SelectRedirect(src){
// ON selection of section this function will work
//alert( document.getElementById('s1').value);
window.location=src;
}
////////////////// 
</script>
        </head>
	<body class="is-preload">

			<header id="header">
				<a class="logo" href="index.jsp">Mini Stack Exchange</a>
				<nav>
                                    <%
                                    String s=(String)session.getAttribute("username");
                                    if(s==null)s="";
                                    else s="Welcome,".concat(s);
                                    %><%=s%>
					<a href="#menu">Menu</a>
				</nav>
			</header>

		<!-- Nav -->
			<nav id="menu">
				<ul class="links">
					<li><a href="index.jsp">Home</a></li>
					    <li><a href="loginpage.jsp">Login</a></li>
                                        
					<li><a href="popularpage.jsp">Popular</a></li>
                                        <li><a href="postinspage.jsp">Create Post</a></li>
				</ul>
			</nav>
				<div id="heading" >
				<h1>Mini STack Exchange</h1>
                                </div>
<br>
        
    
                                   <section> </section><!-- CTA -->
                
                <div class="inner" >
                    <form><div class="row gtr-50" style="width:300px;align-content:center" align="center">
                            Sort By:<select  onChange="SelectRedirect(this.value);">
                                <option value="popularpage.jsp?type=viewcount">Views</option>
                                <option value="popularpage.jsp?type=favouritecount">favorite</option>
                                <option value="popularpage.jsp?type=answercount">answer</option>
                                <option value="popularpage.jsp?type=commentcount">comment</option>
                            </select>
                        </div>
                        
                    </form>
                        <br><%
                        String mn=request.getParameter("search");
                        %>
                    <center><H2>Popular Posts</h2></center>
                    <ul class="alt">
                        <form name=frm action="viewpost"  method="post" action="">
                            <input type="hidden" name="hdnbtn"/>
                            
                <%Connection conn=null;
                Statement st=null;
                Statement st2=null;
                String username=null;
                String search=request.getParameter("search");
        try{
               Class.forName("org.postgresql.Driver");   
        conn=DriverManager.getConnection("jdbc:postgresql://localhost:5432/group_31", "postgres", "1234");
        String posttext;
        int postid;
            st =conn.createStatement();
            st2=conn.createStatement();
            String sd=(String)request.getParameter("type");
            if(sd==null)
                sd="viewcount";
            ResultSet resultSet = st.executeQuery("SELECT * FROM posts where posttypeid=1 order by "+sd+" desc limit 10");
            
            while(resultSet.next())
            {
                posttext = resultSet.getString("title");
                postid=resultSet.getInt("id");
                int userid=resultSet.getInt("owneruserid");
                ResultSet rs=st2.executeQuery("SELECT * FROM users where id="+userid);
                Timestamp date=resultSet.getTimestamp("creationdate");
                while(rs.next())
                username=rs.getString("displayname");
                String datea=date.toLocalDateTime().toString();
                datea=datea.substring(0, 10);
                %>
                
			<li><section>
							<div class="content">
								<header>
									
								</header>
							<font color="black"><p><%=posttext%>
</p></font>
Asked By:<a href="userpage.jsp?id=<%=userid%>"> <%=username%></a> <b>On:<%=datea%> <%=resultSet.getInt("viewcount")%> Views  <div style="color: green;"><%=resultSet.getInt("answercount")%> Answers</div><div align="right">  <b></b><button id=postid name="Goto" value=<%=postid%> onclick="{document.frm.hdnbt.value=this.value;document.frm.submit();}"   class="button primary small">Goto Post</button></div>
							</div>
                                                       
			</section>
    <% }
      conn.close();
      }
    catch(Exception e){
        out.println(e);
    }
        
    %> 
    </form>
</ul>
                        </div>
		
		<!-- Footer -->
			<footer id="footer">
				<div class="inner">
					<div class="content">
						<section>
							<h3>Mini Stack Exchange</h3>
							<p>The Website is developed on netbeans using java Server pages and servlets,using PostgreSQL on the backend and having a wide variety of features.</p>
						</section>
						<section>
							<h4>Shortcuts</h4>
							<ul class="alt">
								<li><a href="#">Login Page.</a></li>
								<li><a href="#">Signup Page.</a></li>
								<li><a href="#">Search page</a></li>
								<li><a href="#">Posts</a></li>
							</ul>
						</section>
						<section>
							<h4>Links to favorites</h4>
							<ul class="plain">
								<li><a href="#"><i class="icon fa-twitter">&nbsp;</i>Twitter</a></li>
								<li><a href="#"><i class="icon fa-facebook">&nbsp;</i>Facebook</a></li>
								<li><a href="#"><i class="icon fa-instagram">&nbsp;</i>Instagram</a></li>
								<li><a href="#"><i class="icon fa-github">&nbsp;</i>Github</a></li>
							</ul>
						</section>
					</div>
					<div class="copyright">
						&copy; Untitled. Photos <a href="#">SSS</a> <a href="https://coverr.co">Initiative</a>.
					</div>
				</div>
			</footer>

		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/browser.min.js"></script>
			<script src="assets/js/breakpoints.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>

	</body>
</html>