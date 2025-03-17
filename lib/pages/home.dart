import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'compete.dart'; // Redirects to ShowcasePage
import 'messaging.dart';
import 'upcoming.dart';
import 'notification.dart';
import 'shopping.dart';
import 'profile.dart';
import 'whatsnew.dart';
import 'customize.dart'; // Redirects to CustomizePage
import '../auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final AuthService authService = AuthService();

  String _firstname = ''; // Default username
  
  // Define colors for consistency
  final Color primaryGreen = const Color(0xFF207008); // Deeper green
  final Color secondaryGreen = const Color(0xFF46C221); // Medium green
  final Color lightGreen = const Color(0xFFE8F5E9); // Light green background
  final Color accentGreen = const Color(0xFF78F951); // Accent green

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();

    // Force a UI update after a short delay
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {});
      }
    });

    _pages.add(_buildHomeContent());
    _pages.add(const ShoppingPage());
    _pages.add(const ProfilePage());
  }




  void _fetchUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          final fetchedFirstname = userDoc['first_name'] ?? 'No username';// Debugging

          setState(() {
            _firstname = fetchedFirstname;// Debugging
          });
        } else {
          print('User document does not exist');
        }
      } catch (e) {
        print('Error fetching user details: $e');
      }
    }
  }




  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  
  Widget _buildHomeContent() {
    return Container(
      decoration: BoxDecoration(
        // Using a subtle gradient background
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [lightGreen, Colors.white],
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
                Builder( // ✅ This ensures it updates when _username changes
                  builder: (context) { // Debugging
                    return _buildAppBar();
                  },
                ),
                _buildMainContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
          )
        ],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Row with Back Button + Greeting
              Row(
                children: [
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primaryGreen.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person_outline,
                      color: primaryGreen,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Hello, ',
                          style: GoogleFonts.outfit(
                            fontSize: 24,
                            color: const Color.fromARGB(255, 13, 2, 2),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: _firstname.isEmpty ? '...' : _firstname,
                          style: GoogleFonts.outfit(
                            fontSize: 24,
                            color: primaryGreen,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _buildActionButtons(),
            ],
          ),
          const SizedBox(height: 16),
          // Add search bar
          _buildSearchBar(),
        ],
      ),
    );
  }
  
  Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: GoogleFonts.inter(
            color: Colors.grey[500],
            fontSize: 16,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: primaryGreen,
          ),
          suffixIcon: _isSearching
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.grey[600],
                  ),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _isSearching = false;
                    });
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
        onChanged: (value) {
          setState(() {
            _isSearching = value.isNotEmpty;
          });
        },
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
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onPressed,
              splashColor: primaryGreen.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(icon, color: primaryGreen, size: 24),
              ),
            ),
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              child: Text(
                badgeCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
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
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 25),
          _buildWelcomeBanner(),
          const SizedBox(height: 25),
          _buildQuickActionsRow(),
          const SizedBox(height: 30),
          _buildWhatsNewSection(),
          const SizedBox(height: 25),
          _buildFeatureCarousel(),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
  
  Widget _buildWelcomeBanner() {
    return Container(
      height: 163,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryGreen, secondaryGreen],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: primaryGreen.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            left: -20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome Back!',
                        style: GoogleFonts.outfit(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Discover the latest updates and features waiting for you',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // 1) Get Started → upcoming.dart
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const UpcomingPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: primaryGreen,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'Get Started',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Icon(
                    Icons.landscape,
                    size: 80,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildQuickActionsRow() {
    final List<QuickAction> actions = [
      QuickAction(
        icon: Icons.auto_awesome,
        label: 'Compete',
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
      QuickAction(
        icon: Icons.settings,
        label: 'Customize',
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CustomizePage()),
        ),
      ),
    ];
  
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Actions",
          style: GoogleFonts.outfit(
            fontSize: 20,
            color: Colors.black87,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: actions
              .map((action) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: _buildQuickNavCard(action),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
  
  Widget _buildQuickNavCard(QuickAction action) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: action.onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          constraints: const BoxConstraints(minHeight: 120),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: primaryGreen.withOpacity(0.15),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [primaryGreen, secondaryGreen],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  action.icon,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                action.label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w600,
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
                fontSize: 20,
                color: Colors.black87,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WhatsNewPage()),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: primaryGreen.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              ),
              child: Text(
                'See All',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: primaryGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // News items
        _buildNewsItem(
          title: 'New Competition Announced',
          subtitle: 'Showcase your builds and win prizes',
          date: 'Mar 8',
          icon: Icons.auto_awesome,
        ),
        _buildNewsItem(
          title: 'Weekly Specials',
          subtitle: 'New Weekly Specials are now available',
          date: 'Mar 10',
          icon: Icons.eco,
        ),
      ],
    );
  }
  
  Widget _buildNewsItem({
    required String title,
    required String subtitle,
    required String date,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: primaryGreen,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: lightGreen,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    date,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: primaryGreen,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildFeatureCarousel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Featured Content",
          style: GoogleFonts.outfit(
            fontSize: 20,
            color: Colors.black87,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 203,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              // 2) Shop the Latest → ShoppingPage
              _buildFeatureCard(
                title: "Shop the Latest",
                color: Colors.teal,
                icon: Icons.lightbulb_outline,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WhatsNewPage()),
                  );
                },
              ),
              // 3) Community Events → Compete page (ShowcasePage)
              _buildFeatureCard(
                title: "Community Events",
                color: Colors.amber[700]!,
                icon: Icons.people_outline,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShowcasePage()),
                  );
                },
              ),
              // 4) Build your own bundle → CustomizePage
              _buildFeatureCard(
                title: "Build your own Bundle",
                color: Colors.deepPurple,
                icon: Icons.shopping_bag_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CustomizePage()),
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
  }
  
  Widget _buildFeatureCard({
    required String title,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color,
            color.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 55),
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Explore',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  Widget buildDashboard(BuildContext context) {
    return Scaffold(
      body: IndexedStack( // ✅ Keeps state but allows updates
        index: _selectedIndex,
        children: [
          _buildHomeContent(), // ✅ This will rebuild when _username updates
          const ShoppingPage(),
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: primaryGreen.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, size: 26),
                activeIcon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: primaryGreen.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.home, size: 26),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.storefront_outlined, size: 26),
                activeIcon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: primaryGreen.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.storefront, size: 26),
                ),
                label: 'Shop',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline, size: 26),
                activeIcon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: primaryGreen.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person, size: 26),
                ),
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
