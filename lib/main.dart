import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_flutter/src/viewmodels/contact/contact_state.dart';
import 'package:learn_flutter/src/viewmodels/contact/contact_view_model.dart';

import 'src/shared/theme.dart';
import 'src/widgets/contact_list.dart';
import 'src/widgets/menu_bottom.dart';

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
