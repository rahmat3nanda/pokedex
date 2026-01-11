import 'package:pokedex/cores/core/jsonable.dart' show Json, JsonTrim, Jsonable;

class Pokemon extends Jsonable<Pokemon> {
  const Pokemon({
    this.id,
    this.name,
    this.height,
    this.weight,
    this.order,
    this.baseExperience,
    this.isDefault,
    this.abilities,
    this.types,
    this.stats,
    this.moves,
    this.gameIndices,
    this.species,
    this.sprites,
    this.cries,
  });

  final int? id;
  final String? name;
  final int? height;
  final int? weight;
  final int? order;
  final int? baseExperience;
  final bool? isDefault;

  final List<PokemonAbility>? abilities;
  final List<PokemonType>? types;
  final List<PokemonStat>? stats;
  final List<PokemonMove>? moves;
  final List<GameIndex>? gameIndices;

  final Prop? species;
  final Sprites? sprites;
  final Cries? cries;

  @override
  Pokemon? decode(Json? json) {
    if (json == null) return null;
    return Pokemon(
      id: json['id'],
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
      order: json['order'],
      baseExperience: json['base_experience'],
      isDefault: json['is_default'],
      abilities: (json['abilities'] as List<dynamic>?)
          ?.map((dynamic e) => const PokemonAbility().decode(e))
          .toList()
          .whereType<PokemonAbility>()
          .toList(),
      types: (json['types'] as List<dynamic>?)
          ?.map((dynamic e) => const PokemonType().decode(e))
          .toList()
          .whereType<PokemonType>()
          .toList(),
      stats: (json['stats'] as List<dynamic>?)
          ?.map((dynamic e) => const PokemonStat().decode(e))
          .toList()
          .whereType<PokemonStat>()
          .toList(),
      moves: (json['moves'] as List<dynamic>?)
          ?.map((dynamic e) => const PokemonMove().decode(e))
          .toList()
          .whereType<PokemonMove>()
          .toList(),
      gameIndices: (json['game_indices'] as List<dynamic>?)
          ?.map((dynamic e) => const GameIndex().decode(e))
          .toList()
          .whereType<GameIndex>()
          .toList(),
      species: const Prop().decode(json['species']),
      sprites: const Sprites().decode(json['sprites']),
      cries: const Cries().decode(json['cries']),
    );
  }

  @override
  Json encode() => <String, Object?>{
    'id': id,
    'name': name,
    'height': height,
    'weight': weight,
    'order': order,
    'base_experience': baseExperience,
    'is_default': isDefault,
    'abilities': abilities?.map((PokemonAbility e) => e.encode()).toList(),
    'types': types?.map((PokemonType e) => e.encode()).toList(),
    'stats': stats?.map((PokemonStat e) => e.encode()).toList(),
    'moves': moves?.map((PokemonMove e) => e.encode()).toList(),
    'game_indices': gameIndices?.map((GameIndex e) => e.encode()).toList(),
    'species': species?.encode(),
    'sprites': sprites?.encode(),
    'cries': cries?.encode(),
  }.trim;

  @override
  List<Object?> get props => <Object?>[
    id,
    name,
    height,
    weight,
    order,
    baseExperience,
    isDefault,
    abilities,
    types,
    stats,
    moves,
    gameIndices,
    species,
    sprites,
    cries,
  ];
}

class PokemonAbility extends Jsonable<PokemonAbility> {
  const PokemonAbility({this.ability, this.isHidden, this.slot});

  final Prop? ability;
  final bool? isHidden;
  final int? slot;

  @override
  PokemonAbility? decode(Json? json) {
    if (json == null) return null;
    return PokemonAbility(
      ability: const Prop().decode(json['ability']),
      isHidden: json['is_hidden'],
      slot: json['slot'],
    );
  }

  @override
  Json encode() => <String, Object?>{
    'ability': ability?.encode(),
    'is_hidden': isHidden,
    'slot': slot,
  }.trim;

