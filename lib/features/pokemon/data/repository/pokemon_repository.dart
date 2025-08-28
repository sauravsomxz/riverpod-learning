import 'package:riverpod_test/features/pokemon/data/datasource/pokemon_remote_datasource.dart';
import 'package:riverpod_test/features/pokemon/data/models/pokemon_response_model.dart';

class PokemonRepository {
  final PokemonRemoteDataSource _remoteDataSource;

  PokemonRepository(this._remoteDataSource);

  Future<PokemonResponse> getPokemons() async {
    return await _remoteDataSource.fetchPokemons();
  }
}
