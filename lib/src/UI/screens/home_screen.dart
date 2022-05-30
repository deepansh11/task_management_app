import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:sample_app/src/UI/screens/mqtt_test.dart';
import 'package:sample_app/src/UI/screens/settings_screen.dart';
import 'package:sample_app/src/UI/screens/task_reports.dart';
import 'package:sample_app/src/UI/screens/task_created.dart';
import 'package:sample_app/src/UI/widgets/screen_switcher.dart';
import 'package:sample_app/src/repo/provider.dart';
import 'package:sample_app/src/repo/tasks.dart';
import 'package:sample_app/src/utils/sidebar_theme.dart';
import 'package:sidebarx/sidebarx.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late int _selectedIndex;
  late SidebarXController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = 0;
    controller = SidebarXController(selectedIndex: _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = const [
      DataSubmitted(),
      TaskCard(),
      MqttClientData(),
      SettingScreen(),
    ];

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Workstation-1',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
        body: Row(
          children: [
            SidebarX(
              controller: controller,
              theme: SideBarTheme.sideBarTheme,
              extendedTheme: SideBarTheme.extendedTheme,
              footerDivider: SideBarTheme.divider,
              headerBuilder: (context, extended) {
                return SizedBox(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      extended ? 'Task Management System' : 'TMS',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
              items: const [
                SidebarXItem(
                  label: 'Task List',
                  icon: Icons.task,
                ),
                SidebarXItem(
                  label: 'Create Task',
                  icon: Icons.add,
                ),
                SidebarXItem(
                  label: 'Porter Reports',
                  icon: Icons.person_pin_rounded,
                ),
                SidebarXItem(
                  label: 'Settings',
                  icon: Icons.settings,
                ),
                SidebarXItem(
                  label: 'Live Map',
                  icon: Icons.location_on,
                )
              ],
            ),
            Expanded(
                child: Center(
              child: ScreenSwitcher(
                controller: controller,
                pages: _pages,
              ),
            ))
          ],
        )
        // bottomNavigationBar: Container(
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     boxShadow: [
        //       BoxShadow(
        //         blurRadius: 20,
        //         color: Colors.black.withOpacity(.1),
        //       )
        //     ],
        //   ),
        //   child: SafeArea(
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        //       child: GNav(
        //         rippleColor: Colors.grey[300]!,
        //         hoverColor: Colors.grey[100]!,
        //         gap: 8,
        //         activeColor: Colors.black,
        //         iconSize: 24,
        //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        //         duration: const Duration(milliseconds: 400),
        //         tabBackgroundColor: Colors.grey[100]!,
        //         color: Colors.black,
        //         tabs: const [
        //           GButton(
        //             icon: Icons.home,
        //             text: 'Home',
        //           ),
        //           GButton(
        //             icon: Icons.menu_book_sharp,
        //             text: 'Create Task',
        //           ),
        //           GButton(
        //             icon: Icons.person,
        //             text: 'Profile',
        //           ),
        //         ],
        //         selectedIndex: _selectedIndex,
        //         onTabChange: (index) {
        //           setState(() {
        //             _selectedIndex = index;
        //           });

        //           if (index == 0) {
        //             ref.refresh(taskFetchProvider);
        //           }
        //         },
        //       ),
        //     ),
        //   ),
        // ),
        );
  }
}
