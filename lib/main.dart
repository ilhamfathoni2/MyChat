import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_flutter/src/bloc/contact_state.dart';
import 'package:learn_flutter/src/screens/send_message.dart';

import 'src/models/contact.dart';
import 'src/shared/theme.dart';
import 'src/screens/chat_room.dart';
import 'src/bloc/contacts_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact List',
      home: BlocProvider(
        // Gunakan BlocProvider untuk menyediakan ContactCubit ke widget tree
        create: (context) => ContactCubit(), // Inisialisasi ContactCubit
        child: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final contactCubit = context.read<ContactCubit>();
    contactCubit.fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Chat',
            style: lightTextStyle.copyWith(fontWeight: semiBold)),
        elevation: 0,
        backgroundColor: kPrimaryColor,
      ),
      backgroundColor: kBgColor,
      body: BlocBuilder<ContactCubit, ContactState>(
        builder: (context, state) {
          if (state is ContactLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ContactLoaded) {
            final contacts = state.contacts;
            return ContactList(contacts: contacts);
          } else if (state is ContactError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
      bottomSheet: const MenuBottomSheet(),
    );
  }
}

class ContactList extends StatelessWidget {
  final List<Contact> contacts;

  const ContactList({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        final contactCubit = context.read<ContactCubit>();
        contactCubit.fetchContacts();
      },
      child: ListView.builder(
        itemCount: contacts.length,
        padding: const EdgeInsets.only(bottom: 150, top: 20),
        itemBuilder: (context, index) {
          Contact contact = contacts[index];
          return ContactCard(contact: contact);
        },
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final Contact contact;

  const ContactCard({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
            color: kWhiteColor, borderRadius: BorderRadius.circular(30)),
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
              style:
                  blackTextStyle.copyWith(fontSize: 16, fontWeight: semiBold)),
          subtitle: Text(contact.shortMessage,
              maxLines: 1, // Maksimal 1 baris
              overflow: TextOverflow.ellipsis,
              style:
                  blackTextStyle.copyWith(fontSize: 12, fontWeight: reguler)),
          trailing: Text(contact.time.substring(11, 16),
              style: blackTextStyle.copyWith(fontSize: 12, fontWeight: light)),
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
    );
  }
}

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
