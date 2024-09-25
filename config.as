package {
  public class config {
    public static const menus:Array = ["store", "marketplace", "character", "inventory", "classChanger", "achievement", "leaderboard", "collections", "activities", "clubs", "friendList", "likedWorlds", "cornerstone", "map", "welcome", "claims", "dailyLogin", "howtoplay", "settings", "bomberRoyale", "atlas"];

    public static const parser:Object = {
      "classchanger": "classChanger",
      "friendlist": "friendList",
      "likedworlds": "likedWorlds",
      "dailyLogin": "dailyLogin",
      "bomberroyale": "bomberRoyale"
    };

    public static const TYPE:Object = {
      "INT": 0,
      "BOOL": 1
    };

    public static const convert:Object = {
      "store": [TYPE.BOOL],
      "marketplace": [TYPE.BOOL],
      "character": [TYPE.BOOL],
      "inventory": [TYPE.BOOL],
      "classChanger": [TYPE.BOOL],
      "achievement": [TYPE.BOOL],
      "leaderboard": [TYPE.BOOL],
      "collections": [TYPE.BOOL],
      "activities": [TYPE.BOOL],
      "clubs": [TYPE.BOOL],
      "friendList": [TYPE.BOOL],
      "likedWorlds": [TYPE.BOOL],
      "cornerstone": [TYPE.BOOL],
      "map": [TYPE.BOOL],
      "welcome": [TYPE.BOOL],
      "claims": [TYPE.BOOL],
      "dailyLogin": [TYPE.BOOL],
      "howtoplay": [TYPE.BOOL],
      "settings": [TYPE.BOOL],
      "bomberRoyale": [TYPE.BOOL],
      "atlas": [TYPE.BOOL],
      "auto_claims": [TYPE.BOOL],
      "minimap": [TYPE.BOOL],
      "minimap_opacity": [TYPE.INT, 0, 100],
      "minimap_scale": [TYPE.INT, 0, 300],
      "minimap_x": [TYPE.INT, 0, 5000],
      "minimap_y": [TYPE.INT, 0, 5000],
      "minimap_refresh_delay": [TYPE.INT, -1, 1000]
    };

    public static var cfg:Object = {
      "store": false,
      "marketplace": false,
      "character": false,
      "inventory": false,
      "classChanger": false,
      "achievement": false,
      "leaderboard": false,
      "collections": false,
      "activities": false,
      "clubs": false,
      "friendList": false,
      "likedWorlds": false,
      "cornerstone": false,
      "map": false,
      "welcome": false,
      "claims": false,
      "dailyLogin": false,
      "howtoplay": false,
      "settings": false,
      "bomberRoyale": false,
      "atlas": false,
      "auto_claims": false,
      "minimap": false,
      "minimap_opacity": 80,
      "minimap_scale": 46,
      "minimap_x": 700,
      "minimap_y": 10,
      "minimap_refresh_delay": -1
    };

    public function config() {
      super();
    }
  }
}
