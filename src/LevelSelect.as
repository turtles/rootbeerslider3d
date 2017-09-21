package  
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	/**
	 * ...
	 * @author Leah S.
	 */
	public class LevelSelect extends Sprite 
	{
		private var starArray:Array;
		private var previewArray:Array;
		private var coinTextArray:Array;
		private var lockArray:Array;
		private var page:int = 0, buttonArray:Array;
		private var close:Button, nextPage:Button, prevPage:Button;
		//private var back:Image, title_easy:Image, title_normal:Image, title_hard:Image;
		private var title_easy:Image, title_normal:Image, title_hard:Image;
		
		public function LevelSelect() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage():void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			//back = new Image(Assets.getTexture("BackGame"));
			//addChild(back);
			
			close = new Button(Assets.getAtlas().getTexture("x"));
			close.pivotX = close.width / 2;
			close.pivotY = close.height / 2;
			close.x = 600;
			close.y = 42;
			addChild(close);
			
			nextPage = new Button(Assets.getAtlas().getTexture("next"));
			nextPage.pivotX = nextPage.width / 2;
			nextPage.pivotY = nextPage.height / 2;
			nextPage.x = 640 - 86;
			nextPage.y = 448;
			addChild(nextPage);
			
			prevPage = new Button(Assets.getAtlas().getTexture("back"));
			prevPage.pivotX = prevPage.width / 2;
			prevPage.pivotY = prevPage.height / 2;
			prevPage.x = 86;
			prevPage.y = 448;
			addChild(prevPage);
			
			title_easy = new Image(Assets.getAtlas().getTexture("easy"));
			title_normal = new Image(Assets.getAtlas().getTexture("normal"));
			title_hard = new Image(Assets.getAtlas().getTexture("hard"));
			
			title_easy.pivotX = title_easy.width / 2;
			title_normal.pivotX = title_normal.width / 2;
			title_hard.pivotX = title_hard.width / 2;
			
			title_easy.x = title_normal.x = title_hard.x = 320;
			title_easy.y = 7;
			title_normal.y = title_hard.y = 9;
			title_easy.touchable = title_normal.touchable = title_hard.touchable = false;
			
			previewArray = new Array();
			
			for (var i:int = 0; i < 24; i++) {
				//trace("level" + i.toString());
				var img:Image = new Image(Assets.getAtlas().getTexture("level" + i.toString()));
				img.pivotX = img.texture.width / 2;
				img.pivotY = img.texture.height / 2;
				img.y = img.texture.height/2+9;
				img.x = img.texture.width/2+9;
				previewArray.push(img);
			}
			
			lockArray = new Array();
			
			for (var i:int = 0; i < 8; i++) {
				var img:Image = new Image(Assets.getAtlas().getTexture("lock"));
				//img.pivotX = img.texture.width / 2;
				//img.pivotY = img.texture.height / 2;
				//img.y += 160;
				img.visible = false;
				lockArray.push(img);
			}
			
			starArray = new Array();
			coinTextArray = new Array();
			buttonArray = new Array();
			var xmargin:int = 20;
			
			for (var yy:int = 0; yy < 2; yy++) {
				for (var xx:int = 0; xx < 4; xx++) {
					var b:Button = new Button(Assets.getAtlas().getTexture("levelselect"), "", Assets.getAtlas().getTexture("levelselect_down"));
					b.scaleWhenDown = 0.94;
					b.x = xmargin + ((640 - xmargin * 2) / 4) * xx;
					b.y = 83 + yy * 168;
					for (var i:int = 0; i < 3; i++) {
						var star:Image = new Image(Assets.getAtlas().getTexture("star_levelselect"));
						star.x = 9.5 + i*21;
						star.y = 110.5;
						b.mContents.addChild(star);
						starArray.push(star);
					}
					//var coinImg:Image = new Image(Assets.getAtlas().getTexture("silvercoin"));
					//coinImg.pivotX = coinImg.texture.width / 2;
					//coinImg.pivotY = coinImg.texture.height / 2;
					//coinImg.x = 74;
					//coinImg.y = 120;
					//coinImg.scaleX = coinImg.scaleY = 0.5;
					//b.mContents.addChild(coinImg);
					var coinText:TextField = new TextField(120, 32, "", "Main", 14, 0xFFFFFF);
					coinText.x = 18;
					coinText.y = 104;
					coinText.hAlign = HAlign.RIGHT;
					b.mContents.addChild(coinText);
					coinTextArray.push(coinText);
					
					b.mContents.addChild(previewArray[xx + yy * 4]);
					b.mContents.addChild(lockArray[xx + yy * 4]);
					
					addChild(b);
					buttonArray.push(b);
				}
			}
			
			setupPage();
			
			addChild(title_easy);
			addChild(title_normal);
			addChild(title_hard);
		}
		
		public function init():void {
			addEventListener(Event.TRIGGERED, onTriggered);
			
			// Show an ad?
			
			setStars();
			visible = true;
		}
		
		private function setStars():void {
			var staring_i:int = page * 8;
			for (var i:int = 0; i < 8; i++) {
				for (var ii:int = 0; ii < 3; ii++) {
					starArray[i*3 + ii].visible = (ii < Global.stars[staring_i+i]);
				}
			}
		}
		
		public function setupPage():void {
			switch (page) {
				case 0:
					prevPage.visible = false;
					title_easy.visible = true;
					title_normal.visible = false;
					title_hard.visible = false;
				break;
				case 1:
					prevPage.visible = true;
					nextPage.visible = true;
					title_easy.visible = false;
					title_normal.visible = true;
					title_hard.visible = false;
				break;
				case 2:
					nextPage.visible = false;
					title_easy.visible = false;
					title_normal.visible = false;
					title_hard.visible = true;
				break;
			}
			setStars();
			setCoins();
			setPreview();
			setLocks();
		}
		
		private function setLocks():void {
			var unlocks:int = 0;
			for (var i:int = 4; i < 8; i++) {
				lockArray[i].visible = true;
			}
			for (var i:int = 0; i < 8; i++) {
				if (i < 4) {
					if (Global.stars[i + page * 8] == 3)
						unlocks++;
				} else if (unlocks > 0) {
					switch (i) {
						case 4:
							lockArray[i].visible = false;
							if (Global.stars[i + page * 8] == 3) unlocks++;
						break;
						case 5:
							if (unlocks > 1) {
							lockArray[i].visible = false;
							if (Global.stars[i + page * 8] == 3) unlocks++;
							}
						break;
						case 6:
							if (unlocks > 2) {
								lockArray[i].visible = false;
								if (Global.stars[i + page * 8] == 3) unlocks++;
							}
						break;
						case 7:
							if (unlocks > 3) {
								lockArray[i].visible = false;
							}
						break;
					}
				}
			}
			for (var i:int = 4; i < 8; i++) {
				buttonArray[i].touchable = !lockArray[i].visible;
			}
			
		}
		
		private function setPreview():void {
			for (var i:int = 0; i < 8; i ++ ) {
				for (var ii:int = 0; ii < 3; ii++) {
					buttonArray[i].mContents.removeChild(previewArray[ii * 8 + i]);
				}
				buttonArray[i].mContents.addChildAt(previewArray[page * 8 + i], 1);
			}
		}
		
		private function setCoins():void {
			var staring_i:int = page * 8;
			for (var i:int = 0; i < 8; i++) {
				coinTextArray[i].text = Global.coins[staring_i + i].toString() +"/" + Global.totalcoins[staring_i + i].toString();
			}
		}
		
		private function onTriggered(e:Event):void {
			var b:Button = (e.target as Button);
			Basic_View.play_sound_button = true;
			
			if (b == nextPage) {
				if (page < 2) {
					page += 1; 
					setupPage();
				}
			} else if (b == prevPage) {
				if (page > 0) {
					page -= 1; 
					setupPage();
				}
			} else if (b == close) {
				Basic_View.room = 0;
				removeEventListeners();
			} else {
				for (var i:int = 0; i < buttonArray.length; i++) {
					if (b == buttonArray[i]) {
						//trace(i);
						Basic_View.setLevel(i+8*page);
						removeEventListeners();
						Basic_View.room = 2;
					}
				}
			}
		}
		
		public function update():void {
			
		}
	}
}