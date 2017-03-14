component accessors="true" {

    property name="settings"
        inject="coldbox:modulesettings:cbgithub"
        setter="false"
        getter="false";

    property name="APIRequest"
        inject="APIRequest@cbgithub"
        setter="false"
        getter="false";

    property name="id";
    property name="token";
    property name="hashedToken";
    property name="tokenLastEight";
    property name="note";
    property name="scopes";
    property name="createdDate";
    property name="updatedDate";

    function delete() {
        APIRequest.delete(
            endpoint = "/authorizations/#getId()#",
            username = settings.username,
            password = settings.password
        );
    }

}