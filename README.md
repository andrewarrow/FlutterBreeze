# flutter_breeze

```
  http: ^0.13.3
  path_provider: ^2.0.5
  cached_network_image: ^3.0.0
```

# Run

```
flutter pub get
flutter devices
flutter run -d [your_device_id]
```

# iOS Screenshots

<img src="screenshots/ms1.png" alt="Login" width="282" height="579">

This is the login page from [lib/session.dart](https://github.com/andrewarrow/FlutterBreeze/blob/main/lib/session.dart) and it will make an http POST to `http://localhost:3000/api/login` and if it gets back a 200 with json like:

```
{"id": 1, "name": "something"}
```

You will have a logged in user like `final Map<String, dynamic>? user;` in [lib/index.dar](https://github.com/andrewarrow/FlutterBreeze/blob/main/lib/index.dart) and you can access the name field like:

```
user?['name'];
```

You'll see this in [lib/menu.dart](https://github.com/andrewarrow/FlutterBreeze/blob/main/lib/menu.dart) and notice the:

```
Navigator.popUntil(otherContext, (route) => route.isFirst);
```

Logic to get you back to the first screen. We pass around `otherContext` to each
screen so the Navigator can use just one context.

After login when you land on the HomePage it will page an http get to:

```
http://localhost:3000/api/cats
```

And expect some json like:

```
[{"id": 1, "name": "milkshake"},{"id": 2, "name": "other"}]
```

to make a list display of N items. It uses `GestureDetector` to know that you selected one and then opens a detail page for that selected item in [lib/cat.dart](https://github.com/andrewarrow/FlutterBreeze/blob/main/lib/cat.dart)


<img src="screenshots/ms2.jpg" alt="Login" width="282" height="579">
<img src="screenshots/ms3.jpg" alt="Login" width="282" height="579">
<img src="screenshots/ms4.jpg" alt="Login" width="282" height="579">
