
import React from "react";
import { NavigationContainer } from '@react-navigation/native';
import Home from './Home.js';

const Stack = createNativeStackNavigator(screens);

const screens = {
    Home: {
      screen: Home
    },
  };

export default () => {
    return (
      <NavigationContainer>
        <Stack.Navigator initialRouteName="Login">
          <Stack.Screen name="Home" component={Home} options={{ headerShown: false }} />
        </Stack.Navigator>
      </NavigationContainer>
    );
};