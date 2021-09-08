import 'package:flutter/material.dart';

class PersistentBottomBarScaffold extends StatefulWidget {
  /// pass the required items for the tabs and BottomNavigationBar
  final List<PersistentTabItem> items;

  const PersistentBottomBarScaffold({Key? key, required this.items})
      : super(key: key);

  @override
  _PersistentBottomBarScaffoldState createState() =>
      _PersistentBottomBarScaffoldState();
}

class _PersistentBottomBarScaffoldState
    extends State<PersistentBottomBarScaffold> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Using indexedStack to maintain the order of the tabs and the state of the
      /// previously opened tab
      body: IndexedStack(
        index: _selectedTab,
        children: widget.items
            .map((page) => Navigator(
                  /// Each tab is wrapped in a Navigator so that naigation in
                  /// one tab can be independent of the other tabs
                  key: page.navigatorkey,
                  onGenerateInitialRoutes: (navigator, initialRoute) {
                    return [MaterialPageRoute(builder: (context) => page.tab)];
                  },
                ))
            .toList(),
      ),

      /// Define the persistent bottom bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        items: widget.items
            .map((item) => BottomNavigationBarItem(
                icon: Icon(item.icon), label: item.title))
            .toList(),
      ),
    );
  }
}

/// Model class that holds the tab info for the [PersistentBottomBarScaffold]
class PersistentTabItem {
  final Widget tab;
  final Key? navigatorkey;
  final String title;
  final IconData icon;

  PersistentTabItem(
      {required this.tab,
      this.navigatorkey,
      required this.title,
      required this.icon});
}
