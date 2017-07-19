component accessors="true" {

    property name="ContentService"
        inject="ContentService@cbgithub"
        getter="false"
        setter="false";

    property name="content" default="";
    property name="_links" default="";
    property name="html_url" default="";
    property name="sha" default="";
    property name="path" default="";
    property name="url" default="";
    property name="size" default="";
    property name="name" default="";
    property name="submodule_git_url" default="";
    property name="type" default="";
    property name="git_url" default="";
    property name="download_url" default="";
    property name="encoding" default="";
    property name="mimetype" default="";

    Content function init() {
        variables.base64Library = createObject( "java", "org.apache.commons.codec.binary.Base64" );
        variables._links = {
            "git": "",
            "self": "",
            "html": ""
        };
        variables.mimeType = "";

        return this;
    }

    function getContent(
        string encoding = "UTF-8"
    ) {
        var decodedContent = decodeContent();

        if ( getMimeType() == "text/plain" ) {
            return toString( decodedContent, arguments.encoding );
        }

        return decodedContent;
    }

    function getMimeType() {
        if ( variables.type == "file" && variables.mimeType == "" ) {
            var randomFilename = createUUID();

            fileWrite( "ram:///#randomFilename#", decodeContent() );

            variables.mimeType = fileGetMimeType( "ram:///#randomFilename#", true );

            fileDelete( "ram:///#randomFilename#" );
        }

        return variables.mimeType;
    }

    function getDownloadUrl() {
        return variables.download_url;
    }

    function getGitUrl() {
        return variables.git_url;
    }

    function getHtmlUrl() {
        return variables.html_url;
    }

    function getLinks() {
        return variables._links;
    }

    function getSubmoduleGitUrl() {
        return variables.submodule_git_url;
    }

    private function decodeContent() {
// drop down into Java to decode the Base64 string due to a bug in Railo 4.2+ and Lucee 4+
// https://luceeserver.atlassian.net/browse/LDEV-555
        return variables.base64Library.decodeBase64( variables.content );
    }

}
