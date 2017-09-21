package
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.engine.FontDescription;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;

	/**
	 * ...
	 * @author Leah S.
	 */
	public class TitleScreen extends Sprite
	{
		//private var back:Image;
		private var title:Image;

		private var info:Sprite;
		private var btn_start:Button, btn_info:Button, btn_info_close:Button;
		private var btn_logo:Button;

		public function TitleScreen() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage():void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			btn_logo = new Button(Assets.getAtlas().getTexture("logo"));
			btn_logo.alignPivot();
			btn_logo.x = 320;
			btn_logo.y = 48;
			btn_logo.scaleX = btn_logo.scaleY = 0.85;
			addChild(btn_logo);

			title = new Image(Assets.getAtlas().getTexture("title"));
			title.pivotX = title.width / 2;
			title.pivotY = title.height / 2;

			title.x = 320;
			title.y = 200;

			addChild(title);

			btn_start = new Button(Assets.getAtlas().getTexture("click_to_play"));
			btn_start.pivotX = btn_start.upState.width / 2;
			btn_start.pivotY = btn_start.upState.height / 2;
			btn_start.x = 320;
			btn_start.y = 400;
			addChild(btn_start);

			btn_info = new Button(Assets.getAtlas().getTexture("info"));
			btn_info.pivotX = btn_info.upState.width / 2;
			btn_info.pivotY = btn_info.upState.height / 2;
			btn_info.x = 608;
			btn_info.y = 32;
			addChild(btn_info);

			info = new Sprite();
			info.x = 320;
			info.y = 240;
			var infoImg = new Image(Assets.getAtlas().getTexture("soundcredits"));
			infoImg.pivotX = infoImg.texture.width / 2;
			infoImg.pivotY = infoImg.texture.height / 2;
			info.addChild(infoImg);

			btn_info_close = new Button(Assets.getAtlas().getTexture("okay"));
			btn_info_close.pivotX = btn_info_close.upState.width / 2;
			btn_info_close.pivotY = btn_info_close.upState.height / 2;
			btn_info_close.y = 136;
			info.addChild(btn_info_close);

			info.visible = false;
			addChild(info);

		}

		public function init():void {
			addEventListener(Event.TRIGGERED, onTriggered);
			visible = true;
		}

		private function hideInfo():void {
			info.visible = false;
			btn_start.touchable = true;
		}

		private function showInfo():void {
			info.visible = true;
			var t2:Tween = new Tween(info, 0.3, "easeOut");
			info.scaleX = info.scaleY = 0.75;
			t2.scaleTo(1);
			Starling.juggler.add(t2);
			btn_start.touchable = false;
		}

		private function onTriggered(e:Event):void {
			var btn:Button = (e.target as Button);

			if (btn == btn_info) {
				if (info.visible) {
					hideInfo();
				} else {
					showInfo();
				}
			}
			if (btn == btn_info_close) {
				hideInfo();
			}
			if (btn == btn_logo)
			{
				OpenWebsite();
			}

			if (btn == btn_start) {
				Basic_View.play_sound_button = true;
				StarlingForeground.levelselect.setupPage();
				Basic_View.room = 1;

				btn_start.removeEventListener(Event.TRIGGERED, onTriggered);
			}

		}

		private function OpenWebsite():void
		{
			navigateToURL(new URLRequest("http://www.codeinferno.com/"), "_blank");
		}

	}
}
