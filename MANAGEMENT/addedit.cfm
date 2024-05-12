<cftry>
    <cfparam name= "book" default= ""/>
    <cfparam name="qterm" default=""/>
    <cfset addEditFunctions = createObject("addedit") />
    <cfset addEditFunctions.processForms(form) >


    <div class="row">
        <div id="main" class="col-9">
            <cfif book.len() gt 0>
                <cfoutput>#mainForm()#</cfoutput>
            </cfif> 
        </div>
        <div id= "leftgutter" class="col-lg-3 order-first">
            <cfoutput> #sideNav()#</cfoutput>           
        </div>
    </div>
    <cfcatch type="any">
        <cfoutput>
            #cfcatch.Message#
        </cfoutput>
    </cfcatch>
</cftry>

<cffunction name="sideNav">
    <cfset allbooks = addEditFunctions.sideNavBooks(qterm)>
    <div>
        Book List
    </div>
    <cfoutput>
        #findBookForm()#
    </cfoutput>
    <cfoutput>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a href="#cgi.script_name#?tool=addedit&book=new" class ="nav-link">
                    New Book
                </a>
            </li>
            
            <cfif qterm.len() ==0>
                No Search Term Entered
                <cfelseif allBooks.recordcount==0>
                    No Results Found
                <cfelse>
                    <cfloop query="allbooks">
                        <li class= "nav-item">
                            <a class="nav-link" href="#cgi.SCRIPT_NAME#?tool=addedit&book=#isbn13#&qTerm=#qTerm#">#trim(title)#</a>
                        </li>
                    </cfloop>
            </cfif>
        </ul>
    </cfoutput>
</cffunction>
<cffunction name="findBookForm">
    <cfoutput>
        <form action="#cgi.script_name#?tool=#tool#" method="post">
            <div class="form-floating mb-3">
                <input type="text" id="qterm" name="qterm" class="form-control" value="#qterm#" placeholder="Enter a search term to find a book to edit" />
                <label for="qterm">Search Inventory </label>
            </div>
        </form>
    </cfoutput>
</cffunction>

<cffunction name="mainForm">
    <cfset allPublisher = addEditFunctions.allPublishers()>
    <cfset var thisBookDetails= addEditFunctions.bookDetails(book)>
    <cfset var allGenres = addEditFunctions.allGenres(book) />
    <cfset var allGenresForThisBook = addEditFunctions.bookGenres( book ) />

    <cfoutput>

        <form action="#cgi.script_name#?tool=addedit&book=#book#&qTerm=#qTerm#" method ="POST" enctype="multipart/form-data"> 
            <div class="form-floating mb-3">
                <input type="text" id="isbn13" name="isbn13" class="form-control" value="#thisBookDetails.isbn13[1]#" placeholder="Please enter the ISBN13"/>
                <label for="isbn13">ISBN 13: </label>
            </div>
            <div class="form-floating mb-3">
                <input type="text" id="title" name="title" class="form-control" value="#thisBookDetails.title[1]#" placeholder="Please enter Book title"/>
                <label for="title">Book Title</label>
            </div>
            <div class="form-floating mb-3">
                <input type="text" id="weight" name="weight" class="form-control" value="#thisBookDetails.weight[1]#" placeholder="Please enter Book Weight"/>
                <label for="weight">Weight: </label>
            </div>
            <div class="form-floating mb-3">
                <input type="text" id="year" name="year" class="form-control" value="#thisBookDetails.year[1]#" placeholder="Please enter Publishing Year"/>
                <label for="year">Year: </label>
            </div>
            <div class="form-floating mb-3">
                <input type="text" id="pages" name="pages" class="form-control" value="#thisBookDetails.pages[1]#" placeholder="Please enter Total Pages"/>
                <label for="pages">Pages: </label>
            </div>
            
            <div class="form-floating mb-3">
                <select class="form-select" id="Publishers" name="Publishers" aria-label="Publishers Select Control">
                    <option></option>
                    <cfloop query="allPublisher">
                        <option value="#publisherID#" #publisherID eq thisBookDetails.publisher ? "selected" : ""# >#name#</option>

                    </cfloop>
                </select>
                <label for="Publishers">Publishers</label>
            </div>
            <label for="uploadImage">Upload Cover</label>
            <div class="row">
                <div class="col">
                    <div class="input-group mb-3">
                        <input type="file" id="uploadImage" name="uploadimage" class="form-control" />
                        <input type="hidden" name="image" value="#trim(thisBookDetails.image[1])#" />
                    </div>
                </div>
                <div class="col">
                    <cfif thisBookDetails.image[1].len() gt 0 >
                        <img src="../images/#trim(thisBookDetails.image[1])#" style="width:200px" />
                    </cfif>
                </div>
            </div>


            <div class="form-floating mb-3">
                <div>
                    <label for="description">Description</label>
                </div>
                <textarea id="description" name="description">
                    <cfoutput>#thisBookDetails.description[1]#</cfoutput>
                </textarea>
                <script>
                    ClassicEditor.create(document.querySelector('##description')).catch(error => {console.dir(error)});
                </script>
            </div>
            <div>
                <h4>Genres</h4>
                
                <input type="hidden" name="genre" value="0" />

                
                <cfloop query="allGenres">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="#genreId#" id="genre#genreId#" name="genre">
                        <label class="form-check-label" for="genre#genreId#">
                          #genreName#
                        </label>
                      </div>
                </cfloop>
                <cfloop query="allGenresForThisBook">
                    <script type="text/javascript">
                        try{
                            document.getElementById("genre#genreId#").checked=true;
                        }catch(err){
                            console.dir(err);
                        }
                    </script>
                </cfloop>
            </div>
            <button type="submit" class="btn btn-primary" style="width: 100%">Add Book</button>

        </form>
    </cfoutput>
</cffunction>


<cffunction name="sideNav">
    <cfset allbooks = addEditFunctions.sideNavBooks(qterm)>
    <div>
        Book List
    </div>
    <cfoutput>
        #findBookForm()#
    </cfoutput>
    <cfoutput>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a href="#cgi.script_name#?tool=addedit&book=new" class ="nav-link">
                    New Book
                </a>
            </li>
            
            <cfif qterm.len() ==0>
                No Search Term Entered
                <cfelseif allBooks.recordcount==0>
                    No Results Found
                <cfelse>
                    <cfloop query="allbooks">
                        <li class= "nav-item">
                            <a class="nav-link" href="#cgi.SCRIPT_NAME#?tool=addedit&book=#isbn13#&qTerm=#qTerm#">#trim(title)#</a>
                        </li>
                    </cfloop>
            </cfif>
        </ul>
    </cfoutput>
</cffunction>
<cffunction name="findBookForm">
    <cfoutput>
        <form action="#cgi.script_name#?tool=#tool#" method="post">
            <div class="form-floating mb-3">
                <input type="text" id="qterm" name="qterm" class="form-control" value="#qterm#" placeholder="Enter a search term to find a book to edit" />
                <label for="qterm">Search Inventory </label>
            </div>
        </form>
    </cfoutput>
</cffunction>