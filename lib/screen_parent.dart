import 'package:flutter/material.dart';
import 'package:test_int_kr/screen_details.dart';
import 'package:test_int_kr/screen_home.dart';

class ScreenParent extends StatelessWidget {
  ScreenParent({super.key});
  final ValueNotifier<int> _pageNotifier = ValueNotifier<int>(0);
  final List<Widget> _screens = [
    const ScreenHome(),
    const ScreenDetails(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _pageNotifier,
        builder: (context, value, child) => _screens[value],
      ),
      bottomNavigationBar: BottomNavigationBar(pageNotifier: _pageNotifier),
    );
  }
}

// ignore: must_be_immutable
class BottomNavigationBar extends StatelessWidget {
  ValueNotifier<int> pageNotifier;
  BottomNavigationBar({super.key, required this.pageNotifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: pageNotifier,
      builder: (context, value, child) => Container(
        height: 70,
        decoration:
            BoxDecoration(border: Border.all(color: Colors.grey.shade200)),
        child: Row(children: [
          bottomNavigationItem(
              icon: Icons.home,
              label: 'home',
              onTap: () => pageNotifier.value = 0,
              isSelected: pageNotifier.value == 0),
          bottomNavigationItem(
              icon: Icons.cached,
              label: 'Temp',
              onTap: () => pageNotifier.value = 1,
              isSelected: pageNotifier.value == 1)
        ]),
      ),
    );
  }
}

Expanded bottomNavigationItem(
    {required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isSelected = false}) {
  return Expanded(
      child: GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Icon(
          icon,
          color: isSelected ? Colors.black : Colors.grey,
        ),
        Text(
          label,
          style: TextStyle(color: isSelected ? Colors.black : Colors.grey),
        )
      ],
    ),
  ));
}
