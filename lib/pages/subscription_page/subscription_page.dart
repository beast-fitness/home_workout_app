import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:full_workout/constants/constant.dart';
import 'package:full_workout/pages/detail_input_page/user_detail_widget/custom_loading_indicator.dart';
import 'package:full_workout/pages/subscription_page/subscription_page_widget/statics_section.dart';
import 'package:full_workout/pages/subscription_page/subscription_page_widget/subscription_faq.dart';
import 'package:full_workout/pages/subscription_page/subscription_page_widget/subscription_hader.dart';
import 'package:full_workout/pages/subscription_page/subscription_page_widget/subsctiption_plan.dart';
import 'package:full_workout/pages/subscription_page/subscription_page_widget/user_review.dart';
import 'package:full_workout/provider/subscription_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/loading_indicator.dart';

class SubscriptionPage extends StatefulWidget {
  SubscriptionPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  void initState() {

    var data = Provider.of<SubscriptionProvider>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((_) =>  data.fetchOffers());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var data = Provider.of<SubscriptionProvider>(context, listen: true);
    Constants constants = Constants();
    buildButton() {
      return Column(
        children: [
          Spacer(),
          Container(
            color: Colors.grey,
            height: .2,
          ),
          Material(
            elevation: 5,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                width: double.infinity,
                height: 65,
                child: ElevatedButton(
                  onPressed: data.isBuyBtnLoading
                      ? null
                      : () => data.onBuyBtnClick(context: context),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2, vertical: 6.5),
                          color: Colors.blue.shade600,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  data.packageList[data.offerIndex].product
                                      .priceString,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "Only : " +
                                      constants.getPerMonthPrice(
                                        product: data
                                            .packageList[data.offerIndex]
                                            .product,
                                      ) +
                                      "/M",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),


                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 12),
                          color: Colors.blue.shade700,
                          child: Center(
                            child:
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "BUY",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Icon(Icons.arrow_forward),

                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      elevation: 0,

                      padding: EdgeInsets.zero),
                )),
          ),
        ],
      );
    }

    buildDivider() {
      return Container(
          padding: EdgeInsets.only(top: 8, bottom: 16),
          child: Constants().getDivider(context: context));
    }

    return  Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Get Premium",
            ),
            actions: [
              data.isLoading?Container():  Padding(
                padding: EdgeInsets.only(right: 8,top: 10,bottom: 10),
                child: OutlinedButton(

                  onPressed: () {
                    data.restoreSubscription(context: context);
                  },
                  child: Row(
                    children: [
                     Text("Restore"),


                    ],
                  ),
                  style:
                      OutlinedButton.styleFrom(primary: Theme.of(context).primaryColor,
                        side: BorderSide(width: 1, color: Colors.blue),),
                ),
              ),
            ],
          ),
          body: data.isLoading
              ? Center(child: CircularProgressIndicator()) : data.packageList.isEmpty?Center(child: Text("Something went wrong..."),)
              : SafeArea(
                  child: Stack(
                    children: [
                      ListView(
                        physics: BouncingScrollPhysics(),
                        children: [

                              SubscriptionHeader(),
                          buildDivider(),

                          SubscriptionPlan(),

                              buildDivider(),

                          UserReview(),
                          SizedBox(
                            height: 28,
                          ),
                          // buildDivider(),
                          // SubscriptionTime(),
                          buildDivider(),

                          SubscriptionFAQ(),

                          StaticsSection(),
                          // SizedBox(height: 280, child: buildFAQ()),
                          SizedBox(
                            height: 60,
                          ),
                        ],
                      ),
                buildButton()
              ],
            ),
          ),
        ),
        if(data.isBuyBtnLoading )CustomLoadingIndicator(msg: "Loading...",)     ],
    );
  }
}