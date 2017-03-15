component {

    property name="wirebox" inject="wirebox";
    property name="populator" inject="wirebox:populator";
    property name="APIRequest" inject="APIRequest@cbgithub";

    function getAuthenticatedUser(
        string token,
        string username,
        string password
    ) {
        arguments.endpoint = "/user";
        var response = APIRequest.get( argumentCollection = arguments );
        var result = deserializeJSON( response.filecontent );
        result.authenticatedUser = true;
        return populateUserFromAPI( result );
    }

    private User function populateUserFromAPI( required struct user ) {
        return populator.populateFromStruct(
            target = wirebox.getInstance( "User@cbgithub" ),
            memento = user,
            ignoreEmpty = true
        );
    }

}