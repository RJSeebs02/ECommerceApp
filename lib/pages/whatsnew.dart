import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bangerlabz/pages/home.dart';
import 'package:bangerlabz/pages/weekly.dart' as weekly;
import 'package:bangerlabz/pages/upcoming.dart' as upcoming;

class WhatsNewPage extends StatelessWidget {
  const WhatsNewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button that goes to HomePage
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.green),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                        (route) => false,
                      );
                    },
                  ),
                  Text(
                    "What's New",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.green[800],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined, color: Colors.green),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.green[300]),
                  prefixIcon: Icon(Icons.search, color: Colors.green[300]),
                  filled: true,
                  fillColor: Colors.green[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            // Tabs Row – Order: What's New (active), Upcoming Pieces, Weekly Specials
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Active tab: What's New – pill on left
                  InkWell(
                    onTap: () {
                      // Already on WhatsNewPage.
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "What's New",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  // "Upcoming Pieces" tab with fade transition
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              const upcoming.UpcomingPage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(opacity: animation, child: child);
                          },
                          transitionDuration: const Duration(milliseconds: 300),
                        ),
                      );
                    },
                    child: Text(
                      'Upcoming Pieces',
                      style: GoogleFonts.inter(
                        color: Colors.green[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  // "Weekly Specials" tab with fade transition
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              const weekly.WeeklyPage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(opacity: animation, child: child);
                          },
                          transitionDuration: const Duration(milliseconds: 300),
                        ),
                      );
                    },
                    child: Text(
                      'Weekly Specials',
                      style: GoogleFonts.inter(
                        color: Colors.green[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // List of "What's New" items
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.green[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.new_releases, color: Colors.green),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Update ${index + 1}',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.green[800],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Description for update ${index + 1}.',
                                  style: GoogleFonts.inter(
                                    color: Colors.green[700],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 16, color: Colors.green[700]),
                            const SizedBox(width: 4),
                            Text(
                              'Monday, 13 June',
                              style: GoogleFonts.inter(
                                color: Colors.green[700],
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Icon(Icons.access_time, size: 16, color: Colors.green[700]),
                            const SizedBox(width: 4),
                            Text(
                              '09:00 - 10:00 AM',
                              style: GoogleFonts.inter(
                                color: Colors.green[700],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              // Detail action
                            },
                            child: Text(
                              'Detail',
                              style: GoogleFonts.inter(
                                color: Colors.green[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
