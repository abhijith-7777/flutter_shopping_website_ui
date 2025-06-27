import 'dart:math';
import 'package:flutter/material.dart';

class HeartBurstAnimation extends StatelessWidget {
  final Animation<double> animation;
  final bool show;

  const HeartBurstAnimation({
    super.key,
    required this.animation,
    required this.show,
  });

  @override
  Widget build(BuildContext context) {
    if (!show) return const SizedBox.shrink();
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          final progress = animation.value;
          return Stack(
            children: List.generate(6, (i) {
              final angle = pi / 3 * i;
              final dx = cos(angle) * 0 * progress;
              final dy = sin(angle) * 20 * progress;
              return Positioned(
                top: 8 + dy,
                right: 8 + dx,
                child: Opacity(
                  opacity: 1 - progress,
                  child: Text(
                    "❤️",
                    style: TextStyle(fontSize: 24 + 16 * (1 - progress)),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
