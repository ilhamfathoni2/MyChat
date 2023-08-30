import 'package:flutter/material.dart';

import 'src/models/contact.dart';
import 'src/shared/theme.dart';
import 'src/screens/chat_room.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Contact> contacts = [
    Contact(
      name: 'Acel Abdullah',
      shortMessage: 'When we will meet?',
      time: '09.30',
    ),
    Contact(
      name: 'Aqil',
      shortMessage: 'Are you still working?',
      time: '10.30',
    ),
    Contact(
      name: 'Ambar',
      shortMessage: 'I am hungry, let’s go!!!!',
      time: '07.00',
    ),
    Contact(
      name: 'Rizki',
      shortMessage: 'When we will meet?',
      time: '12.30',
    ),
    Contact(
      name: 'Fachri',
      shortMessage: 'I am hungry, let’s go!!!!',
      time: '14.00',
    ),
    Contact(
      name: 'Farhan',
      shortMessage: 'Are you still working?',
      time: '17.20',
    ),
    Contact(
      name: 'Fahmi',
      shortMessage: 'When we will meet?',
      time: '19.00',
    ),
    Contact(
      name: 'Bujang',
      shortMessage: 'I am hungry, let’s go!!!!',
      time: '08.30',
    ),
    Contact(
      name: 'Ujang',
      shortMessage: 'Are you still working?',
      time: '16.00',
    ),
  ];

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact List',
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              expandedHeight: 60,
              pinned: true,
              flexibleSpace: Container(
                width: 152,
                margin: const EdgeInsets.only(left: 15, right: 15),
                alignment: Alignment.centerLeft,
                child: Text('My Chat',
                    style: blackTextStyle.copyWith(
                        fontSize: 25, fontWeight: semiBold)),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                  bottom: 140), // Atur jarak ke bawah sebesar 100px
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    Contact contact = contacts[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: SizedBox(
                        height: 80,
                        child: Center(
                          child: ListTile(
                            title: Text(contact.name,
                                style: blackTextStyle.copyWith(
                                    fontSize: 16, fontWeight: semiBold)),
                            subtitle: Text(contact.shortMessage,
                                style: blackTextStyle.copyWith(
                                    fontSize: 12, fontWeight: reguler)),
                            trailing: Text(contact.time,
                                style: blackTextStyle.copyWith(
                                    fontSize: 12, fontWeight: light)),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatRoomScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: contacts.length,
                ),
              ),
            ),
          ],
        ),
        bottomSheet: const MenuBottomSheet(),
      ),
    );
  }
}

class MenuBottomSheet extends StatelessWidget {
  const MenuBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 14),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: kBlackColor.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottomSheetMenuItem(
              icon: Icons.chat,
              text: 'Chat',
              backgroundColor: kBlueColor,
            ),
            BottomSheetMenuItem(
              icon: Icons.access_time,
              text: 'Status',
              backgroundColor: kOrangeColor,
            ),
            BottomSheetMenuItem(
              icon: Icons.group,
              text: 'Group',
              backgroundColor: kSoftRedColor,
            ),
          ],
        ),
      ),
    );
  }
}

class BottomSheetMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color backgroundColor;

  const BottomSheetMenuItem({
    super.key,
    required this.icon,
    required this.text,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
          ),
          child: Icon(icon, color: kWhiteColor),
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: inactiveTextStyle.copyWith(fontSize: 14, fontWeight: medium),
        ),
      ],
    );
  }
}
