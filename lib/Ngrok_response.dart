class NgrokResponse {
  List<Tunnels>? tunnels;
  String? uri;
  Null? nextPageUri;

  NgrokResponse({this.tunnels, this.uri, this.nextPageUri});

  NgrokResponse.fromJson(Map<String, dynamic> json) {
    if (json['tunnels'] != null) {
      tunnels = <Tunnels>[];
      json['tunnels'].forEach((v) {
        tunnels!.add(new Tunnels.fromJson(v));
      });
    }
    uri = json['uri'];
    nextPageUri = json['next_page_uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tunnels != null) {
      data['tunnels'] = this.tunnels!.map((v) => v.toJson()).toList();
    }
    data['uri'] = this.uri;
    data['next_page_uri'] = this.nextPageUri;
    return data;
  }
}

class Tunnels {
  String? id;
  String? publicUrl;
  String? startedAt;
  String? proto;
  String? region;
  TunnelSession? tunnelSession;
  TunnelSession? endpoint;
  String? forwardsTo;

  Tunnels(
      {this.id,
        this.publicUrl,
        this.startedAt,
        this.proto,
        this.region,
        this.tunnelSession,
        this.endpoint,
        this.forwardsTo});

  Tunnels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    publicUrl = json['public_url'];
    startedAt = json['started_at'];
    proto = json['proto'];
    region = json['region'];
    tunnelSession = json['tunnel_session'] != null
        ? new TunnelSession.fromJson(json['tunnel_session'])
        : null;
    endpoint = json['endpoint'] != null
        ? new TunnelSession.fromJson(json['endpoint'])
        : null;
    forwardsTo = json['forwards_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['public_url'] = this.publicUrl;
    data['started_at'] = this.startedAt;
    data['proto'] = this.proto;
    data['region'] = this.region;
    if (this.tunnelSession != null) {
      data['tunnel_session'] = this.tunnelSession!.toJson();
    }
    if (this.endpoint != null) {
      data['endpoint'] = this.endpoint!.toJson();
    }
    data['forwards_to'] = this.forwardsTo;
    return data;
  }
}

class TunnelSession {
  String? id;
  String? uri;

  TunnelSession({this.id, this.uri});

  TunnelSession.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uri'] = this.uri;
    return data;
  }
}