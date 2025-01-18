import 'package:flutter/material.dart';
import '../utils/theme.dart';

class LabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Labs',
              style: TextStyle(
                fontSize: 30,
                color: AppColors.h1,
                fontWeight: FontWeight.bold,
                ),
            ),
            const SizedBox(height: 20),
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
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Icon(
                    Icons.search,
                    color: AppColors.defaultText,
                    size: 40,
                  ),
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
                contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                filled: true,
                fillColor: AppColors.secondaryBg,
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Image.asset(
                '../assets/images/map_sample.webp',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
