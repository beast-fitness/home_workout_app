import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:full_workout/constants/constant.dart';
import 'package:rate_my_app/rate_my_app.dart';

class RateAppInitWidget extends StatefulWidget {
  final Widget Function(RateMyApp) builder;

  RateAppInitWidget({required this.builder});

  @override
  _RateAppInitWidgetState createState() => _RateAppInitWidgetState();
}

class _RateAppInitWidgetState extends State<RateAppInitWidget> {
  RateMyApp rateMyApp = RateMyApp();
  Constants constants = Constants();
  String comment = "";

  List<Widget> actionsBuilder(BuildContext context, double stars, bool isDark) {
    Widget buildRateButton(double starts) {
      return TextButton(
          onPressed: () async {
            final launchAppStore = stars >= 4;
            final event = RateMyAppEventType.rateButtonPressed;
            await rateMyApp.callEvent(event);
            if (launchAppStore) {
              rateMyApp.launchStore();
            } else {
              Navigator.of(context).pop();
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Rate this App"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      contentPadding: EdgeInsets.all(16),
                      content: TextFormField(
                          maxLines: 5,
                          autofocus: true,
                          decoration: InputDecoration(
                              hintText: 'Write your review....',
                              contentPadding: EdgeInsets.all(8.0),
                              border: OutlineInputBorder()),
                          onChanged: (comment) =>
                              setState(() => this.comment = comment)),
                      actions: [
                        TextButton(
                            onPressed: () async {
                              String toSend = "$comment\n\n";
                              final Email email = Email(
                                body: toSend,
                                subject: 'App Review',
                                recipients: ['workoutfeedback@gmail.com'],
                                isHTML: false,
                              );

                              try {
                                await FlutterEmailSender.send(email);
                              } catch (e) {
                                constants.getToast(
                                    "Thanks for your Feedback", isDark);
                              }
                            },
                            child: Text("Ok")),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancel"),
                        )
                      ],
                    );
                  });
            }
          },
          child: Text("Rate"));
    }

    if (stars == null) {
      return [RateMyAppNoButton(rateMyApp, text: "Later")];
    } else {
      return [
        RateMyAppNoButton(rateMyApp, text: "Later"),
        buildRateButton(stars),
      ];
    }
  }


  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return RateMyAppBuilder(
      rateMyApp: RateMyApp(googlePlayIdentifier: constants.packageName,
      minLaunches: 5,
      remindDays: 2,
      minDays: 5,
        remindLaunches: 10,
      ),
      onInitialized: (context, rateMyApp) {
        setState(() {
          this.rateMyApp = rateMyApp;
        });
        if(rateMyApp.shouldOpenDialog){
          rateMyApp.showStarRateDialog(context,
              title: "Rate this App",
              message: "Do you like this app? Please leave a rating",
              starRatingOptions: StarRatingOptions(initialRating: 0,),
              actionsBuilder: (context, stars) {
                return actionsBuilder(context, stars??0, isDark);
              });
        }
      },
      builder: (context) => rateMyApp == null
          ? Center(child: CircularProgressIndicator())
          : widget.builder(rateMyApp),
    );
  }
}
