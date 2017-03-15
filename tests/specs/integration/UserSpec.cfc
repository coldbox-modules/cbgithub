component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {

    function beforeAll() {
        super.beforeAll();
    }

    function run() {
        describe( "Users", function() {
            it( "can get the currently authenticated user", function() {
                var User = wirebox.getInstance( "UserService@cbgithub" )
                    .getAuthenticatedUser( token = application.env[ "GITHUB_TOKEN" ] );

                expect( User.getLogin() ).toBe( application.env[ "GITHUB_USERNAME" ] );
                expect( User.isAuthenticatedUser() ).toBeTrue();
            } );

            it( "can get a user's repositories", function() {
                var User = wirebox.getInstance( "UserService@cbgithub" )
                    .getAuthenticatedUser();

                var repositories = User.getRepos().filter( function( repo ) {
                    return repo.getName() == "initial-test-repository";
                } );

                expect( repositories ).notToBeEmpty();
                expect( repositories ).toHaveLength( 1 );
            } );
        } );
    }

}