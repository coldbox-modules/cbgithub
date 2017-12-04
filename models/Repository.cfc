component accessors="true" {

    property name="RepositoryService"
        inject="RepositoryService@cbgithub"
        getter="false"
        setter="false";

    property name="UserService"
        inject="UserService@cbgithub"
        getter="false"
        setter="false";

    property name="id";
    property name="owner";
    property name="name";
    property name="sshUrl" default="";
    property name="description" default="";
    property name="private" default="false";
    property name="created" default="false";

    function init() {
        varaibles.sshUrl = "";
        varaibles.description = "";
        variables.private = false;
        variables.created = false;
    }

    function getFullName() {
        return "#getOwner()#/#getName()#";
    }

    function isStarred() {
        if ( isNull( variables.starred ) ) {
            variables.starred = userService.hasStarredRepo( this );
        }
        return variables.starred;
    }

    function star() {
        userService.starRepo( this );
        variables.starred = true;
        return this;
    }

    function unstar() {
        userService.unstarRepo( this );
        variables.starred = false;
        return this;
    }

    function save(
        string token,
        string username,
        string password
    ) {
        if ( ! getCreated() ) {
            arguments.repo = this;
            return RepositoryService.create( argumentCollection = arguments );
        }
        return this;
    }

    function delete(
        string token,
        string username,
        string password
    ) {
        arguments.repo = this;
        RepositoryService.delete( argumentCollection = arguments );
        setId( "" );
        setCreated( false );
        return this;
    }

}
