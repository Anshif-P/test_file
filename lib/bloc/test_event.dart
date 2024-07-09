part of 'test_bloc.dart';

abstract class TestEvent {}

class UpdateText extends TestEvent {
  String text;
  UpdateText({required this.text});
}
