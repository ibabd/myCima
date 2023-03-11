// ignore_for_file: file_names

class DetailsModel {
  String? id;
  String? title;
  String? author;
  String? thumbnailUrl;
  List<Category>? category;
  List<String>? releaseyear;
  List<Gener>? genre;
  List<Quality>? quality;

  List<Mpaa>? mpaa;

  String? series;
  String? season;
  String? number;
  String? ribbon;
  int? imdbRating;
  String? imdbVotes;
  String? artitle;
  String? alsoKnownAs;
  String? originalName;
  String? location;
  String? story;
  String? runtime;
  String? trailer;
  List<Downloads>? downloads;
  String? imdbID;
  //String? seasonsTabs;
  String? seasonsTabsName;
  List<SeasonsTabsGrid>? seasonsTabsGrid;
  String? watchUrl;
  String? watch;
  String? interest;

  DetailsModel(
      {this.id,
        this.title,
        this.author,
        this.thumbnailUrl,
        this.category,
        this.releaseyear,
        this.genre,
        this.quality,
        this.mpaa,
        this.series,
        this.season,
        this.number,
        this.ribbon,
        this.imdbRating,
        this.imdbVotes,
        this.artitle,
        this.alsoKnownAs,
        this.originalName,
        this.location,
        this.story,
        this.runtime,
        this.trailer,
        this.downloads,
        this.imdbID,
        //this.seasonsTabs,
        this.seasonsTabsName,
        this.seasonsTabsGrid,
        this.watchUrl,
        this.watch,
        this.interest});

  DetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    thumbnailUrl = json['thumbnailUrl'];
    if (json["category"] != null) {
      category = <Category>[];
      json["category"].forEach((v) {
        category!.add(Category.fromJson(v));
      });
    }
    releaseyear = json['releaseyear'].cast<String>();
    if (json['genre'] != null) {
      genre = <Gener>[];
      json['genre'].forEach((v) {
        genre!.add(Gener.fromJson(v));
      });
    }
    if (json['Quality'] != null) {
      quality = <Quality>[];
      json['Quality'].forEach((v) {
        quality!.add(Quality.fromJson(v));
      });
    }

    if (json['mpaa'] != null) {
      mpaa = <Mpaa>[];
      json['mpaa'].forEach((v) {
        mpaa!.add(Mpaa.fromJson(v));
      });
    }
    series = json['series'];
    season = json['season'];
    number = json['number'];
    ribbon = json['ribbon'];
    imdbRating = json['imdbRating'];
    imdbVotes = json['imdb_votes'];
    artitle = json['artitle'];
    alsoKnownAs = json['AlsoKnownAs'];
    originalName = json['originalName'];
    location = json['location'];
    story = json['story'];
    runtime = json['runtime'];
    trailer = json['Trailer'];
    if (json['downloads'] != null) {
      downloads = <Downloads>[];
      json['downloads'].forEach((v) {
        downloads!.add(Downloads.fromJson(v));
      });
    }
    imdbID = json['imdbID'];
    //seasonsTabs = json['seasonsTabs'];
    seasonsTabsName = json['seasonsTabs_name'];
    if (json['seasonsTabs_grid'] != null) {
      seasonsTabsGrid = <SeasonsTabsGrid>[];
      json['seasonsTabs_grid'].forEach((v) {
        seasonsTabsGrid!.add(SeasonsTabsGrid.fromJson(v));
      });
    }
    watchUrl = json['watch_url'];
    watch = json['watch'];
    interest = json['interest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['author'] = author;
    data['thumbnailUrl'] = thumbnailUrl;
    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }
    data['releaseyear'] = releaseyear;
    if (genre != null) {
      data['genre'] = genre!.map((v) => v.toJson()).toList();
    }
    if (quality != null) {
      data['Quality'] = quality!.map((v) => v.toJson()).toList();
    }
    if (mpaa != null) {
      data['mpaa'] = mpaa!.map((v) => v.toJson()).toList();
    }
    data['series'] = series;
    data['season'] = season;
    data['number'] = number;
    data['ribbon'] = ribbon;
    data['imdbRating'] = imdbRating;
    data['imdb_votes'] = imdbVotes;
    data['artitle'] = artitle;
    data['AlsoKnownAs'] = alsoKnownAs;
    data['originalName'] = originalName;
    data['location'] = location;
    data['story'] = story;
    data['runtime'] = runtime;
    data['Trailer'] = trailer;
    if (downloads != null) {
      data['downloads'] = downloads!.map((v) => v.toJson()).toList();
    }
    data['imdbID'] = imdbID;
    //  data['seasonsTabs'] = seasonsTabs;
    data['seasonsTabs_name'] = seasonsTabsName;
    if (seasonsTabsGrid != null) {
      data['seasonsTabs_grid'] =
          seasonsTabsGrid!.map((v) => v.toJson()).toList();
    }
    data['watch_url'] = watchUrl;
    data['watch'] = watch;
    data['interest'] = interest;
    return data;
  }
}

class Category {
  int? termId;
  String? name;
  String? slug;
  int? termGroup;
  int? termTaxonomyId;
  String? taxonomy;
  String? description;
  int? parent;
  int? count;
  String? filter;
  String? termOrder;

  Category(
      {this.termId,
        this.name,
        this.slug,
        this.termGroup,
        this.termTaxonomyId,
        this.taxonomy,
        this.description,
        this.parent,
        this.count,
        this.filter,
        this.termOrder});

