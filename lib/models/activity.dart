import 'package:flutter/material.dart';

class Activity {
  final String title;

  final String subject;

  final int questions;

  final IconData icon;

  final Color color;

  const Activity({
    required this.title,
    required this.subject,
    required this.questions,
    required this.icon,
    required this.color,
  });
}