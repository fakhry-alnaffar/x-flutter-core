import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';

abstract class Result<T> {

  const Result();

  factory Result.success(T data) => ResultSuccess<T>(data);

  factory Result.error({required Failure failure}) => ResultError<T>(failure);

  bool get isSuccess => this is ResultSuccess<T>;

  bool get isError => this is ResultError;


  ///WARNING. ALWAYS CHECK success == true before call
  T get data => (this as ResultSuccess<T>).data;

  ///WARNING. ALWAYS CHECK isError == true before call
  ResultError get error => this as ResultError;
}

final class ResultSuccess<T> extends Result<T> {
  final T _data;

  @override
  T get data => _data;

  ResultSuccess(T data) : _data = data;
}

final class ResultError<T> extends Result<T> {
  final Failure _failure;

  Failure get failure => _failure;

  ResultError(Failure failure) : _failure = failure;
}

