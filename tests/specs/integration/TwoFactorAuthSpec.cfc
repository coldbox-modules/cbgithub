component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {

    function beforeAll() {
        super.beforeAll();
        variables.mockAPIRequest = prepareMock(
            wirebox.getInstance( "APIRequest@cbgithub" )
        );
        variables.OAuthService = prepareMock(
            wirebox.getInstance( "OAuthService@cbgithub" )
        );
    }

    function run() {
        describe( "Two Factor Auth", function() {
            it( "throws a TwoFactorAuthRequired exception if the user has two factor authentication turned on and did not provide a token", function() {
                mockAPIRequest.$( "post" ).$results( {
                    responseheader = {
                        "status_code" = "401",
                        "X-GitHub-OTP" = "required; app"
                    }
                } );

                OAuthService.$property(
                    propertyName = "APIRequest",
                    mock = mockAPIRequest
                );
                
                expect( function() {
                    OAuthService.createToken(
                        note = "needs two factor",
                        scopes = [ "repo" ]
                    );
                } ).toThrow( "TwoFactorAuthRequired" );
            } );
        } );
    }

}