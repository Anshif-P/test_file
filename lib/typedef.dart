import 'package:either_dart/either.dart';
import 'package:test_int_kr/exception.dart';

typedef EitherResponse<T> = Future<Either<AppException, T>>;
