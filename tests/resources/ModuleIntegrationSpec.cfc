component extends="coldbox.system.testing.BaseTestCase" {

    function beforeAll() {
        super.beforeAll();
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

    function getSystemSetting( name, defaultValue ) {
        var system = createObject( "java", "java.lang.System" );
        var envValue = system.getEnv( name );
        if ( ! isNull( envValue ) ) {
            return envValue;
        }

        var propertyValue = system.getProperty( name );
        if ( ! isNull( propertyValue ) ) {
            return propertyValue;
        }

        if ( ! isNull( defaultValue ) ) {
            return defaultValue;
        }

        throw( "No env var or java system property exists for key [#name#]" );
    }

}
