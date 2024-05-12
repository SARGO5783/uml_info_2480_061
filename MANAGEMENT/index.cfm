<cfif !session.keyExists("user") ||
     (!session.keyExists("user") && !session.user.keyExists("isAdmin")) || 
        (!session.user.isAdmin)>
    <cflocation url="#cgi.SCRIPT_NAME.replace('management/','')#" />
</cfif>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Title</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha38
        4-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM
        9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <script src="https://cdn.ckeditor.com/ckeditor5/41.1.0/classic/ckeditor.js"></script>

    </head>
    <body>
        <cfparam name="tool" default="addEdit" />
            <div id="wrapper" class="container">
                <div id="navarea"> 
                    <cfinclude template = "managementNav.cfm"/>
                </div>
                <div id="mainarea">
                    <cfinclude template="#tool#.cfm" />
                </div>
        </div>

    </body>
</html>