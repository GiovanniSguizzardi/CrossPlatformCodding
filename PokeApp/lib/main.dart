import 'package:flutter/material.dart';

void main() {
  runApp(const PokemonStarterApp());
}

class PokemonStarterApp extends StatelessWidget {
  const PokemonStarterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const PokemonStarterScreen(),
    );
  }
}

class PokemonStarterScreen extends StatefulWidget {
  const PokemonStarterScreen({super.key});

  @override
  State<PokemonStarterScreen> createState() =>
      _PokemonStarterScreenState();
}

final starters = [
  Pokemon(name: "Bulbasaur", image: "images/bulbasaur.png"),
  Pokemon(name: "Charmander", image: "images/charmander.png"),
  Pokemon(name: "Squirtle", image: "images/squirtle.png"),
];

class _PokemonStarterScreenState extends State<PokemonStarterScreen> {
  Pokemon pokemonSelected = starters.first;

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: isPortrait
              ? PokemonStarterScreenPortrait(
                  pokemonSelected: pokemonSelected,
                  options: starters,
                  onSelected: (pokemon) {
                    setState(() {
                      pokemonSelected = pokemon;
                    });
                  },
                )
              : PokemonStarterScreenLandscape(
                  pokemonSelected: pokemonSelected,
                  options: starters,
                  onSelected: (pokemon) {
                    setState(() {
                      pokemonSelected = pokemon;
                    });
                  },
                ),
        ),
      ),
    );
  }
}

class PokeLogo extends StatelessWidget {
  const PokeLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Image.asset(
        "images/logo_pokemon.png",
        fit: BoxFit.contain,
      ),
    );
  }
}

class PokeHeader extends StatelessWidget {
  const PokeHeader(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: Colors.black87,
      ),
    );
  }
}

class Pokemon {
  final String name;
  final String image;

  Pokemon({required this.name, required this.image});
}

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(pokemon.image, width: 200, height: 200),
          const SizedBox(height: 12),
          Text(
            pokemon.name.toUpperCase(),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

class PokemonOption extends StatelessWidget {
  final bool selected;
  final Pokemon pokemon;
  final Function(Pokemon) onSelected;

  const PokemonOption({
    super.key,
    required this.selected,
    required this.pokemon,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(pokemon),
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected ? Colors.red.shade100 : Colors.transparent,
            ),
            child: Image.asset(
              selected
                  ? "images/pokeball_selected.png"
                  : "images/pokeball_unselected.png",
              width: 45,
              height: 45,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            pokemon.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight:
                  selected ? FontWeight.bold : FontWeight.normal,
              color: selected ? Colors.red : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class PokemonOptionsList extends StatelessWidget {
  final List<Pokemon> options;
  final Pokemon pokemonSelected;
  final Function(Pokemon) onSelected;

  const PokemonOptionsList({
    super.key,
    required this.options,
    required this.pokemonSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: options.map((pokemon) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: PokemonOption(
            pokemon: pokemon,
            selected: pokemon == pokemonSelected,
            onSelected: onSelected,
          ),
        );
      }).toList(),
    );
  }
}

class PokemonStarterScreenPortrait extends StatelessWidget {
  final Pokemon pokemonSelected;
  final List<Pokemon> options;
  final Function(Pokemon) onSelected;

  const PokemonStarterScreenPortrait({
    super.key,
    required this.pokemonSelected,
    required this.options,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const PokeLogo(),
        const PokeHeader("Escolha seu Pokémon inicial"),
        PokemonCard(pokemon: pokemonSelected),
        PokemonOptionsList(
          options: options,
          pokemonSelected: pokemonSelected,
          onSelected: onSelected,
        ),
      ],
    );
  }
}

class PokemonStarterScreenLandscape extends StatelessWidget {
  final Pokemon pokemonSelected;
  final List<Pokemon> options;
  final Function(Pokemon) onSelected;

  const PokemonStarterScreenLandscape({
    super.key,
    required this.pokemonSelected,
    required this.options,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const PokeLogo(),
              const SizedBox(height: 20),
              PokemonCard(pokemon: pokemonSelected),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const PokeHeader("Escolha seu Pokémon inicial"),
              const SizedBox(height: 32),
              PokemonOptionsList(
                options: options,
                pokemonSelected: pokemonSelected,
                onSelected: onSelected,
              ),
            ],
          ),
        ),
      ],
    );
  }
}