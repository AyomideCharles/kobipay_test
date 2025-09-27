import 'dart:async';
import 'package:flutter/material.dart';

class StaggeredFadeIn extends StatefulWidget {
  final Widget child;
  final int index;
  final Duration duration;
  final Duration delayBetween;
  final bool animateOnce;

  const StaggeredFadeIn({
    super.key,
    required this.child,
    required this.index,
    this.duration = const Duration(milliseconds: 500),
    this.delayBetween = const Duration(milliseconds: 200),
    this.animateOnce = true,
  });

  @override
  State<StaggeredFadeIn> createState() => _StaggeredFadeInState();
}

class _StaggeredFadeInState extends State<StaggeredFadeIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  bool _didAnimate = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);

    if (widget.animateOnce) {
      Future.delayed(widget.delayBetween * widget.index, () {
        if (mounted) {
          _ctrl.forward();
          _didAnimate = true;
        }
      });
    } else {
      _ctrl.forward();
    }
  }

  @override
  void didUpdateWidget(covariant StaggeredFadeIn oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.animateOnce || !_didAnimate) {
      _ctrl.forward();
      _didAnimate = true;
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _ctrl,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.08),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut)),
        child: widget.child,
      ),
    );
  }
}
