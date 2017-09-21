package Game 
{
	import away3d.loaders.Loader3D;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Leah S.
	 */
	public class GeneralObject 
	{
		public var model:Loader3D, id:int = -1;
		
		public var x:Number, y:Number, w:int, h:int, xspeed:Number, yspeed:Number;
		public var life:int = 100;
		public var active:Boolean = true; // setting to false should make invisible but it's up to the implementer to decide
		
		public function GeneralObject(x:Number, y:Number, w:int, h:int, xspeed:Number=0, yspeed:Number=0) 
		{
			this.x = x;
			this.y = y;
			this.w = w;
			this.h = h;
			this.xspeed = xspeed;
			this.yspeed = yspeed;
		}
		
		public function update():void {
			if (id == -1) return;
			switch (id) {
				case 0:
				case 1:
				case 2:
					model.rotationY += 10;
				break;
				case 3:
					model.rotationY += 4;
				break;
			}
		}
	}

}