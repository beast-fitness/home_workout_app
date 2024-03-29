import 'package:flutter/material.dart';
import 'package:full_workout/provider/connectivity_provider.dart';
import 'package:provider/provider.dart';

import '../../../../provider/ads_provider.dart';
import '../../../../widgets/dialogs/connectivity_error_dialog.dart';
import '../../../subscription_page/subscription_page.dart';

class GetPrimeBottomSheet extends StatefulWidget {
  final String spKey;

  const GetPrimeBottomSheet({Key? key, required this.spKey}) : super(key: key);

  @override
  State<GetPrimeBottomSheet> createState() => _GetPrimeBottomSheetState();
}

class _GetPrimeBottomSheetState extends State<GetPrimeBottomSheet> {
  @override
  void initState() {
    Provider.of<AdsProvider>(context, listen: false).isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdsProvider>(builder: (context, provider, _) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: Material(
          color: Theme.of(context).cardColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(left: 25),
                    height: 50,
                    width: 50,
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.passthrough,
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          child: Icon(
                            Icons.ondemand_video_sharp,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                              color: Theme.of(context).primaryColor),
                        ),
                        Positioned(
                            bottom: -2,
                            right: -2,
                            child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black),
                                child: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                  size: 12,
                                )))
                      ],
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      child: Icon(Icons.close),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 28,
              ),
              Center(
                child: Text(
                  "Unlock Premium Workout".toUpperCase(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
              ),
              SizedBox(
                height: 22,
              ),
              if (provider.loadingError)
                Center(
                  child: Text(
                    "Fail to load reward  🙃",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              SizedBox(
                height: 28,
              ),
              Container(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await provider.createRewardAd(
                          context: context, key: widget.spKey);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                        backgroundColor: Theme.of(context).primaryColor),
                    icon: provider.isLoading
                        ? Container(
                            height: 25,
                            width: 25,
                            margin: EdgeInsets.only(right: 8),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Icon(
                            Icons.video_collection_outlined,
                          ),
                    label: provider.isLoading
                        ? Text("Loading...")
                        : Text("Watch AD"),
                  )),
              Container(
                padding: EdgeInsets.symmetric(vertical: 24,horizontal: 18),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      color: Colors.grey.withOpacity(.4),
                      height: 1,
                    )),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "OR",
                      style: TextStyle(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(.6)),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: Container(
                      color: Colors.grey.withOpacity(.4),
                      height: 1,
                    )),
                  ],
                ),
              ),
              Container(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(

                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.amberAccent                  ,    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
                    onPressed: () async {
                      bool isConnected =
                          await Provider.of<ConnectivityProvider>(context,
                                  listen: false)
                              .isNetworkConnected;
                      if (isConnected) {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return SubscriptionPage(showCrossButton: false,);
                        }));
                      } else {
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (context) => ConnectivityErrorDialog());
                      }
                    },
                    label: Text(
                      "Get Prime",
                      style: TextStyle(color: Colors.black),
                    ),
                    icon: Image.asset(
                      "assets/other/prime_icon.png",
                      height: 28,
                      color: Colors.black87,
                    ),
                  )),
              SizedBox(
                height: 44,
              ),
              Text(
                "With a premium workout subscription, you will be able to reach your fitness goals in less time. You will have access to 50+ workout plans with the premium subscription.",
                style: TextStyle(
                    fontSize: 13.5,
                    letterSpacing: 1.2,
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(.6)),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 18,
              ),
            ],
          ),
        ),
      );
    });
  }
}
