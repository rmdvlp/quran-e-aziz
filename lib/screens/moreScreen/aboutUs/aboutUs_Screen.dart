import 'package:flutter/material.dart';
import 'package:quran_aziz/utils/more_screens_appBar.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  final List<TeamMember> teamMembers = [
    TeamMember(
      name: 'Riasat Ali',
      qualification: 'BS Computer Science',
      phoneNumber: '+92 324 4544220',
      role: 'Full Stack Developer',
      imageUrl:  Images.riasatImage,
    ),
    TeamMember(
      name: 'Ahmad Shakeel',
      qualification: 'BS Computer Science',
      phoneNumber: '+92 301 8486122',
      role: 'Front End Developer',
      imageUrl: Images.ahmadImage,
    ),
    TeamMember(
      name: 'Hamna',
      qualification: 'BS Computer Science',
      phoneNumber: '+1122334455',
      role: 'UI/UX Designer',
      imageUrl: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const MoreScreensAppBar(
        text: "About Us",
        color: AppColors.white,
      ),
      body: ListView.builder(
        itemCount: teamMembers.length,
        itemBuilder: (context, index) {
          final member = teamMembers[index];
          return Card(
            margin: const EdgeInsets.all(10.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Member Image
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage(member.imageUrl!),
                  ),
                  const SizedBox(width: 20),

                  // Member Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          member.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          member.qualification,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Role: ${member.role}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(Icons.phone, color: Colors.green),
                            const SizedBox(width: 5),
                            Text(
                              member.phoneNumber,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


class TeamMember {
  final String name;
  final String qualification;
  final String phoneNumber;
  final String role;
  final String? imageUrl;

  TeamMember({
    required this.name,
    required this.qualification,
    required this.phoneNumber,
    required this.role,
     this.imageUrl,
  });
}
