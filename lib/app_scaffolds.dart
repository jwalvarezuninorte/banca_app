import 'package:banca_app/screens/screens.dart';
import 'package:banca_app/backend/services/sqlite_service.dart';
import 'package:banca_app/widgets/base/base.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({
    super.key,
  });

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  late List<Widget> screens = [];

  int selectedIndex = 0;
  late SqliteService _sqliteService;

  @override
  void initState() {
    super.initState();

    _sqliteService = SqliteService();
    _sqliteService.initCreditHistoryDatabase().whenComplete(() async {
      screens = [
        HomeScreen(sqliteService: _sqliteService),
        HistoryScreen(sqliteService: _sqliteService),
      ];

      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(keepPage: true);

    void changeScreen(int index, BuildContext context) {
      selectedIndex = index;
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {});
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onVerticalDragCancel: () => FocusScope.of(context).unfocus(),
        onHorizontalDragCancel: () => FocusScope.of(context).unfocus(),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: screens,
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: selectedIndex,
        onTap: (p0) => changeScreen(p0, context),
      ),
    );
  }
}
