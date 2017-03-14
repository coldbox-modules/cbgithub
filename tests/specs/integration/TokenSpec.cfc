component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {

    function beforeAll() {
        super.beforeAll();
        variables.OAuthService = wirebox.getInstance( "OAuthService@cbgithub" );
    }

    function run() {
        describe( "Deleting tokens", function() {
            it( "can delete a token", function() {
                var token = makeTestToken();

                token.delete();

                var allTokens = OAuthService.getAll().map( function( token ) {
                    return token.getId();
                } );
                expect( allTokens ).notToInclude( token.getId() );
            } );
        } );
    }

    private function makeTestToken() {
        var token = OAuthService.createToken(
            username = application.env[ "GITHUB_USERNAME" ],
            password = application.env[ "GITHUB_PASSWORD" ],
            note = "cbgithub testing token",
            scopes = [ "user:email" ]
        );

        expect( token ).notToBeNull();
        expect( token ).toBeInstanceOf( "cbgithub.models.Token" );
        expect( token.getToken() ).notToHaveLength( 0, "The token shouldn't be blank" );

        return token;
    }

}