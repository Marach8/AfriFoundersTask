import 'package:flutter/material.dart';

class AfriSliverHeader extends SliverPersistentHeaderDelegate {
  final Widget child;
  final bool rebuild;
  final double minExt, maxExt;

  AfriSliverHeader({
    required this.child,
    required this.maxExt,
    required this.minExt,
    required this.rebuild
  });

  @override
  double get minExtent => minExt;

  @override
  double get maxExtent => maxExt;

  @override
  Widget build(_, __, ___) => child;

  @override
  bool shouldRebuild(_) => rebuild;
}
