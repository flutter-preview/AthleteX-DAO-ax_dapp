@JS()
library magic_sdk;

import 'package:js/js.dart';

@JS()
class Magic {
  external factory Magic(
    String apiKey,
    dynamic options,
  );
  /// accessing the [auth] methods
  external dynamic get auth;
  
  external void loginWithMagicLink();
  external void loginWithSMS();
  external void loginWithCredential();
  external void loginWithEmailOTP();

  /// accessing the [user] methods
  external dynamic get user;

  external void updateEmail();
  external void getIdToken();
  external void getMetadata();
  external void isLoggedIn();
  external void logout();

  /// accessing the [rpcProvider] variable
   
  external dynamic get rpcProvider;

  /// accessing the [connect] methods
  
  external dynamic get connect;

  external void getWalletInfo();
  external void showWallet();
  external void requestUserInfo();
  external void disconnect();
}
