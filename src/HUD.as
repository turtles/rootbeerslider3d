package  
{
	import away3d.core.math.MathConsts;
	import flash.geom.Point;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.filters.BlurFilter;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	public class HUD extends Sprite 
	{
		public var stars_count:int = 0;
		
		
		public var added:Boolean = false;
		public var stars:Array, back:Image, player:Image;
		private var coinArray:Array, coinPointArray:Array;
		private var blockArray:Array;
		private var hudw:int, hudh:int, hudx:int = 8, hudy:int = 8;
		private var pause:Boolean = false;
		private var pauseMenu:PauseMenu;
		
		private var spinloader:Image, spin1:Image, spin2:Image, spin3:Image;
		private var showspinloader:Boolean = false;
		
		private var movesText:TextField, moves:int = -1, tip:int = 0;
		public var _coins:int, _totalcoins:int, coinText:TextField, coinIcon:Image;
		private var tutorial1:Image, tutorial1_spr:Sprite, tutorial2:Image, tutorial1mousedown:Image, tutorial1mouseup:Image, movesSubtitle:Image;
		private var tutorial1_slide:Number = 0;
		
		public function HUD() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			coinArray = new Array();
			coinPointArray = new Array();
			blockArray = new Array();
		}
		
		private function onAddedToStage(e:Event):void {
			added = true;
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			back = new Image(Assets.getAtlas().getTexture("hud_map1"));
			hudw = back.texture.width;
			hudh = back.texture.height;
			back.x = hudx;
			back.y = hudy;
			addChild(back);
			
			player = new Image(Assets.getAtlas().getTexture("mug_icon"));
			player.pivotX = player.texture.width / 2;
			player.pivotY = player.texture.height / 2;
			addChild(player);
			
			
			movesText = new TextField(96, 64, "", "Main", 48, 0xFFFFFF);
			movesText.hAlign = HAlign.RIGHT;
			movesText.x = 640-96-16;
			movesText.y = 0;
			
			movesSubtitle = new Image(Assets.getAtlas().getTexture("moves"));
			movesSubtitle.pivotX = movesSubtitle.texture.width / 2;
			movesSubtitle.pivotY = movesSubtitle.texture.height / 2;
			movesSubtitle.x = 607;
			movesSubtitle.y = 61;
			addChild(movesSubtitle);
			
			tutorial1_spr = new Sprite();
			
			tutorial1 = new Image(Assets.getAtlas().getTexture("tut1"));
			tutorial1.pivotX = tutorial1.texture.width / 2;
			tutorial1.pivotY = tutorial1.texture.height / 2;
			tutorial1_spr.addChild(tutorial1);
			
			tutorial1mousedown = new Image(Assets.getAtlas().getTexture("mouse1"));
			tutorial1mousedown.pivotX = tutorial1mousedown.texture.width / 2;
			tutorial1mousedown.pivotY = tutorial1mousedown.texture.height / 2;
			tutorial1_spr.addChild(tutorial1mousedown);
			
			tutorial1mouseup = new Image(Assets.getAtlas().getTexture("mouse0"));
			tutorial1mouseup.pivotX = tutorial1mouseup.texture.width / 2;
			tutorial1mouseup.pivotY = tutorial1mouseup.texture.height / 2;
			tutorial1_spr.addChild(tutorial1mouseup);
			
			tutorial1mousedown.y = 32;
			tutorial1mouseup.y = 32;
			
			tutorial1_spr.x = 330;
			tutorial1_spr.y = 90;
			tutorial1_spr.visible= false;
			addChild(tutorial1_spr);
			
			tutorial2 = new Image(Assets.getAtlas().getTexture("tut2"));
			tutorial2.pivotX = tutorial2.texture.width / 2;
			tutorial2.pivotY = tutorial2.texture.height / 2;
			tutorial2.x = 320;
			tutorial2.y = 90;
			tutorial2.visible = false;
			addChild(tutorial2);
			
			stars = new Array();
			for (var i:int = 0; i < 3; i++) {
				var star:Image = new Image(Assets.getAtlas().getTexture("star_level"));
				star.pivotX = star.texture.width / 2;
				star.pivotY = star.texture.height / 2;
				star.x = 500 + 54 * i;
				star.y = 446;
				star.visible = false;
				stars.push(star);
				addChild(star);
			}
			for (var i:int = 0; i < 3; i++) {
				var nostar:Image = new Image(Assets.getAtlas().getTexture("star_level_nostar"));
				nostar.pivotX = nostar.texture.width / 2;
				nostar.pivotY = nostar.texture.height / 2;
				nostar.x = 500 + 54 * i;
				nostar.y = 446;
				stars.push(nostar);
				addChild(nostar);
			}
			for (var i:int = 0; i < 3; i++) {
				var star:Image = new Image(Assets.getAtlas().getTexture("star_level"));
				star.pivotX = star.texture.width / 2;
				star.pivotY = star.texture.height / 2;
				star.x = 500 + 54 * i;
				star.y = 446;
				star.filter = BlurFilter.createGlow(0xffdd55, 1, 2.0, 0.25);
				star.visible = false;
				stars.push(star);
				addChild(star);
			}
			//star.filter = BlurFilter.createGlow(0xffff00, 1.0, 1.0, 0.25);
			
			
			spinloader = new Image(Assets.getAtlas().getTexture("spinloader"));
			spin1 = new Image(Assets.getAtlas().getTexture("1"));
			spin2 = new Image(Assets.getAtlas().getTexture("2"));
			spin3 = new Image(Assets.getAtlas().getTexture("3"));
			spinloader.pivotX = spinloader.texture.width / 2;
			spinloader.pivotY = spinloader.texture.height / 2;
			spin1.pivotX = spin1.texture.width / 2; spin1.pivotY = spin1.texture.height / 2;
			spin2.pivotX = spin2.texture.width / 2; spin2.pivotY = spin2.texture.height / 2;
			spin3.pivotX = spin3.texture.width / 2; spin3.pivotY = spin3.texture.height / 2;
			spinloader.visible = spin1.visible = spin2.visible = spin3.visible = false;
			spinloader.x = spin1.x = spin2.x = spin3.x = 320;
			spinloader.y = spin1.y = spin2.y = spin3.y = 240;
			
			//spinloader.scaleX = spinloader.scaleY = 0.97;
			coinIcon = new Image(Assets.getAtlas().getTexture("silvercoin"));
			coinIcon.pivotX = coinIcon.texture.width / 2;
			coinIcon.pivotY = coinIcon.texture.height / 2;
			coinIcon.x = 540;
			coinIcon.y = 404;
			addChild(coinIcon);
			coinText = new TextField(212, 40, "", "Main", 20, 0xFFFFFF);
			coinText.hAlign = HAlign.RIGHT;
			coinText.x = 420;
			coinText.y = coinIcon.y - coinIcon.texture.height / 2 - 7;
			addChild(coinText);
			
			addChild(spinloader);
			addChild(spin1);
			addChild(spin2);
			addChild(spin3);
			
			addChild(movesText);
		}
		
		public function endLevel(movesLeft:int, stars:int, coins:int, totalcoins:int, goldcoins:int, silvercoins:int, coppercoins:int):void {
			addChild(new LevelCompleteMenu(movesLeft, stars, coins, totalcoins, goldcoins, silvercoins, coppercoins));
		}
		
		public function createLoseMenu():void {
			addChild(new LoseMenu());
		}
		
		public function setCoins(total:int):void {
			_coins = 0;
			_totalcoins = total;
			coinText.visible = coinIcon.visible = true;
			coinText.text = _coins.toString() + "/" + _totalcoins.toString();
		}
		
		public function getCoin(amount:int):void {
			_coins += amount;
			coinText.text = _coins.toString() + "/" + _totalcoins.toString();
		}
		
		public function getStar():void {
			stars_count++;
			switch (stars_count) {
				case 1:
					stars[0].visible = stars[6].visible = true;
					stars[3].visible = false;
				break;
				case 2:
					stars[1].visible = stars[7].visible = true;
					stars[4].visible = false;
				break;
				case 3:
					stars[2].visible = stars[8].visible =  true;
					stars[5].visible = false;
				break;
			}
		}
		
		public function finalize_coins():void {
			for (var i:int = 0; i < coinArray.length; i++) {
				var c:Image = coinArray[i];
				if (c.scaleX == 0.35) {
					setChildIndex(c, 1+getChildIndex(back));
				}
			}
			for (var i:int = 0; i < coinArray.length; i++) {
				var c:Image = coinArray[i];
				if (c.scaleX == 2.0/3.0) {
					setChildIndex(c, 1+getChildIndex(back));
				}
			}
		}
		
		public function add_coin(x:int, y:int, id:int = 0):void {
			if (id < 0 || id > 3) return;
			
			coinPointArray.push(new Point(x, y));
			
			var img:Image;
			
			switch (id) {
				case 0: img = new Image(Assets.getAtlas().getTexture("goldcoin")); img.scaleX = img.scaleY = 0.40; break;
				case 1: img = new Image(Assets.getAtlas().getTexture("silvercoin")); img.scaleX = img.scaleY = 0.35; break;
				case 2: img = new Image(Assets.getAtlas().getTexture("coppercoin")); img.scaleX = img.scaleY = 2.0/3.0; break;
				default: img = new Image(Assets.getAtlas().getTexture("star_hud")); break;
			}
			
			img.pivotX = img.texture.width / 2;
			img.pivotY = img.texture.height / 2;
			img.x = positionx(x);
			img.y = positiony(y);
			
			coinArray.push(img);
			addChild(img);
		}
		
		public function clear_blocks():void {
			while ( blockArray.length > 0) {
				var b:Image = blockArray.pop();
				removeChild(b);
			}
		}
		
		public function tutorial_pace():void {
			tutorial1_spr.visible = false;
			tutorial2.visible = true;
			tutorial2.alpha = 0;
			tutorial2.rotation = 0.25;
			tutorial2.scaleX = tutorial2.scaleY = 0.66;
			var t:Tween = new Tween(tutorial2, 0.25, "easeOut");
			t.fadeTo(1);
			t.scaleTo(1);
			t.animate("rotation", 0);
			Starling.juggler.add(t);
		}
		public function tutorial(mode:int):void {
			switch (mode) {
				case -1:
					tutorial1_spr.visible = tutorial2.visible = false;
				break;
				case 0:
					Starling.juggler.removeTweens(tutorial1_spr);
					Starling.juggler.removeTweens(tutorial2);
					tutorial2.visible = false;
					tutorial1_spr.visible = tutorial1.visible = true;
					tutorial1_spr.alpha = 0.5;
					tutorial1_spr.scaleX = tutorial1_spr.scaleY = 0.66;
					var t:Tween = new Tween(tutorial1_spr, 0.5, "easeOut");
					t.scaleTo(1);
					t.fadeTo(1);
					tutorial1_spr.rotation = -0.25;
					t.animate("rotation", 0);
					Starling.juggler.add(t);
				break;
				case 1:
					Starling.juggler.removeTweens(tutorial1_spr);
					var t:Tween = new Tween(tutorial1_spr, 0.25, "linear");
					t.fadeTo(0);
					t.scaleTo(0.66);
					t.onComplete = tutorial_pace;
					Starling.juggler.add(t);
					tutorial1_spr.visible = false;
					//tutorial2.visible = true;
				break;
				case 2:
					Starling.juggler.removeTweens(tutorial1_spr);
					Starling.juggler.removeTweens(tutorial2);
					var t:Tween = new Tween(tutorial2, 0.25, "linear");
					t.fadeTo(0);
					t.scaleTo(0.66);
					Starling.juggler.add(t);
					//tutorial2.visible = false;
				break;
			}
		}
		
		public function add_block(x:int, y:int):void {
			var img:Image = new Image(Assets.getAtlas().getTexture("box"));
			
			img.pivotX = img.texture.width / 2;
			img.pivotY = img.texture.height / 2;
			img.x = positionx(x);
			img.y = positiony(y);
			
			blockArray.push(img);
			addChildAt(img, getChildIndex(back)+1);
		}
		public function add_floor(x:int, y:int, id:int):void {
			var img:Image;
			if (id == 0) {
				img = new Image(Assets.getAtlas().getTexture("hud_floor"));
			} else {
				img = new Image(Assets.getAtlas().getTexture("hud_win"));
			}
			
			img.pivotX = img.texture.width / 2;
			img.pivotY = img.texture.height / 2;
			img.x = positionx(x);
			img.y = positiony(y);
			
			blockArray.push(img);
			addChildAt(img, getChildIndex(back)+1);
		}
		
		public function remove_coin(x:int, y:int):void {
			for (var i:int = 0; i < coinPointArray.length; i++) {
				if (coinPointArray[i].x == x && coinPointArray[i].y == y) {
					coinPointArray.splice(i, 1);
					removeChild(coinArray[i], true);
					coinArray.splice(i, 1);
				}
			}
		}
		
		public function update():void {
			if (!added) return;
			
			if (Basic_View.endLevel) {
				if (stars[0].visible || stars[3].visible) {
					for (var i:int = 0; i < 9; i++) {
						stars[i].visible = false;
					}
					coinText.visible = coinIcon.visible = false;
				}
				
			} else {
				if (pause != Global.pause) {
					if (Global.pause) {
						addChild(pauseMenu = new PauseMenu(tip));
						tip = (tip + 1) % 5;
					} else {
						if (pauseMenu != null) {
							removeChild(pauseMenu, true);
							pauseMenu = null;
						}
					}
					pause = Global.pause;
				}
				for (var i:int = 6; i < 9; i++) {
					if (stars[i].visible) {
						if (stars[i].alpha-(1.0/60.0) <= 0) {
							stars[i].visible = false;
						} else {
							stars[i].alpha -= 1.0 / 60.0;
						}
					}
				}
				
				if (tutorial1_spr.visible) {
					tutorial1_slide += 0.005+((0.5 - Math.abs(tutorial1_slide-0.5))/30);
					if (tutorial1_slide > 1) 
					{
						tutorial1_slide = 0;
					}
					if (tutorial1_slide < 0.66) {
						tutorial1mouseup.visible = false;
						tutorial1mousedown.visible = true;
					} else {
						tutorial1mouseup.visible = true;
						tutorial1mousedown.visible = false;
					}
					
					tutorial1mouseup.x = tutorial1mousedown.x = -120 + 240 * tutorial1_slide;
				}
			}
		}
		
		public function Reset():void {
			stars_count = 0;
			for (var i:int = 0; i < 9; i++) {
				stars[i].visible = (i > 2 && i < 6);
			}
			setCoins(_totalcoins);
			while (coinArray.length > 0) {
				removeChild(coinArray.pop(), true);
			}
			coinPointArray = new Array();
			// then add coins from parent
		}
		
		public function HideSpinloader():void {
			spinloader.visible = spin1.visible = spin2.visible = spin3.visible = false;
		}
		
		public function Spinloader(ticks:int):void {
			spinloader.visible = true;
			spinloader.rotation = -MathConsts.DEGREES_TO_RADIANS * ((ticks - 10) * 3);
			switch ((ticks / 30) >> 0) { // >> 0 is the same as math.floor for positive numbers
				case 0:
					spin1.visible = true;
					spin2.visible = spin3.visible = false;
				break;
				case 1:
					spin2.visible = true;
					spin1.visible = spin3.visible = false;
				break;
				case 2:
				case 3:
					spin3.visible = true;
					spin1.visible = spin2.visible = false;
				break;
			}
		}
		
		public function update_stats(moves:int):void {
			if (moves != this.moves) {
				movesText.text = moves.toString();
			}
		}
		public function update_player(x:int, y:int):void {
			player.x = positionx(x);
			player.y = positiony(y);
		}
		
		private function positionx(x:int):Number {
			return hudx + (x / 30) + hudw / 2;;
		}
		
		private function positiony(y:int):Number {
			return hudy + (-y / 30) + hudh / 2;
		}
		
		public function update_map_image(level:int):void {
			switch (level) {
				case 1:
					back = new Image(Assets.getAtlas().getTexture("hud_map1"));
				break;
			}
			hudw = back.texture.width;
			hudh = back.texture.height;
			back.x = hudx;
			back.y = hudy;
		}
		
		
		
	}

}