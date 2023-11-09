import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/navigation/navigation_bloc.dart';
import '../widgets/buttons/buttonWithGradient.dart';

class BirthdayPage extends StatefulWidget {
  BirthdayPage({super.key});

  @override
  State<BirthdayPage> createState() => _BirthdayPageState();
}

class _BirthdayPageState extends State<BirthdayPage>
    with TickerProviderStateMixin {
  late int currentYear;
  late List<int> years;
  late int selectedYear;

  @override
  void initState() {
    super.initState();
    currentYear = DateTime.now().year;

    years = List.generate(currentYear - 1899, (index) => currentYear - index);

    selectedYear = currentYear;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener <NavigationBloc, NavigationState>(
        listener: (context, state) {
          // switch (state.currentPage) {
          //   case 'Final':
          //
          //     return FinalPage();
          //   case 'Birthday':
          //     return BirthdayPage();
          //   case 'Option':
          //     return OptionPage();
          //   default:
          //     return OptionPage();
          // }
          if (state.currentPage == 'Birthday') {
            Navigator.of(context).pushNamed('/birthday');
          }
        },
        child: Scaffold(
            body: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background/background_image.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Log in your date of birth',
                    style:
                    GoogleFonts.nunito(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 150,
                    child: ListWheelScrollView(
                      diameterRatio: 1.5,
                      itemExtent: 50,
                      children: years.map((year) {
                        return Center(
                          child: Text(
                            year.toString(),
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w900,
                              fontSize: 40,
                            ),
                          ),
                        );
                      }).toList(),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedYear = years[index];
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Selected year: $selectedYear',
                    style: TextStyle(fontSize: 20),
                  ),
                  ButtonGradient(
                    onPressed: () {
                      context.read<NavigationBloc>().add(NavigationToFinal());
                    },
                    title: 'Next',
                  ),
                ],
              ),
            )));
  }
}