  Category.fromJson(Map<String, dynamic> json) {
    termId = json['term_id'];
    name = json['name'];
    slug = json['slug'];
    termGroup = json['term_group'];
    termTaxonomyId = json['term_taxonomy_id'];
    taxonomy = json['taxonomy'];
    description = json['description'];
    parent = json['parent'];
    count = json['count'];
    filter = json['filter'];
    termOrder = json['term_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['term_id'] = termId;
    data['name'] = name;
    data['slug'] = slug;
    data['term_group'] = termGroup;
    data['term_taxonomy_id'] = termTaxonomyId;
    data['taxonomy'] = taxonomy;
    data['description'] = description;
    data['parent'] = parent;
    data['count'] = count;
    data['filter'] = filter;
    data['term_order'] = termOrder;
    return data;
  }
}

class Downloads {
  String? name;
  String? quality;
  String? url;

  Downloads({this.name, this.quality, this.url});

  Downloads.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quality = json['quality'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['quality'] = quality;
    data['url'] = url;
    return data;
  }
}

class SeasonsTabsGrid {
  String? termID;
  String? title;
  String? year;
  int? author;
  String? thumbnailUrl;

  SeasonsTabsGrid(
      {this.termID, this.title, this.year, this.author, this.thumbnailUrl});

  SeasonsTabsGrid.fromJson(Map<String, dynamic> json) {
    termID = json['termID'];
    title = json['title'];
    year = json['year'];
    author = json['author'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['termID'] = termID;
    data['title'] = title;
    data['year'] = year;
    data['author'] = author;
    data['thumbnailUrl'] = thumbnailUrl;
    return data;
  }
}
class Mpaa {
  int? termId;
  String? name;
  String? slug;
  int? termGroup;
  int? termTaxonomyId;
  String? taxonomy;
  String? description;
  int? parent;
  int? count;
  String? filter;
  String? termOrder;

  Mpaa(
      {this.termId,
        this.name,
        this.slug,
        this.termGroup,
        this.termTaxonomyId,
        this.taxonomy,
        this.description,
        this.parent,
        this.count,
        this.filter,
        this.termOrder});

  Mpaa.fromJson(Map<String, dynamic> json) {
    termId = json['term_id'];
    name = json['name'];
    slug = json['slug'];
    termGroup = json['term_group'];
    termTaxonomyId = json['term_taxonomy_id'];
    taxonomy = json['taxonomy'];
    description = json['description'];
    parent = json['parent'];
    count = json['count'];
    filter = json['filter'];
    termOrder = json['term_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['term_id'] = termId;
    data['name'] = name;
    data['slug'] = slug;
    data['term_group'] = termGroup;
    data['term_taxonomy_id'] = termTaxonomyId;
    data['taxonomy'] = taxonomy;
    data['description'] = description;
    data['parent'] = parent;
    data['count'] = count;
    data['filter'] = filter;
    data['term_order'] = termOrder;
    return data;
  }
}
class Gener {
  int? termId;
  String? name;
  String? slug;
  int? termGroup;
  int? termTaxonomyId;
  String? taxonomy;
  String? description;
  int? parent;
  int? count;
  String? filter;
  String? termOrder;

  Gener(
      {this.termId,
        this.name,
        this.slug,
        this.termGroup,
        this.termTaxonomyId,
        this.taxonomy,
        this.description,
        this.parent,
        this.count,
        this.filter,
        this.termOrder});

  Gener.fromJson(Map<String, dynamic> json) {
    termId = json['term_id'];
    name = json['name'];
    slug = json['slug'];
    termGroup = json['term_group'];
    termTaxonomyId = json['term_taxonomy_id'];
    taxonomy = json['taxonomy'];
    description = json['description'];
    parent = json['parent'];
    count = json['count'];
    filter = json['filter'];
    termOrder = json['term_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['term_id'] = termId;
    data['name'] = name;
    data['slug'] = slug;
    data['term_group'] = termGroup;
    data['term_taxonomy_id'] = termTaxonomyId;
    data['taxonomy'] = taxonomy;
    data['description'] = description;
    data['parent'] = parent;
    data['count'] = count;
    data['filter'] = filter;
    data['term_order'] = termOrder;
    return data;
  }
}
class Quality {
  int? termId;
  String? name;
  String? slug;
  int? termGroup;
  int? termTaxonomyId;
  String? taxonomy;
  String? description;
  int? parent;
  int? count;
  String? filter;
  String? termOrder;

  Quality(
      {this.termId,
        this.name,
        this.slug,
        this.termGroup,
        this.termTaxonomyId,
        this.taxonomy,
        this.description,
        this.parent,
        this.count,
        this.filter,
        this.termOrder});

  Quality.fromJson(Map<String, dynamic> json) {
    termId = json['term_id'];
    name = json['name'];
    slug = json['slug'];
    termGroup = json['term_group'];
    termTaxonomyId = json['term_taxonomy_id'];
    taxonomy = json['taxonomy'];
    description = json['description'];
    parent = json['parent'];
    count = json['count'];
    filter = json['filter'];
    termOrder = json['term_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['term_id'] = termId;
    data['name'] = name;
    data['slug'] = slug;
    data['term_group'] = termGroup;
    data['term_taxonomy_id'] = termTaxonomyId;
    data['taxonomy'] = taxonomy;
    data['description'] = description;
    data['parent'] = parent;
    data['count'] = count;
    data['filter'] = filter;
    data['term_order'] = termOrder;
    return data;
  }
}

