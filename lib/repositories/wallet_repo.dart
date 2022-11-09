// Imports go here ( not sure what they are yet )

// What we could do is return the wallet api per each wallet type registered
enum SupportedWallet {

    /// Represents https://metamask.io/
    Metamask,

    /// Represents https://walletconnect.com/
    WalletConnect,
    /// Represents https://www.coinbase.com/wallet/
    Coinbase
};


abstract class WalletRepo<WalletOption> {
    WalletRepo(this.wallet);

    final SupportedWallet wallet;

    // Activites of a connected wallet...



  /// The initial [EthereumChain] that the wallet will be switched to.
  final EthereumChain defaultChain;

  /// [WalletCredentials] cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const credentialsCacheKey = '__credentials_cache_key__';

  /// Allows listening to changes to the current [EthereumChain].
  Stream<EthereumChain> get chainChanges => _walletApiClient.chainChanges;

  /// Returns the current [EthereumChain] synchronously.
  EthereumChain get currentChain => _walletApiClient.currentChain;

  ValueStream<Wallet> get _walletChanges => _walletChangeController.stream;

  /// Allows listening to changes to the current [Wallet].
  Stream<Wallet> get walletChanges => _walletChanges;

  /// Returns the current [Wallet] synchronously.
  Wallet get currentWallet =>
      _walletChanges.valueOrNull ?? const Wallet.disconnected();

  /// Returns the cached [WalletCredentials] for the connected wallet. This
  /// doesn't return `null`, because when called, the wallet is asssumed to be
  /// connected and thus have it's credentials cached.
  WalletCredentials get credentials =>
      _cache.read<WalletCredentials>(key: credentialsCacheKey)!;

  /// Allows the user to connect to a `MetaMask` wallet.
  ///
  /// Returns the hexadecimal representation of the wallet address.
  ///
  /// Throws:
  /// - [WalletUnavailableFailure]
  /// - [WalletOperationRejectedFailure]
  /// - [EthereumWalletFailure]
  /// - [UnknownWalletFailure]
  Future<String> connectWallet() async {}

  Future<String> _getWalletCredentials() async {}

  void _cacheWalletCredentials(WalletCredentials credentials) => _cache.write(
        key: credentialsCacheKey,
        value: credentials,
      );

  /// Switches the currently used [EthereumChain].
  ///
  /// Throws:
  /// - [WalletUnavailableFailure]
  /// - [WalletOperationRejectedFailure]
  /// - [EthereumWalletFailure]
  /// - [UnknownWalletFailure]
  Future<void> switchChain(EthereumChain chain) async {}

  /// Simulates disconnecting user's wallet. For security reasons an actual
  /// disconnect is not possible.
  void disconnectWallet();

  /// Adds the token with the given [tokenAddress] and [tokenImageUrl] to
  /// user's wallet.
  ///
  /// Throws:
  /// - [WalletUnavailableFailure]
  /// - [WalletUnsuccessfulOperationFailure]
  /// - [WalletOperationRejectedFailure]
  /// - [EthereumWalletFailure]
  /// - [UnknownWalletFailure]
  Future<void> addToken({
    required String tokenAddress,
    required String tokenImageUrl,
  });

  /// Returns the amount of tokens with [tokenAddress] owned by the wallet
  /// identified by current [Wallet.address].
  ///
  /// Defaults to [BigInt.zero] on error.
  Future<BigInt> getRawTokenBalance(String tokenAddress) async {}

  /// Returns an aproximate balance for the token with the given [tokenAddress],
  /// on the connected wallet. It returns `null` when any error occurs.
  ///
  /// **WARNING**: Due to rounding errors, the returned balance is not
  /// reliable, especially for larger amounts or smaller units. While it can be
  /// used to display the amount of ether in a human-readable format, it should
  /// not be used for anything else.
  Future<double?> getTokenBalance(String tokenAddress) async {}

  /// Returns the amount typically needed to pay for one unit of gas(in gwei).
  Future<double> getGasPrice() => _walletApiClient.getGasPrice();
}