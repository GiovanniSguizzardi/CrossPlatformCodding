import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const JoKenPokemonApp());
}

class JoKenPokemonApp extends StatelessWidget {
  const JoKenPokemonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JoKenPokemon',
      theme: ThemeData(useMaterial3: true),
      home: const JoKenPokemonScreen(),
    );
  }
}

class JoKenPokemonScreen extends StatefulWidget {
  const JoKenPokemonScreen({super.key});

  @override
  State<JoKenPokemonScreen> createState() => _JoKenPokemonScreenState();
}

class _JoKenPokemonScreenState extends State<JoKenPokemonScreen> {

  final List<Pokemon> pokemons = [
    Pokemon(name: 'Charmander', imagePath: 'images/charmander.png'),
    Pokemon(name: 'Bulbasaur', imagePath: 'images/bulbassaur.png'),
    Pokemon(name: 'Squirtle', imagePath: 'images/squirtle.png'),
  ];

  Pokemon? playerChoice;
  Pokemon? computerChoice;
  String result = '';

  void _play(Pokemon selected) {

    final random = Random();
    final compChoice = pokemons[random.nextInt(pokemons.length)];

    String battleResult;

    if (selected.name == compChoice.name) {
      battleResult = 'Empate!';
    } else if (
        (selected.name == 'Charmander' && compChoice.name == 'Bulbasaur') ||
        (selected.name == 'Bulbasaur' && compChoice.name == 'Squirtle') ||
        (selected.name == 'Squirtle' && compChoice.name == 'Charmander')
    ) {
      battleResult = 'Você venceu!';
    } else {
      battleResult = 'Você perdeu!';
    }

    setState(() {
      playerChoice = selected;
      computerChoice = compChoice;
      result = battleResult;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.orange[50],
      body: SafeArea(
        child: Column(
          children: [

            const PokemonHeader(),

            Expanded(
              child: BattleArena(
                playerPokemon: playerChoice,
                enemyPokemon: computerChoice,
                result: result,
              ),
            ),

            PokemonFooter(
              pokemons: pokemons,
              playerChoice: playerChoice,
              onSelected: _play,
            ),
          ],
        ),
      ),
    );
  }
}

class Pokemon {
  final String name;
  final String imagePath;

  Pokemon({
    required this.name,
    required this.imagePath,
  });
}

class PokemonLogo extends StatelessWidget {
  const PokemonLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Image.asset(
        'images/logo_pokemon.png',
        height: 200,
      ),
    );
  }
}

class PokemonHeader extends StatelessWidget {
  const PokemonHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const PokemonLogo();
  }
}

class BattleArena extends StatelessWidget {

  final Pokemon? playerPokemon;
  final Pokemon? enemyPokemon;
  final String result;

  const BattleArena({
    super.key,
    required this.playerPokemon,
    required this.enemyPokemon,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {

    if (playerPokemon == null) {
      return const BattleEmptyState();
    }

    return BattleView(
      playerPokemon: playerPokemon!,
      enemyPokemon: enemyPokemon,
      result: result,
    );
  }
}

class BattleEmptyState extends StatelessWidget {

  const BattleEmptyState({super.key});

  @override
  Widget build(BuildContext context) {

    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Icon(
            Icons.catching_pokemon,
            size: 80,
            color: Colors.red,
          ),

          SizedBox(height: 16),

          Text(
            "Escolha seu Pokémon para iniciar a batalha!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class BattleView extends StatelessWidget {

  final Pokemon playerPokemon;
  final Pokemon? enemyPokemon;
  final String result;

  const BattleView({
    super.key,
    required this.playerPokemon,
    required this.enemyPokemon,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        Expanded(
          child: Row(
            children: [

              Expanded(
                child: PokemonCard(
                  pokemon: playerPokemon,
                  playerName: "Jogador",
                  mirror: false,
                ),
              ),

              Expanded(
                child: PokemonCard(
                  pokemon: enemyPokemon,
                  playerName: "Computador",
                  mirror: true,
                ),
              ),
            ],
          ),
        ),

        BattleResult(result: result),
      ],
    );
  }
}

class PokemonCard extends StatelessWidget {

  final Pokemon? pokemon;
  final String playerName;
  final bool mirror;

  const PokemonCard({
    super.key,
    required this.pokemon,
    required this.playerName,
    required this.mirror,
  });

  @override
  Widget build(BuildContext context) {

    if (pokemon == null) {
      return const SizedBox();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Flexible(
          flex: 3,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(mirror ? 3.14159 : 0),
            child: Image.asset(
              pokemon!.imagePath,
              fit: BoxFit.contain,
            ),
          ),
        ),

        const SizedBox(height: 4),

        Text(
          pokemon!.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(playerName),
      ],
    );
  }
}

class BattleResult extends StatelessWidget {

  final String result;

  const BattleResult({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        result,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
    );
  }
}

class PokemonFooter extends StatelessWidget {

  final List<Pokemon> pokemons;
  final Pokemon? playerChoice;
  final Function(Pokemon) onSelected;

  const PokemonFooter({
    super.key,
    required this.pokemons,
    this.playerChoice,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          const Text(
            "Faça sua jogada de mestre",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          Row(
            children: pokemons.map((p) {

              return Expanded(
                child: PokemonOption(
                  selected: playerChoice == p,
                  pokemon: p,
                  onSelected: (pokemon) => onSelected(p),
                ),
              );

            }).toList(),
          ),
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

          Image.asset(
            selected
                ? "images/pokeball_selected.png"
                : "images/pokeball_unselected.png",
            width: 40,
            height: 40,
          ),

          const SizedBox(height: 4),

          Text(
            pokemon.name,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}