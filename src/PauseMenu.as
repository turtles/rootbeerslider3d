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

	/**
	 * ...
	 * @author Leah S.
	 */
	public class PauseMenu extends Sprite
	{
		private var back:Image, title:Image;
		private var btn_unpause:Button, btn_quit:Button, btn_restart:Button;
		private var quickTip:TextField, quickTipTitle:TextField, tip:int;

		public function PauseMenu(tip:int = 0)
		{
			x = 320;
			y = 244;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.tip = tip;
		}

		private function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);


			back = new Image(Assets.getAtlas().getTexture("pausemenu"));
			back.pivotX = back.texture.width / 2;
			back.pivotY = back.texture.height / 2;
			back.y = 12;
			//back.x = 320;
			//back.y = 0;
			addChild(back);

			title = new Image(Assets.getAtlas().getTexture("paused"));
			title.pivotX = title.texture.width / 2;
			title.pivotY = title.texture.height / 2;
			title.y = -172;
			addChild(title);

			btn_unpause = new Button(Assets.getAtlas().getTexture("resume"));
			btn_unpause.pivotX = btn_unpause.upState.width / 2;
			btn_unpause.pivotY = btn_unpause.upState.height / 2;
			btn_unpause.y = 58;
			addChild(btn_unpause);

			btn_restart = new Button(Assets.getAtlas().getTexture("restart"));
			btn_restart.pivotX = btn_restart.upState.width / 2;
			btn_restart.pivotY = btn_restart.upState.height / 2;
			btn_restart.y = 58+60;
			addChild(btn_restart);

			btn_quit = new Button(Assets.getAtlas().getTexture("quitlevel"));
			btn_quit.pivotX = btn_quit.upState.width / 2;
			btn_quit.pivotY = btn_quit.upState.height / 2;
			btn_quit.y = 58+60*2;

			quickTipTitle = new TextField(286, 32, "Quick Tips:", "Main", 24, 0xFFFFFF);
			quickTipTitle.x = -143;
			quickTipTitle.y = -112;
			var str:String;
			switch (tip) {
				case 0: str = "Drag and flick the mouse. The faster you flick, the farther the rootbeer mug slides."; break;
				case 1: str = "There’s no penalty for restarting a level."; break;
				case 2: str = "Collect all 3 stars to unlock new levels."; break;
				case 3: str = "Slide the mug to the end zone before running out of moves."; break;
				case 4: str = "Hold SPACEBAR and move the mouse to look around the level."; break;
				default: str = "";
			}
			quickTip = new TextField(286, 200, str, "Main", 18, 0xFFFFFF);
			quickTip.x = -143;
			quickTip.y = -74;
			quickTip.touchable = false;
			quickTipTitle.hAlign = quickTip.hAlign = HAlign.LEFT;
			quickTipTitle.vAlign = quickTip.vAlign = VAlign.TOP;
			quickTipTitle.touchable = quickTip.touchable = false;
			addChild(quickTipTitle);
			addChild(quickTip);

			addChild(btn_quit);

			addEventListener(Event.TRIGGERED, onTriggered);
			
			var t2:Tween = new Tween(this, 0.3, "easeOut");
			scaleX = scaleY = 0.75;
			t2.scaleTo(1);
			Starling.juggler.add(t2);
		}

		private function onTriggered(e:Event):void {
			var btn:Button = (e.target as Button);

			if (btn == btn_unpause) {
				Global.pause = false;
				Basic_View.play_sound_button = true;
				removeEventListeners();
				removeFromParent(true);
			}
			if (btn == btn_restart) {
				Global.pause = false;
				Basic_View.play_sound_button = true;
				Basic_View.restart = true;
				removeEventListeners();
				removeFromParent(true);
			}
			if (btn == btn_quit) {
				Global.pause = false;
				Basic_View.room = 1;
				Basic_View.play_sound_button = true;
				removeEventListeners();
				removeFromParent(true);
				//removeEventListeners();
				//removeFromParent(true);
			}
		}

	}

}
