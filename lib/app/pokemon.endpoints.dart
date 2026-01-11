import 'package:pokedex/cores/networking/endpoints.interface.dart'
    show Endpoints;

enum PokemonEndpoints with Endpoints {
  list('get-list', 'pokemon'),
  detail('get-detail', 'pokemon/:id');

  const PokemonEndpoints(this.title, this.path);

  @override
  final String path;

  @override
  final String title;
}
