import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:test_int_kr/bloc/test_bloc.dart';
import 'package:test_int_kr/gext.dart';

class ScreenNewTest extends StatefulWidget {
  ScreenNewTest({super.key});

  @override
  State<ScreenNewTest> createState() => _ScreenNewTestState();
}

class _ScreenNewTestState extends State<ScreenNewTest> {
  TestGextController gextController = Get.put(TestGextController());
  String currentOption = '';
  bool checkBox = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          BlocBuilder<TestBloc, TestState>(
            builder: (context, state) {
              if (state is TextUpdatedSuccessState) {
                return Text(state.text);
              }
              return Text('Hai');
            },
          ),
          ElevatedButton(
              onPressed: () {
                gextController.change('dilshad');
                context.read<TestBloc>().add(UpdateText(text: 'ho'));
              },
              child: Icon(Icons.add)),
          GetBuilder<TestGextController>(
              builder: (controller) => Text(controller.name)),
          InkWell(
              onTap: () {
                // _bottomSheetFnc(context);
                showDialog(
                    context: context, builder: (context) => showAlertDialog);
              },
              child: Text('show bottom sheet')),
          RadioListTile(
            title: Text('Legend'),
            value: 'option 1',
            groupValue: currentOption,
            onChanged: (value) {
              currentOption = value!;
              setState(() {});
            },
          ),
          RadioListTile(
            title: Text('Boat'),
            value: 'option 2',
            groupValue: currentOption,
            onChanged: (value) {
              setState(() {});
              currentOption = value!;
            },
          ),
          Checkbox(
              value: checkBox,
              onChanged: (value) {
                setState(() {});
                checkBox = value!;
              }),
        ],
      ),
    );
  }

  void _bottomSheetFnc(BuildContext context) {
    showBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 100,
            width: double.maxFinite,
            child: Column(
              children: [Text('hai')],
            ),
          );
        });
  }

  AlertDialog get showAlertDialog {
    return AlertDialog(
      title: Text('hai'),
      actions: [Text('cancel'), Text('ok')],
    );
  }
}
