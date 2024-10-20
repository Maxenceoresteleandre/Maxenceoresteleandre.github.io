import React from 'react';


export default function Dashboard({ navigation }) {
    return (
        <View style={styles.container}>
            <Text style={styles.text}>Dashboard</Text>
            <Button
                title="Go to Home"
                onPress={() => navigation.navigate('Home')}
            />
        </View>
    );
}