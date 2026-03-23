import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class LoginController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> authenticate() async {
    try {
      bool isAuth = await auth.authenticate(
        localizedReason: 'Login using biometrics',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );

      if (isAuth) {
        Get.offAllNamed('/market');
      }
    } catch (e) {
      String message = "Authentication failed";

      if (e is PlatformException) {
        switch (e.code) {
          case 'NotAvailable':
            message = "Biometric not available on this device";
            break;
          case 'NotEnrolled':
            message = "No biometrics enrolled";
            break;
          case 'LockedOut':
            message = "Too many attempts. Try later";
            break;
          case 'PermanentlyLockedOut':
            message = "Biometric locked permanently";
            break;
          default:
            message = "Error: ${e.message}";
        }
      }

      Get.snackbar(
        "Error",
        message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}