import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/info_button.dart';
import '../../database/workout_list.dart';
import '../../pages/services/youtube_service/youtube_player.dart';

class WorkoutDetailDialog extends StatefulWidget {
  final List<Workout> workoutList;
  final int index;

  const WorkoutDetailDialog(
      {super.key, required this.workoutList, required this.index});

  @override
  WorkoutDetailDialogState createState() => WorkoutDetailDialogState();
}

class WorkoutDetailDialogState extends State<WorkoutDetailDialog> {
  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: widget.index);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    int currPage = widget.index;

    var item = widget.workoutList;

    onLeftAction(StateSetter setState) {
      if (currPage > 0) {
        setState(() {
          currPage--;
        });
        controller.animateToPage(currPage,
            duration: Duration(milliseconds: 500), curve: Curves.decelerate);
      }
    }

    onRightAction(StateSetter setState) {
      if (currPage < item.length - 1) {
        setState(() {
          currPage++;
        });
        controller.animateToPage(currPage,
            duration: Duration(milliseconds: 500), curve: Curves.decelerate);
      }
    }

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, true);
        return Future.value(true);
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(
            horizontal: width * .07, vertical: height * .13),
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        child: PageView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: item.length,
                            controller: controller,
                            itemBuilder: (context, index) {
                              currPage = index;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        color: Colors.white,
                                        height: height * .2,
                                        child: Center(
                                          child: Image.asset(
                                            item[index].imageSrc,
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          right: 10,
                                          top: 10,
                                          child: InfoButton(
                                              bgColor: Theme.of(context).primaryColor,
                                              fgColor: Colors.white,
                                              tooltip: "Video",
                                              icon: Icons.ondemand_video,
                                              onPress: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          YoutubeTutorial(
                                                            workout: widget.workoutList[
                                                            currPage],
                                                          ),
                                                    ));
                                              })),
                                    ],
                                  ),
                                  Container(
                                    height: 1.5,
                                    color: Theme.of(context).dividerColor,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 10, left: 16, bottom: 4),
                                    child: Text(
                                      item[index].title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 16, right: 16, top: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Theme.of(context).cardColor,
                                    ),
                                    height: height * .32,
                                    child: ListView.separated(
                                      physics: BouncingScrollPhysics(),
                                      padding: EdgeInsets.only(bottom: 8),
                                      itemCount: item[index].steps.length,
                                      itemBuilder: (ctx, i) {
                                        return Text.rich(TextSpan(
                                            text: "Step ${i + 1}: ",
                                            style: TextStyle(
                                              fontSize: 14,
                                              letterSpacing: 1.2,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            children: <InlineSpan>[
                                              TextSpan(
                                                  text: item[index].steps[i],
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                            ]));
                                      },
                                      separatorBuilder: (context, index) {
                                        return Divider(
                                          height: 16,
                                          thickness: .0,
                                        );
                                      },
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Spacer(),
                                      TextButton(
                                        child: Text("Close"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(16),
                              bottomLeft: Radius.circular(16))),
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                onLeftAction(setState);
                              },
                              icon: Icon(
                                FontAwesomeIcons.backwardStep,
                                color: (currPage > 0)
                                    ? Colors.white
                                    : Colors.grey.shade300.withOpacity(.5),
                              )),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${currPage + 1} / ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "${item.length}",
                                style:
                                TextStyle(color: Colors.white, fontSize: 16),
                              )
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                onRightAction(setState);
                              },
                              icon: Icon(
                                FontAwesomeIcons.forwardStep,
                                color: (currPage < item.length - 1)
                                    ? Colors.white
                                    : Colors.grey.shade300.withOpacity(.5),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
