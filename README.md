ncmb-ruby-client
================

A simple Ruby client for the nifty cloud mobile backend REST API. This is developer preview.

Basic Usage
-----------

```
NCMB.initialize application_key: application_key,  client_key: client_key

@todo = NCMB::DataStore.new 'Todo'
@todo = @todo.limit(20)

@todo.each do |item|
  puts item[:String]
  puts "  #{item[:Array]} -> #{item[:Array].class}"
end

@todo = NCMB::Object.new 'Todo'
@todo.set('String', 'Test String')
@todo.set('Integer', 100)
@todo.set('Boolean', true)
@todo.set('Array', [1, 2, 3, "Orange", "Tomato"])
@todo.set('Object', {test1: 'a', test2: 'b'})
@todo.set('Location', NCMB::GeoPoint.new(50, 30))
@todo.set('MultipleLine', "test\ntest\n")
@todo.set('Increment', NCMB::Increment.new(2))
@todo.set('Date', Time.new(2016, 2, 24, 12, 30, 45))
@todo.save
```

### Register push notification

```
NCMB.initialize application_key: application_key,  client_key: client_key

@push = NCMB::Push.new
@push.immediateDeliveryFlag = true
@push.target = ['ios']
@push.message = "This is test message"
@push.deliveryExpirationTime = "3 day"
if @push.save
  puts "Push save successful."
else
  puts "Push save faild."
end
```

## Unit test

### Settings
* Install libraries
```
bundle install
```
* Rename file `setting_default.yml` to `setting.yml` and then fill you `application_key`, `client_key`

### Run unit test 
Run `spec` task:
```
rake spec
```

## Run all examples

Run `examples` task:

```
rake examples
```

Or you can run every single example

```
ruby examples/example_file_name.rb
```

## Test script

Before run `examples/script.rb`, you should upload the below script files to Script function on the Console screen.

### helloworld.js

* File Name: helloworld.js
* Method: GET
* File Status: Executable
```javascript
module.exports = function(req, res) {
  res.send('{"msg":"Hello World!"}');
}
```

### helloworld2.js

* File Name: helloworld2.js
* Method: GET
* File Status: Executable
```javascript
module.exports = function(req, res) {
  if (req.query.name) {
    res.send('{"msg":"Hello ' + req.query.name +'!"}');
  } else {
    res.send('{"msg":"Hello World!"}');
  }
}
```

### email.js

* File Name: email.js
* Method: POST
* File Status: Executable

(Don't forget to change `YOUR-APPLICATION-KEY` and `YOUR-CLIENT-KEY` to your value before upload.)

```javascript
function saveData(req, res) {
  // POSTのデータを取得
  var email = req.body.email;
  var message = req.body.body;
  
  var NCMB = require('ncmb');
  var ncmb = new NCMB('YOUR-APPLICATION-KEY', 'YOUR-CLIENT-KEY');

  // データを保存する
  var Item = ncmb.DataStore('Item');
  var item = new Item();
  item.set("email", email)
      .set("message", message)
      .save()
      .then(function(item){
        // 成功
        res.send('{"msg":"POST data successfully!"}');

      })
      .catch(function(err){
        // 失敗
        res.send('{"msg":"' + err + '"}');
      });
}

module.exports = saveData;
```

## Environment to confirm

* Ruby v2.7.3 - Bundler version 2.1.4
* Ruby v3.0.1 - Bundler version 2.2.15

## License

MIT.

[ニフクラ mobile backend](http://mb.cloud.nifty.com/)
