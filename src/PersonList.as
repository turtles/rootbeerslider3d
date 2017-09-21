package  
{
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.Screen;
	
	/**
	 * ...
	 * @author Leah S.
	 */
	public class PersonList extends Screen 
	{
		
		private var header:Header;
		private var list:List;
		
		public function PersonList() 
		{
			
		}
		
		override protected function draw():void {
			header.width = actualWidth;
			
			list.y = header.height;
			list.width = actualWidth;
			list.height = actualHeight - header.height;
			
		}
		
		override protected function initialize():void {
			header = new Header();
			header.title = "Gaming Team";
			addChild(header);
			
			list = new List();
			addChild(list);
		}
	}

}