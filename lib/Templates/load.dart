import 'package:brew_crew/Templates/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Center loadingWidget() {
  return Center(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: Center(
        child: LoadingAnimationWidget.inkDrop(color: coffeeColor, size: 50),
      ),
    ),
  );
}
