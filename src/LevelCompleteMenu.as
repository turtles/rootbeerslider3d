package  
{
	import away3d.loaders.parsers.ImageParser;
	import Game.Player;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * ...
	 * @author Leah S.
	 */
	public class LevelCompleteMenu extends Sprite 
	{
		private var back:Image, title:Image;
		private var btn_replay:Button, btn_finish:Button;
		private var coinCollection:Array;
		private var starImages:Array = new Array(), movesLeft:int, stars:int, coins:int, totalcoins:int;
		private var movesText:TextField, starsText:TextField, coinsText:TextField;
		private var prStars:Boolean = false, prCoins:Boolean = false;
		
		public function LevelCompleteMenu(movesLeft:int, stars:int, coins:int, totalcoins:int, goldcoins:int, silvercoins:int, coppercoins:int) 
		{
			x = 320;
			y = 250;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			this.movesLeft = movesLeft;
			this.stars = stars;
			this.coins = coins;
			this.totalcoins = totalcoins;
			coinCollection = [goldcoins, silvercoins, coppercoins];
			
			if (Global.stars[Basic_View.currentLevel] < stars) {
				Global.stars[Basic_View.currentLevel] = stars;
				prStars = true;
			}
			if (Global.coins[Basic_View.currentLevel] < coins) {
				Global.coins[Basic_View.currentLevel] = coins;
				prCoins = true;
			}
			if (coins > 0) {
				Basic_View.play_sound_coindrop = true;
			}
			
			if (prStars || prCoins) {
				StarlingForeground.levelselect.setupPage();
				Basic_View.save();
			}
		}
		
		private function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			back = new Image(Assets.getAtlas().getTexture("level_complete"));
			back.pivotX = back.texture.width / 2;
			back.pivotY = back.texture.height / 2;
			addChild(back);
			
			title = new Image(Assets.getAtlas().getTexture("levelcomplete"));
			title.pivotX = title.texture.width / 2;
			title.pivotY = title.texture.height / 2;
			title.y = -150;
			addChild(title);
			
			
			//var t:Tween = new Tween(title, 0.5, "easeOut");
			//title.scaleX = title.scaleY = 1.2;
			//title.alpha = 0.5;
			//t.scaleTo(1);
			//t.fadeTo(1);
			//Starling.juggler.add(t);
			if (movesLeft == 0) {
				movesText = new TextField(480, 80, "Just made it!", "Main", 22, 0xFFFFFF);
			} else if (movesLeft == 1) {
				movesText = new TextField(480, 80, "Finished with 1 move left", "Main", 22, 0xFFFFFF);
			} else {
				movesText = new TextField(480, 80, "Finished with " + movesLeft.toString() + " moves left", "Main", 22, 0xFFFFFF);
			}
			movesText.x = -240;
			movesText.y = -90;
			movesText.touchable = false;
			movesText.hAlign = HAlign.CENTER;
			movesText.vAlign = VAlign.TOP;
			addChild(movesText);
			
			starsText = new TextField(200, 64, stars.toString() + "/3 Stars", "Main", 18, 0xFFFFFF);
			starsText.x = -144;
			starsText.y = 40;
			starsText.touchable = false;
			starsText.hAlign = HAlign.LEFT;
			starsText.vAlign = VAlign.TOP;
			addChild(starsText);
			
			coinsText = new TextField(200, 64, coins.toString() + "/" + totalcoins.toString() + " Cents", "Main", 18, 0xFFFFFF);
			coinsText.x = 16;
			coinsText.y = 40;
			coinsText.touchable = false;
			coinsText.hAlign = HAlign.CENTER;
			coinsText.vAlign = VAlign.TOP;
			addChild(coinsText);
			
			if (prCoins) {
				var prcoins:Image = new Image(Assets.getAtlas().getTexture("pr_token"));
				prcoins.x = 184;
				prcoins.y = coinsText.y- 3;
				addChild(prcoins);
			}
			if (prStars) {
				var prstars:Image = new Image(Assets.getAtlas().getTexture("pr_token"));
				prstars.x = -48;
				prstars.y = starsText.y-3;
				addChild(prstars);
			}
			
			for (var i:int = 0; i < 3; i++) {
				var img:Image;
				if (i+1 <= stars) {
					img = new Image(Assets.getAtlas().getTexture("star"));
					img.y += 1;
				} else {
					img = new Image(Assets.getAtlas().getTexture("nostar"));
				}
				img.pivotX = img.texture.width / 2;
				img.pivotY = img.texture.height / 2;
				img.x = -160 + i * 64;
				img.y -= 12;
				addChild(img);
			}
		
			
			btn_replay = new Button(Assets.getAtlas().getTexture("replay"));
			btn_replay.pivotX = btn_replay.upState.width / 2;
			btn_replay.pivotY = btn_replay.upState.height / 2;
			btn_replay.x = -130;
			btn_finish = new Button(Assets.getAtlas().getTexture("finish"));
			btn_finish.pivotX = btn_finish.upState.width / 2;
			btn_finish.pivotY = btn_finish.upState.height / 2;
			btn_finish.x = 130;
			btn_replay.y = btn_finish.y = 127;
			addChild(btn_replay);
			addChild(btn_finish);
			
			addEventListener(Event.TRIGGERED, onTriggered);
			
			//pivotX = back.texture.width / 2;
			//pivotY = back.texture.height / 2;
			
			//var t1:Tween = new Tween(btn_quit, 0.3, "easeOut");
			//btn_quit.scaleX = btn_quit.scaleY = 0.5;
			//t1.scaleTo(1);
			//Starling.juggler.add(t1);
			
			for (var i:int = 0; i < coinCollection.length; i++) {
				for (var ii:int = 0; ii < coinCollection[i]; ii++) {
					var img:Image = new Image(Assets.getAtlas().getTexture((i == 0 ? "goldcoin" : (i == 1 ? "silvercoin" : "coppercoin"))));
					img.pivotX = img.texture.width / 2;
					img.pivotY = img.texture.height / 2;
					img.x = 128;
					img.y = -8;
					addChild(img);
					var tw:Tween = new Tween(img, 1.0, "easeOut");
					tw.moveTo(img.x - Math.random() * 80 + 40, img.y - Math.random() * 80 + 40);
					Starling.juggler.add(tw);
				}
			}
			
			var t2:Tween = new Tween(this, 0.3, "easeOut");
			scaleX = scaleY = 0.75;
			t2.scaleTo(1);
			Starling.juggler.add(t2);
			Basic_View.save();
			
			//// Show ad?
			//levelsWonSinceLastAd++;
			//if (levelsWonSinceLastAd > 5) {
				//// Show ad!
				//
				//levelsWonSinceLastAd = 0;
			//}
		}
		
		private function onTriggered(e:Event):void {
			var btn:Button = (e.target as Button);
			
			if (btn == btn_replay) {
				Basic_View.restart = true;
				Basic_View.play_sound_button = true;
				removeEventListeners();
				removeFromParent(true);
				dispose();
			}
			if (btn == btn_finish) {
				Basic_View.room = 1;
				Basic_View.play_sound_button = true;
				removeEventListeners();
				removeFromParent(true);
				dispose();
				//removeEventListeners();
				//removeFromParent(true);
			}
		}
		
	}

}