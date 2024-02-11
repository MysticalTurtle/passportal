import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  // Headers
  static const TextStyle headline = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    letterSpacing: 1.5,
  );
  static const TextStyle subtitle1 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );
  static const TextStyle subtitle2 = TextStyle(
    fontSize: 12,
    color: AppColors.white,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle subtitle3 = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
  );

  // Body
  static const TextStyle body1 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle body2 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle body3 = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle captionRegular = TextStyle(
    fontSize: 8,
    fontWeight: FontWeight.normal,
  );
}
