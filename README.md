This package contains some base classes designed to improve experience of using HTTP networking
functionality. 

Initially works with Dio api client but you free to extend implementation to use any other api client.


## Usage

Create a new api client:

```

final dioClientModule = _DioClientModule();
final apiClient = dioClientModule.makeApiClient(
    ApiClientParams(
    baseUrl: 'https://jsonplaceholder.typicode.com/',
    defaultConnectTimeout: 5000,
    defaultReceiveTimeout: 5000,
    interceptors: [LogInterceptor()],
    headers: {} //optional
    ),
);

```

Create custom error handler to parse Api error responses globally:

```

class CustomErrorHandler {

  const CustomErrorHandler._();
  static Object handle(
    int statusCode,
    dynamic response,
  ) {
    return MyApiErrorResponse.fromJson(response as Map<String, dynamic>);
  }
}

```

Create request processor:

```

final processor = dioClientModule.createInternalDioRequestProcessor(
      customErrorParser: MyCustomErrorHandler.handle,
    ),;

```

Make a request:

```

_requestProcessor.processRequest(
      onRequest: () => _apiClient.client.get('https://api.url/getProfile'),
      onParse: (response) {
        return MyResponse.fromJson(response.data);
      },
      //optional
      onCustomRequestError: (code, data){
        return MyCustomError.fromJson(response);
      },
    );

```

Handle result or error from `DataResponse` class response:

```

if (response.isSuccess()) {
    final data = response.data;
    ...
} else {
    // process and error
}

``` 

## Create custom HTTP client implementation

To create you own implementation based on this package you follow these steps:

1. Create your request processor implementation class extended from `RequestProcessor`
2. Implement `processRequest` function code and optional `hasInternetConnection` function code. See InternalDioRequestProcessor for reference. 
3. Create your error processor implementation class extended from `ErrorProcessor`
4. Implement `processError` function code. See `InternalDioErrorProcessor` for reference.




