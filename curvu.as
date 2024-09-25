package {
  public class curvu {
    public function curvu() {
      super();
    }

    public static function clamp(p:Number, min:Number, max:Number) : Number {
      return Math.max(min, Math.min(max, p));
    }
  }
}
