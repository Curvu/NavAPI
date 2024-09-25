package {
  import flash.display.Bitmap;

  public class IggyFunctions {
    public function IggyFunctions() {
      super();
    }

    public static function setTextureForBitmap(param1:Bitmap, param2:Object, param3:int = -1, param4:int = -1) : * {
      if(!(param2 is String))
        if(param2 != null)
          throw new TypeError("must be String or null");
    }
  }
}
