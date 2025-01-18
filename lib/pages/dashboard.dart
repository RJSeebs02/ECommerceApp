import 'package:flutter/material.dart';
import '../utils/theme.dart';
import 'home.dart';
import 'labs.dart';
import 'profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  late Future<List<Widget>> _pages;

  @override
  void initState() {
    super.initState();
    _pages = _initializePages();
  }

  Future<List<Widget>> _initializePages() async {
    return <Widget>[
      HomePage(),
      LabsPage(),
      ProfilePage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Widget>>(
        future: _pages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return snapshot.data![_selectedIndex];
          } else {
            return const Center(child: Text('ERROR: No pages found!'));
          }
        },
      ),
      bottomNavigationBar: Container(
        height: 80.0,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.borderColor, width: 1), // Add top border
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.location_city), label: 'Labs'),
            BottomNavigationBarItem(icon: Icon(Icons.person_4), label: 'Profile'),
          ],
          currentIndex: _selectedIndex,
          backgroundColor: AppColors.secondary,
          unselectedItemColor: AppColors.h2,
          selectedItemColor: AppColors.primary,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
