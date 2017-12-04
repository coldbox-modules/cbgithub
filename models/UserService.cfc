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

    function hasStarredRepo( Repository repo ) {
        arguments.endpoint = "/user/starred/#repo.getFullName()#";
        arguments.exceptionHandler = function( response ) {
            if ( response.ResponseHeader.status_code == 404 ) {
                throw(
                    type = "NotStarredByUser",
                    message = "This repository has not been starred by this user"
                );
            }
        };

        try {
            APIRequest.get( argumentCollection = arguments );
            return true;
        }
        catch ( NotStarredByUser e ) {
            return false;
        }
    }

    function starRepo( Repository repo ) {
        arguments.endpoint = "/user/starred/#repo.getFullName()#";
        return APIRequest.put( argumentCollection = arguments );
    }

    function unstarRepo( Repository repo ) {
        arguments.endpoint = "/user/starred/#repo.getFullName()#";
        return APIRequest.delete( argumentCollection = arguments );
    }

    private User function populateUserFromAPI( required struct user ) {
        return populator.populateFromStruct(
            target = wirebox.getInstance( "User@cbgithub" ),
            memento = user,
            ignoreEmpty = true
        );
    }

}
