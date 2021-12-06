A server app built using [Shelf](https://pub.dev/packages/shelf),
configured to enable running with [Docker](https://www.docker.com/).

This sample code handles HTTP GET requests to `/` and `/echo/<message>`

# Requests Overview

This sample code handles following requests:
### GET
  - `/todos` - this request will fetch all the availabel todos in the list.
  - `/todo/<id>` -this request will fetch `Todo` according to `id` that was parsed

### POST
  - `/add-todo` - this request will add new `Todo` to the list, with JSON body that was attached.

### DELETE 
  - `delete-todo/<id>` - this request will delete `Todo` according to `id` that was parsed.

### PUT
  - `update-todo` - this request will update and replace the `Todo` with same `id`.

# Project Structure

![todo_server_pj_structure](https://user-images.githubusercontent.com/63785350/144826938-81a18288-17fa-48e3-a3a7-b291e7e9ffed.png)

  

# Running the sample

## Running with the Dart SDK

You can run the example with the [Dart SDK](https://dart.dev/get-dart)
like this:

```
$ dart run bin/server.dart
Server listening on port 8080
```

And then from a second terminal:
```
$ curl http://0.0.0.0:8080
Hello, World!
$ curl http://0.0.0.0:8080/echo/I_love_Dart
I_love_Dart
```

## Running with Docker

If you have [Docker Desktop](https://www.docker.com/get-started) installed, you
can build and run with the `docker` command:

```
$ docker build . -t myserver
$ docker run -it -p 8080:8080 myserver
Server listening on port 8080
```

And then from a second terminal:
```
$ curl http://0.0.0.0:8080
Hello, World!
$ curl http://0.0.0.0:8080/echo/I_love_Dart
I_love_Dart
```

You should see the logging printed in the first terminal:
```
2021-05-06T15:47:04.620417  0:00:00.000158 GET     [200] /
2021-05-06T15:47:08.392928  0:00:00.001216 GET     [200] /echo/I_love_Dart
```
