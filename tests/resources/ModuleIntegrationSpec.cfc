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
        if ( fileExists( filePath ) ) {
            var properties = createObject( "java", "java.util.Properties" ).init();
            properties.load( createObject( "java", "java.io.FileInputStream" )
                .init( filePath ) );

            application.env = {};
            for ( var key in properties ) {
                application.env[ key ] = properties[ key ];
            }
        }
    }

}
