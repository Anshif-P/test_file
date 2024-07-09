import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:test_int_kr/api.dart';
import 'package:test_int_kr/gext.dart';
import 'package:test_int_kr/local_storage.dart';
import 'package:test_int_kr/temp.dart';
import 'package:test_int_kr/theme.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  ValueNotifier<bool> checkBoxNotifier = ValueNotifier<bool>(false);
  TextEditingController textEditingController = TextEditingController();

  ValueNotifier<String> selectedItem = ValueNotifier<String>('pending');
  StreamController<String> streamController = StreamController<String>();
  late Stream<String> brocastStream;
  TestGextController gextController = Get.put(TestGextController());
  Rx<String> title = Rx<String>('hello');

  List<String> statusList = ['completed', 'pending', 'billed'];

  String selectedRadio = '';

  @override
  void initState() {
    brocastStream = streamController.stream.asBroadcastStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Icon(
            Icons.sports_esports,
            color: Colors.black,
          ),
        ),
        leadingWidth: 30,
        titleSpacing: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            'G-Store',
          ),
        ),
        actions: const [
          Icon(Icons.notifications),
          SizedBox(
            width: 5,
          ),
          Icon(Icons.favorite_border_outlined),
          SizedBox(
            width: 5,
          ),
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.shopping_cart_outlined),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              height: 50,
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: InputBorder.none,
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.transparent)),
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search for product',
                    contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
                    suffixIcon: const Icon(Icons.tune)),
              ),
            ),
          ),
        ),
      ),
      body: DefaultTabController(
        length: 4,
        child: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      color: Colors.grey.shade200,
                      child: const SizedBox(
                        width: double.maxFinite,
                        height: 120,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        StreamBuilder<String>(
                            stream: brocastStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(snapshot.data ?? 'no input found');
                              }
                              return const Text('no text found');
                            }),
                        const SizedBox(
                          width: 15,
                        ),
                        StreamBuilder<String>(
                            stream: brocastStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(snapshot.data ?? 'no input found');
                              }
                              return const Text('no text found');
                            }),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  height: 100,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => SizedBox(
                            width: 90,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.grey.shade200,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text('Cabinest')
                              ],
                            ),
                          ),
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 10,
                          ),
                      itemCount: 6),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: () {
                          title.value = 'hooi';
                          showDialog(
                              context: context,
                              builder: (context) => showAlertDialog);
                          gextController.change('lengend');
                        },
                        child: GetBuilder<TestGextController>(
                            builder: (controller) => Text(controller.name))),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Transform.scale(
                          scale: .9,
                          child: const CircularProgressIndicator(),
                        ),
                      ],
                    ),
                    ValueListenableBuilder(
                      valueListenable: checkBoxNotifier,
                      builder: (context, _, child) => Checkbox(
                          value: checkBoxNotifier.value,
                          onChanged: (value) {
                            checkBoxNotifier.value = value!;
                          }),
                    ),
                    ValueListenableBuilder(
                      valueListenable: selectedItem,
                      builder: (context, value, child) => DropdownButton(
                        value: selectedItem.value,
                        onChanged: (newValue) {
                          selectedItem.value = newValue!;
                        },
                        items: statusList
                            .map((String status) => DropdownMenuItem<String>(
                                value: status,
                                child: Text(
                                  status,
                                  style: const TextStyle(color: Colors.black),
                                )))
                            .toList(),
                      ),
                    ),
                    RadioListTile<String>(
                        fillColor:
                            const MaterialStatePropertyAll(Colors.yellow),
                        title: const Text('Expert'),
                        value: 'option 1',
                        groupValue: selectedRadio,
                        onChanged: (value) {
                          setState(() {
                            selectedRadio = value!;
                          });
                        }),
                    RadioListTile(
                        title: const Text('Beginner'),
                        value: 'option 2',
                        groupValue: selectedRadio,
                        onChanged: (value) {
                          setState(() {
                            selectedRadio = value!;
                          });
                        }),
                    Radio(
                        value: 'option 3',
                        groupValue: selectedRadio,
                        onChanged: (value) {
                          setState(() {
                            selectedRadio = value!;
                          });
                        }),
                    ElevatedButton(
                        onPressed: () async {
                          Map<String, dynamic> tempData = {
                            'name': 'ismail',
                            'age': 22
                          };

                          Map<String, dynamic> educationData = {
                            'userId': 0,
                            'jobTitle': 'flutter developer',
                            'salary': '5 LPA',
                            'experiance': 1
                          };

                          final int val =
                              await DatabaseHelper.instance.addData(tempData);
                          // print(val);
                          educationData['userId'] = val;
                          await DatabaseHelper.instance
                              .addEducation(educationData);

                          await DatabaseHelper.instance.getEducation();

                          await DatabaseHelper.instance.getData();

                          streamController.add(textEditingController.text);
                          Api.postApis(tempData).whenComplete(() {});

                          await DatabaseHelper.instance.getUserData(10);

                          ReceivePort reciverPort = ReceivePort();
                          Isolate.spawn(complexTask1, reciverPort.sendPort);
                          reciverPort.listen((sum) {
                            print(sum);
                          });
                          // complexTask2();
                        },
                        child: const Text('Add')),
                    Consumer<ThemeProvider>(
                        builder: (context, objProvider, child) => Switch(
                            value: objProvider.isDarkMode,
                            onChanged: (value) {
                              Provider.of<ThemeProvider>(context, listen: false)
                                  .toggleTheme();
                            })),
                    Obx(() => Text(
                          title.value,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ))
                  ],
                ),
              ),
              const TabBar(
                tabs: [
                  Tab(
                    child: Text('name1'),
                  ),
                  Tab(
                    child: Text('name2'),
                  ),
                  Tab(
                    child: Text('name3'),
                  ),
                  Tab(
                    child: Text('name4'),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                  height: 200,
                  child: TabBarView(
                      children: [TempTab(), TempTab(), TempTab(), TempTab()])),
            ],
          ),
        ),
      ),
    );
  }
}

bottomSheetWidget(BuildContext context) {
  return showBottomSheet(
    context: context,
    builder: (context) => Container(
      color: Colors.grey.shade200,
      height: 300,
      width: double.maxFinite,
      child: const Column(
        children: [Text('hello Bottom sheet')],
      ),
    ),
  );
}

AlertDialog get showAlertDialog {
  return AlertDialog(
    title: const Text('Welcome'),
    actions: [
      TextButton(onPressed: () {}, child: const Text('ok')),
      TextButton(onPressed: () {}, child: const Text('cancel'))
    ],
  );
}

complexTask1(SendPort sendPort) {
  int sum = 0;
  for (int i = 1; i < 10000000; i++) {
    sum += i;
  }
  sendPort.send(sum);
}

// complexTask2() {
//   int sum = 0;
//   for (int i = 1; i < 100000000; i++) {
//     sum += i;
//   }
//   print(sum);
// }
