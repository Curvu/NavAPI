package {
  import flash.display.MovieClip;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.events.Event;
  import flash.external.ExternalInterface;

  public class NavigationMenu extends Sprite {
    public var claim:MovieClip;
    public var daily:MovieClip;
    private var cfg:Object = { "store": null, "marketplace": null, "character": null, "inventory": null, "classchanger": null, "achievement": null, "leaderboard": null, "collections": null, "activities": null, "clubs": null, "friendlist": null, "likedworlds": null, "cornerstone": null, "map": null, "welcome": null, "claims": null, "dailylogin": null, "howtoplay": null, "settings": null, "bomberroyale": null, "atlas": null, "auto_claims": false };

    public function NavigationMenu() {
      super();
      this.build();
      this.setup();
      this.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
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
        if (visible && this.cfg["auto_claims"] == "true")
          ExternalInterface.call("OnMenuOptionSelected", "claims");
        return;
      case 5:
        this.daily.visible = visible;
        return;
      default:
        return;
      }
    }

    private function saveConfig(key:String, value:String) : void {
      ExternalInterface.call("UIComponent.OnSaveConfig", "navigationmenu.swf", key, value);
    }

    private function onLoadModConfiguration(key:String, val:String) : * {
      this.cfg[key] = val;
    }

    private function onEnterFrame(e:Event) : * {
      for (var key:String in this.cfg)
        if (this.cfg[key])
          ExternalInterface.call("OnMenuOptionSelected", this.cfg[key]);
    }
  }
}