  @override
  List<Object?> get props => <Object?>[ability, isHidden, slot];
}

class PokemonType extends Jsonable<PokemonType> {
  const PokemonType({this.slot, this.type});

  final int? slot;
  final Prop? type;

  @override
  PokemonType? decode(Json? json) {
    if (json == null) return null;
    return PokemonType(
      slot: json['slot'],
      type: const Prop().decode(json['type']),
    );
  }

  @override
  Json encode() => <String, Object?>{'slot': slot, 'type': type?.encode()}.trim;

  @override
  List<Object?> get props => <Object?>[slot, type];
}

class PokemonStat extends Jsonable<PokemonStat> {
  const PokemonStat({this.baseStat, this.effort, this.stat});

  final int? baseStat;
  final int? effort;
  final Prop? stat;

  @override
  PokemonStat? decode(Json? json) {
    if (json == null) return null;
    return PokemonStat(
      baseStat: json['base_stat'],
      effort: json['effort'],
      stat: const Prop().decode(json['stat']),
    );
  }

  @override
  Json encode() => <String, Object?>{
    'base_stat': baseStat,
    'effort': effort,
    'stat': stat?.encode(),
  }.trim;

  @override
  List<Object?> get props => <Object?>[baseStat, effort, stat];
}

class PokemonMove extends Jsonable<PokemonMove> {
  const PokemonMove({this.move, this.versionDetails});

  final Prop? move;
  final List<MoveVersionDetail>? versionDetails;

  @override
  PokemonMove? decode(Json? json) {
    if (json == null) return null;
    return PokemonMove(
      move: const Prop().decode(json['move']),
      versionDetails: (json['version_group_details'] as List<dynamic>?)
          ?.map((dynamic e) => const MoveVersionDetail().decode(e))
          .toList()
          .whereType<MoveVersionDetail>()
          .toList(),
    );
  }

  @override
  Json encode() => <String, Object?>{
    'move': move?.encode(),
    'version_group_details': versionDetails
        ?.map((MoveVersionDetail e) => e.encode())
        .toList(),
  }.trim;

  @override
  List<Object?> get props => <Object?>[move, versionDetails];
}

class MoveVersionDetail extends Jsonable<MoveVersionDetail> {
  const MoveVersionDetail({
    this.levelLearnedAt,
    this.moveLearnMethod,
    this.versionGroup,
  });

  final int? levelLearnedAt;
  final Prop? moveLearnMethod;
  final Prop? versionGroup;

  @override
  MoveVersionDetail? decode(Json? json) {
    if (json == null) return null;
    return MoveVersionDetail(
      levelLearnedAt: json['level_learned_at'],
      moveLearnMethod: const Prop().decode(json['move_learn_method']),
      versionGroup: const Prop().decode(json['version_group']),
    );
  }

  @override
  Json encode() => <String, Object?>{
    'level_learned_at': levelLearnedAt,
    'move_learn_method': moveLearnMethod?.encode(),
    'version_group': versionGroup?.encode(),
  }.trim;

  @override
  List<Object?> get props => <Object?>[
    levelLearnedAt,
    moveLearnMethod,
    versionGroup,
  ];
}

class GameIndex extends Jsonable<GameIndex> {
  const GameIndex({this.gameIndex, this.version});

  final int? gameIndex;
  final Prop? version;

  @override
  GameIndex? decode(Json? json) {
    if (json == null) return null;
    return GameIndex(
      gameIndex: json['game_index'],
      version: const Prop().decode(json['version']),
    );
  }

  @override
  Json encode() => <String, Object?>{
    'game_index': gameIndex,
    'version': version?.encode(),
  }.trim;

  @override
  List<Object?> get props => <Object?>[gameIndex, version];
}

class Sprites extends Jsonable<Sprites> {
  const Sprites({
    this.frontDefault,
    this.frontShiny,
    this.backDefault,
    this.backShiny,
    this.animated,
    this.other,
    this.versions,
  });

