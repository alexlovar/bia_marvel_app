import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';

final navigatorkey = GlobalKey<NavigatorState>();

void hasInternetConnection() {
  Connectivity().onConnectivityChanged.listen((event) {
    if (event == ConnectivityResult.none) {
      showDialogFlash();
    }
  });
}

void showBottomFlash({String? title, String? content}) {
  showFlash(
    context: navigatorkey.currentContext!,
    builder: (_, controller) {
      return Flash(
        controller: controller,
        position: FlashPosition.bottom,
        forwardAnimationCurve: Curves.easeInCirc,
        reverseAnimationCurve: Curves.easeIn,
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: FlashBar(
            controller:  controller,
            title: Text(title ?? ''),
            content: Text(
              content ?? '',
              style: const TextStyle(fontSize: 16),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () => controller.dismiss(),
                  child: const Text('DISMISS')),
            ],
          ),
        ),
      );
    },
  );
}

void showDialogFlash() {
  navigatorkey.currentContext?.showFlash(
      barrierColor: Colors.black54,
      barrierDismissible: true,
      builder: (context, controller) => FadeTransition(
      opacity: controller.controller,
      child: AlertDialog(
          shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
      side: BorderSide(),
      ),
      contentPadding: const EdgeInsets.only(left: 24.0, top: 16.0, right: 24.0, bottom: 16.0),
      title: const Text('Conexion a Internet'),
      content: const Text('Estas desconectado, por favor revisa tus datos o tu conexion a internet'),
      actions: [
      TextButton(
      onPressed: controller.dismiss,
      child: const Text('Ok'),
      ),
      ],
      ),),);
      
}

