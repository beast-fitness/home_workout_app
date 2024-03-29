import 'package:flutter/material.dart';
import '../../helper/sp_helper.dart';
import '../../helper/sp_key_helper.dart';

class Achievement extends StatefulWidget {
  final Function onTap;

  Achievement({required this.onTap});

  @override
  _AchievementState createState() => _AchievementState();
}

class _AchievementState extends State<Achievement> {
  bool isLoading = true;
  SpHelper _spHelper = SpHelper();
  SpKey _spKey = SpKey();
  int time = 0;
  int exercise = 0;
  double calories = 0;

  getData() async {
    setState(() {
      isLoading = true;
    });

    int loadedTime = await _spHelper.loadInt(_spKey.time) ?? 0;
    int loadedExercise = await _spHelper.loadInt(_spKey.exercise) ?? 0;
    calories = loadedTime * (18 / 60);
    time = loadedTime;
    exercise = loadedExercise;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    Widget getAchievementCard(
        int time, int exercise, double calories, bool isLoading) {
      _buildExercise({required String title, required String subtitle}) {
        return Expanded(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              subtitle,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
          ],
        ));
      }

      return Container(
        color: Colors.blue.withOpacity(.5),
        width: size.width,
        child: Stack(
          children: [
            Opacity(
              opacity: .8,
              child: Image.asset(
                "assets/explore_image/img_20.jpg",
                fit: BoxFit.fill,
                width: size.width,
              ),
            ),
            Container(
              color: Colors.black.withOpacity(.6),
            ),
            Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Spacer(),
                Container(

                    //padding: EdgeInsets.only(bottom: 18),

                    child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildExercise(
                        title: "Exercise", subtitle: exercise.toString()),
                    _buildExercise(
                        title: "Minute",
                        subtitle: (time / 60).ceil().toInt().toString()),
                    _buildExercise(
                        title: "Calories",
                        subtitle: calories.ceil().toInt().toString())
                  ],
                )),
                Spacer(),
              ],
            ),
          ],
        ),
      );
    }

    return getAchievementCard(time, exercise, calories, isLoading);
  }
}
