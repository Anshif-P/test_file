import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:test_int_kr/validation.dart';

class ScreenHome2 extends StatefulWidget {
  const ScreenHome2({super.key});

  @override
  State<ScreenHome2> createState() => _ScreenHome2State();
}

class _ScreenHome2State extends State<ScreenHome2> {
  final List<String> checkBoxItems = [
    'Ac',
    'Swimming pool',
    'Hotel',
    'Elevator'
  ];
  final List<bool> checkBoxIsSelected = [false, false, false, false];
  final List<String> dropDownItems = ['pending', 'finished', 'billed'];
  String currentStatus = 'pending';
  String radioButtonValue = '';
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  StreamController<String> streamController = StreamController<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('test screen'),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              DropdownButton<String>(
                value: currentStatus,
                onChanged: (value) {
                  setState(() {
                    currentStatus = value ?? 'pending';
                  });
                },
                items: dropDownItems
                    .map((String status) => DropdownMenuItem<String>(
                        value: status, child: Text(status)))
                    .toList(),
              ),
            ],
          ),
          SizedBox(
            width: double.maxFinite,
            height: 80,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 05),
              itemCount: checkBoxItems.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Checkbox(
                        value: checkBoxIsSelected[index],
                        onChanged: (value) {
                          setState(() {
                            checkBoxIsSelected[index] = value!;
                          });
                        }),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(checkBoxItems[index])
                  ],
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return showAlertDilog();
                  },
                );
              },
              child: const Text('hello')),
          InkWell(
              onTap: () {
                showBottomSheetFnc();
              },
              child: const Text('hai')),
          RadioListTile(
              title: const Text('Easy'),
              value: 'option 1',
              groupValue: radioButtonValue,
              onChanged: (value) {
                setState(() {
                  radioButtonValue = value!;
                });
              }),
          RadioListTile(
              title: const Text('Hard'),
              value: 'option 2',
              groupValue: radioButtonValue,
              onChanged: (value) {
                setState(() {
                  radioButtonValue = value!;
                });
              }),
          Form(
            key: formKey,
            child: TextFormField(
              validator: (value) => TextFieldValidation.emtyValidation(value),
              controller: controller,
              decoration: const InputDecoration(
                  hintText: 'Type Somthing',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
            stream: streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!);
              }
              return Text('empty');
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Transform.scale(
                scale: .9,
                child: CircularProgressIndicator(),
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () async {
                streamController.add(controller.text);

                // ReceivePort receivePort2 = ReceivePort();
                // Isolate.spawn(complexTast1, receivePort2.sendPort);
                // receivePort2.listen((sum) {
                //   print(sum);
                // });
                // int sum = complexTast2();
                // print(sum);
              },
              child: Text('Add')),
        ],
      ),
    );
  }

  complexTast2() {
    int sum = 0;
    for (int i = 1; i < 100000000; i++) {
      sum += i;
    }
    return sum;
  }

  showBottomSheetFnc() {
    showBottomSheet(
      context: context,
      builder: (context) {
        return const SizedBox(
          height: 300,
          width: double.maxFinite,
        );
      },
    );
  }

  AlertDialog showAlertDilog() {
    return AlertDialog(
      title: const Text('Do You Want To Log Out'),
      actions: [
        TextButton(onPressed: () {}, child: Text('Cancel')),
        TextButton(onPressed: () {}, child: Text('Ok')),
      ],
    );
  }
}

complexTast1(SendPort sendPort2) {
  int sum = 0;
  for (int i = 1; i < 100000000; i++) {
    sum += i;
  }
  return sendPort2.send(sum);
}
