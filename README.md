# react-native-onfido

## Getting started

`$ npm install react-native-onfido --save`

### Mostly automatic installation

`$ react-native link react-native-onfido`

## Usage
```javascript
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
