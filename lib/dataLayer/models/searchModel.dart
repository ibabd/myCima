class SearchModel {
  List<String>? tabs;
  Names? names;
  List<Posts>? posts;

  SearchModel({this.tabs, this.names, this.posts});

  SearchModel.fromJson(Map<String, dynamic> json) {
    tabs = json['tabs'].cast<String>();
    names = json['names'] != null ? Names.fromJson(json['names']) : null;
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(Posts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tabs'] = tabs;
    if (names != null) {
      data['names'] = names!.toJson();
    }
    if (posts != null) {
      data['posts'] = posts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Names {
  String? movies;
  String? series;
  String? anime;
  String? tv;

  Names({this.movies, this.series, this.anime, this.tv});

  Names.fromJson(Map<String, dynamic> json) {
    movies = json['movies'];
    series = json['series'];
    anime = json['anime'];
    tv = json['tv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['movies'] = movies;
    data['series'] = series;
    data['anime'] = anime;
    data['tv'] = tv;
    return data;
  }
}

class Posts {
  String ?id;
  String? title;
  String? year;
  int? author;
  String? thumbnailUrl;

  Posts({ this.id, this.title, this.year, this.author, this.thumbnailUrl});

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    year = json['year'];
    author = json['author'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['year'] = year;
    data['author'] = author;
    data['thumbnailUrl'] = thumbnailUrl;
    return data;
  }
}
/*
final bool connected = connectivity != ConnectivityResult.none;
        if (connected) {
          BlocProvider.of<CimaCubit>(context).myShearches.isNotEmpty
            ? buildSerchBlocWidget()
            : buildBlocWidget();
        } else {
          return buildNoInternet();
        }
      },
 */