<cfparam name="genre" default="green" />
<cfparam name="searchme" default=""> 
<cfset bookinfo = bookstoreFunctions.obtainSearchResults(searchme, genre) />
<cfoutput>

<div>
    <h3>
        <cfoutput>
            #bookstoreFunctions.resultsHeader(searchme, genre)#
        </cfoutput>
    </h3>
</div>
<cfif bookinfo.recordcount == 0>
    #noResults()#
    <cfelseif bookinfo.recordcount == 1>
        #oneResult()#
    <cfelse>
        #manyResults()#
    </cfif>
</cfoutput>

    <cffunction name = "noResults">
        There were no results.
        Please try again
    </cffunction>
    <cffunction name = "oneResult">
       <h6> There was one result: </h6>

        <cfoutput>
            <img src="images/#bookinfo.IMAGE[1]#" style="float:left; width:250px; height:250px"/>
            <span>Title: #bookinfo.title[1]#</span>
            <span>Publisher: #bookinfo.name[1]#</span>
            <span>Year Published: #bookinfo.year[1]#</span>
            <span>Pages: #bookinfo.pages[1]#</span>
        </cfoutput>

    </cffunction>
    <cffunction name = "manyResults">
        There were more than one result, Here is a list:
        <ol class="nav flex-column">
            <cfoutput query= "bookinfo">
                <li class="nav-item">
                    <a class="nav-link" href="#cgi.script_name#?p=details&searchme=#trim(title)#">
                        #trim(title)#
                    </a>
                </li>
            </cfoutput>
        </ol>
    </cffunction>
