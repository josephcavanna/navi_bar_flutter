import 'package:flutter/material.dart';
import 'package:navi_bar_flutter/navi_bar_flutter.dart';

/// an item that is displayed as a tab in a [NaviBar]
class NaviBarItem {
  NaviBarItem({
    required this.icon,
    required this.page,
    this.label,
    this.selectedBackgroundColor,
    this.unselectedBackgroundColor,
    this.selectedIconColor,
    this.unselectedIconColor,
    this.activeIcon,
  });

  /// Icon to be displayed.
  final IconData icon;

  /// The page that appears when tab is selected.
  final dynamic page;

  /// Optional. The label to be displayed when the tab is selected.
  final String? label;

  /// Optional. Sets a custom background color when a tab is selected.
  final Color? selectedBackgroundColor;

  /// Optional. Sets a custom background color when a tab is not selected.
  final Color? unselectedBackgroundColor;

  /// Optional. Sets a custom icon and label color when a tab is selected.
  final Color? selectedIconColor;

  /// Optional. Sets a custom icon and label color when a tab is not selected.
  final Color? unselectedIconColor;

  /// Optional. Changes the icon of the selected tab.
  final IconData? activeIcon;
}

