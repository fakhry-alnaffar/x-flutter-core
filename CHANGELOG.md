## 1.0.2

* Added Data Response type for safe result handling

## 1.0.1

* Added dartdoc comments to all public API elements

## 1.0.0

* Renamed package from `onix_flutter_core` to `x_flutter_core`
* Migrated dependency from `onix_flutter_core_models` to `x_flutter_core_models: ^1.0.0`
* Applied Dart 3 sealed classes, immutable DTOs, and extension-based mappers
* Fixed async race condition in `KeyValueStorage` lazy initialisation
* Fixed `receiveTimeout` not mapping to `NoInternetConnection`
* Fixed `MobileConnectionChecker` OS-first / DNS-second ordering
* Moved `CacheInterceptor` to base layer — no circular imports
* Cleaned up `ErrorProcessor` — pure abstract class, no concrete imports
* Improved `ApiClient` constructor — sync setup, no deferred `_initInterceptors`
* First stable pub.dev release

## 0.0.6-beta.3

* Added function to update base client url

## 0.0.6-beta.2

* Code improvements

## 0.0.6-beta.1

* Code improvements
* Switched to beta core components

## 0.0.5

* Added unit tests for the BasePreferences class

## 0.0.4

* Moved BaseBloc and BaseCubit to a separate package. Moved Failure interface to a separate package

## 0.0.3

* Code cleanup

## 0.0.2

* Fixed bugs in data and domain layers. Updated visibility of library files

## 0.0.1

* Initial architecture release
