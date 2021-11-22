import 'package:flutter/material.dart';
import '../../lib/navi_bar_flutter.dart';
import 'Welcome.dart';
import 'hello.dart';
import 'page_3.dart';
import 'page_4.dart';

void main() {
  runApp(DemoApp());
}

class DemoApp extends StatelessWidget {
  const DemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        /// [NaviBar] uses by default your theme colors
        // theme: ThemeData(
        //     backgroundColor: Colors.red,
        //     primaryColor: Colors.deepOrangeAccent,
        //     scaffoldBackgroundColor: Colors.orangeAccent),
        home: DemoPage(),
      ),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  /// Create a variable for the index and pass it to selectedIndex in [NaviBar]
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Page'),
        leading: Icon(Icons.catching_pokemon),
      ),

      /// Place a [NaviBar] as your bottomNavigationBar.
      bottomNavigationBar: NaviBar(
          type: NaviBarType.basic,
          selectedIndex: _selectedIndex,
          items: items,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          }),

      body: items[_selectedIndex].page,
    );
  }
}

/// Create a list of [NaviBarItem]
/// Optional. [NaviBarItem] lets you change the color of individual icons, their color and background color.
List<NaviBarItem> items = [
  NaviBarItem(icon: Icons.house, label: 'Home', page: Hello()),
  NaviBarItem(icon: Icons.download, label: 'Download', page: Welcome()),
  NaviBarItem(icon: Icons.account_circle, label: 'Account', page: Page3()),
  NaviBarItem(icon: Icons.folder, label: 'Files', page: Page4()),
];
