From: Todd Poynor <tpoynor-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: comments on irc log
Date: Wed, 23 Mar 2005 12:16:27 -0800
Message-ID: <4241CE9B.5050604@mvista.com>
References: <1111113131.25179.73.camel@gaston>	<200503231146.17105.david-b@pacbell.net>
	<200503231153.48230.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <200503231153.48230.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

David Brownell wrote:

>>Thing is, it's the system power states that are placing clock
>>constraints on devices.  On OMAP, going into "deep sleep" means
>>you've got to stop using the 48 MHz clock.  For "big sleep",
>>you can keep using that clock.  Most other CPUs have similar
>>constraints:  multiple system states, defined primarily by
>>clock usage.  
> 
> 
> 
> So to focus on one point:  "pm_message_t" doesn't work well
> at all, since it doesn't have a way to identify the target
> system power state, and drivers thus have no way to see if
> they should drop their requests for those clocks or whether
> the hardware should keep working away.

If I've followed the discussion correctly, it sounds like a lot of the 
system intelligence is targeted at the bus driver level, and the current 
generic platform bus driver for embedded onchip devices will probably 
become something very tied to the particular platform.  If so, then at 
least the bus driver would need to be told of the system state, which 
can code the logic for figuring out which devices must be stopped prior 
to entering a state, and device drivers can simply follow orders to 
suspend.  But I suppose there's some cases in which a device driver may 
have options more complicated than run/suspend in the face of changes in 
clock gating, so having the info available to all drivers could be 
useful even in that situation.

-- 
Todd
