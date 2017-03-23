component {

    property name="wirebox" inject="wirebox";
    property name="populator" inject="wirebox:populator";
    property name="APIRequest" inject="APIRequest@cbgithub";

    function onDIComplete() {
        if ( structKeyExists( application, "cbcontroller" ) ) {
            variables.settings = wirebox.getInstance( dsl = "coldbox:modulesettings:cbgithub" );
        }
    }

    function getAll(
        string username,
        string password,
        string oneTimePassword = ""
    ) {
        if ( isNull( username ) ) { username = settings.username; }
        if ( isNull( password ) ) { password = settings.password; }

        arguments.endpoint = "/authorizations";
        arguments.headers = { "X-GitHub-OTP" = oneTimePassword };
        var response = APIRequest.get( argumentCollection = arguments );
        var result = deserializeJSON( response.filecontent );
        result = convertNullToEmptyString( result );

        return arrayMap( result, function( token ) {
            return populateTokenFromAPI( token );
        } );
    }

    function createToken(
        required string note,
        required array scopes,
        string username,
        string password,
        string oneTimePassword = ""
    ) {
        if ( arrayIsEmpty( scopes ) ) {
            throw( type = "NoScopesSelected", message = "Please select one or more valid GitHub token scopes." );
        }

        if ( isNull( username ) ) { username = settings.username; }
        if ( isNull( password ) ) { password = settings.password; }

        var response = APIRequest.post(
            endpoint = "/authorizations",
            username = username,
            password = password,
            token = "",
            headers = {
                "X-GitHub-OTP" = oneTimePassword
            },
            body = {
                "scopes" = scopes,
                "note" = note
            },
            exceptionHandler = function( response, result ) {
                if ( needsTwoFactorCode( response ) ) {
                    throw(
                        type = "TwoFactorAuthRequired",
                        message = "A 2-factor authentication code is required."
                    );
                }

                if ( tokenAlreadyExists( result ) ) {
                    throw(
                        type = "TokenAlreadyExists",
                        message = "A token for [#note#] already exists for this user."
                    );
                }
            }
        );

        var result = deserializeJSON( response.filecontent );
        result = convertNullToEmptyString( result );

        return populator.populateFromStruct(
            target = wirebox.getInstance( "Token@cbgithub" ),
            memento = result,
            ignoreEmpty = true
        );        
    }

    private Token function populateTokenFromAPI( required struct token ) {
        token.createdDate = token.created_at;
        token.updatedDate = token.updated_at;
        token.tokenLastEight = token.token_last_eight;
        return populator.populateFromStruct(
            target = wirebox.getInstance( "Token@cbgithub" ),
            memento = token,
            ignoreEmpty = true
        );
    }

    private boolean function needsTwoFactorCode( required response ) {
        return response.responseheader.status_code == 401 &&
            structKeyExists( response.responseheader, "X-GitHub-OTP" );
    }

    private boolean function tokenAlreadyExists( required any result ) {
        return structKeyExists( result, "errors" ) &&
            ! arrayIsEmpty( arrayFilter( result.errors, function( error ) {
                return error.code == "already_exists";
            } ) );
    }

    private any function convertNullToEmptyString( required any result ) {
        if ( isNull( result ) ) {
            return "";
        }

        if ( isStruct( result ) ) {
            var newStruct = {};
            for ( var key in result ) {
                if ( ! structKeyExists( result, key ) || isNull( result[ key ] ) ) {
                    newStruct[ key ] = "";    
                }
                else {
                    newStruct[ key ] = convertNullToEmptyString(
                        result[ key ]
                    );
                }
            }
            return newStruct;
        }

        if ( isArray( result ) ) {
            return arrayMap( result, function( item ) {
                return convertNullToEmptyString( item );
            } );
        }

        return result;
    }
    
}