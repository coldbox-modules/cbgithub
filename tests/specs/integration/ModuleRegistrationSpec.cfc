component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {

    function run() {
        describe( "Module Registration", function() {
            it( "correctly registers and activates the module", function() {
                expect(
                    getController().getModuleService().isModuleRegistered( "cbgithub" )
                ).toBeTrue();
            } );
        } );
    }

}