class SpeciesResponse {
  String? id;
  String? url;
  String? scientificName;
  String? type;

  SpeciesResponse({this.id, this.url, this.scientificName, this.type});

  SpeciesResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    scientificName = json['scientificName'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['scientificName'] = this.scientificName;
    data['type'] = this.type;
    return data;
  }
}
