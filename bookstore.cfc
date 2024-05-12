component {
    function obtainSearchResults(searchme="",genre="" ){
		if(searchme.len() > 0){
		var qs = new query( datasource = application.dsource );
		qs.setSql( "select * from Book inner join Publishers on Book.publisher=Publishers.publisherID where title like :searchme or isbn13 like :isbn" );
		qs.addParam(
			name      = "searchme",
			cfsqltype = "CF_SQL_NVARCHAR",
			value     = searchme
		);
		qs.addParam(
			name      = "isbn",
			cfsqltype = "CF_SQL_NVARCHAR",
			value     = "%#searchme#%"
		);
		return qs.execute().getResult();
		} else if (genre.len() > 0){
			var qs = new query( datasource = application.dsource );
			qs.setSql( "select * 
						from Book inner join genresToBooks ON Book.ISBN13 = genresToBooks.isbn13 
						INNER JOIN Publishers ON Book.publisher=Publishers.publisherID
						WHERE genreId=:genre" );
			qs.addParam(
				name      = "genre",
				cfsqltype = "CF_SQL_NVARCHAR",
				value     = trim(arguments.genre)
			);
			return qs.execute().getResult();
		}

	}
	function genresInStock(){
		var genres = new query( datasource = application.dsource );

		genres.setSql( "select distinct genreName, Genres.genreId from genresToBooks inner join Genres on genresToBooks.genreid = Genres.genreId order by genreName");
		return genres.execute().getresult();
	}
	function resultsHeader(searchme="", genre=""){
		if(searchme.len()){
		return "KeyWord: #searchme#";
	} else if(genre.len()){
			var qs = new query( datasource=application.dsource );
			qs.setSql("select * from Genres where genreId=:genre");
			qs.addParam(name="genre",value=arguments.genre);
			var genreName=qs.execute().getResult().genreName[1];

		return "Genre: #genrename#";
	}
}

	function obtainArticle( id ){
		var qs = new query(datasource=application.dsource);
		qs.setSql("select * from content where contentID=:id");
		qs.addParam(name="id",value=id);
		return qs.execute().getResult();
}
}
