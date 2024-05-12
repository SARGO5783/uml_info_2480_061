component {
    function processForms( required struct formData ){
        if (formData.keyExists('isbn13') && formData.keyExists('title') && formData.title.len() > 0) {
            if(formdata.keyExists("uploadImage") && formData.uploadImage.len()>0){
                formData.image = uploadBookCover();
                }
            
            var qs = new query(datasource=application.dsource);
            qs.setSQL("
                IF NOT EXISTS( SELECT * FROM Book WHERE isbn13=:isbn13)
                    INSERT INTO Book (isbn13,title) VALUES (:isbn13,:title);
                UPDATE Book SET
                    title=:title,
                    year=:year,
                    pages=:pages,
                    weight=:weight,
                    image=:image,
                    publisher=:publisher,
                    description=:description
                    WHERE isbn13=:isbn13
                ");
                qs.addParam(
                        name = 'isbn13',
                        cfsqltype = 'CF_SQL_NVARCHAR',
                        value = trim(formData.isbn13),
                        null = formData.isbn13.len() != 13
                    );
                    qs.addParam(
                        name = 'title',
                        cfsqltype = 'CF_SQL_NVARCHAR',
                        value = trim(formData.title),
                        null = formData.title.len() == 0
                    );
                    qs.addParam(
                        name = 'year',
                        cfsqltype = 'CF_SQL_INTEGER',
                        value = trim(formData.year),
                        null = !isValid('numeric', formData.year)
                    );
                    qs.addParam(
                        name = 'pages',
                        cfsqltype = 'CF_SQL_INTEGER',
                        value = trim(formData.pages),
                        null = !isValid('numeric', formData.pages)
                    );
                    qs.addParam(
                        name = 'weight',
                        cfsqltype = 'CF_SQL_DECIMAL',
                        value = trim(formData.weight),
                        null = !isValid('numeric', formData.weight)
                    );
                    qs.addParam(
                        name = 'publisher',
                        cfsqltype = 'CF_SQL_NVARCHAR',
                        value = trim(formData.publishers),
                        null = trim(formData.publishers).len() != 35
                    );
                    qs.addParam(
                        name = 'image',
                        cfsqltype = 'CF_SQL_NVARCHAR',
                        Value = formData.image,
				        null= formData.image.len() == 0
                    );
                    qs.addParam(
                        name = 'description',
                        cfsqltype = 'CF_SQL_NVARCHAR',
                        Value = trim(formData.description),
				        null= trim(formData.description).len() == 0
                    );
                    qs.execute();

                    if(formData.keyExists("genre")){
                        deleteAllBookGenres(formData.isbn13)
                        formData.genre.listToArray().each(function(item){
                            insertGenre(item, formData.isbn13)
                        })
                    }
            }
        }
        function sideNavBooks( qterm ){
            if(qterm.len() ==0 ){
                return queryNew("title");
            } 
            else {
                var qs = new query(datasource = application.dsource);
                qs.setSql("select * from Book where title like :qterm order by title");
                qs.addParam(name="qterm",value='%#qterm#%');
                return qs.execute().getResult();
            }
        }           

       function bookDetails(isbn13){
            var qs = new query(datasource=application.dsource);
            qs.setSql("select * from Book where isbn13=:isbn13");
            qs.addParam(name="isbn13",cfqsltype="CF_SQL_NVARCHAR",value=arguments.isbn13);
            return qs.execute().getResult()
       }
        function allPublishers(){
            var allPublisher = new query( datasource = application.dsource );
            allPublisher.setSql("select * from Publishers");
            return allPublisher.execute().getresult();
    }
        function uploadBookCover(){
            var imageData = fileUpload(expandPath("../images/"),"uploadImage","*","makeUnique");
            return imageData.serverFile;
    }
        function deleteAllBookGenres(isbn13) {
            var qs = new query(datasource=application.dsource);
            qs.setSql("delete from genresToBooks WHERE isbn13=:isbn13");
            qs.addParam( name = "isbn13", value = arguments.isbn13 );
            qs.execute();               
    }
        function allGenres( isbn13 ){
		var qs = new query( datasource = application.dsource );
		qs.setSql("select * from Genres order by genreName");
		return qs.execute().getResult();
	}

        function insertGenre(genreId, isbn13){
        var genres = new query( datasource = application.dsource );
        genres.setSql("insert into genresToBooks (genreId,isbn13) VALUES (:genreId,:isbn13)");
        genres.addParam( name = "genreId", value = arguments.genreId );
        genres.addParam( name = "isbn13", value = arguments.isbn13 );
        return genres.execute().getresult();
    }
    function bookGenres( isbn13 ){
		var qs = new query( datasource = application.dsource );
		qs.setSql( "select * from genresToBooks where isbn13=:isbn13" );
		qs.addParam( name = "isbn13", value = arguments.isbn13 );
		return qs.execute().getResult()
	}

    
}
