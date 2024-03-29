import 'package:flutter/material.dart';
import '../../../../database/workout_list.dart';
import '../../../../helper/recent_workout_db_helper.dart';
import 'package:intl/intl.dart';

class WeeklyWorkoutReport extends StatefulWidget {
  final Function onTap;
  final bool showToday;
  WeeklyWorkoutReport({required this.onTap, required this.showToday});
  @override
  _WeeklyWorkoutReportState createState() => _WeeklyWorkoutReportState();
}

class _WeeklyWorkoutReportState extends State<WeeklyWorkoutReport> {
  RecentDatabaseHelper recentDatabaseHelper = RecentDatabaseHelper();

  List<Workout> workoutList = [];
  List<ActiveDay> activeDayList = [];
  late DateTime startDate;

  late DateTime endDate;

  _getWorkDoneList() async {
    int daySelected = 7;
    int today = DateTime.now().weekday;
    DateTime startDate = (today - daySelected) >= 0
        ? DateTime.now().subtract(Duration(days: today - daySelected))
        : DateTime.now()
            .add(Duration(days: daySelected - today))
            .subtract(Duration(days: 7));
    DateTime endDate = startDate.add(Duration(days: 7));

    DateTime parsedStartDate =
        DateTime(startDate.year, startDate.month, startDate.day - 1);
    DateTime parsedEndDate =
        DateTime(endDate.year, endDate.month, endDate.day - 1);

    List items =
        await recentDatabaseHelper.getRangeData(parsedStartDate, parsedEndDate);

    for (int i = 0; i < 7; i++) {
      bool value = false;
      for (int j = 0; j < items.length; j++) {
        DateTime parsedDate = DateTime.parse(items[j]["date"]);
        DateTime currDate = startDate.add(Duration(days: i));
        print(parsedDate.day.toString() + " : " + currDate.day.toString());
        if (parsedDate.day == currDate.day &&
            parsedDate.month == currDate.month) {
          value = true;
          break;
        }
      }
      activeDayList.add(ActiveDay(
          index: i, isDone: value, date: startDate.add(Duration(days: i))));
    }
    setState(() {});
    for (int i = 0; i < 7; i++) {
      print(activeDayList[i].isDone.toString() +
          "  " +
          activeDayList[i].index.toString());
    }
  }

  @override
  void initState() {
    _getWorkDoneList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getWeeklyUpdate() {
      return InkWell(
        onTap: () => widget.onTap(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: activeDayList
              .map((activeDay) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Text(
                          DateFormat('EEEE').format(activeDay.date)[0],
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CircleAvatar(
                            backgroundColor:
                                Theme.of(context).primaryColor.withOpacity(.8),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 12,
                              child: (widget.showToday &&
                                      activeDay.date.day == DateTime.now().day)
                                  ? CircleAvatar(
                                      radius: 6,
                                      backgroundColor:
                                          Colors.blue.shade700.withOpacity(.6),
                                    )
                                  : CircleAvatar(
                                      radius: 6,
                                      backgroundColor: activeDay.isDone
                                          ? Colors.blue.shade700.withOpacity(.6)
                                          : Colors.white,
                                    ),
                            ),
                            radius: 15),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          activeDay.date.day.toString(),
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      );
    }

    return Container(
      child: getWeeklyUpdate(),
    );
  }
}

class ActiveDay {
  int index;
  bool isDone;
  DateTime date;

  ActiveDay({required this.index, required this.isDone, required this.date});
}
