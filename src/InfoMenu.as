package  
{
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class InfoMenu extends Sprite 
	{
		private var back:Image;
		private var btn_okay:Button;
		
		public function InfoMenu() 
		{
			x = 320;
			y = 240;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			back = new Image(Assets.getAtlas().getTexture("nomoremoves"));
			back.pivotX = back.texture.width / 2;
			back.pivotY = back.texture.height / 2;
			addChild(back);
			
			btn_okay = new Button(Assets.getAtlas().getTexture("okay"));
			btn_okay.pivotX = btn_okay.upState.width / 2;
			btn_okay.pivotY = btn_okay.upState.height / 2;
			
			btn_okay.y = 64;
			
			addChild(btn_okay);
			
			addEventListener(Event.TRIGGERED, onTriggered);
			
			//pivotX = back.texture.width / 2;
			//pivotY = back.texture.height / 2;
			
			//var t1:Tween = new Tween(btn_quit, 0.3, "easeOut");
			//btn_quit.scaleX = btn_quit.scaleY = 0.5;
			//t1.scaleTo(1);
			//Starling.juggler.add(t1);
			var t2:Tween = new Tween(this, 0.3, "easeOut");
			scaleX = scaleY = 0.75;
			t2.scaleTo(1);
			Starling.juggler.add(t2);
		}
		
		private function onTriggered(e:Event):void {
			var btn:Button = (e.target as Button);
			
			if (btn == btn_okay) {
				Global.infoscreen = false;
				Basic_View.play_sound_button = true;
				removeEventListeners();
				removeFromParent(true);
				dispose();
			}
		}
		
	}

}