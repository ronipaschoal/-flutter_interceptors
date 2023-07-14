import 'dart:convert';
import 'package:interceptors/config/http_package.dart';
import 'package:interceptors/datasources/cep_api/cep_api.dart';
import 'package:interceptors/models/cep.dart';

class CepHttpApi implements CepApi {
  @override
  String path = 'https://viacep.com.br/ws';

  @override
  String type = 'json';

  @override
  Future<AddressModel> getAddress(String cep) async {
    try {
      final http = HttpPackageClient();
      final response = await http.get(Uri.parse('$path/$cep/$type/'));
      final result = jsonDecode(response.body);

      return AddressModel(
        zipCode: result['cep'],
        publicPlace: result['logradouro'],
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
