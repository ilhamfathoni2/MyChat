import 'package:flutter/material.dart';
import 'package:learn_flutter/src/models/contact.dart';
import 'package:learn_flutter/src/shared/theme.dart';

import '../screens/chat_room/chat_room.dart';

class ContactCard extends StatelessWidget {
  final Contact contact;

  const ContactCard({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(70),
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          // decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(60))),
          padding: const EdgeInsets.all(10),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: kPrimaryColor,
                    width: 2.0,
                  )),
              child: CircleAvatar(
                  radius: 24,
                  backgroundColor: kPrimaryColor,
                  child: Image.asset(contact.image)
                  // backgroundImage: AssetImage(contact.image),
                  ),
            ),
            title: Text(contact.name,
                maxLines: 1, // Maksimal 1 baris
                overflow: TextOverflow.ellipsis,
                style: blackTextStyle.copyWith(
                    fontSize: 16, fontWeight: semiBold)),
            subtitle: Text(contact.shortMessage,
                maxLines: 1, // Maksimal 1 baris
                overflow: TextOverflow.ellipsis,
                style:
                    blackTextStyle.copyWith(fontSize: 12, fontWeight: reguler)),
            trailing: Text(contact.time.substring(11, 16),
                style:
                    blackTextStyle.copyWith(fontSize: 12, fontWeight: light)),
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration.zero,
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return ChatRoomScreen(
                      id: contact.id,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
