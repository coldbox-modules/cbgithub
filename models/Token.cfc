component accessors="true" {

    property name="APIRequest"
        inject="APIRequest@cbgithub"
        setter="false"
        getter="false";

    property name="id";
    property name="token";
    property name="hashedToken";
    property name="tokenLastEight";
    property name="note";
    property name="scopes";
    property name="createdDate";
    property name="updatedDate";

    function onDIComplete() {
        if ( structKeyExists( application, "cbcontroller" ) ) {
            variables.settings = application.wirebox.getInstance( dsl = "coldbox:modulesettings:cbgithub" );
        }
    }

    function delete(
        string username,
        string password,
        string oneTimePassword = ""
    ) {
        if ( isNull( username ) ) { username = settings.username; }
        if ( isNull( password ) ) { password = settings.password; }
        
        arguments.headers = { "X-GitHub-OTP" = oneTimePassword };
        arguments.endpoint = "/authorizations/#getId()#";
        
        APIRequest.delete( argumentCollection = arguments );
    }

}