component accessors="true" {

    property name="RepositoryService" inject="RepositoryService@cbgithub";

    property name="id";
    property name="login";
    property name="authenticatedUser" getter="false" default="false";

    function init() {
        variables.authenticatedUser = false;
    }

    function getRepos() {
        return isAuthenticatedUser() ?
            RepositoryService.getReposForAuthenticatedUser() :
            RepositoryService.getReposForUser( getLogin() );
    }

    function isAuthenticatedUser() {
        return variables.authenticatedUser;
    }

}