
import 'package:full_workout/database/workout_list.dart';
import 'package:flutter/material.dart';
import 'package:full_workout/database/workout_plan/four_week_challenges/full_body_challenge.dart';
class ChallengesModel {
  final String title;
  final String imageUrl;
  final String coverImage;
  final String tag;
  final List<List<Workout>> challengeList;

  ChallengesModel({
    required this.title,
    required this.tag,
    required this.imageUrl,
    required this.coverImage,

    required this.challengeList,
  });
}
