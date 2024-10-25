import 'package:eattendance/untils/export_file.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsAndCOnditions extends StatefulWidget {
  @override
  _TermsAndCOnditionsState createState() => _TermsAndCOnditionsState();
}

class _TermsAndCOnditionsState extends State<TermsAndCOnditions> {
  bool isLoading = true;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (status) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://sites.google.com/view/nuhvin-e-attendance/terms-and-conditions'));
  }

  Future<bool> _onBack() async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBack,
      child: Scaffold(
        backgroundColor: Kwhite,
        appBar: CustomAppBar(
          dontHaveBackAsLeading: false,
          title: "Terms And Conditions",
        ),
        body: SafeArea(
          child: Stack(
            children: [
              WebViewWidget(controller: _controller),
              if (isLoading)
                Center(
                  child: CircularProgressIndicator(
                    color: KOrange,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
