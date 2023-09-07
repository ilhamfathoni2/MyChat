import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_flutter/src/viewmodels/contact/contact_state.dart';
import 'package:learn_flutter/src/viewmodels/contact/contact_view_model.dart';
import 'package:learn_flutter/src/viewmodels/message/message_view_model.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<ContactCubit>(
          create: (BuildContext context) => ContactCubit(),
        ),
        BlocProvider<MessageCubit>(
          create: (BuildContext context) => MessageCubit(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Contact List',
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
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
