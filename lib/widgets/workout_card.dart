import 'package:flutter/material.dart';
import '../../../database/workout_list.dart';
import '../../../helper/sp_helper.dart';
import '../../../pages/workout_page/exercise_list_page.dart';
import 'package:intl/intl.dart';

class WorkoutCard extends StatelessWidget {
  final String title;
  final List<Workout> workoutList;
  final int tagValue;
  final String imaUrl;
  final String tag;
  final int index;

  WorkoutCard({
    required this.title,
    required this.workoutList,
    required this.tagValue,
    required this.imaUrl,
    required this.tag,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    getLastDate() {
      return FutureBuilder(
        future: SpHelper().loadString(tag),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            String date = DateFormat.MMMd()
                .format(DateTime.parse(snapShot.data.toString()));
            return Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text("Last Time : $date",
                  style: TextStyle(
                      color: Colors.white.withOpacity(.8),
                      fontSize: 14,
                      letterSpacing: 1.3,
                      fontWeight: FontWeight.w400)),
            );
          } else
            return Container();
        },
      );
    }

    getDuration(int totalExercise) {
      getIValue() {
        if (totalExercise < 15) {
          return 0;
        } else if (totalExercise < 20) {
          return 1;
        }
        return 2;
      }

      return Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(1),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          width: 30,
          height: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < 3; i++)
                Icon(
                  Icons.circle,
                  size: 7,
                  color: getIValue() < i
                      ? Colors.grey.shade500
                      : Colors.black.withOpacity(.8),
                ),
            ],
          ));
    }

    getDifficulty() {
      return Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(1),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          width: 35,
          height: 18,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < 3; i++)
                Icon(
                  Icons.circle,
                  size: 7,
                  color: tagValue < i
                      ? Colors.grey.shade500
                      : Colors.black.withOpacity(.8),
                ),
            ],
          ));
    }

    getTitle() {
      return Padding(
        padding: const EdgeInsets.only(
          left: 18.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(
              flex: 3,
            ),
            Container(
              child: Text(
                title.toUpperCase(),
                style:TextStyle(

                    color: Colors.white.withOpacity(.9),
                    fontSize: 18,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w600),
              ),
            ),
            getLastDate(),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      "Difficulty",
                      style: TextStyle(
                          color: Colors.white.withOpacity(.8),
                          fontSize: 14,
                          letterSpacing: 1.1),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    getDifficulty()
                  ],
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  children: [
                    Text(
                      "Duration",
                      style: TextStyle(
                          color: Colors.white.withOpacity(.8),
                          fontSize: 14,
                          letterSpacing: 1.1),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    getDuration(workoutList.length)
                  ],
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 10, right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child:  InkWell(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ExerciseListScreen(
                        imgSrc: imaUrl,
                            workOutList: workoutList,
                            tag: tag,
                            title: title,
                            tagValue: tagValue,
                          )),
                );
              },
              child:Container(
                height: 150,
                color: Colors.black54,
                child: Stack(
              children: [
                Image.asset(
                  imaUrl,
                  height: 150,
                  width: width,
                  fit: BoxFit.fill,
                ),
                Container(
                  color: Colors.black.withOpacity(.4),
                ),
                getTitle(),
              ],
                ),
              ),
        ),
      ),
    );
  }
}
