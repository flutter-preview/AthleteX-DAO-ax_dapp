import 'package:ax_dapp/wallet/javascript_calls/magic.dart';

class MagicRepository {
  MagicRepository({required Magic magic})
      : _magic = magic;
  final Magic _magic;

  void loginWithMagicLink() {
    _magic.auth.loginWithMagicLink();
  }

  void logout() {
    _magic.user.logout();
  }
}
