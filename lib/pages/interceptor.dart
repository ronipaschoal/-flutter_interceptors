import 'package:flutter/material.dart';
import 'package:interceptors/datasources/cep_api/cep_dio_api.dart';
import 'package:interceptors/datasources/cep_api/cep_http_api.dart';
import 'package:interceptors/services/cep_service.dart';

class InterceptorPage extends StatefulWidget {
  const InterceptorPage({super.key});

  @override
  State<InterceptorPage> createState() => _InterceptorPageState();
}

enum RequestType {
  http('HTTP'),
  dio('Dio');

  const RequestType(this.text);

  final String text;
}

class _InterceptorPageState extends State<InterceptorPage> {
  final _cepControler = TextEditingController();
  final _pageTitle = 'Interceptor Demo';
  String _requestText = '';
  String _resultText = '';

  void _request({
    required RequestType requestType,
    required String cep,
  }) async {
    setState(() {
      _requestText = 'Foi feita uma requisição usando ${requestType.text}:';
      _resultText = 'Carregando...';
    });

    try {
      final cepService = (requestType == RequestType.http)
          ? CepService(cepApi: CepHttpApi())
          : CepService(cepApi: CepDioApi());
      final address = await cepService.getCep(_cepControler.text);
      setState(() {
        _resultText = 'CEP: ${address.zipCode}\n'
            'logradouro: ${address.publicPlace}';
      });
    } catch (e) {
      setState(
        () => _resultText =
            'Ocorreu um erro, verifique o CEP informado e tente novamente!',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          _pageTitle,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64.0),
          width: 290,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _cepControler,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CEP',
                ),
              ),
              const SizedBox(height: 32.0),
              Text(_requestText),
              const SizedBox(height: 16.0),
              Text(_resultText),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _request(
              requestType: RequestType.http,
              cep: _cepControler.text,
            ),
            tooltip: RequestType.http.text,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              RequestType.http.text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 8.0),
          FloatingActionButton(
            onPressed: () => _request(
              requestType: RequestType.dio,
              cep: _cepControler.text,
            ),
            tooltip: RequestType.dio.text,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              RequestType.dio.text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
