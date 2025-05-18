import 'package:flutter/material.dart';

class SlideUpList extends StatefulWidget {
  final List<Widget> children;
  final Duration itemDelay;
  final Duration animationDuration;
  final double offsetY;
  final bool useListView;

  const SlideUpList({
    super.key,
    required this.children,
    this.itemDelay = const Duration(milliseconds: 100),
    this.animationDuration = const Duration(milliseconds: 600),
    this.offsetY = 40,
    this.useListView = false,
  });

  @override
  State<SlideUpList> createState() => _SlideUpListState();
}

class _SlideUpListState extends State<SlideUpList>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<Offset>> _animations;
  late final List<Animation<double>> _opacities;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(
      widget.children.length,
      (i) => AnimationController(
        vsync: this,
        duration: widget.animationDuration,
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<Offset>(
        begin: Offset(0, widget.offsetY / 100),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    }).toList();

    _opacities = _controllers.map((controller) {
      return Tween<double>(
        begin: 0,
        end: 1,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    }).toList();

    _runAnimations();
  }

  Future<void> _runAnimations() async {
    for (int i = 0; i < _controllers.length; i++) {
      await Future.delayed(widget.itemDelay);
      _controllers[i].forward();
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final children = List.generate(widget.children.length, (i) {
      return SlideTransition(
        position: _animations[i],
        child: FadeTransition(
          opacity: _opacities[i],
          child: widget.children[i],
        ),
      );
    });

    return widget.useListView
        ? ListView(
            padding: const EdgeInsets.all(20),
            children: children,
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          );
  }
}
