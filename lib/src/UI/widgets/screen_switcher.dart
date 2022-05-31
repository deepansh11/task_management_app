import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_app/src/repo/tasks.dart';
import 'package:sidebarx/sidebarx.dart';

class ScreenSwitcher extends ConsumerWidget {
  const ScreenSwitcher(
      {Key? key, required this.controller, required this.pages})
      : super(key: key);

  final SidebarXController controller;
  final List<Widget> pages;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          switch (controller.selectedIndex) {
            case 0:
              ref.refresh(taskFetchProvider);
              return pages[0];
            case 1:
              return pages[1];
            case 2:
              return pages[2];
            case 3:
              return pages[3];
            case 4:
              return pages[2];
            default:
              return Text(
                'Page Not Found',
                style: theme.textTheme.headline5,
              );
          }
        });
  }
}
