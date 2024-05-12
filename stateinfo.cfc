component {
    function obtainUser( isLoggedIn = false, firstname = "", lastname = "", email = "", acctNumber = "", isAdmin = 0) {
        return {
              "isLoggedIn"=arguments.isLoggedIn,
               "firstname":arguments.firstname,
               "lastname":arguments.lastname,
               "email":arguments.email,
               "acctNumber":arguments.acctNumber,
               "isAdmin":arguments.isAdmin

            }
    }
    function emailisUnique(required string email) {
        var qs = new query(datasource=application.dsource);
        qs.setSql("select * from people where email=:email");
        qs.addParam(name="email",value=arguments.email);
        return qs.execute().getResult().recordcount == 0;
    }
    function processNewAccount(formData){
        if(emailIsUnique(formData.email)){
            } 
        else {
            return {success:false, 
                    message:"That email is already in our system. Pleaselogin"
                    };
            }
    }     
    function addPassword(id, password){
        try {
            var qs = new query(datasource = application.dsource);
            qs.setSql("insert into passwords (personid, password) values (:personid, :password) ");
            qs.addParam(name = "personid", value = arguments.id);
            qs.addParam(name = "password", value = hash(arguments.password, "SHA-256"));
            qs.execute();
            return true;
        }
        catch(ary err){
            return false;
        }
    }
    function addAccount( required string personid, required string firstName, required string lastName, required string email) {
        var qs = new query(datasource=application.dsource);
        qs.setSql("insert into people (personid, firstname, lastname, email) 
                    values (:personid, :firstname, :lastname, :email) ");
        qs.addParam(name="personid", value=arguments.personid);
        qs.addParam(name="firstname", value=arguments.firstName);
        qs.addParam(name="lastname", value=arguments.lastName);
        qs.addParam(name="email", value=arguments.email);
        qs.execute();
    }
    function processNewAccount(formData){
        if(emailIsUnique(formData.email)){
            var newid = createuuid();
            if(addPassword(newid, formData.password)){
                addAccount(newid, formData.firstname, formData.lastname,formdata.email);
            };
            return {success:true, message:"Account Made. Go login!"}
        } 
        else {
            return {success:false, message:"That email is already in our database. Please log in"};
        }
    }

    function logMeIn(username, password){
        var qs = new query(datasource=application.dsource);
        qs.setSql("select * from people inner join passwords on people.personid=passwords.personid WHERE email=:email and password=:password");
        qs.addParam(name="email", value=arguments.username);
        qs.addParam(name="password", value=hash(form.loginpass,"SHA-256"));
        return qs.execute().getResult();
       }


}
