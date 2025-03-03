import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'showcase.dart'; // Redirects to ShowcasePage
import 'messaging.dart';
import 'upcoming.dart';
import 'notification.dart';
import 'shopping.dart';
import 'profile.dart';
import 'whatsnew.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  @override
  _HomePageState createState() => _HomePageState();
}
  
class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  int _selectedIndex = 0;
  final List<Widget> _pages = [];
  
  // Define colors for consistency
  final Color primaryGreen = const Color(0xFF2E7D32); // Deeper green
  final Color secondaryGreen = const Color(0xFF43A047); // Medium green
  final Color lightGreen = const Color(0xFFE8F5E9); // Light green background
  final Color accentGreen = const Color(0xFF81C784); // Accent green
  
  @override
  void initState() {
    super.initState();
    _pages.add(_buildHomeContent());
    _pages.add(const ShoppingPage());
    _pages.add(const ProfilePage());
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  
  Widget _buildHomeContent() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            primaryGreen.withOpacity(0.1),
            Colors.white,
            Colors.white,
          ],
          stops: const [0.0, 0.4, 1.0],
        ),
      ),
      child: RefreshIndicator(
        color: primaryGreen,
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildAppBar(),
                _buildMainContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildAppBar() {
    // Using a single RichText for "Hello, User" to reduce spacing
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            primaryGreen.withOpacity(0.2),
            Colors.white.withOpacity(0.9),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Hello, ',
                  style: GoogleFonts.outfit(
                    fontSize: 28,
                    color: const Color.fromARGB(255, 13, 2, 2),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: 'User',
                  style: GoogleFonts.outfit(
                    fontSize: 28,
                    color: const Color.fromARGB(255, 12, 42, 10),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          _buildActionButtons(),
        ],
      ),
    );
  }
  
  Widget _buildActionButtons() {
    return Row(
      children: <Widget>[
        _buildIconButton(
          icon: Icons.notifications_outlined,
          badgeCount: 3,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotificationPage()),
          ),
        ),
        const SizedBox(width: 16),
        _buildIconButton(
          icon: Icons.message_outlined,
          badgeCount: 2,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MessagingPage()),
          ),
        ),
      ],
    );
  }
  
  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onPressed,
    int badgeCount = 0,
  }) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(icon, color: primaryGreen, size: 28),
            onPressed: onPressed,
          ),
        ),
        if (badgeCount > 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.red[600],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
              child: Text(
                badgeCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
  
  Widget _buildMainContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 32),
          _buildQuickActionsGrid(),
          const SizedBox(height: 32),
          _buildWhatsNewSection(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
  
  Widget _buildQuickActionsGrid() {
    final List<QuickAction> actions = [
      QuickAction(
        icon: Icons.auto_awesome,
        label: 'Showcase',
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ShowcasePage()),
        ),
      ),
      QuickAction(
        icon: Icons.calendar_today_outlined,
        label: 'Upcoming',
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UpcomingPage()),
        ),
      ),
    ];
  
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: actions.map((QuickAction action) => _buildQuickNavCard(action)).toList(),
    );
  }
  
  Widget _buildQuickNavCard(QuickAction action) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: action.onPressed,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: primaryGreen.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: primaryGreen.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  action.icon,
                  color: primaryGreen,
                  size: 28,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                action.label,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildWhatsNewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "What's New?",
              style: GoogleFonts.outfit(
                fontSize: 26,
                color: primaryGreen,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WhatsNewPage()),
                );
              },
              child: Text(
                'See All',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: secondaryGreen,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Add news items here
      ],
    );
  }
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  Widget buildDashboard(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        height: 70.0,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: primaryGreen.withOpacity(0.2), width: 1),
          ),
          boxShadow: [
            BoxShadow(color: primaryGreen.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5)),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 26),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.storefront_outlined, size: 26),
              label: 'Shop',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 26),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey[500],
          selectedItemColor: primaryGreen,
          selectedLabelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
          unselectedLabelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return buildDashboard(context);
  }
}
  
class QuickAction {
  QuickAction({required this.icon, required this.label, required this.onPressed});
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
}
