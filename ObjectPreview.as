package {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.external.ExternalInterface;
  import flash.geom.Rectangle;

  public class ObjectPreview extends Sprite {
    private static var listeners:Array = null;

    private var _textureName:String;
    private var image:Bitmap = new Bitmap(new BitmapData(1, 1));

    private var _imageWidth:Number;
    private var _imageHeight:Number;

    private var _loaded:Boolean = false;
    public var loadedCallback:Function = null;

    public function ObjectPreview(width:Number = -1, height:Number = -1) {
      super();
      this._imageWidth = width;
      this._imageHeight = height;
      this.addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage,false,0,true);
      ExternalInterface.addCallback("objectPreviewReady",objectPreviewReady);

      this.addChild(this.image);
    }

    private static function findListener(listener:ObjectPreview) : int {
      if(listeners) {
        var len:int = listeners.length;
        for (var i:int = 0; i < len; i++)
          if (listeners[i] == listener)
            return i;
      }
      return -1;
    }

    public static function objectPreviewReady(name:String) : void {
      if(listeners == null) return;
      var obj:ObjectPreview = null;
      var len:int = int(listeners.length - 1);
      for (; len >= 0; len--) {
        obj = listeners[len] as ObjectPreview;
        if(obj && name == obj.textureName) {
          obj.removeListener();
          obj.replaceTexture();
        }
      }
    }

    public function get imageWidth() : int {
      return this.image.width;
    }

    public function get imageHeight() : int {
      return this.image.height;
    }

    public function get textureName() : String {
      return this._textureName || "";
    }

    public function set textureName(param1:String) : void {
      if(this._textureName == param1) return;
      this._textureName = param1;
      if(!param1 || param1.length == 0) {
        this.removeListener();
        IggyFunctions.setTextureForBitmap(this.image,null);
        this._loaded = false;
      } else this.addListener();
    }

    public function getBitmapBounds() : Rectangle {
      return this.image.getBounds(this.image);
    }

    private function addListener() : void {
      if(!listeners) listeners = [];
      if(findListener(this) == -1) listeners.push(this);
      ExternalInterface.call("UIComponent.CheckTextureExists", this._textureName);
    }

    private function onRemovedFromStage(param1:Event) : void {
      this.removeListener();
    }

    private function removeListener() : void {
      var idx:int = findListener(this);
      if(idx >= 0) listeners.splice(idx, 1);
    }

    private function replaceTexture() : void {
      var bounds:Rectangle = null;
      try {
        IggyFunctions.setTextureForBitmap(this.image, null);
        this.image.scaleX = this.image.scaleY = 1;
        IggyFunctions.setTextureForBitmap(this.image,this._textureName,this._imageWidth,this._imageHeight);
        bounds = this.image.getBounds(this.image);
        this._imageWidth = (this._imageWidth < 0) ? bounds.width : this._imageWidth;
        this._imageHeight = (this._imageHeight < 0) ? bounds.height : this._imageHeight;

        this._loaded = true;
        if(this.loadedCallback != null) this.loadedCallback(this);
      } catch(e:ArgumentError) {
        trace("TextureLoadError: " + e.message);
      }
    }
  }
}
