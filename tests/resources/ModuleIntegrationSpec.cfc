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
        application.env = {};
        
        var system = createObject( "java", "java.lang.System" );

        // Server Environment Variables
        var envVars = system.getEnv();
        for ( var key in envVars ) {
            application.env[ key ] = envVars[ key ];
        }

        // Java System Properties
        var systemProps = system.getProperties();
        for ( var key in systemProps ) {
            application.env[ key ] = systemProps[ key ];
        }
        
        // .env file
        var filePath = expandPath( "../.env" );
        if ( fileExists( filePath ) ) {
            var properties = createObject( "java", "java.util.Properties" ).init();
            properties.load( createObject( "java", "java.io.FileInputStream" ).init( filePath ) );
            for ( var key in properties ) {
                application.env[ key ] = properties[ key ];
            }
        }

        if ( isNull( application.env[ "GITHUB_USERNAME" ] ) || application.env[ "GITHUB_USERNAME" ] == "" ) {
            throw( "You must specify a GitHub username in your environment variables" );
        }

        if ( isNull( application.env[ "GITHUB_TOKEN" ] ) || application.env[ "GITHUB_TOKEN" ] == "" ) {
            throw( "You must specify a GitHub token in your environment variables" );
        }
    }

}