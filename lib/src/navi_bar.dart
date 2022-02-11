import 'package:flutter/material.dart';
import 'navi_bar_item.dart';

class NaviBar extends StatefulWidget {
  const NaviBar({
    Key? key,
    required this.onTap,
    required this.items,
    required this.selectedIndex,
    this.type = NaviBarType.basic,
    this.backgroundColor,
    this.selectedTabColor,
    this.unselectedTabColor,
    this.selectedIconColor,
    this.unselectedIconColor,
    this.selectedIconSize = 32,
    this.unselectedIconSize = 24,
    this.barHeight = 85,
    this.barPadding,
    this.borderRadius,
    this.duration = const Duration(milliseconds: 250),
    this.curve = Curves.linear,
  }) : super(key: key);

  /// Opens the selected tab
  final ValueChanged<int> onTap;

  /// The tabs in a [NaviBar]. Each [NaviBarItem] becomes a tab.
  final List<NaviBarItem> items;

  /// This indicates the selected icon in a [NaviBar].
  /// Defaults to selectedIndex = 0, which selects the first icon from the left.
  final int selectedIndex;

  /// Select the preferred type of [NaviBar].
  /// Defaults to [NaviBarType.basic]
  final NaviBarType type;

  /// Defines the background color.
  /// Defaults to null, [NaviBar] will then use the Theme background color.
  final Color? backgroundColor;

  /// Sets the color for the selected tab.
  /// Defaults to null, [NaviBar] will then use the Theme scaffold background color.
  final Color? selectedTabColor;

  /// Sets the color for the unselected tabs.
  /// Defaults to null. [NaviBar] will then use the Theme background color.
  final Color? unselectedTabColor;

  /// Sets the color for the selected icon.
  /// Defaults to null. [NaviBar] will then use the Theme background color.
  final Color? selectedIconColor;

  /// Sets color for the unselected icons.
  /// Defaults to null.
  final Color? unselectedIconColor;

  /// The size of the selected icon.
  /// Defaults to 32.
  final double selectedIconSize;

  /// The size of the unselected icons.
  /// Defaults to 24.
  final double unselectedIconSize;

  /// This determines the height of a [NaviBar].
  /// Defaults to 85.
  final double? barHeight;

  /// Sets the padding of a [NaviBar].
  /// Defaults to null.
  final EdgeInsets? barPadding;

  /// The border radius of a [NaviBar].
  /// Defaults to null.
  final BorderRadius? borderRadius;

  /// Defines the duration of the animation.
  /// Defaults to 250 milliseconds.
  final Duration duration;

  /// Sets the animation curve. Defaults to Curves.linear.
  final Curve curve;

  @override
  _NaviBarState createState() => _NaviBarState();
}

