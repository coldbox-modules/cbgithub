component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {

    function beforeAll() {
        super.beforeAll();
        variables.RepoService = wirebox.getInstance( "RepositoryService@cbgithub" );
    }

    function run() {
        describe( "Repositories", function() {
            it( "can retrieve a repository", function() {
                var repo = RepoService.find( "elpete-test/initial-test-repository" );

                expect( repo ).notToBeNull();
                expect( repo.getName() ).toBe( "initial-test-repository" );
                expect( repo.getCreated() ).toBeTrue();
            } );

            describe( "Creating repositories", function() {
                afterEach( function() {
                    if ( structKeyExists( variables, "repo" ) ) {
                        variables.repo.delete();
                        structDelete( variables, "repo" );
                    }
                } );

                it( "can create a public repository", function() {
                    variables.repo = wirebox.getInstance( "Repository@cbgithub" );
                    repo.setOwner( "elpete-test" );
                    repo.setName( "test-create-repo" );

                    expect( repo.getId() ).toBeNull();
                    expect( repo.getCreated() ).toBeFalse();

                    repo.save();

                    expect( repo.getId() ).notToBeNull();
                    expect( repo.getId() ).notToBe( "" );
                    expect( repo.getCreated() ).toBeTrue();
                } );
            } );

            describe( "Deleting repositories", function() {
                afterEach( function() {
                    if ( structKeyExists( variables, "repo" ) ) {
                        variables.repo.delete();
                        structDelete( variables, "repo" );
                    }
                } );

                it( "can delete a repository", function() {
                    var repo = wirebox.getInstance( "Repository@cbgithub" );
                    repo.setOwner( "elpete-test" );
                    repo.setName( "test-create-repo" );

                    expect( repo.getId() ).toBeNull();
                    expect( repo.getCreated() ).toBeFalse();

                    repo.save();

                    expect( repo.getId() ).notToBeNull();
                    expect( repo.getId() ).notToBe( "" );
                    expect( repo.getCreated() ).toBeTrue();

                    repo.delete();

                    expect( repo.getId() ).toBe( "" );
                    expect( repo.getCreated() ).toBeFalse();                    
                } );
            } );
        } );
    }

}