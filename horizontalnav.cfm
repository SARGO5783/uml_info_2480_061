<cfoutput>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="##">
            <img src="images/rdb.png" alt="Read Dees Books Logo"/>
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="##navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#cgi.SCRIPT_NAME#">Home <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#cgi.SCRIPT_NAME#?p=content&id=B6F16606-CBC2-48B7-9AA1A363CC19948B">Store Information</a>
                    </li>
                    
                    <li class="nav-item">
                        <a class="nav-link" href="#cgi.SCRIPT_NAME#?p=content&id=DEDF0B6D-C219-4492-88B39B4F1EDAEC8D">Highlighted Favorites</a>
                        

                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#cgi.SCRIPT_NAME#?p=content&id=9E542DC7-2D04-42A3-A3E9AEECC2F596A5">Events</a>
                    </li>
            </ul>
                <form class="d-flex" action="#cgi.script_name#?p=details" method="post">
                    <input class="form-control me-2" type="search" name="searchme" placeholder="Search" aria-label="Search">                
                    <button class="btn btn-outline-success" type="submit">Search</button>            
                </form> 
            <ul class="navbar-nav mr-auto">
                    <cfif session.user.isloggedin> 
                         <li class="nav-item">
                             <span class="nav-link">Welcome #session.user.firstname#</a>
                         </li>
                         <li class="nav-item">
                            <a href="#cgi.SCRIPT_NAME#?p=logoff " class="nav-link">logout</a>
                         </li>
                        <cfelse>    
                            <li class="nav-item">
                                <a href="#cgi.SCRIPT_NAME#?p=login" class="nav-link">Login</a>
                            </li>
                    </cfif>
                    <cfif session.user.isAdmin == 1>
                        <li class="nav-item">
                            <a href="management/index.cfm?tool=addEdit" class="nav-link">Management</a>
                        </li>
                    </cfif>
            </ul>
        </div>
    </nav>
</cfoutput>