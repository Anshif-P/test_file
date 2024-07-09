part of 'test_bloc.dart';

abstract class TestState {}

final class TestInitial extends TestState {}

final class TextUpdatedSuccessState extends TestState {
  String text;
  TextUpdatedSuccessState({required this.text});
}
