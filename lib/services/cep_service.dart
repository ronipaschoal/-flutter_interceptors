import 'package:interceptors/datasources/cep_api/cep_api.dart';
import 'package:interceptors/models/cep.dart';

class CepService {
  final CepApi cepApi;

  CepService({required this.cepApi});

  Future<AddressModel> getCep(String cep) {
    try {
      return cepApi.getAddress(cep);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
