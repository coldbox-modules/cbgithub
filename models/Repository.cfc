component accessors="true" {

    property name="RepositoryService"
        inject="RepositoryService@cbgithub"
        getter="false"
        setter="false";

    property name="id";
    property name="owner";
    property name="name";
    property name="description" default="";
    property name="private" default="false";
    property name="created" default="false";

    function init() {
        varaibles.description = "";
        variables.private = false;
        variables.created = false;
    }

    function getFullName() {
        return "#getOwner()#/#getName()#";
    }

    function save() {
        if ( ! getCreated() ) {
            var repo = RepositoryService.create( this );
            setId( repo.getId() );
            setCreated( true );
        }
        return this;
    }

    function delete() {
        RepositoryService.delete( this );
        setId( "" );
        setCreated( false );
        return this;
    }

}