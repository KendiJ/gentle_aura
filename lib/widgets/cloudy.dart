import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class CloudyFeel extends StatefulWidget {
  const CloudyFeel({super.key});

  @override
  State<CloudyFeel> createState() => _CloudyFeelState();
}

class _CloudyFeelState extends State<CloudyFeel>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  double value = 0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final child = Center(
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return ShaderBuilder(
            (context, shader, child) {
              return AnimatedSampler(
                (image, size, canvas) {
                  shader.setFloat(0, size.width);
                  shader.setFloat(1, size.height);
                  shader.setFloat(2, value);

                  value += 0.03;
                  canvas.drawRect(
                    Rect.fromLTWH(0, 0, size.width, size.height),
                    Paint()..shader = shader,
                  );
                },
                child: Container(
                  width: screenSize.width,
                  height: screenSize.height,
                ),
              );
            },
            assetKey: 'shaders/cloudy.frag',
          );
        },
      ),
    );
    return Scaffold(
      body: Stack(
        children: [child, const Center()],
      ),
    );
  }
}
