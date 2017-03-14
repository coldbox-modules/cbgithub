# cbgithub

[![Master Branch Build Status](https://img.shields.io/travis/elpete/cbgithub/master.svg?style=flat-square&label=master)](https://travis-ci.org/elpete/cbgithub)


## A CFML Wrapper around the GitHub API optimized for ColdBox

## Testing

To run the tests, first copy the `.env.example` file to `.env` and fill out the required properties.  This is used to test against the actual GitHub api without persisting any changes.  Additionally, some of the tests require 2-factor authentication to be turned off. (Don't worry, we fully support 2-factor authentication!)