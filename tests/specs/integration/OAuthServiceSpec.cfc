component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {

    function beforeAll() {
        super.beforeAll();
        variables.OAuthService = wirebox.getInstance( "OAuthService@cbgithub" );
    }

    function run() {
        describe( "retrieving tokens", function() {
            it( "can retrieve all tokens for the authorized user", function() {
                var tokens = OAuthService.getAll(
                    username = application.env[ "GITHUB_USERNAME" ],
                    password = application.env[ "GITHUB_PASSWORD" ]
                );

                expect( tokens ).notToBeNull();
                expect( tokens ).toBeArray();
                expect( tokens ).toHaveLength( 1 );
                expect( tokens[ 1 ].getTokenLastEight() )
                    .toBe( right( application.env[ "GITHUB_TOKEN" ], 8 ) );
            } );
        } );

        describe( "Token Creation", function() {
            afterEach( function() {
                if ( structKeyExists( variables, "token" ) ) {
                    variables.token.delete();
                }
                structDelete( variables, "token" );
            } );
            it( "can create a token with a valid username and password and array of valid scopes", function() {
                variables.token = OAuthService.createToken(
                    username = application.env[ "GITHUB_USERNAME" ],
                    password = application.env[ "GITHUB_PASSWORD" ],
                    note = "cbgithub testing token",
                    scopes = [ "user:email" ]
                );

                expect( token ).notToBeNull();
                expect( token ).toBeInstanceOf( "cbgithub.models.Token" );
                expect( token.getToken() ).notToHaveLength( 0, "The token shouldn't be blank" );
            } );

            it( "throws an exception if no scopes are requested", function() {
                expect( function() {
                    variables.token = OAuthService.createToken(
                        username = application.env[ "GITHUB_USERNAME" ],
                        password = application.env[ "GITHUB_PASSWORD" ],
                        note = "cbgithub testing token",
                        scopes = []
                    );
                } ).toThrow( "NoScopesSelected" );
            } );

            it( "throws an exception if a token with the same note already exists", function() {
                variables.token = OAuthService.createToken(
                    note = "cbgithub testing token",
                    scopes = [ "user:email" ]
                );

                expect( function() {
                    var anotherToken = OAuthService.createToken(
                        note = "cbgithub testing token",
                        scopes = [ "user:email" ]
                    );
                } ).toThrow( "TokenAlreadyExists" );
            } );
        } );
    }

}