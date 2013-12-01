# fb-test-user

Creates test user for automated tests.

If there is no test user, the new test user will be created, otherwise the old one will be returned.

## Installation

    $ npm install fb-test-user

## Example

```js

var TestUser = require('fb-test-user');

var config = {
    appId: 123,
    appSecret: 'abc',
    permissions: 'read_stream, friends_location'
};

inst = new TestUser(config);
inst.createTestUser(function(err, user){
    //user is: { id: '100007266971717', access_token: 'CAAUY15laJ0wBAHBsEc67brBGaTY' }
});
```

## License

MIT
