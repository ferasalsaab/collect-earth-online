
<nav class="navbar navbar-expand-lg navbar-light fixed-top py-0" style="background-color: white;" id="main-nav">
	<div class="container-fluid">
				<a class="navbar-brand pt-1 pb-1" href="${root}/home">    
					<img class= "img-fluid" id="ceo-site-logo" src="${root}/img/ceo-logo.png">
				</a>
			   <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			    <span class="navbar-toggler-icon"></span>
			  </button>
			  
			  
	  	<div class="collapse navbar-collapse" id="navbarSupportedContent">
	  		<ul class="navbar-nav ml-auto">
	        <#list ["Home","About", "Support"] as url>
	            <#if navlink == url>
	                <li class="nav-item active">
	                		<a class="nav-link" href="${root}/${url?lower_case}">${url}</a>
					</li>
	            <#else>
	                <li class="nav-item">
	                		<a class="nav-link" href="${root}/${url?lower_case}">${url}</a>
	                </li>
	            </#if>
	        </#list>
	        <#if username??>
	            <#if navlink == "Account">
	                <li class="nav-item active">
						<a class="nav-link" href="${root}/account/${userid}">Account</a>
					</li>
	            <#else>
	                <li class="nav-item">
	                		<a  class="nav-link" href="${root}/account/${userid}">Account</a>
	                </li>
	            </#if>
	        </#if>
	
	        <#if username??>
		            <#if navlink == "Logout">
		            <li id="username" class="nav-item">
		            <span class="nav-link disabled">${username}</span> 
		            </li>
		            <li  id="login-button"class="nav-item">
	   	            <button type="button" class="btn btn-outline-danger btn-sm" onclick="location.href = '${root}/logout'">
	           	      Logout
	                 </button>	 
	                 </li>   
		            <#else>
		            <li id="username" class="nav-item my-auto">
		            <span class="nav-link disabled">${username}</span> 
		            </li>
		            <li  id="login-button"class="nav-item my-auto">
	   	            <button type="button" class="btn btn-outline-danger btn-sm" onclick="location.href = '${root}/logout'">
	           	      Logout
	                 </button>
	                 </li>	    
	               </#if>
	        <#else>
	            <#if navlink == "Login" || navlink == "Register">
	            <li id="login-button" class="nav-item my-auto">
		            <button type="button" class="btn bg-lightgreen btn-sm" onclick="location.href = '${root}/login'">
		                Login/Register
	                </button>
	                </li>
		            <#else>
		            <li id="login-button" class="nav-item my-auto">
		            <button type="button" class="btn bg-lightgreen btn-sm" onclick="location.href = '${root}/login'">
		                Login/Register
	                </button>
	                </li>
	            </#if>
	        </#if>
	    </ul>
	    </div>
    </div><!-- end container -->
</nav>

<script>
function menuControls() {
    var x = document.getElementById("myTopnav");
    if (x.className === "topnav") {
        x.className += " responsive";
    } else {
        x.className = "topnav";
    }
    var ml = document.getElementById("mobileLogin");
    if (ml.className === "mobileLogin") {
            ml.className += " responsive";
        } else {
            ml.className = "mobileLogin";
        }
}
</script>