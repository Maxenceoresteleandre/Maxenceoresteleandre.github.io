import React from 'react';


export default () => {
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