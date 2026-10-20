import 'package:flutter/material.dart';

import '../styles.dart';

class SubjectCard extends StatelessWidget {
  final String title;

  final IconData icon;

  final Color color;

  final Color background;

  const SubjectCard({
    super.key,

    required this.title,

    required this.icon,

    required this.color,

    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.all(11),

      decoration: BoxDecoration(
        color: background,

        borderRadius:
        BorderRadius.circular(12),
      ),

      child: Row(
        children: [
          Icon(
            icon,

            color: color,

            size: 27,
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Text(
              title,

              style: const TextStyle(
                color: AppColor.text,

                fontWeight:
                FontWeight.w700,

                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}