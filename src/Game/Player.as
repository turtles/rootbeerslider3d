package Game
{
	import away3d.core.math.MathConsts;
	import away3d.primitives.CubeGeometry;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Leah S.
	 */
	public class Player
	{
		public var body:b2Body;
		public var moves:int = 7;

		public var xstart:int, ystart:int, mousexstart:int=-1, mouseystart:int=-1, drag:Boolean = false;
		private var lastMouse:Point;

		private const walkspeed:int = 8;
		private const friction:Number = 0.98;
		public var x:Number=0, y:Number=0;
		public var xspeed:Number=0, yspeed:Number=0;
		public var rotation:Number = 0;
		public var w:int = 108, h:int = 108;
		private var direction:int = 1;

		public function Player()
		{

		}

		public function PlaceFree(x:int, y:int, x2:int, y2:int):Boolean {
			// x2 and y2 are a second test (for in-between position)
			var self:Rectangle = new Rectangle(x-w/2-8, y-h/2-2, w, h);
			var self2:Rectangle = new Rectangle(x2-w/2-8, y2-h/2-2, w, h);
			for (var i:int = 0; i < Basic_View.solidlist.length; i++) {
				if (self.intersects(Basic_View.solidlist[i])) return false;
				if (self2.intersects(Basic_View.solidlist[i])) return false;
			}
			return true;
		}

		public function update():void {//keyLeft:Boolean, keyRight:Boolean, keyUp:Boolean, keyDown:Boolean):void {
			var limit:int = 150;

			if (drag) {
				var dragx:Number, dragy:Number;
				dragx = (Basic_View.globalMouseX - mousexstart);
				dragy = (Basic_View.globalMouseY - mouseystart);

				if (Math.sqrt(dragx * dragx + dragy * dragy) > limit) {
					var atan2:Number = Math.atan2( dragy, -dragx);
					dragx = -limit*Math.cos(atan2);
					dragy = limit*Math.sin(atan2);
				}

				x = xstart + dragx;
				y = ystart - dragy;

				lastMouse = new Point(Basic_View.globalMouseX, Basic_View.globalMouseY);
			} else {
				if (mousexstart != -1 && mouseystart != -1) {
					//xspeed = Math.sqrt(Math.pow(Basic_View.globalMouseX - mousexstart, 2) + Math.pow(Basic_View.globalMouseY - mouseystart, 2));

					xspeed = (Basic_View.globalMouseX - lastMouse.x)*2;
					yspeed = -(Basic_View.globalMouseY - lastMouse.y)*2;

					var speed:Number = Math.sqrt(xspeed * xspeed + yspeed * yspeed);

					if (!PlaceFree(x, y, xstart + (x - xstart) / 2, ystart + (y - ystart) / 2)) {
						x = xstart;
						y = ystart;
					}
					if (speed < 2) {
						xspeed = 0;
						yspeed = 0;
						x = xstart;
						y = ystart;
					} else {
						if (speed > 200) {
							var atan2:Number = Math.atan2( yspeed, xspeed);
							xspeed = 200*Math.cos(atan2);
							yspeed = 200*Math.sin(atan2);
						}
						moves--;
					}

					body.SetPosition(new b2Vec2(x*Basic_View.worldScale, y*Basic_View.worldScale));
					body.SetLinearVelocity(new b2Vec2(xspeed*2, yspeed*2));

					mousexstart = -1;
					mouseystart = -1;
				}
				x = body.GetPosition().x/Basic_View.worldScale;
				y = body.GetPosition().y/Basic_View.worldScale;
				rotation = -body.GetAngle()*MathConsts.RADIANS_TO_DEGREES;
			}

		}
	}
}
