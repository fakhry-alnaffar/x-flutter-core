# x_flutter_core

A robust networking, storage, and infrastructure layer for scalable Flutter
applications. Built on Dio with Clean Architecture patterns.

[![pub.dev](https://img.shields.io/pub/v/x_flutter_core.svg)](https://pub.dev/packages/x_flutter_core)

## Features

- Dio-based HTTP client with caching, retry, and proxy support
- Clean architecture request/error processor pipeline
- Secure and shared preferences storage with lazy initialisation
- Connectivity checker (mobile + always-connected stubs)
- Sealed `DataResponse<T>` type for safe result handling

## Installation

```yaml
dependencies:
  x_flutter_core: ^1.0.0
```

## Usage

### Create an API client

```dart
final dioClientModule = _DioClientModule();
final apiClient = dioClientModule.makeApiClient(
  ApiClientParams(
    baseUrl: 'https://api.example.com/',
    defaultConnectTimeout: 5000,
    defaultReceiveTimeout: 5000,
    interceptors: [MyLogInterceptor()],
    headers: {},
  ),
);
```

### Create a custom error parser

```dart
class CustomErrorParser {
  const CustomErrorParser._();

  static Object parse(int statusCode, dynamic response) {
    if (response is! Map<String, dynamic>) {
      return MyApiError(message: response?.toString());
    }
    return MyApiError.fromJson(response);
  }
}
```

### Create a request processor

```dart
final processor = dioClientModule.createInternalDioRequestProcessor(
  customErrorParser: CustomErrorParser.parse,
);
```

### Make a request

```dart
final response = await processor.processRequest(
  onRequest: () => apiClient.client.get('/users'),
  onParse: (response) => UserModelList.fromJson(response.data),
);
```

### Handle the result

```dart
if (response.isSuccess()) {
  final data = response.data;
} else {
  // handle error via ServerErrorMapper
}
```

## Custom HTTP client

1. Extend `RequestProcessor` and implement `processRequest`.
2. Extend `ErrorProcessor` and implement `processError`.

See `InternalDioRequestProcessor` and `InternalDioErrorProcessor` for reference implementations.

## License

MIT
