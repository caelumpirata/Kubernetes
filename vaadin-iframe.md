# Opening Python app inside vaadin iframe 
issue ❌

`Failed to load resource: the server responded with a status of 403 (Forbidden)`

fix ✅

make sure python app has domain name without any `/path'

example ❌
```
app.example.com/helloworld/
```

example ✅
```
app.example.com
```
