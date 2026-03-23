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
      Get.snackbar("Error", e.toString());
    }
  }
}