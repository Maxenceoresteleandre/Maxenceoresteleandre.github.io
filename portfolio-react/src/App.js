// Filename - App.js

import React from "react";
import Navigator from './screens/Navigator';

export default function App() {
    return (
        <Navigator/>
    );
}
  
const styles = StyleSheet.create({
    container: {
      flex: 1,
      justifyContent: 'center',
      paddingTop: Constants.statusBarHeight,
      backgroundColor: '#ecf0f1',
      padding: 8,
    },
    paragraph: {
      margin: 24,
      fontSize: 18,
      fontWeight: 'bold',
      textAlign: 'center',
    },
});

