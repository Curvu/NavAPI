package {
  import flash.display.MovieClip;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.external.ExternalInterface;
  import flash.geom.*;

  // TODO: startup minimap
  // TODO: minimap is opening without reason when doing ship

  public class NavigationMenu extends Sprite {
    public var claim:MovieClip;
    public var daily:MovieClip;

    public var miniMap:ObjectPreview;
    public var miniMapEnabled:Boolean;
    public var miniMapStartupCheck:Boolean;
    public var refreshDelayCounter:int = 0;

    public function NavigationMenu() {
      super();
      this.miniMap = new ObjectPreview();
      this.miniMap.textureName = "_WorldMap";
      ExternalInterface.call("UIComponent.OnSaveConfig", "map.swf", "minimap_disable_map", "0");
      this.build();
      this.setup();
    }

    private function build() : void {
      this.claim.data = 4;
      this.daily.data = 5;
      this.addEventListener(MouseEvent.CLICK, this.onTrayOption);
      this.stage.addEventListener(Event.RESIZE, this.onStageResize);
      this.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
    }

    private function setup() : void {
      ExternalInterface.addCallback("showMenu", this.toggleMinimap);
      ExternalInterface.addCallback("showTrayButton", this.showTrayButton);
      ExternalInterface.addCallback("loadModConfiguration", this.onLoadModConfiguration);
      ExternalInterface.call("OnConfigured");
    }

    public function onEnterFrame(e:Event) : void {
      for (var key:String in config.menus) {
        if (config.cfg[key]) {
          ExternalInterface.call("OnMenuOptionSelected", key);
        }
      }

      if (!config.cfg.minimap || !this.miniMapEnabled) return;
      if(++this.refreshDelayCounter >= config.cfg.minimap_refresh_delay) {
        ExternalInterface.call("OnMenuOptionSelected", "map");
        this.refreshDelayCounter = 0;
      }
    }

    private function onTrayOption(e:MouseEvent) : void {
      var opt:MovieClip = e.target as MovieClip;
      if(opt) ExternalInterface.call("OnTrayOptionSelected", opt.data);
    }

    private function showTrayButton(btn:int, visible:Boolean) : void {
      switch(btn) {
      case 4:
        this.claim.visible = visible;
        if (visible && config.cfg.auto_claims)
          ExternalInterface.call("OnMenuOptionSelected", "claims");
        return;
      case 5:
        this.daily.visible = visible;
        return;
      default:
        return;
      }
    }

    public function onLoadModConfiguration(key:String, val:String) : void {
      key = config.parser[key] || key;
      switch(config.convert[key][0]) {
      case config.TYPE.INT:
        config.cfg[key] = int(curvu.clamp(Number(val), config.convert[key][1], config.convert[key][2]));
        break;
      case config.TYPE.BOOL:
        config.cfg[key] = val == "true";
        break;
      default:
        break;
      }

      if(key.indexOf("minimap") == 0) this.updateMinimap();
    }

    public function onStageResize(e:Event) : void {
      this.updateMinimap();
    }

    public function toggleMinimap(toggle:Boolean) : void {
      if (!toggle || !config.cfg.minimap) return;
      this.miniMapEnabled = !this.miniMapEnabled;
      if(this.miniMapEnabled) this.updateMinimap();
      else this.destroyMinimap();
    }

    public function destroyMinimap() : void {
      this.miniMapStartupCheck = false;
      this.removeChild(this.miniMap);
      ExternalInterface.call("UIComponent.OnSaveConfig", "map.swf", "minimap_disable_map", "0");
      ExternalInterface.call("UIComponent.OnSaveConfig", "map.swf", "minimap_recently_closed", "1");
      ExternalInterface.call("UIComponent.OnSaveConfig", "map.swf", "minimap_recently_closed", "0");
    }

    public function updateMinimap() : void {
      if(!config.cfg.minimap) return;
      if(!this.miniMapStartupCheck) {
        this.miniMapStartupCheck = true;
        this.miniMapEnabled = true;
        this.addChild(this.miniMap);
        ExternalInterface.call("UIComponent.OnSaveConfig", "map.swf", "minimap_disable_map", "1");
      }
      if(!this.miniMapEnabled) return;
      this.miniMap.alpha = config.cfg.minimap_opacity / 100;
      this.miniMap.scaleX = config.cfg.minimap_scale / 100;
      this.miniMap.scaleY = config.cfg.minimap_scale / 100;
      var xPos:* = this.stage.fullScreenWidth * config.cfg.minimap_x;
      var yPos:* = this.stage.fullScreenHeight * config.cfg.minimap_y;
      var pos:* = this.globalToLocal(new Point(xPos / 1137, yPos / 1137));
      this.miniMap.x = pos.x;
      this.miniMap.y = pos.y;
    }
  }
}
