import 'package:flutter/material.dart';

class SlideUpOnLoad extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double offsetY;

  const SlideUpOnLoad({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.offsetY = 40.0,
  });

  @override
  State<SlideUpOnLoad> createState() => _SlideUpOnLoadState();
}

class _SlideUpOnLoadState extends State<SlideUpOnLoad>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, widget.offsetY / 500),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: widget.child,
      ),
    );
  }
}
