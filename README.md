# navi_bar_flutter

A customizable bottom navigation bar using simple animations and theme colors that comes with a couple of presets.

![NaviBar example](https://github.com/josephcavanna/navi_bar_flutter/blob/main/gif/navibar.gif)

### Add dependency
```yaml
dependencies: 
  navi_bar_flutter: ^1.0.6 #latest version
```

### How to use

Place a [NaviBar] as your bottomNavigationBar.

```
...
        bottomNavigationBar: NaviBar(
          type: NaviBarType.rounded,
          selectedIndex: _selectedIndex,
          items: items,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
        )
```

### NaviBar Attributes

'onTap': Function handling tap on items\
'items': List of NaviBarItems\
'selectedIndex': Index of NaviBar. Indicates the selected icon\
'type': Select a type of NaviBar. Defaults to NaviBarType.basic\
'backgroundColor': Background color of NaviBar. Defaults to null & NaviBar sets the theme background color\
'selectedTabColor': Color for the selected tab. Defaults to null & NaviBar sets the theme scaffold background color\
'unselectedTabColor' Color for unselected tabs. Defaults to null & NaviBar sets the theme background color\
'selectedIconColor': Color for the selected icon. Defaults to null & NaviBar sets the theme background color\
'unselectedIconColor': Color for unselected icons. Defaults to null & NaviBar sets the theme primary color\
'selectedIconSize': The size of the selected icon. Defaults to 32\
'unselectedIconSize': The size of unselected icons. Defaults to 24\
'barHeight': The height of NaviBar. Defaults to 85\
'barPadding': The padding of NaviBar. Default to EdgeInsets.all(0)\
'borderRadius': The border radius of NaviBar. Defaults to BorderRadius.all(Radius.zero)\
'duration': The duration of the animation. Defaults to 250 milliseconds\
'curve': The animation curve. Defaults to Curves.linear\

### NaviBarItem Attributes

'icon': The icon to be displayed\
'page': The page that appears when tab is selected\
'label': The label that is displayed when tab is selected\
'selectedBackgroundColor': Sets a custom background color when tab is selected\
'unselectedBackgroundColor': Sets a custom background color when tab is not selected\
'selectedIconColor': Sets a custom icon and label color when tab is selected\
'unselectedIconColor': Sets a custom icon and label color when tab is not selected\
'activeIcon': Changes the icon of the tab when selected\
