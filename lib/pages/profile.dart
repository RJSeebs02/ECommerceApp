import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../utils/theme.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 30,
                      color: AppColors.h1,
                      fontWeight: FontWeight.bold,
                      ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.logout, color: AppColors.logout),
                    onPressed: () {
                      Navigator.pop(context);
                    }
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Text(
                        'Subscribe Now for\nExclusive Benefits',
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 25,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 30,
                        color: AppColors.secondary,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.topCenter,
                child: ClipOval(
                  child: Image.asset(
                    '../assets/images/default_profile.webp',
                    width: 150.0,  // Specify the width of the circular image
                    height: 150.0, // Specify the height of the circular image
                    fit: BoxFit.cover, // This will ensure the image fills the circle properly
                  ),
                )
              ),
              const SizedBox(height: 50),
              const Text(
                'Username',
                style: TextStyle(
                  color: AppColors.defaultText,
                  fontSize: 20
                ),
              ),
              const TextField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'User01',
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black), // Bottom border color
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue), // Color when focused
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Email',
                style: TextStyle(
                  color: AppColors.defaultText,
                  fontSize: 20
                ),
              ),
              const TextField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'user@example.com',
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black), // Bottom border color
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue), // Color when focused
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Age',
                          style: TextStyle(
                            color: AppColors.defaultText,
                            fontSize: 20
                          ),
                        ),
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: '27',
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black), // Bottom border color
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue), // Color when focused
                            ),
                          ),
                        ),
                      ]
                    )
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gender',
                          style: TextStyle(
                            color: AppColors.defaultText,
                            fontSize: 20
                          ),
                        ),
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: 'Male',
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black), // Bottom border color
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue), // Color when focused
                            ),
                          ),
                        ),
                      ]
                    )
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Contact Number',
                style: TextStyle(
                  color: AppColors.defaultText,
                  fontSize: 20
                ),
              ),
              const TextField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: '(xxx) xxx-xxxx',
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black), // Bottom border color
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue), // Color when focused
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
