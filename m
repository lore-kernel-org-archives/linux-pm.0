From: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Mockup of a driver.
Date: Thu, 24 Mar 2005 10:28:07 +1100
Message-ID: <1111620485.14853.234.camel@desktop.cunningham.myip.net.au>
Reply-To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============40511143425272955=="
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============40511143425272955==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

Perhaps we can help ourselves solidify this discussion a little by
producing some pseudo code. Here's my first hack at driver "fred". I
haven't made any effort at applying _all_ of the discussion so far. Feel
free to ignore it, pull it to pieces...

Nigel

/* fred_power_management
 *
 * Called on system state transitions and run time transitions
 */
static int fred_power_management(pm_messsage_t * request)
{
	/* The state we're really in */
	static int current_state = FRED_FULL_POWER;

	/* The state we would be in if a system state isn't overriding us */
	static int current_state_rt = FRED_FULL_POWER;

	/* 
	 * pm_message_to_fred_state might be the same function for a whole
	 * swag of devices eg those on a particular bus
	 */
	int fred_state_requested = pm_message_to_fred_state(request);

	int result = 0;

	/* 
	 * Whether a system state or rt state requested, if we're
	 * already in the state, there's nothing to do.
	 */

	if (fred_state_requested == current_state)
		return 0;

	if (request->type == PM_SYSTEM_STATE) {
		/* Can we, and do we want to decline the transition? */
		if (request->can_decline && i_dont_want_to())
			return -ENO_WAY_HOSE;
	} else {
		current_state_rt = fred_state_requested;

		/* Does system state force us to a lower state? */
		if (current_state < fred_state_requested)
			return 0;
	}

	/* 
	 * Perhaps other drivers (not necessarily parent) might like to know
	 * I'm about to change state. They might also want to say "Don't do it!"
	 * Is a notifier chain the best way to do this?
	 * notifier_chain (or whatever) would really be part of the struct device,
	 * I guess.
	 */
	if (result=notifier_call_chain(&fred_pre_state_change_notifier_chain))
		return result;

	switch (fred_state_requested) {
		case FRED_FULL_POWER:
			/* whatever is required to do the transition */
			break;
		
		case FRED_SEMI_CONSCIOUS:
			/* whatever is required to do this transition */
			break;
	}

	/* 
	 * Perhaps other drivers (not necessarily parent) might like to know
	 * I have changed state. They can't complain now, though.
	 */
	notifier_call_chain(&fred_post_state_change_notifier_chain))

	current_state = fred_state_requested;
	return 0;
}

-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net


--===============40511143425272955==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============40511143425272955==--
