import 'package:riverpod_test/core/network/api_client.dart';
import 'package:riverpod_test/core/network/endpoints.dart';
import 'package:riverpod_test/features/pokemon/data/models/pokemon_response_model.dart';

class PokemonRemoteDataSource {
  final ApiClient _client;

  PokemonRemoteDataSource(this._client);

  Future<PokemonResponse> fetchPokemons() async {
    final response = await _client.get(Endpoints.getAllPokemons);

    return PokemonResponse.fromJson(response.data);
  }
}
