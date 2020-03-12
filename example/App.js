import React, { Component } from 'react';
import { StyleSheet, Text, View } from 'react-native';

import Onfido from 'react-native-onfido';

const token = 'test_iCPCbZOQv01rBCSZ5xZt65JaqMj_et76';

export default class App extends Component<{}> {
  state = {
    status: 'starting',
    message: '--'
  };
  
  createApplicant = (callback) => {
    let applicant = {
      first_name: 'Jane',
      last_name: 'Doe'
    }
    fetch('https://api.onfido.com/v2/applicants', {
      method: 'POST',
      headers: {
        'Authorization': `Token token=${token}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(applicant)
    })
    .then((response) => {
      if (response.ok) {
          response.json().then((responseJson) => {
            let applicantId = responseJson.id;
            callback(applicantId)
          })
      } else {
        console.log("Unable to create applicant", "Applicant Id is required to initiate SDK flow. Check your internet connection or token. To try again, press \"Launch\"")
      }
    })
  }

  componentDidMount() {
    this.createApplicant((applicantId)=> {
      Onfido.startSDK(
        token,
        applicantId,
        'CR',
        () => { console.log("Verification complete", "To perform another verification, press \"Launch\"") },
        (errorCause) => {
          if (errorCause == "USER_LEFT_ACTIVITY") {
            console.log("Flow cancelled", "To try again, press \"Launch\"")
          } else {
            console.log("Flow not finished", "To try again, press \"Launch\"")
          }
        }
      );
    });
  }
  
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>☆Onfido React Native</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});
