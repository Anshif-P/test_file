import 'dart:async';

import 'package:bloc/bloc.dart';
part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  TestBloc() : super(TestInitial()) {
    on<UpdateText>(updateText);
  }
  FutureOr<void> updateText(UpdateText event, Emitter<TestState> emit) {
    emit(TextUpdatedSuccessState(text: event.text));
  }
}
