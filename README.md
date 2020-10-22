<div align="center">

![react-native-onfido](https://remtech.org/wp-content/uploads/2019/06/Onfido_IMTC.jpg)

[![Version](https://img.shields.io/npm/v/react-native-onfido)](https://www.npmjs.com/package/react-native-onfido)
[![Build](https://travis-ci.org/react-native-nation/react-native-onfido.svg?branch=master)](https://travis-ci.org/react-native-nation/react-native-onfido)
[![Coverage](https://coveralls.io/repos/github/react-native-nation/react-native-onfido/badge.svg?branch=master)](https://coveralls.io/github/react-native-nation/react-native-onfido?branch=master)
[![Minified size](https://img.shields.io/bundlephobia/min/react-native-onfido)](https://github.com/react-native-nation/react-native-onfido/blob/master/LICENSE)
[![Downloads](https://img.shields.io/npm/dm/react-native-onfido)](https://www.npmjs.com/package/react-native-onfido)
[![Dependabot](https://api.dependabot.com/badges/status?host=github&repo=react-native-nation/react-native-onfido)](https://dependabot.com)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/react-native-nation/react-native-onfido/pulls)
[![Tested with jest](https://img.shields.io/badge/tested_with-jest-99424f.svg)](https://github.com/facebook/jest)

</div>

# React Native Nation Onfido
This package is a wrapper for the Onfido Library. https://onfido.com/

## Table of contents
* [How to install](#howtoinstall)
* [API Methods](#using)
* [Example](#example)
* [Community profile](#community)
* [Contributing](#contributing)

<a name="howtoinstall"></a>

## How to install
`yarn add react-native-onfido`.
 
<a name="using"></a>
## API Methods

# startSDK
To start the onfido KYC proccess use `startSDK`
```js
Onfido.startSDK(token, applicantId, country, onSuccess, OnError);
```

# Example

<a name="example"></a>
## Example
React native example

```js
import Onfido from 'react-native-onfido';

Onfido.startSDK(
    token,
    applicantId,
    country,
    () => { 
        console.log("Verification complete");
    },
    (errorCause) => {
        if (errorCause == "USER_LEFT_ACTIVITY") {
            console.log("Flow cancelled")
        } else {
            console.log("Flow not finished")
        };
    });
```

<a name="community"></a>
## Community profile
Please read through our [CODE_OF_CONDUCT.md](/.github/CODE_OF_CONDUCT.md).

<a name="contributing"></a>
## Contributing
Please read through our [CONTRIBUTING.md](/.github/CONTRIBUTING.md).

## Contributors

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore -->
<table>
  <tr>
    <td align="center"><a href="https://jamesjara.me"><img src="https://avatars2.githubusercontent.com/u/780219?v=4" width="100px;" alt="James Jara"/><br /><sub><b>James Jara</b></sub></a><br /><a href="#infra-jamesjara" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a> <a href="https://github.com/React-Native-Nation/react-native-onfido/commits?author=jamesjara" title="Code">💻</a> <a href="https://github.com/React-Native-Nation/react-native-onfido/commits?author=jamesjara" title="Tests">⚠️</a> <a href="https://github.com/React-Native-Nation/react-native-onfido/commits?author=jamesjara" title="Documentation">📖</a></td>
  </tr>
</table>

<a name="reactnativenation"></a>
## React Native Nation
React Native Nation is the best spanish website for react native documentation.
[react-native-nation](https://reactnativenation.com).
