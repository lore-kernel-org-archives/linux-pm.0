From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Power Management framework proposal
Date: Sun, 22 Jul 2007 21:19:17 -0700
Message-ID: <1185164357.2714.49.camel__3370.52841573513$1185164522$gmane$org@laptopd505.fenrus.org>
References: <Pine.LNX.4.64.0707212339550.6350@asgard.lang.hm>
	<1185091022.19678.28.camel@localhost.localdomain>
	<Pine.LNX.4.64.0707220057210.6350@asgard.lang.hm>
	<1185105911.29238.43.camel@localhost.localdomain>
	<Pine.LNX.4.64.0707221156210.6350@asgard.lang.hm>
	<1185145766.2714.27.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0707221914550.6350@asgard.lang.hm>
	<1185162647.2714.35.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0707222054060.6350@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0707222054060.6350@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: "ext linux-pm-bounces@lists.linux-foundation.org" <linux-pm-bounces@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 2007-07-22 at 21:04 -0700, david@lang.hm wrote:
> >> the fact that you want to run at the max frequancy for a given voltage is
> >
> > no I want to run at the max frequency PERIOD. On just about any PC, it's
> > more power efficient to go full speed when executing code, and then idle
> > for as long as you can. (there are some second order effects that make
> > this a bit more complex, but as first order approach it's a sound
> > approach). Voltage follows, and that's fine.
> 
> this seems to be contradicted by the fact that AMD is listing the ability 
> for each core to run at a different clock speed on the new 4-core chips as 
> an advantage.

that's a marketing thing mostly.. they all still run at the same voltage
anyway.

>  if you always want to run at the max frequency PERIOD then 
> why bother engineering the ability to do otherwise? (as opposed to just 
> shutting down unused cores)

multicore changes the rules a little but not all that much. (the idle
power is higher if not all cores are idle at the same time. Yet... each
core individually trying to be idle as quickly as possible is the best
way to get to the highest "all cores idle" time, unless there is some
really special/weird synchronization)


> >> this strategy should work well on the normal unpredictable workload that
> >> most people deal with, but there are some cases where the workload becomes
> >> pretty predictable (media players for example) where there really is less
> >> variation, and a need for a constant availability of the cpu, so it may
> >> actually save a smidge of power to run below the highest freq that the
> >> voltage allows rather then running faster and being idle more cycles.
> >
> > that actually is the example showcase of race-to-idle where you
> > absolutely want to run at the highest frequency..
> 
> only if the transitions don't cost anything significant, 

these are second order effects though. On a pc, the transition costs are
quite low (as I said, single or low double digit microseconds).
They are not zero, and that is why you see things like ondemand ramp up
only after a little time, as a guestimate to make sure it's not just a
really short lived code execution.

> and the 
> computation capacity per watt of power is the same at all frequencies. the 
> chip performance numbers I've been seeing (which I admit are mostly 
> embedded datasheets) indicate that neither of these hold true.

let me give you a real world example then, and the numbers I'm using are
ballpark the same as you'll find in a (mobile) core 2 duo datasheet, I
just rounded them a little so that the math works out nice.

power at full speed: 34W
power at half speed: 24W
power at idle: 1W

assume media playback, and a dumb one, that takes half a second to
decode a second of media. (again to make the math simple)

at half speed: Energy for a second is 0.5 * 24 + 0.5 * 1 = 12.5 J
at full speed: Energy for a second is 0.25 * 34 + 0.75 * 1 = 9.25 J

this works for all systems where the idle power is more lower than the
power you save by dropping speed... and that is almost all of them in
the PC world.

now you can argue that 0.5 seconds is a really really long time, and
you'd be right. so for really really short stints (say a timer
interrupt) you don't want to change the voltage at all (nor would you
want to change the plls to change frequency for that matter). But once
you start chaning those, you might as well go full speed.

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org
