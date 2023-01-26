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
  
  /// Authenticate a user passwordlessly using a "magic link" sent to the 
  /// specified user's email address.
  external void loginWithMagicLink();

  /// Authenticate a user passwordlessly using a one-time code sent to the specified phone number.
  external void loginWithSMS();

  /// Authenticate a user via a "Magic Credential," a special, one-time-use DID Token created by 
  /// the user to hydrate their authentication between page reloads.
  external void loginWithCredential();

  /// Authenticate a user passwordlessly using an email one-time code sent to the 
  /// specified user's email address.
  external void loginWithEmailOTP();

  /// accessing the [user] methods
  external dynamic get user;

  /// Initiates the update email flow that allows a user to change their email address.
  external void updateEmail();

  /// Generates a Decentralized Id Token which acts as a proof of 
  /// authentication to resource servers.
  external void getIdToken();

  /// Retrieves information for the authenticated user.
  external void getMetadata();

  /// Checks if a user is currently logged in to the Magic SDK.
  external void isLoggedIn();

  /// Logs out the currently authenticated Magic user
  external void logout();

  /// accessing the [rpcProvider] variable
   
  external dynamic get rpcProvider;

  /// accessing the [connect] methods
  
  external dynamic get connect;
  
  /// Returns information about the logged in user's wallet, such as the walletType
  external void getWalletInfo();

  /// Will show the wallet view for an authenticated user. 
  /// This can be used to let the user manage their wallet, purchase/send/receive crypto, 
  /// access their recovery phrase, or end their session. 
  /// This is only supported for users who login with email or Google, 
  /// not third party wallets such as metamask.
  external void showWallet();

  /// Will prompt the user to consent to sharing information with the requesting dApp. 
  /// Currently returns only the user’s verified email address, 
  /// which requires explicit user consent.
  external void requestUserInfo();

  /// Will disconnect the user from the dApp. This is similar to logging a user out. 
  /// Will clear any third party wallet the user selected.
  external void disconnect();
}
