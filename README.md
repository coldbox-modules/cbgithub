# cbgithub
[![All Contributors](https://img.shields.io/badge/all_contributors-2-orange.svg?style=flat-square)](#contributors)

[![Master Branch Build Status](https://img.shields.io/travis/elpete/cbgithub/master.svg?style=flat-square&label=master)](https://travis-ci.org/elpete/cbgithub)


## A CFML Wrapper around the GitHub API optimized for ColdBox

## Getting Started

### Access Security

There are two ways of providing secure access to your GitHub repository: Username and password or `Personal Access Token`. If both are provided, the Personal Access Token is used.

#### Username and Password

You should already have these details from when you setup your GitHub account.

#### Personal Access Token

A Personal Access Token is generated from within your GitHub Account online.

First [sign in to your GitHub Account](https://github.com/login) using your username or email address and password. Then, from your account (top right dropdown), select `Settings` then `Personal access token` under `Developer settings`. Select `Generate new token` and provide a `Token description` such as `cbgithub`. Choose the `Select scopes` that are appropriate for the access you need to this GitHub account. Make a note of the new personal access token generated.

#### Configuring cbgithub Security

Now you need to take either your GitHub `username` and `password` or the `personal access token` you've just created and add them to your ColdBox Module settings in `config/Coldbox.cfc`. Take a look at [Retrieving Module Settings](https://coldbox.ortusbooks.com/content/full/modules/retrieving_&_interacting_with_module_settings/) for more information. 

Populate your `config/Coldbox.cfc` like this if you want to use your username and password...

```
moduleSettings = {
    cbgithub = {
        "username" = "myUserName",
        "password" = "myPassword"
    }
};
```

...or like this if you want to use your personal access token...

```
moduleSettings = {
    cbgithub = {
        "token" = "myPersonalToken"
    }
};
```

**Remember**: Don't commit these details to a publicly accessible GitHub repository otherwise your account could be compromised!
## Contents Endpoint

GitHub offers a set of endpoints that provide [access to the contents of files](https://developer.github.com/v3/repos/contents/) in the repository. These include the ability to read the README file and any other file. Also it's possible to create, update and delete any file in the repository.

### getReadMe( owner, repo, ref, encoding )

I return a `Content` object populated with information about the `README` file. Calling the `getContent()` method on the `Content` object will decode the raw `base64` string.

#### Example

```
property name="ContentService" inject="ContentService@cbgithub";

...

readme = ContentService.getReadMe( owner="elpete", repo="cbgithub", ref="master", encoding="utf-8" );
```

#### Arguments

Argument | Description
-------- | -----------
`owner` (required, string) | Name of the GitHub account
`repo` (required, string) | Name of the repository of the `owner`
`ref` (optional, string="master") | Name of the branch, tag or commit to read from
`encoding` (optional, string="utf-8") | Type of file encoding

#### Response

<table>
	<thead>
		<tr>
			<th>Property</th>
			<th>Type</th>
			<th>Value</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>content</td>
			<td>string</td>
			<td>
				IyBjYmdpdGh1YgoKWyFbTWFzdGVyIEJyYW5jaCBCdWlsZCBTdGF0dXNdKGh0
dHBzOi8vaW1nLnNoaWVsZHMuaW8vdHJhdmlzL2VscGV0ZS9jYmdpdGh1Yi9t
YXN0ZXIuc3ZnP3N0eWxlPWZsYXQtc3F1YXJlJmxhYmVsPW1hc3RlcildKGh0
dHBzOi8vdHJhdmlzLWNpLm9yZy9lbHBldGUvY2JnaXRodWIpCgoKIyMgQSBD
Rk1MIFdyYXBwZXIgYXJvdW5kIHRoZSBHaXRIdWIgQVBJIG9wdGltaXplZCBm
b3IgQ29sZEJveAoKIyMgVGVzdGluZwoKVG8gcnVuIHRoZSB0ZXN0cywgZmly
c3QgY29weSB0aGUgYC5lbnYuZXhhbXBsZWAgZmlsZSB0byBgLmVudmAgYW5k
IGZpbGwgb3V0IHRoZSByZXF1aXJlZCBwcm9wZXJ0aWVzLiAgVGhpcyBpcyB1
c2VkIHRvIHRlc3QgYWdhaW5zdCB0aGUgYWN0dWFsIEdpdEh1YiBhcGkgd2l0
aG91dCBwZXJzaXN0aW5nIGFueSBjaGFuZ2VzLiAgQWRkaXRpb25hbGx5LCBz
b21lIG9mIHRoZSB0ZXN0cyByZXF1aXJlIDItZmFjdG9yIGF1dGhlbnRpY2F0
aW9uIHRvIGJlIHR1cm5lZCBvZmYuIChEb24ndCB3b3JyeSwgd2UgZnVsbHkg
c3VwcG9ydCAyLWZhY3RvciBhdXRoZW50aWNhdGlvbiEp
			</td>
		</tr>
		<tr>
			<td>_links</td>
			<td>struct</td>
			<td>
				<table>
					<thead>
						<tr>
							<th>Property</th>
							<th>Type</th>
							<th>Value</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>html</td>
							<td>string</td>
							<td>https://github.com/elpete/cbgithub/blob/master/README.md</td>
						</tr>
						<tr>
							<td>self</td>
							<td>string</td>
							<td>
								https://api.github.com/repos/elpete/cbgithub/contents/README.md?ref=master
							</td>
						</tr>
						<tr>
							<td>git</td>
							<td>string</td>
							<td>
								https://api.github.com/repos/elpete/cbgithub/git/blobs/6b029017cb3349add550d491729e435d7cafa7d3
							</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
		<tr>
			<td>html_url</td>
			<td>string</td>
			<td>https://github.com/elpete/cbgithub/blob/master/README.md</td>
		</tr>
		<tr>
			<td>sha</td>
			<td>string</td>
			<td>6b029017cb3349add550d491729e435d7cafa7d3</td>
		</tr>
		<tr>
			<td>path</td>
			<td>string</td>
			<td>README.md</td>
		</tr>
		<tr>
			<td>url</td>
			<td>string</td>
			<td>
				https://api.github.com/repos/elpete/cbgithub/contents/README.md?ref=master
			</td>
		</tr>
		<tr>
			<td>size</td>
			<td>number</td>
			<td>573</td>
		</tr>
		<tr>
			<td>name</td>
			<td>string</td>
			<td>README.md</td>
		</tr>
        <tr>
            <td>submodule_git_url</td>
            <td>string</td>
            <td></td>
        </tr>
		<tr>
			<td>type</td>
			<td>string</td>
			<td>file</td>
		</tr>
		<tr>
			<td>git_url</td>
			<td>string</td>
			<td>
				https://api.github.com/repos/elpete/cbgithub/git/blobs/6b029017cb3349add550d491729e435d7cafa7d3
			</td>
		</tr>
		<tr>
			<td>download_url</td>
			<td>string</td>
			<td>
				https://raw.githubusercontent.com/elpete/cbgithub/master/README.md
			</td>
		</tr>
		<tr>
			<td>encoding</td>
			<td>string</td>
			<td>base64</td>
		</tr>
        <tr>
            <td>mimetype</td>
            <td>string</td>
            <td>text/plain</td>
        </tr>
	</tbody>
</table>

## Testing

To run the tests, first copy the `.env.example` file to `.env` and fill out the required properties.  This is used to test against the actual GitHub api without persisting any changes.  Additionally, some of the tests require 2-factor authentication to be turned off. (Don't worry, we fully support 2-factor authentication!)

## Compatibility

This project has been tested against Adobe ColdFusion 11+ and Lucee 4.5+ servers.

## Contributors

Thanks goes to these wonderful people ([emoji key](https://github.com/kentcdodds/all-contributors#emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
| [<img src="https://avatars2.githubusercontent.com/u/2583646?v=3" width="100px;"/><br /><sub>Eric Peterson</sub>](https://github.com/elpete)<br />[💬](#question-elpete "Answering Questions") [💻](https://github.com/elpete/cbgithub/commits?author=elpete "Code") [📖](https://github.com/elpete/cbgithub/commits?author=elpete "Documentation") [⚠️](https://github.com/elpete/cbgithub/commits?author=elpete "Tests") | [<img src="https://avatars2.githubusercontent.com/u/1644678?v=3" width="100px;"/><br /><sub>Richard Herbert</sub>](https://twitter.com/richardherbert)<br />[💻](https://github.com/elpete/cbgithub/commits?author=richardherbert "Code") [📖](https://github.com/elpete/cbgithub/commits?author=richardherbert "Documentation") [⚠️](https://github.com/elpete/cbgithub/commits?author=richardherbert "Tests") |
| :---: | :---: |
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/kentcdodds/all-contributors) specification. Contributions of any kind welcome!
