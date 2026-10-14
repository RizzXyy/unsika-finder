import 'package:flutter/material.dart';
import '../widgets/bottom_navbar.dart';
import 'dashboard_screen.dart';
import 'history_screen.dart';
import 'profile_screen.dart';
import 'report_screen.dart';

/// Layar utama: menampung navbar bawah dan berpindah antar halaman.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;

  void _goTo(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: _index,
        children: [
          DashboardScreen(onReport: () => _goTo(1)),
          ReportScreen(onBack: () => _goTo(0)),
          HistoryScreen(onBack: () => _goTo(0)),
          ProfileScreen(onOpenHistory: () => _goTo(2)),
        ],
      ),
      bottomNavigationBar: BottomNavbar(currentIndex: _index, onTap: _goTo),
    );
  }
}