import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/core/network/api_client.dart';
import 'package:riverpod_test/features/pokemon/data/datasource/pokemon_remote_datasource.dart';
import 'package:riverpod_test/features/pokemon/data/models/pokemon_response_model.dart';
import 'package:riverpod_test/features/pokemon/data/repository/pokemon_repository.dart';

/// Provider for ApiClient (singleton)
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

/// Provider for Remote Data Source
final pokemonRemoteDataSourceProvider = Provider<PokemonRemoteDataSource>((ref) {
  final client = ref.read(apiClientProvider);
  return PokemonRemoteDataSource(client);
});

/// Provider for Repository
final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  final remote = ref.read(pokemonRemoteDataSourceProvider);
  return PokemonRepository(remote);
});

/// Business Logic Provider (fetches and exposes data to UI)
final pokemonProvider = FutureProvider<PokemonResponse>((ref) async {
  final repo = ref.read(pokemonRepositoryProvider);
  final response = await repo.getPokemons();
  return response;
});
