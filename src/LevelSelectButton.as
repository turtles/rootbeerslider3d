package  
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class LevelSelectButton extends Button 
	{
		public var stars:Array, lvl:int;
		public var coinText:TextField;
		public var snapshot1:Image, snapshot2:Image, snapshot3:Image;
		
		public function LevelSelectButton() {
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function LevelSelectButton(x:int, y:int, level:int)  {
			this.x = x; this.y = y;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.lvl = level;
		}
		
		private function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			upState = Assets.getAtlas().getTexture("levelselect");
			
			
			pivotX = upState.width / 2;
			pivotY = upState.height / 2;
			
			for (var i:int = 0; i < 3; i++) {
				stars.push(new Image(Assets.getAtlas().getTexture("star_levelselect")));
				stars[i].pivotX = stars[i].texture.width / 2;
				stars[i].pivotY = stars[i].texture.height / 2;
				stars[i].x = -60 + i * 20;
				stars[i].y = 24;
				addChild(stars[i]);
			}
			
			var coin:Image = new Image(Assets.getAtlas().getTexture("silvercoin"));
			coin.pivotX = coin.texture.width / 2;
			coin.pivotY = coin.texture.height / 2;
			coin.x = 24;
			coin.y = 24;
			addChild(coin);
			
			coinText = new TextField(80, 32, "", "Main", 16, 0xFFFFFF);
			coinText.hAlign = HAlign.LEFT;
			coinText.vAlign = VAlign.TOP;
			addChild(coinText);
			
		}
		
	}
}