package Game 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	/**
	 * ...
	 * @author Leah S.
	 */
	public class Crosshair extends Sprite
	{
		private var img:Image;
		
		public function Crosshair() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			img = new Image(Assets.getAtlas().getTexture("crosshair"));
			img.x = -500;
			img.y = -500;
			img.pivotX = img.texture.width / 2;
			img.pivotY = img.texture.height / 2;
			
			addChild(img);
		}
		
		public function update():void {
			img.x = Basic_View.globalMouseX;
			img.y = Basic_View.globalMouseY;
		}
	}

}