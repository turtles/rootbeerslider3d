

package
{
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class StarlingBackground extends Sprite
	{		
		private static var _instance : StarlingBackground;
		
		public static function getInstance():StarlingBackground
		{
			return _instance;
		}

		public function StarlingBackground()
		{
			_instance = this;
			
		}
	}
}