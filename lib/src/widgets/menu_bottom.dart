import 'package:flutter/material.dart';

import '../../main.dart';
import '../screens/send_message/send_message.dart';
import '../shared/theme.dart';

class MenuBottomSheet extends StatelessWidget {
  const MenuBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration.zero,
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const MyApp();
                  },
                ),
              );
            },
          ),
          BottomSheetMenuItem(
            icon: Icons.send,
            text: 'Send',
            backgroundColor: kOrangeColor,
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration.zero,
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const SendMessageScreen();
                  },
                ),
              );
            },
          ),
          BottomSheetMenuItem(
            icon: Icons.group,
            text: 'Group',
            backgroundColor: kSoftRedColor,
          ),
        ],
      ),
    );
  }
}

class BottomSheetMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color backgroundColor;
  final Function()? onTap;

  const BottomSheetMenuItem({
    super.key,
    required this.icon,
    required this.text,
    required this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
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
      ),
    );
  }
}
