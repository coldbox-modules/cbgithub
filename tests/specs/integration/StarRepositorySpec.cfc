component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {

    function beforeAll() {
        super.beforeAll();
        variables.RepoService = wirebox.getInstance( "RepositoryService@cbgithub" );
    }

    function run() {
        describe( "Starring Repositories", function() {
            it( "can check if a user has starred a repository", function() {
                var repo = RepoService.find( "elpete-test/initial-test-repository" );

                expect( repo ).notToBeNull();
                expect( repo.getName() ).toBe( "initial-test-repository" );
                expect( repo.getCreated() ).toBeTrue();
                expect( repo.isStarred() ).toBeFalse();
            } );

            it( "can star a repository", function() {
                var repo = RepoService.find( "elpete-test/initial-test-repository" );

                expect( repo ).notToBeNull();
                expect( repo.getName() ).toBe( "initial-test-repository" );
                expect( repo.getCreated() ).toBeTrue();

                repo.star();

                expect( repo.isStarred() ).toBeTrue();
            } );

            it( "starring a starred repository does nothing", function() {
                var repo = RepoService.find( "elpete-test/initial-test-repository" );

                expect( repo ).notToBeNull();
                expect( repo.getName() ).toBe( "initial-test-repository" );
                expect( repo.getCreated() ).toBeTrue();

                repo.star();

                expect( repo.isStarred() ).toBeTrue();

                repo.star();

                expect( repo.isStarred() ).toBeTrue();
            } );

            it( "can remove a star from a repository", function() {
                var repo = RepoService.find( "elpete-test/initial-test-repository" );

                expect( repo ).notToBeNull();
                expect( repo.getName() ).toBe( "initial-test-repository" );
                expect( repo.getCreated() ).toBeTrue();

                repo.star();

                expect( repo.isStarred() ).toBeTrue();

                repo.unstar();

                expect( repo.isStarred() ).toBeFalse();
            } );

            it( "unstarring a repo multiple times does nothing", function() {
                var repo = RepoService.find( "elpete-test/initial-test-repository" );

                expect( repo ).notToBeNull();
                expect( repo.getName() ).toBe( "initial-test-repository" );
                expect( repo.getCreated() ).toBeTrue();

                repo.star();

                expect( repo.isStarred() ).toBeTrue();

                repo.unstar();

                expect( repo.isStarred() ).toBeFalse();

                repo.unstar();

                expect( repo.isStarred() ).toBeFalse();
            } );
        } );
    }

}
