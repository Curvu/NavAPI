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
auto_claims = 1 # can be 0/1, if 1 it will automatically open the "claims" window whenever there is a new claim
```

## Available options (key = value)

| Key            | Value          |
|----------------|----------------|
| store          | 0/1            |
| marketplace    | 0/1            |
| character      | 0/1            |
| inventory      | 0/1            |
| classchanger   | 0/1            |
| achievement    | 0/1            |
| leaderboard    | 0/1            |
| collections    | 0/1            |
| activities     | 0/1            |
| clubs          | 0/1            |
| friendlist     | 0/1            |
| likedworlds    | 0/1            |
| cornerstone    | 0/1            |
| map            | 0/1            |
| welcome        | 0/1            |
| claims         | 0/1            |
| dailyLogin     | 0/1            |
| howtoplay      | 0/1            |
| settings       | 0/1            |
| bomberroyale   | 0/1            |
| atlas          | 0/1            |

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