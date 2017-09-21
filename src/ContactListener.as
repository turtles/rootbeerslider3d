package
{
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.Contacts.b2Contact;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * ...
	 * @author Leah S.
	 */
	 public class ContactListener extends b2ContactListener
	 {
        public static const MUG_HIT_BLOCK:String = "HITBLOCK";
        public var eventDispatcher:EventDispatcher;

        public function ContactListener()
        {
        	eventDispatcher = new EventDispatcher();
        }

        override public function BeginContact(contact:b2Contact):void
        {
        	if ((contact.GetFixtureA().GetBody().GetUserData() == "mug" && contact.GetFixtureB().GetBody().GetUserData() == "block")
        			|| (contact.GetFixtureA().GetBody().GetUserData() == "block" && contact.GetFixtureB().GetBody().GetUserData() == "mug")) {
        	eventDispatcher.dispatchEvent(new Event(MUG_HIT_BLOCK));
        }
		}
	}
}
