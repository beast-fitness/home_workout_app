import 'package:flutter/material.dart';
import 'package:full_workout/constants/constants.dart';

import '../../../main.dart';

class FAQPage extends StatelessWidget {
  static const routeName = "FAQ-page";

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    Widget getFAQTile() {
      return Column(
        children: faqList
            .map((faq) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                      child: Material(
                        color: isDark?Colors.grey.shade800:Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              initiallyExpanded: true,
                              title: Text(
                                faq.question,
                                style: textTheme.bodyText1.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 18.0, right: 18, bottom: 18),
                                  child: Text(faq.answer),
                                )
                              ],
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 8,
                    )
                  ],
                ))
            .toList(),
      );
    }

    return Scaffold(
      backgroundColor: isDark?Colors.black:Colors.white,
      appBar: AppBar(
        backgroundColor: isDark?Colors.black:Colors.white,
        title: Text("FAQ",style: TextStyle(color: isDark?Colors.white:Colors.black),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [getFAQTile()],
        ),
      ),
    );
  }
}

class FAQ {
  String question;
  String answer;

  FAQ({this.question, this.answer});
}

List<FAQ> faqList = [
  FAQ(
      question: "What is the home workout app?",
      answer:
      "Home Workouts provides daily workout routines for all your main muscle groups. In just a few minutes a day, you can build muscles and keep fitness at home without having to go to the gym. No equipment or coach needed, all exercises can be performed with just your body weight."),
  FAQ(
      question: "Is it effective to workout at home?",
      answer:
      "Providing you are prepared to put a little time and effort into your workout at home, it can be just as effective as a gym workout. However for others, the prospect of going into a gym is daunting and therefore exercising in the comfort of their own home is much more appealing."),
  FAQ(
      question: "Is home workout no equipment good?",
      answer:
      "While most of us don't have round-the-clock access to a full gym stocked with weights and machines, the truth is that you really can work your entire body without them. Of course, equipment can help and is great for progressing and diversifying a workout program."),
  FAQ(
      question: "What is the 28 day workout challenge?",
      answer:
      "There are 5 exercises in this workout. You'll do each exercise for 30 seconds, rest for 20 seconds and then move onto the next exercise. When you've completed the entire circuit, take a 60-second rest and then repeat the entire circuit again four more times. You do the circuit five times in total."),
  FAQ(
      question: "How long should a beginner workout?",
      answer:
      "Try starting with short workouts that are 30 minutes or less. As you feel your strength building, add a couple more minutes every week. The American Heart Association recommends 75-150 minutes of aerobic activity, as well as two strength-training sessions, per week."),
  FAQ(
      question: "Can you see results from working out in 4 weeks?",
      answer:
      "Surely you've wondered when you will start seeing the results of your workouts: Generally you can expect to notice results after two weeks. Your posture will improve and you'll feel more muscle tone. It takes three to four months for the muscles to grow."),
  FAQ(
      question: "Can you transform your body in 4 weeks?",
      answer:
      "Yes, absolutely! How much of a transformation depends on how restrictive you are with your food and how much effort you put in. It involves a combination of healthy eating, resistance exercise and cardiovascular exercise")
];