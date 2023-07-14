import 'package:interceptors/models/cep.dart';

abstract interface class CepApi {
  late final String path;
  late final String type;
  Future<AddressModel> getAddress(String cep);
}
