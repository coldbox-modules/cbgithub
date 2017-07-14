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

## Testing

To run the tests, first copy the `.env.example` file to `.env` and fill out the required properties.  This is used to test against the actual GitHub api without persisting any changes.  Additionally, some of the tests require 2-factor authentication to be turned off. (Don't worry, we fully support 2-factor authentication!)

## Compatibility

This project has been tested against Adobe ColdFusion 11+ and Lucee 4.5+ servers.

## Contributors

Thanks goes to these wonderful people ([emoji key](https://github.com/kentcdodds/all-contributors#emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
| [<img src="https://avatars2.githubusercontent.com/u/2583646?v=3" width="100px;"/><br /><sub>Eric Peterson</sub>](https://github.com/elpete)<br />[💬](#question-elpete "Answering Questions") [💻](https://github.com/elpete/cbgithub/commits?author=elpete "Code") [📖](https://github.com/elpete/cbgithub/commits?author=elpete "Documentation") [⚠️](https://github.com/elpete/cbgithub/commits?author=elpete "Tests") | [<img src="https://avatars2.githubusercontent.com/u/1644678?v=3" width="100px;"/><br /><sub>Richard Herbert</sub>](https://twitter.com/richardherbert)<br />[📖](https://github.com/elpete/cbgithub/commits?author=richardherbert "Documentation") |
| :---: | :---: |
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/kentcdodds/all-contributors) specification. Contributions of any kind welcome!
