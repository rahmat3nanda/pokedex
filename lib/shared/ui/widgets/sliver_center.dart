import 'package:flutter/material.dart'
    show
        BoxConstraints,
        Matrix4,
        Offset,
        PaintingContext,
        RenderObject,
        SingleChildRenderObjectWidget,
        Widget;
import 'package:flutter/rendering.dart'
    show
        Constraints,
        ParentData,
        RenderObjectWithChildMixin,
        RenderSliver,
        RenderSliverConstrainedCrossAxis,
        SliverConstraints,
        SliverGeometry,
        SliverHitTestResult,
        SliverPhysicalParentData;

class SliverCenter extends SingleChildRenderObjectWidget {
  const SliverCenter({required Widget sliver, super.key})
    : super(child: sliver);

  @override
  RenderSliver createRenderObject(_) => _RenderSliverCenter();
}

class _RenderSliverCenter extends RenderSliver
    with RenderObjectWithChildMixin<RenderSliver> {
  double? horizontalPadding;

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! SliverPhysicalParentData) {
      child.parentData = SliverPhysicalParentData();
    }
  }

  @override
  void performLayout() {
    child!.layout(constraints, parentUsesSize: true);

    final SliverGeometry? childGeometry = child!.geometry;
    if (childGeometry != null) {
      _updateCenterOffset();
      geometry = SliverGeometry(
        scrollExtent: childGeometry.scrollExtent,
        paintExtent: childGeometry.paintExtent,
        maxPaintExtent: childGeometry.maxPaintExtent,
        layoutExtent: childGeometry.layoutExtent,
      );
    }
  }

  void _updateCenterOffset() {
    if (child != null) {
      final ParentData? parentData = child!.parentData;
      if (parentData is SliverPhysicalParentData) {
        final Constraints? parentConstraints = parent?.constraints;
        double? parentSize;
        if (parentConstraints is BoxConstraints) {
          parentSize = parentConstraints.maxWidth;
        } else if (parentConstraints is SliverConstraints) {
          parentSize = parentConstraints.crossAxisExtent;
        }
        if (parentSize != null) {
          final SliverConstraints childConstraints = child!.constraints;
          final double childSize = childConstraints.crossAxisExtent;
          double crossAxisPadding;
          if (child != null && child is RenderSliverConstrainedCrossAxis) {
            final double childMaxExtent =
                (child! as RenderSliverConstrainedCrossAxis).maxExtent;
            crossAxisPadding = childSize - childMaxExtent;
          } else {
            crossAxisPadding = parentSize - childSize;
          }
          horizontalPadding = crossAxisPadding / 2;
          parentData.paintOffset = Offset(horizontalPadding!, 0);
        }
      }
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      final ParentData? parentData = child!.parentData;
      if (parentData is SliverPhysicalParentData) {
        context.paintChild(child!, offset + Offset(horizontalPadding ?? 0, 0));
      }
    }
  }

  @override
  bool hitTest(
    SliverHitTestResult result, {
    required double mainAxisPosition,
    required double crossAxisPosition,
  }) {
    if (child == null || horizontalPadding == null) return false;

    // Adjust crossAxisPosition to the child's coordinate space by
    //subtracting horizontalPadding.
    final double adjustedCrossAxisPosition =
        crossAxisPosition - horizontalPadding!;

    if (adjustedCrossAxisPosition < 0) {
      return false;
    }

    return child!.hitTest(
      result,
      mainAxisPosition: mainAxisPosition,
      crossAxisPosition: adjustedCrossAxisPosition,
    );
  }

  @override
  void applyPaintTransform(RenderObject child, Matrix4 transform) {
    final ParentData? childParentData = child.parentData;
    if (childParentData is SliverPhysicalParentData) {
      childParentData.applyPaintTransform(transform);
    }
  }
}
