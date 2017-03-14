component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {

    function beforeAll() {
        super.beforeAll();
        variables.APIRequest = wirebox.getInstance( "APIRequest@cbgithub" );
    }

    function run() {
        describe( "Authentication", function() {
            it( "can log in with a valid username and password", function() {
                var response = "";
                expect( function() {
                    response = APIRequest.get(
                        endpoint = "/user",
                        username = application.env[ "GITHUB_USERNAME" ],
                        password = application.env[ "GITHUB_PASSWORD" ]
                    );
                } ).notToThrow();

                expect( response.responseheader.status_code ).toBe( 200 );
            } );

            it( "can log in with a valid token", function() {
                var response = "";
                expect( function() {
                    response = APIRequest.get(
                        endpoint = "/user",
                        token = application.env[ "GITHUB_TOKEN" ]
                    );
                } ).notToThrow();

                expect( response.responseheader.status_code ).toBe( 200 );
            } );

            it( "throws an exception if the credentials are invalid or missing", function() {
                expect( function() {
                    var response = APIRequest.get(
                        endpoint = "/user",
                        username = "BadUsername",
                        password = "BadPassword"
                    );
                } ).toThrow( type = "BadCredentials" );
            } );
        } );
    }

}