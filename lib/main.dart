import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:test_int_kr/bloc/test_bloc.dart';
import 'package:test_int_kr/screen_new_test.dart';
import 'package:test_int_kr/theme.dart';

void main() {
  runApp(ChangeNotifierProvider<ThemeProvider>(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => TestBloc())],
      child: MaterialApp(
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)),
        themeMode: ThemeMode.dark,
        // Provider.of<ThemeProvider>(context).isDarkMode
        //     ? ThemeMode.dark
        //     : ThemeMode.light,
        darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.black)),
        debugShowCheckedModeBanner: false,
        home: ScreenNewTest(),
      ),
    );
  }
}
