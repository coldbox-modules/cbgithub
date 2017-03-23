component {

    property name="wirebox" inject="wirebox";
    property name="populator" inject="wirebox:populator";
    property name="APIRequest" inject="APIRequest@cbgithub";

    function find(
        required string user,
        string repoName,
        string token,
        string username,
        string password
    ) {
        var repoSlug = isNull( repoName ) ? user : "#user#/#repoName#";
        arguments.endpoint = "/repos/" & repoSlug;
        var response = APIRequest.get( argumentCollection = arguments );
        var result = deserializeJSON( response.filecontent );
        return populateRepoFromAPI( result );
    }

    function getReposForAuthenticatedUser(
        string token,
        string username,
        string password
    ) {
        arguments.endpoint = "/user/repos";
        var response = APIRequest.get( argumentCollection = arguments );
        var result = deserializeJSON( response.filecontent );
        return arrayMap( result, function( repo ) {
            return populateRepoFromAPI( repo );
        } );
    }

    function getReposForUser( required string username ) {
        arguments.endpoint = "/users/#username#/repos";
        var response = APIRequest.get( argumentCollection = arguments );
        var result = deserializeJSON( response.filecontent );
        return arrayMap( result, function( repo ) {
            return populateRepoFromAPI( repo );
        } );
    }

    function create(
        required Repository repo,
        string token,
        string username,
        string password
    ) {
        arguments.endpoint = "/user/repos";
        arguments.body = {
            "name" = repo.getName(),
            "description" = repo.getDescription(),
            "private" = repo.getPrivate()
        };
        var response = APIRequest.post( argumentCollection = arguments );
        var result = deserializeJSON( response.filecontent );
        return populateRepoFromAPI( result );
    }

    function delete(
        required Repository repo,
        string token,
        string username,
        string password
    ) {
        arguments.endpoint = "/repos/#repo.getOwner()#/#repo.getName()#";
        APIRequest.delete( argumentCollection = arguments );
    }

    private function populateRepoFromAPI( repo ) {
        repo.created = true;
        repo.owner = repo.owner.login;
        repo.description = isNull( repo.description ) ? "" : repo.description;
        return populator.populateFromStruct(
            target = wirebox.getInstance( "Repository@cbgithub" ),
            memento = repo,
            ignoreEmpty = true
        );
    }

}