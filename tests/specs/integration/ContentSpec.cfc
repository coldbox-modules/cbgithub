component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {

    function beforeAll() {
        super.beforeAll();
        variables.ContentService = wirebox.getInstance( "ContentService@cbgithub" );
    }

    function run() {
        describe( "Contents", function() {
            it( "can read the README file", function() {
                var file = ContentService.getReadMe( "elpete", "cbgithub", "master" );

                expect( file ).toBeInstanceOf( "testingModuleRoot.cbgithub.models.Content" );

                expect( file.getName() ).toBe( "README.md" );
                expect( file.getType() ).toBe( "file" );
                expect( file.getHtmlUrl() ).toBe( "https://github.com/elpete/cbgithub/blob/master/README.md" );
                expect( file.getPath() ).toBe( "README.md" );
                expect( file.getDownloadUrl() ).toBe( "https://raw.githubusercontent.com/elpete/cbgithub/master/README.md" );
                expect( file.getEncoding() ).toBe( "base64" );
                expect( file.getMimeType() ).toBe( "text/plain" );

                expect( file.getContent() ).toInclude( "cbgithub" );
            } );
        } );
    }

}
