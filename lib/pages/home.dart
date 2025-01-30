import 'package:flutter/material.dart';
import '../utils/theme.dart';

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
              Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                      size: 50,
                      color: AppColors.defaultText,),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                style: const TextStyle(
                  color: AppColors.defaultText,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  labelText: 'Searchsssss',
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
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: AppColors.secondaryBg,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.broadcast_on_personal,
                                  size: 30,
                                  color: AppColors.primary,
                                ),
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Community',
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColors.defaultText,
                              ),
                            ),
                          ],
                        )
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: AppColors.secondaryBg,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.dataset_linked,
                                  size: 30,
                                  color: AppColors.primary,
                                ),
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Upcoming',
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColors.defaultText,
                              ),
                            ),
                          ],
                        )
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: AppColors.secondaryBg,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.rebase_edit,
                                  size: 30,
                                  color: AppColors.primary,
                                ),
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Customize',
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColors.defaultText,
                              ),
                            ),
                          ],
                        )
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Row(
                        children: [
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
                            size: 30,
                            color: AppColors.secondary,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 1,
                        child: Container(
                          color: AppColors.tertiary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 20,
                            color: AppColors.secondary,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Lorem Ipsum',
                              style: TextStyle(
                                color: AppColors.secondary,
                                fontSize: 15,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
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
}
