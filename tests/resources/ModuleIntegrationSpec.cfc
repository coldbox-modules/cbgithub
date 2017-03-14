component extends="coldbox.system.testing.BaseTestCase" {

    function beforeAll() {
        loadEnv();
        super.beforeAll();
        loadEnv();
        variables.wirebox = application.wirebox;
        getController().getModuleService()
            .registerAndActivateModule( "cbgithub", "testingModuleRoot" );
    }

    /**
    * @beforeEach
    */
    function setupIntegrationTest() {
        setup();
    }

    function loadEnv() {
        var filePath = expandPath( "../.env" );
        if ( ! fileExists( filePath ) ) {
            throw( "No .env file found.  Please see the README.md for getting started with the tests." )
        }
        var properties = createObject( "java", "java.util.Properties" ).init();
        properties.load( createObject( "java", "java.io.FileInputStream" )
            .init( filePath ) );

        application.env = {};
        for ( var key in properties ) {
            application.env[ key ] = properties[ key ];
        }

        if ( isNull( application.env[ "GITHUB_USERNAME" ] ) || application.env[ "GITHUB_USERNAME" ] == "" ) {
            throw( "You must specify a GitHub username in your .env file" );
        }

        if ( isNull( application.env[ "GITHUB_TOKEN" ] ) || application.env[ "GITHUB_TOKEN" ] == "" ) {
            throw( "You must specify a GitHub token in your .env file" );
        }
    }

}