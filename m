From: David Brownell <david-b@pacbell.net>
Subject: Re: Problems with PM_FREEZE
Date: Thu, 29 Sep 2005 10:12:45 -0700
Message-ID: <20050929171245.7012DE9E1F@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
References: <Pine.LNX.4.44L0.0509291136210.4928-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============96082252195217821=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509291136210.4928-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: stern@rowland.harvard.edu
Cc: ncunningham@cyclades.com, linux-pm@lists.osdl.org, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

--===============96082252195217821==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> Date: Thu, 29 Sep 2005 11:45:15 -0400 (EDT)
> From: Alan Stern <stern@rowland.harvard.edu>
>
> Dave:
>
> Pavel is obviously right that the clean solution is to add a pm_message_t 
> argument to resume().

I tend to disagree with that.  Changing every resume() method is
not "clean", and it's more obvious to me that the pm_message
semantics are (still) problematic.  Any argument to resume() would
be encouraging fragile "if (came_from(X)) { ... }" style logic.

Heck, there's still no way for drivers to know what the target
system state is ... and THAT is a core issue here.

During FREEZE, the target system state is "something snapshottable".
During SUSPEND, it's one of numerous variants of "low power" ... and
device drivers can only guess which one it'll be.  (Is it an ACPI
state?  S1, S3, S4?  Some non-ACPI platform state?)

Case in point:  in some system low power states, drivers need to turn
off certain clocks, and may not be able to support wakeup.  In others,
drivers leave those clocks on, and can support wakeup.  But there is
no way to figure out the target state given the pm_message ...


> But there might be an easier approach that would help this particular
> case.  You changed things so that for USB, PM_EVENT_FREEZE works like a
> PM_EVENT_SUSPEND.  But once PM_EVENT_RUNTIME is defined and used by the
> /sys/.../power/state attribute, why not do the opposite?  Make USB
> PM_EVENT_SUSPEND work like a PM_EVENT_FREEZE -- don't actually suspend any
> devices other than the root hub.

If the device states in question are real ones (and are for example
testable), I don't have an issue with defining them.

But defining more and more pseudo-states seems to me like trouble.
I've not seen a definition of PM_EVENT_RUNTIME, for one thing;


> That way there would be no difficulty about devices being in the wrong
> state when the resumed kernel tries to wake them up.  And it would reduce
> the time required for the sleep transition.  Actual power consumption
> would not be an issue; when the root hub suspends, all the devices below
> it will automatically suspend as well.

Power consumption WOULD be an issue.  Devices in USB_STATE_SUSPEND (a
real hardware state, not a pseudo-state!!) consume about 0.5 mA each.
Devices that are in other (wired) USB states consume about 100 mA each.
(Or for "high power" devices, 2.5 mA and 500 mA.)  

It's true that could shrink the time for sleep transitions, assuming
the devices weren't already asleep.  But I don't think that's a big
deal at this point.

- Dave


--===============96082252195217821==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============96082252195217821==--
