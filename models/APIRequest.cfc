component {

    variables.hostname = "https://api.github.com/";
    variables.defaultHeaders = {
        "Content-Type" = "application/json"
    };

    function onDIComplete() {
        if ( structKeyExists( application, "cbcontroller" ) ) {
            variables.settings = application.wirebox.getInstance( dsl = "coldbox:modulesettings:cbgithub" );
        }
    }

    public function makeRequest(
        required string method,
        required string endpoint,
        struct headers = {},
        struct body = {},
        any token,
        string username,
        string password,
        any exceptionHandler
    ) {
        if ( isNull( token ) && isNull( username ) && isNull( password ) ) {
            token = settings.token;
            username = settings.username;
            password = settings.password;
        }

        structAppend( headers, variables.defaultHeaders );
        structAppend(
            headers,
            createAuthorizationHeader( argumentCollection = arguments )
        );

        cfhttp( method = method, url = createAPIUrl( endpoint ), result = "response" ) {
            for ( var key in headers ) {
                cfhttpparam( type = "header", name = key, value = headers[ key ] );
            }
            if ( method == "post" || method == "put" ) {
                cfhttpparam( type = "body", value = serializeJson( body ) );
            }
        }

        if ( ! isNull( arguments.exceptionHandler ) ) {
            exceptionHandler( response, deserializeJSON( response.filecontent ) );
        }

        if ( response.responseheader.status_code == 401 ) {
            throw( type = "BadCredentials", message = "Bad Credentials" );
        }

        if ( left( response.responseheader.status_code, 1 ) == 4 || left( response.responseheader.status_code, 1 ) == 5 ) {
            throw( type = "APIError", message = response.filecontent );
        }

        return response;
    }

    public struct function get(
        required string endpoint,
        struct headers = {},
        struct body = {},
        string token,
        string username,
        string password
    ) {
        arguments.method = "get";
        return makeRequest( argumentCollection = arguments );
    }

    public struct function post(
        required string endpoint,
        struct headers = {},
        struct body = {},
        string token,
        string username,
        string password
    ) {
        arguments.method = "post";
        return makeRequest( argumentCollection = arguments );
    }

    public struct function delete(
        required string endpoint,
        struct headers = {},
        struct body = {},
        string token,
        string username,
        string password
    ) {
        arguments.method = "delete";
        return makeRequest( argumentCollection = arguments );
    }

    private struct function createAuthorizationHeader(
        any token,
        string username,
        string password
    ) {
        if ( isNull( token ) && ( isNull( username ) || isNull( password ) ) ) {
            return {};
        }

        if ( ! isNull( token ) && token != "" ) {
            token = isInstanceOf( token, "cbgithub.models.Token" ) ?
                token.getToken() :
                token;
            return { "Authorization" = "token #token#" };
        }

        return { "Authorization" = "basic #ToBase64("#username#:#password#")#" };
    }

    private string function createAPIUrl( required string endpoint ) {
        if ( endpoint != "/" && left( endpoint, 1 ) == "/" ) {
            endpoint = mid( endpoint, 2, len( endpoint ) );
        }
        return variables.hostname & endpoint;
    }

}