class _NaviBarState extends State<NaviBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<Color?>? _animationColor;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationColor = ColorTween(
            begin:
                widget.unselectedTabColor ?? Theme.of(context).backgroundColor,
            end: widget.selectedTabColor ??
                Theme.of(context).scaffoldBackgroundColor)
        .animate(_controller);

    final Animation<double> _animationDouble =
        CurvedAnimation(parent: _controller, curve: widget.curve);

    final EdgeInsets barPadding;
    final BorderRadius borderRadius;

    switch (widget.type) {
      case NaviBarType.basic:
        barPadding = const EdgeInsets.all(0);
        borderRadius = const BorderRadius.all(Radius.zero);
        break;
      case NaviBarType.rounded:
        barPadding = const EdgeInsets.all(15);
        borderRadius = const BorderRadius.all(Radius.circular(45));
        break;
    }

    return Container(
      decoration: BoxDecoration(
          borderRadius: widget.borderRadius ?? borderRadius,
          color: widget.backgroundColor ?? Theme.of(context).backgroundColor),
      margin: widget.barPadding ?? barPadding,
      width: double.infinity,
      height: widget.barHeight,
      clipBehavior: Clip.hardEdge,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (final item in widget.items)
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor:
                    widget.backgroundColor ?? Theme.of(context).primaryColor,
                hoverColor:
                    widget.backgroundColor ?? Theme.of(context).primaryColor,
                onTap: () {
                  _controller.reset();
                  _controller.forward();
                  widget.onTap(widget.items.indexOf(item));
                },
                child: TweenAnimationBuilder<double>(
                    tween: Tween(
                        begin: 0,
                        end: widget.items.indexOf(item) == widget.selectedIndex
                            ? 25 / widget.items.length
                            : 2),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          itemIcon(item, _animationDouble, context),
                          itemLabel(item, context),
                        ],
                      ),
                    ),
                    duration: widget.duration,
                    curve: widget.curve,
                    builder: (context, value, child) {
                      return AnimatedBuilder(
                          animation: _animationColor ??
                              CurvedAnimation(
                                  curve: widget.curve, parent: _controller),
                          builder: (BuildContext _, Widget? childWidget) {
                            return Container(
                              constraints: BoxConstraints(
                                maxHeight: widget.barHeight!,
                              ),
                              alignment: Alignment.center,
                              padding: widget.type == NaviBarType.basic
                                  ? widget.items.indexOf(item) ==
                                          widget.selectedIndex
                                      ? EdgeInsets.only(
                                          bottom: widget.items.length <= 3
                                              ? value * 2
                                              : value * 5)
                                      : EdgeInsets.all(0)
                                  : EdgeInsets.all(0),
                              child: child,
                              height: widget.barHeight!,
                              width: width(item, context, barPadding),
                              decoration: BoxDecoration(
                                color: backgroundColor(item),
                              ),
                            );
                          });
                    }),
              ),
            )
        ],
      ),
    );
  }

  /// This method displays the label of each [item] in a [NaviBar]
  Text itemLabel(NaviBarItem item, BuildContext context) {
    return Text(
      widget.items.indexOf(item) == widget.selectedIndex
          ? item.label ?? ''
          : '',
      style: TextStyle(
          color: item.selectedIconColor ??
              widget.selectedIconColor ??
              Theme.of(context).backgroundColor,
          fontWeight: FontWeight.w600,
          height: 0.9),
      textAlign: TextAlign.center,
      maxLines: 1,
    );
  }

  /// This method displays the icon of each [item] in a [NaviBar]
  Widget itemIcon(NaviBarItem item, Animation<double> _animationDouble,
      BuildContext context) {
    return widget.items.indexOf(item) == widget.selectedIndex
        ? ScaleTransition(
            scale: _animationDouble,
            child: Icon(item.activeIcon ?? item.icon,
                color: item.selectedIconColor ??
                    widget.selectedIconColor ??
                    Theme.of(context).backgroundColor,
                size: widget.selectedIconSize),
          )
        : Icon(item.icon,
            color: item.unselectedIconColor ??
                widget.unselectedIconColor ??
                Theme.of(context).primaryColor,
            size: widget.unselectedIconSize);
  }

  /// This method determines the background color of each [item] of a [NaviBar]
  Color? backgroundColor(NaviBarItem item) {
    return widget.items.indexOf(item) == widget.selectedIndex
        ? item.selectedBackgroundColor ?? _animationColor?.value
        : (item.unselectedBackgroundColor ??
            widget.unselectedTabColor ??
            widget.backgroundColor);
  }

  /// This method calculates the width of each [item] of a [NaviBar] based on the number of [items]
  double width(NaviBarItem item, BuildContext context, EdgeInsets barPadding) {
    return widget.items.indexOf(item) == widget.selectedIndex
        ? 175 * _controller.value
        : (MediaQuery.of(context).size.width -
                (widget.barPadding?.horizontal ?? barPadding.horizontal) -
                175) /
            (widget.items.length - 1);
  }
}

/// The different types of [NaviBar]
enum NaviBarType {
  basic,
  rounded,
}