  final String? frontDefault;
  final String? frontShiny;
  final String? backDefault;
  final String? backShiny;

  final Sprites? animated;
  final SpriteOther? other;
  final SpriteVersions? versions;

  @override
  Sprites? decode(Json? json) {
    if (json == null) return null;
    return Sprites(
      frontDefault: json['front_default'],
      frontShiny: json['front_shiny'],
      backDefault: json['back_default'],
      backShiny: json['back_shiny'],
      animated: Sprites().decode(json['animated']),
      other: const SpriteOther().decode(json['other']),
      versions: const SpriteVersions().decode(json['versions']),
    );
  }

  @override
  Json encode() => <String, Object?>{
    'front_default': frontDefault,
    'front_shiny': frontShiny,
    'back_default': backDefault,
    'back_shiny': backShiny,
    'animated': animated?.encode(),
    'other': other?.encode(),
    'versions': versions?.encode(),
  }.trim;

  @override
  List<Object?> get props => <Object?>[
    frontDefault,
    frontShiny,
    backDefault,
    backShiny,
    animated,
    other,
    versions,
  ];
}

class SpriteOther extends Jsonable<SpriteOther> {
  const SpriteOther({this.home, this.officialArtwork, this.dreamWorld});

  final SpriteImage? home;
  final SpriteImage? officialArtwork;
  final SpriteImage? dreamWorld;

  @override
  SpriteOther? decode(Json? json) {
    if (json == null) return null;
    return SpriteOther(
      home: const SpriteImage().decode(json['home']),
      officialArtwork: const SpriteImage().decode(json['official-artwork']),
      dreamWorld: const SpriteImage().decode(json['dream_world']),
    );
  }

  @override
  Json encode() => <String, Object?>{
    'home': home?.encode(),
    'official-artwork': officialArtwork?.encode(),
    'dream_world': dreamWorld?.encode(),
  }.trim;

  @override
  List<Object?> get props => <Object?>[home, officialArtwork, dreamWorld];
}

class SpriteVersions extends Jsonable<SpriteVersions> {
  const SpriteVersions({this.raw});

  final Json? raw;

  @override
  SpriteVersions? decode(Json? json) {
    if (json == null) return null;
    return SpriteVersions(raw: json);
  }

  @override
  Json encode() => <String, Object?>{'raw': raw?.trim}.trim;

  @override
  List<Object?> get props => <Object?>[raw];
}

class SpriteImage extends Jsonable<SpriteImage> {
  const SpriteImage({this.frontDefault, this.frontShiny});

  final String? frontDefault;
  final String? frontShiny;

  @override
  SpriteImage? decode(Json? json) {
    if (json == null) return null;
    return SpriteImage(
      frontDefault: json['front_default'],
      frontShiny: json['front_shiny'],
    );
  }

  @override
  Json encode() => <String, Object?>{
    'front_default': frontDefault,
    'front_shiny': frontShiny,
  }.trim;

  @override
  List<Object?> get props => <Object?>[frontDefault, frontShiny];
}

class Cries extends Jsonable<Cries> {
  const Cries({this.latest, this.legacy});

  final String? latest;
  final String? legacy;

  @override
  Cries? decode(Json? json) {
    if (json == null) return null;
    return Cries(latest: json['latest'], legacy: json['legacy']);
  }

  @override
  Json encode() => <String, Object?>{'latest': latest, 'legacy': legacy}.trim;

  @override
  List<Object?> get props => <Object?>[latest, legacy];
}

class Prop extends Jsonable<Prop> {
  const Prop({this.name, this.url});

  final String? name;
  final String? url;

  @override
  Prop? decode(Json? json) {
    if (json == null) return null;
    return Prop(name: json['name'], url: json['url']);
  }

  @override
  Json encode() => <String, Object?>{'name': name, 'url': url}.trim;

  @override
  List<Object?> get props => <Object?>[name, url];
}
