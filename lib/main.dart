import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:eattendance/untils/export_file.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //////////////////////////////////////////
  await UserSimplePreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
            // navigatorKey: navigatorKey,
            title: "eAttendance",
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Roboto',
              bottomSheetTheme: const BottomSheetThemeData(
                  backgroundColor: Colors.transparent),
            ),
            getPages: Routes.routes,
            initialRoute: kSplash,
            builder: (context, child) {
              return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: child!);
            });
      },
    );
  }
}
