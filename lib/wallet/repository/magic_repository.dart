import 'package:ax_dapp/wallet/javascript_calls/magic.dart';
import 'package:ax_dapp/wallet/javascript_calls/web3_rpc.dart';

class MagicRepository {
  MagicRepository({required Magic magic, required Web3 web3})
      : _magic = magic,
        _web3 = web3;
  final Magic _magic;
  final Web3 _web3;

  void connect() {
    _web3.eth.getAccounts();
  }

  void disconnect() {
    _magic.connect.disconnect();
  }
}
