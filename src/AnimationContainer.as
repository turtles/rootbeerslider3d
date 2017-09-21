package
{
	import away3d.loaders.Loader3D;
	/**
	 * ...
	 * @author Leah S.
	 */
	public class AnimationContainer
	{
		public var model:Loader3D, id:int = -1;
		public var life:Number = 1, ease:Number = 0;

		public function AnimationContainer(id:int, model:Loader3D)
		{
			this.id = id;
			this.model = model;
			if (id == 0) {
				model.rotationY = 0;
			}
			if (id == 1) {
				ease = -0.1;
			}
		}

		public function update():void {
			switch (id) {
				case 0:
					ease += 0.025;
					model.y += 50 * ease;
					model.rotationZ += 15;
					life -= 0.03;
				break;
				case 1:
					ease += 0.01;
					model.y += 50 * ease;
					model.rotationY += 4;
					life -= 0.01;
				break;
			}
		}

	}

}
