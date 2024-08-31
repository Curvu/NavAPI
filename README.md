# NavAPI
An API for creating custom navigation in Trove between different mods.

## Installation
1. Go to the [releases](https://trovesaurus.com/mod=11096)
2. Install mod and install the config file
3. Place the `NavAPI.tmod` on the mods folder and the `NavAPI.cfg` in `%appdata%/Trove/ModCfgs`

## Costumization
The mod has a config file that allows you to change some of the things:
```bash
[navigationmenu.swf]
auto_claims = true # can be true or false, if true it will automatically open the "claims" window
```

## Available options (key = value)

| Key            | Value          |
|----------------|----------------|
| store          | store          |
| marketplace    | marketplace    |
| character      | character      |
| inventory      | inventory      |
| classchanger   | classChanger   |
| achievement    | achievement    |
| leaderboard    | leaderboard    |
| collections    | collections    |
| activities     | activities     |
| clubs          | clubs          |
| friendlist     | friendList     |
| likedworlds    | likedWorlds    |
| cornerstone    | cornerstone    |
| map            | map            |
| welcome        | welcome        |
| claims         | claims         |
| dailyLogin     | dailyLogin     |
| howtoplay      | howtoplay      |
| settings       | settings       |
| bomberroyale   | bomberRoyale   |
| atlas          | atlas          |


## Snippet Example
```as
private function onInviteAll(e:MouseEvent) : void {
  var timer:Timer = new Timer(600, list.length);
  timer.addEventListener(TimerEvent.TIMER, onTick);
  timer.start();
}

private function onTick(e:TimerEvent) : void {
  cfg.saveExternalConfig("navigationmenu.swf", "friendlist", "friendList");

  // ...
  // invite player
  // ...

  var timer:Timer = new Timer(200, 1);
  timer.addEventListener(TimerEvent.TIMER_COMPLETE, function(e:TimerEvent):void {
    cfg.saveExternalConfig("navigationmenu.swf", "friendlist", "null");
  });
  timer.start();
}
```

## Credits
- Geoflay, base .swf file
- Grainus, idea