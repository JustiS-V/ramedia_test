import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../bloc/navigation/navigation_bloc.dart';
import '../../constants/colors.dart';
import '../../services/gameservice.dart';
import '../../widgets/coinchangewidget.dart';
import '../../widgets/spinnerwidget.dart';

class WhitePage extends StatefulWidget {
  WhitePage({super.key});

  @override
  State<WhitePage> createState() => _WhitePageState();
}

class _WhitePageState extends State<WhitePage>
    with TickerProviderStateMixin {

  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 1),
  );

  late final AnimationController spinnerController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 1),
  );

  var gameService = GameService();


  botCheck () {

  }

  Future<void> fetchLocation() async {
    final Uri url = Uri.parse('https://ipinfo.io/json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      Navigator.of(context).pushNamed('/webview');

    } else {
      print('Failed to fetch location. Status code: ${response.statusCode}');
    }
  }


  @override
  void initState() {
    super.initState();
    fetchLocation();
    gameService.playSound('riseup');
    controller.forward();
    spinnerController.forward();
  }


  showPopup(type) {
    double res_height = MediaQuery.of(context).size.height;
    double res_width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: SizedBox(
            height: res_height * 0.35,
            width: res_width * 0.9,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Material(
                child: Column(
                  children: [
                    Container(
                      width: res_width * 0.9,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.centerRight,
                              colors: [kprimarycolor, ksecondarycolor])),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(
                            type == "GAME END" ? "GAME OVER" : "YOU WIN",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Image.asset(
                      'lib/assets/Graphics/gfx-seven-reel.png',
                      width: 100,
                    ),
                    Spacer(),
                    Text(
                      type == "GAME END"
                          ? "Bad Luck! You lost all of the coins.\nLet's play again"
                          : "Hurray! You win the spin.\nLet's play again",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 17),
                    ),
                    Spacer(),
                    TextButton(
                        onPressed: () {
                          if (type == "GAME END") {
                            Navigator.pop(context);
                            setState(() {
                              gameService.reset();
                            });
                          } else {
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          type == "GAME END" ? "NEW GAME" : "CONTINUE",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19),
                        ),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.only(
                                    left: 20, right: 20, top: 5, bottom: 5)),
                            foregroundColor:
                            MaterialStateProperty.all(kprimarycolor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(
                                        color: kprimarycolor, width: 3))))),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double res_height = MediaQuery.of(context).size.height;
    double res_width = MediaQuery.of(context).size.width;

    // return Container();
    return BlocListener <NavigationBloc, NavigationState>(
      listener: (context, state) {},
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [kprimarycolor, ksecondarycolor])),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: ListView(
              padding: EdgeInsets.only(left: 15, right: 15),
              children: [
                SizedBox(
                  height: res_height * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          gameService.reset();
                        });
                      },
                      child: const Icon(
                        Icons.restart_alt_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    Image.asset(
                      'lib/assets/Graphics/gfx-slot-machine.png',
                      width: res_width * 0.6,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.info_outline,
                        color: Colors.white,
                        size: 40,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: res_height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.25),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(30))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'YOUR\nCOINS',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            '${gameService.yourcoins.toString()}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.25),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(30))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${gameService.highscore.toString()}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            'HIGH\nSCORE',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: res_height * 0.02,
                ),
                Column(
                  children: [
                    spinnerwidgetbox(
                      spinnerImage: '${gameService.items[gameService.reels[0]]}',
                      isSpin: false,
                      controller: spinnerController,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        spinnerwidgetbox(
                          spinnerImage:
                          '${gameService.items[gameService.reels[1]]}',
                          isSpin: false,
                          controller: spinnerController,
                        ),
                        spinnerwidgetbox(
                          spinnerImage:
                          '${gameService.items[gameService.reels[2]]}',
                          isSpin: false,
                          controller: spinnerController,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        spinnerController.forward(from: 0);
                        var spin = gameService.spin();
                        if (spin == "GAME END") {
                          showPopup('GAME END');
                        }
                        if (spin == "WIN") {
                          showPopup('WIN');
                        }
                        setState(() {});
                      },
                      child: spinnerwidgetbox(
                        spinnerImage: 'gfx-spin.png',
                        isSpin: true,
                        controller: spinnerController,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: res_height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        gameService.playSound('casino-chips');

                        setState(() {
                          gameService.coin10 = true;
                          controller.forward(from: 0);
                        });
                      },
                      child: CoinChangeWidget(
                        isTrue: gameService.coin10,
                        coinValue: '10',
                      ),
                    ),
                    Container(
                      child: SlideTransition(
                        position: Tween<Offset>(
                            begin: Offset(0, 0),
                            end: Offset(gameService.coin10 ? -2 : 2, 0))
                            .animate(controller),
                        child: Image.asset(
                          'lib/assets/Graphics/gfx-casino-chips.png',
                          height: 40,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        gameService.playSound('casino-chips');
                        setState(() {
                          gameService.coin10 = false;
                          controller.forward(from: 0);
                        });
                      },
                      child: CoinChangeWidget(
                        isTrue: !gameService.coin10,
                        coinValue: '20',
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}