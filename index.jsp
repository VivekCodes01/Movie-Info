<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="org.json.*"%>
<html>
	<head>
		<title>Movie Info</title>
	</head>
	<style>
		*{
			text-align:center;
			
		  }
		body {
    margin: 0;
    padding: 20px;
    min-height: 100vh;

    background: conic-gradient(
        from 210deg,
        #c5bbb8 0deg,
        #c5bbb8 24deg,
        #b8b5b8 calc(24deg + 0.1deg),
        #b8b5b8 48deg,
        #a9afb7 calc(48deg + 0.1deg),
        #a9afb7 72deg,
        #9aa8b5 calc(72deg + 0.1deg),
        #9aa8b5 96deg,
        #8ba1b3 calc(96deg + 0.1deg),
        #8ba1b3 120deg,
        #7d98af calc(120deg + 0.1deg),
        #7d98af 144deg,
        #7090ab calc(144deg + 0.1deg),
        #7090ab 168deg,
        #6587a6 calc(168deg + 0.1deg),
        #6587a6 192deg,
        #5c7ea1 calc(192deg + 0.1deg),
        #5c7ea1 216deg,
        #55759b calc(216deg + 0.1deg),
        #55759b 240deg,
        #516c94 calc(240deg + 0.1deg),
        #516c94 264deg,
        #4f638d calc(264deg + 0.1deg),
        #4f638d 288deg,
        #505a85 calc(288deg + 0.1deg),
        #505a85 312deg,
        #54537d calc(312deg + 0.1deg),
        #54537d 336deg,
        #5b4b74 calc(336deg + 0.1deg),
        #5b4b74 360deg
    );

    font-family: Arial, sans-serif;
}
		.poster {
    width: 200px;
    height: 300px;
    object-fit: cover;
    border-radius: 8px;
    margin-top: 15px;
}
		.box
		{
			border: 5px solid black;
			border-radius:5px;
			width:500px;
			min-height:400px;
			margin: 30px auto;
			postion:relative;
   font-family: Arial, sans-serif;
			animation: fadeIn 1s ease-in;
			text-align: center;
			padding:20px;
			 background: rgba(255, 255, 255, 0.2);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);

    border: 2px solid rgba(255, 255, 255, 0.4);
    border-radius: 15px;

    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.25);
		}

		@keyframes fadeIn {
   			 from {
       					 opacity: 0;
   				 }

    			to {
       					 opacity: 1;
    			     }
			}

		.search {
    width: 350px;
    height: 45px;
    padding: 0 18px;

    font-size: 16px;
    color: #222;

    background: rgba(255, 255, 255, 0.85);
    border: 2px solid rgba(255, 255, 255, 0.6);
    border-radius: 25px;

    outline: none;
    box-sizing: border-box;

    transition: 0.3s;
}

.search::placeholder {
    color: #666;
}

.search:focus {
    width: 400px;
    border-color: #4f638d;
    box-shadow: 0 0 15px rgba(255, 255, 255, 0.5);
}
		.btn {
    height: 45px;
    padding: 0 28px;

    background: #4f638d;
    color: white;

    border: none;
    border-radius: 25px;

    font-size: 15px;
    font-weight: bold;

    cursor: pointer;

    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.25);

    transition: 0.3s;
}

.btn:hover {
    background: #352f5c;
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.35);
}
	</style>
<body>

<form method="post">

<input type="text" name="search"  class="search" placeholder="Enter movie name" required><br><br>
<input type="submit" value="Search" class="btn">


</form>
<%
	String movie = request.getParameter("search");

	String name="",year="",released="",runtime="",genre="",actors="",lang="",country="",plot="",res="",rating="",boxoffice="",poster="",type="";
	boolean found=false;

	
	try
		{

	
		
		
	if(movie != null )
	{
		



		String link = "https://www.omdbapi.com/?apikey=5bc2f102&t="+ URLEncoder.encode(movie, "UTF-8");
	
	

		URL url = new URL(link);
		HttpURLConnection con = (HttpURLConnection)url.openConnection();
		con.setRequestMethod("GET");
		int status = con.getResponseCode();
		
	if(status==200)
{
		InputStreamReader inst = new InputStreamReader(con.getInputStream());
		BufferedReader br = new BufferedReader(inst);
	
		String data="";
		String line= br.readLine();
		
		while(line!=null)
		{
			data+=line;
			line=br.readLine();
		}
		
		JSONObject obj = new JSONObject(data);
		 res = obj.optString("Response");
		if(res.equals("True"))
		{
		 name = obj.optString("Title");
		year=obj.optString("Year");
		released=obj.optString("Released");
		runtime=obj.optString("Runtime");
		genre=obj.optString("Genre");
		actors=obj.optString("Actors");
		plot=obj.optString("Plot");
		lang=obj.optString("Language");
		country=obj.optString("Country");
		rating=obj.optString("imdbRating")	;
		boxoffice=obj.optString("BoxOffice")	;
		poster=obj.optString("Poster");
		type==obj.optString("Type");

		found = true;
		}
		else
		{
			out.println("Movie not found");
		}

}
		
	}
		}
	catch(Exception e)
		{
			out.println("Movie not found"+e);
		}
%>
<%

	if(found==true)
	{

%>

	<div class="box">
<p>Name:<%=name%></p>
<p>Year:<%=year%></p>
<p>Released:<%=released%></p>
<p>Duration:<%=runtime%></p>
<p>Genre:<%=genre%></p>
<p>Actors:<%=actors%></p>
<p>Plot:<%=plot%></p>
<p>language:<%=lang%></p>
<p>Country:<%=country%></p>
<p>Type:<%=type%></p>
<p>IBM Rating:<%=rating%></p>
<p>Box Office Collection:<%=boxoffice%></p>	
<img src="<%=poster%>" class="poster">

</div>


<%
}



%>




</body>
</html>