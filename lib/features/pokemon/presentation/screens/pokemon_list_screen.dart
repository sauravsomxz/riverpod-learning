import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/features/pokemon/presentation/widgets/pokemon_list_tile.dart';
import 'package:riverpod_test/features/pokemon/providers/pokemon_provider.dart';

class PokemonListScreen extends ConsumerWidget {
  const PokemonListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonAsync = ref.watch(pokemonProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokédex"),
        centerTitle: true,
      ),
      body: pokemonAsync.when(
        data: (data) {
          if (data.results.isEmpty) {
            return const Center(child: Text("No Pokémon found"));
          }
          return ListView.builder(
            itemCount: data.results.length,
            itemBuilder: (context, index) {
              final pokemon = data.results[index];
              return PokemonTile(pokemon: pokemon);
            },
          );
        },
        loading: () =>
        const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        error: (err, stack) =>
            Center(child: Text("Error: ${err.toString()}")),
      ),
    );
  }
}
