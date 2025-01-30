import 'package:flutter/material.dart';
import '../utils/theme.dart';
import 'communityposts.dart';
import 'upcoming.dart';
import 'customize.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 30, 50, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Hello,',
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.h2,
                          ),
                        ),
                        Text(
                          'User',
                          style: TextStyle(
                            fontSize: 30,
                            color: AppColors.h1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.sms_outlined,
                      size: 30,
                      color: AppColors.defaultText,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Search Bar
              TextField(
                style: const TextStyle(
                  color: AppColors.defaultText,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  labelText: 'Search',
                  labelStyle: const TextStyle(
                    color: AppColors.defaultText,
                    fontSize: 20,
                  ),
                  hintText: 'Anything in mind?',
                  hintStyle: const TextStyle(
                    color: AppColors.defaultText,
                    fontSize: 20,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.defaultText,
                    size: 30,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColors.secondaryBg),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColors.secondaryBg),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  filled: true,
                  fillColor: AppColors.secondaryBg,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
              const SizedBox(height: 20),

              // Quick Navigation Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildQuickNavButton(
                    context,
                    icon: Icons.broadcast_on_personal,
                    label: 'Community',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommunityPage(),
                        ),
                      );
                    },
                  ),
                  _buildQuickNavButton(
                    context,
                    icon: Icons.dataset_linked,
                    label: 'Upcoming',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpcomingPage(),
                        ),
                      );
                    },
                  ),
                  _buildQuickNavButton(
                    context,
                    icon: Icons.rebase_edit,
                    label: 'Customize',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductCustomizationPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Your Posts Section
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Text(
                          'Your Posts',
                          style: TextStyle(
                            color: AppColors.secondary,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: AppColors.secondary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Divider(color: AppColors.tertiary),
                    const SizedBox(height: 20),
                    Row(
                      children: const [
                        Icon(
                          Icons.access_time,
                          size: 20,
                          color: AppColors.secondary,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Lorem Ipsum',
                          style: TextStyle(
                            color: AppColors.secondary,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // What's New Section
              const Text(
                'What\'s New?',
                style: TextStyle(
                  color: AppColors.h1,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget for Quick Navigation Buttons
  Widget _buildQuickNavButton(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onPressed}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: AppColors.secondaryBg,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              icon,
              size: 30,
              color: AppColors.primary,
            ),
            onPressed: onPressed,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            color: AppColors.defaultText,
          ),
        ),
      ],
    );
  }
}
