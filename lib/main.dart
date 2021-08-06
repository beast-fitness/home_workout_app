import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_workout/helper/notification_helper.dart';

import 'package:full_workout/pages/main/report_page/report_page.dart';
import 'package:full_workout/pages/main/report_page/workout_report/workout_detail_report.dart';
import 'package:full_workout/pages/main/setting_page/profile_settings_screen.dart';
import 'package:full_workout/pages/main/setting_page/reminder_screen.dart';
import 'package:full_workout/pages/main/setting_page/setting_screen.dart';
import 'package:full_workout/pages/main/setting_page/sound_settings_page.dart';
import 'package:full_workout/pages/main/weight_report_page/weight_report_detail.dart';
import 'package:full_workout/pages/main_page.dart';
import 'package:full_workout/pages/main/setting_page/faq_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  tz.initializeTimeZones();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  ));

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    NotificationHelper.init(initScheduled: true);
    listenNotification();
  }

  void listenNotification() =>
      NotificationHelper.onNotifications.stream.listen(onClickedNotification);

  onClickedNotification(String payload) => Navigator.of(context).pushNamed("/");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Workout',
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(color: Colors.black),
          backgroundColor: Colors.black,
          primarySwatch: Colors.blue,
          textTheme: textTheme,
          radioTheme: RadioThemeData(
            fillColor:MaterialStateProperty.all(Colors.blue.shade700),
          ),
          switchTheme: SwitchThemeData(thumbColor:MaterialStateProperty.all(Colors.blue.shade100),),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey.shade800,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.blue.shade700)),
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.blue.shade700)),
          )),
      theme: ThemeData(
          primaryColor: Colors.blue.shade700,

          textTheme: textTheme,
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.blue.shade700,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(color: Colors.black),
            //  toolbarTextStyle: TextStyle(color: Colors.black),
              actionsIconTheme: IconThemeData(color: Colors.black)),
          radioTheme: RadioThemeData(
            fillColor: MaterialStateProperty.all(Colors.blue.shade700),
          ),

          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(

                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.transparent)),
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.blue.shade700)),
          )),

      routes: {
        '/': (ctx) => MainPage(),
        ReminderTab.routeName: (ctx) => ReminderTab(),
        FAQPage.routeName: (ctx) => FAQPage(),
        ReportPage.routeName: (ctx) => ReportPage(),
        MainPage.routeName: (ctx) => MainPage(),
        ProfileSettingScreen.routeName: (ctx) => ProfileSettingScreen(),
        SoundSetting.routeName: (ctx) => SoundSetting(),
        WeightReportDetail.routeName: (ctx) => WeightReportDetail(),
        WorkoutDetailReport.routeName: (ctx) => WorkoutDetailReport(),
        SettingPage.routeName: (ctx) => SettingPage()
      },
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
    );
  }
}


var textTheme = TextTheme(
  headline1: GoogleFonts.montserrat(
      fontSize: 97, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.montserrat(
      fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.montserrat(fontSize: 48, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.montserrat(
      fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.montserrat(
      fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.montserrat(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.montserrat(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.montserrat(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.montserrat(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
      color: Colors.blue.shade700),
  caption: GoogleFonts.montserrat(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.montserrat(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);








