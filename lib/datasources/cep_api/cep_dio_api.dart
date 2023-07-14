import 'package:interceptors/config/dio_package.dart';
import 'package:interceptors/datasources/cep_api/cep_api.dart';
import 'package:interceptors/models/cep.dart';

class CepDioApi implements CepApi {
  @override
  String path = 'https://viacep.com.br/ws';

  @override
  String type = 'json';

  @override
  Future<AddressModel> getAddress(String cep) async {
    try {
      final http = DioPackageClient().dio;
      final response = await http.get('$path/$cep/$type/');
      return AddressModel(
        zipCode: response.data['cep'],
        publicPlace: response.data['logradouro'],
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
