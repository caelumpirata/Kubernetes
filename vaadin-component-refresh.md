## update vaadin component value using @Push  and @ClientCallable
```
https://vaadin.com/docs/v23/advanced/server-push#push.access
```

## refresh.js
```
window.refreshUI = function refreshUI(element) {
    console.log("Hi, from refreshUI");

    // Check if $server is defined before attempting to call greet
    if (element && element.$server && typeof element.$server.refreshUI === 'function') {
        setInterval(function() {
            // Assuming 'element' is the element you want to pass
            element.$server.refreshUI(); // Attempt to call $server.greet()
        }, 1000);
    } else {
        console.error('element.$server or element.$server.greet is not defined');
    }
}
```

## Dog.java
inside constructor 
```
callJsMethodInTheBrowser();
```
oustside constructor
-------------------
```
	private void callJsMethodInTheBrowser() {
        getElement().executeJs("refreshUI($0)");
    }
```
this would be refreshed 
```
@ClientCallable
	public void refreshUI() {
    	    refreshMe();
	}
```




