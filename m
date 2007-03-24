From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Fri, 23 Mar 2007 17:52:00 -0700
Message-ID: <200703231752.01985.david-b@pacbell.net>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703230915.12117.david-b@pacbell.net>
	<Pine.LNX.4.60.0703232158090.5971@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.60.0703232158090.5971@poirot.grange>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alexey.y.starikovskiy@intel.com, dirk.behme@de.bosch.com, pavel@ucw.cz, linux-pm@lists.linux-foundation.org, johannes@sipsolutions.net, nico@cam.org, ben@simtec.co.uk
List-Id: linux-pm@vger.kernel.org

On Friday 23 March 2007 2:08 pm, Guennadi Liakhovetski wrote:
> On Fri, 23 Mar 2007, David Brownell wrote:
> > =

> > Yuck.  No.  Speed is only a factor in that STR is likely slower.
> =

> I'm just trying to think about it from the user perspective. As a user I =

> want - save the system save some power but be ready again when I need it =

> _not_ _later_ than, 10 sec after wakeup. I don't care how it is called. I =

> want to save as much power as possible and I want a certain wakeup time. =


That's not really a kernel issue; and it's highly dependent on what
devices are hooked up.  What if certain devices take a second to
re-activate ... and you have a dozen of them hooked up?


> Yes, if one system in your example is clocked slower, then yes, saying "I =

> want it back up and running 5 seconds after wakeup" will for one of them =

> mean "standby" for another one "str". As a user I don't care whatsoever =

> what PCI state you drive my eth card into. I want it back in 5 seconds.

I don't think any of the current tools address such guarantees.

And it seems to me you're looking at this more from a tools
perspective than from "what does pm_ops.enter(STATE) do".
So this is a change-of-topic.


> Similarly for single devices: I don't need wlan now, but when I need it I =

> want it to be available in less than 2 seconds.

That's a driver-specific issue.


> And if I say 10 minutes hibernate it.

The tools I've seen give a "hibernate" (suspend-to-disk) option,
but not a "10 minutes" option ... and on Linux, there isn't even
any kind of "enter system state X if idle for M minutes" facility.


> If I say "don't care about time, save maximum power" - similarly.

Again, that's an issue about what some to-be-written userspace
tool might do.


> And I may say "I want it wakeable from eth" or "from modem" take that int=
o =

> account too.

All those are driver configuration issues, although there's also
a huge dose of "ACPI wake events rarely work".  For ethernet
devices there's "ethtool".  For serial lines and other devices,
there's /sys/devices/.../power/wakeup configuration.

 =

> Those would be policies to be implemented in the user space. The kernel =

> might just present a single numerical per-device parameter "wakeup =

> responsiveness", and a way to do this system-wide.

Today, if you want to associate a set of wakeup events with some
particular sleep state (and the hardware supports them), just update
the /sys/devices/.../power/wakeup values before writing /sys/power/state
and voila!

That could be done with a shell script.

- Dave


> =

> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski
> =
