import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter/webview_flutter.dart';

import '../../bloc/navigation/navigation_bloc.dart';

class GreyPage extends StatefulWidget {
  const GreyPage({super.key});

  @override
  State<GreyPage> createState() => _GreyPageState();
}

class _GreyPageState extends State<GreyPage>
    with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {},
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://youtube.com'));

  @override
  Widget build(BuildContext context) {
    return BlocListener <NavigationBloc, NavigationState>(
        listener: (context, state) {},
        child:  Scaffold(
          body: WebViewWidget(
            controller: controller,

          ),
        ));
  }
}