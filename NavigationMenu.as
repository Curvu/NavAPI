package {
  import flash.display.MovieClip;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.events.Event;
  import flash.external.ExternalInterface;

  public class NavigationMenu extends Sprite {
    public var claim:MovieClip;
    public var daily:MovieClip;

    private const parser:Object = { "store": "store", "marketplace": "marketplace", "character": "character", "inventory": "inventory", "classchanger": "classChanger", "achievement": "achievement", "leaderboard": "leaderboard", "collections": "collections", "activities": "activities", "clubs": "clubs", "friendlist": "friendList", "likedworlds": "likedWorlds", "cornerstone": "cornerstone", "map": "map", "welcome": "welcome", "claims": "claims", "dailyLogin": "dailyLogin", "howtoplay": "howtoplay", "settings": "settings", "bomberroyale": "bomberRoyale", "atlas": "atlas", "auto_claims": "auto_claims" };

    public const TYPE:Object = {
      "INT": 0
    };

    public const convert:Object = {
      "store": [TYPE.INT, 0, 1],
      "marketplace": [TYPE.INT, 0, 1],
      "character": [TYPE.INT, 0, 1],
      "inventory": [TYPE.INT, 0, 1],
      "classChanger": [TYPE.INT, 0, 1],
      "achievement": [TYPE.INT, 0, 1],
      "leaderboard": [TYPE.INT, 0, 1],
      "collections": [TYPE.INT, 0, 1],
      "activities": [TYPE.INT, 0, 1],
      "clubs": [TYPE.INT, 0, 1],
      "friendList": [TYPE.INT, 0, 1],
      "likedWorlds": [TYPE.INT, 0, 1],
      "cornerstone": [TYPE.INT, 0, 1],
      "map": [TYPE.INT, 0, 1],
      "welcome": [TYPE.INT, 0, 1],
      "claims": [TYPE.INT, 0, 1],
      "dailyLogin": [TYPE.INT, 0, 1],
      "howtoplay": [TYPE.INT, 0, 1],
      "settings": [TYPE.INT, 0, 1],
      "bomberRoyale": [TYPE.INT, 0, 1],
      "atlas": [TYPE.INT, 0, 1],
      "auto_claims": [TYPE.INT, 0, 1]
    };

    private var cfg:Object = {
      "store": 0,
      "marketplace": 0,
      "character": 0,
      "inventory": 0,
      "classChanger": 0,
      "achievement": 0,
      "leaderboard": 0,
      "collections": 0,
      "activities": 0,
      "clubs": 0,
      "friendList": 0,
      "likedWorlds": 0,
      "cornerstone": 0,
      "map": 0,
      "welcome": 0,
      "claims": 0,
      "dailyLogin": 0,
      "howtoplay": 0,
      "settings": 0,
      "bomberRoyale": 0,
      "atlas": 0,
      "auto_claims": 0
    };

    public function NavigationMenu() {
      super();
      this.build();
      this.setup();
    }

    private function build() : void {
      this.claim.data = 4;
      this.daily.data = 5;
      this.addEventListener(MouseEvent.CLICK, this.onTrayOption);
    }

    private function setup() : void {
      ExternalInterface.addCallback("loadModConfiguration", this.onLoadModConfiguration);
      ExternalInterface.addCallback("showTrayButton", this.showBtn);
    }

    private function onTrayOption(e:MouseEvent) : void {
      var opt:MovieClip = e.target as MovieClip;
      if(opt) ExternalInterface.call("OnTrayOptionSelected", opt.data);
    }

    private function showBtn(btn:int, visible:Boolean) : void {
      switch(btn) {
      case 4:
        this.claim.visible = visible;
        if (visible && this.cfg["auto_claims"])
          ExternalInterface.call("OnMenuOptionSelected", "claims");
        return;
      case 5:
        this.daily.visible = visible;
        return;
      default:
        return;
      }
    }

    public static function clamp(p:Number, min:Number, max:Number) : Number {
      return Math.max(min, Math.min(max, p));
    }

    private function onLoadModConfiguration(key:String, val:String) : * {
      if ((key = this.parser[key]) == null) return;
      switch(convert[key][0]) {
      case TYPE.INT:
        cfg[key] = int(clamp(Number(val), convert[key][1], convert[key][2]));
        break;
      default:
        break;
      }

      if(!hasEventListener(Event.ENTER_FRAME) && val == "1")
        addEventListener(Event.ENTER_FRAME, onEnterFrame)
    }

    private function onEnterFrame(e:Event) : * {
      var found:Boolean = false;
      for (var key:String in this.cfg) {
        if (this.cfg[key]) {
          ExternalInterface.call("OnMenuOptionSelected", key);
          found = true;
        }
      }
      if(!found) removeEventListener(Event.ENTER_FRAME, onEnterFrame);
    }
  }
}
