// TODO(Pearlson): confirm info

/// {@template ethereum_currency}
/// Holds data about an `Ethereum` currency.
/// {@endtemplate}
enum EthereumCurrency {
  /// Represents no currency.
  none(currencyName: '', symbol: ''),

  /// AthleteX currency.
  ax(currencyName: 'AthleteX Token', symbol: 'AX'),

  /// SportX currency.
  sx(currencyName: 'SportX Token', symbol: 'SX'),

  /// Matic currency(used with Polygon).
  matic(currencyName: 'MATIC Token', symbol: 'MATIC'),

  /// Wrapped Ether currency.
  weth(currencyName: 'WETH Token', symbol: 'WETH'),

  /// USD Coin currency.
  usdc(currencyName: 'USDC Token', symbol: 'USDC'),

  /// APT currency.
  apt(currencyName: 'AP Token', symbol: 'APT');

  /// {@macro ethereum_currency}
  const EthereumCurrency({
    required this.currencyName,
    required this.symbol,
  });

  /// The name of the currency.
  final String currencyName;

  /// The symbol for the currency.
  final String symbol;

  /// The no. of decimals used with this currency.
  final int decimals = 18;
}
