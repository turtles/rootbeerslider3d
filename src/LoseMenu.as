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

	public class LoseMenu extends Sprite
	{
		private var back:Image;
		private var btn_replay:Button, btn_quit:Button;

		public function LoseMenu()
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

			btn_replay = new Button(Assets.getAtlas().getTexture("replay"));
			btn_replay.pivotX = btn_replay.upState.width / 2;
			btn_replay.pivotY = btn_replay.upState.height / 2;
			btn_quit = new Button(Assets.getAtlas().getTexture("quitlevel"));
			btn_quit.pivotX = btn_quit.upState.width / 2;
			btn_quit.pivotY = btn_quit.upState.height / 2;

			btn_replay.x = -128;
			btn_quit.x = 128;
			btn_replay.y = btn_quit.y = 32;
			addChild(btn_replay);
			addChild(btn_quit);

			addEventListener(Event.TRIGGERED, onTriggered);

			var t2:Tween = new Tween(this, 0.3, "easeOut");
			scaleX = scaleY = 0.75;
			t2.scaleTo(1);
			Starling.juggler.add(t2);
		}

		private function onTriggered(e:Event):void {
			var btn:Button = (e.target as Button);

			if (btn == btn_replay) {
				Global.pause = false;
				Basic_View.restart = true;
				Basic_View.play_sound_button = true;
				removeEventListeners();
				removeFromParent(true);
				dispose();
			}
			if (btn == btn_quit) {
				Global.pause = false;
				Basic_View.play_sound_button = true;
				Basic_View.room = 1;
				removeEventListeners();
				removeFromParent(true);
				dispose();
			}
		}

	}

}
