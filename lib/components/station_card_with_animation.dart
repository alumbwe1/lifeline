import 'package:flutter/material.dart';

class StationCardWithAnimation extends StatefulWidget {
  final VoidCallback onTap;
  final Widget content;

  const StationCardWithAnimation({
    required this.onTap,
    required this.content,
  });

  @override
  _StationCardWithAnimationState createState() =>
      _StationCardWithAnimationState();
}

class _StationCardWithAnimationState extends State<StationCardWithAnimation> {
  bool isCardHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            isCardHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            isCardHovered = false;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: isCardHovered ? Colors.grey[200] : Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: isCardHovered ? Colors.grey[300]! : Colors.transparent,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: widget.content,
        ),
      ),
    );
  }
}
