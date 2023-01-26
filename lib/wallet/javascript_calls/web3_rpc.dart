@JS()
library web3rpc;

import 'package:js/js.dart';

@JS()
class Web3 {
  external factory Web3(
    dynamic provider,
  );

  /// Will change the provider for its module.
  external void setProvider();

  /// Contains the current available providers.
  external void providers();

  /// When using web3.js in an Ethereum compatible browser,
  /// it will set with the current native provider by that browser.
  /// Will return the given provider by the (browser) environment,
  /// otherwise null.
  external void givenProvider();

  /// Will return the current provider, otherwise null.
  external void currentProvider();

  /// accessing the [eth] methods
  external dynamic get eth;

  /// Returns a list of accounts the node controls
  external void getAccounts();

  /// The default chain property is used for signing transactions locally.
  external void defaultChain();

  /// The default common property is used for signing transactions locally.
  external void defaultCommon();

  /// Returns the current gas price oracle.
  /// The gas price is determined by the last few blocks median gas price.
  external void getGasPrice();

  /// Transaction fee history Returns base fee per gas and transaction effective priority
  /// fee per gas history for the requested block range if available.
  /// The range between headBlock-4 and headBlock is
  /// guaranteed to be available while retrieving data from
  /// the pending block and older history are optional to support.
  /// For pre-EIP-1559 blocks the gas prices are returned as rewards and
  /// zeroes are returned for the base fee per gas.
  external void getFeeHistory();

  /// Get the balance of an address at a given block.
  external void getBalance();

  /// Sends a transaction to the network.
  external void sendTransaction();

  /// Sends an already signed transaction,
  external void sendSignedTransaction();

  /// Signs data using a specific account.
  /// This account needs to be unlocked.
  external void sign();

  /// Signs a transaction. This account needs to be unlocked.
  external void signTransaction();

  /// This method will request/enable the accounts from the current environment.
  /// This method will only work if you’re using the injected provider from a application like
  /// Metamask, Status or TrustWallet.
  /// It doesn’t work if you’re connected to a node with a default Web3.js provider
  /// (WebsocketProvider, HttpProvider and IpcProvider).
  external void requestAccounts();

  /// Returns the chain ID of the current connected node as described in the EIP-695.
  external void getChainId();
}
