From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re: ...))
Date: Tue, 8 May 2007 10:56:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705080949280.3217-100000@iolanthe.rowland.org>
References: <200705080047.08319.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705080047.08319.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Tue, 8 May 2007, Rafael J. Wysocki wrote:

> As far as I understand it, for S4 the platform provides a means for verifying
> if the hardware wasn't changed too much while the system was "sleeping" (via
> the NVS memory region).

Rereading p.20, it appears to go the other way: The system checks for
hardware changes when booting from Soft Off.  Or perhaps it always checks.  
I guess there aren't supposed to be any hardware changes while in S4,
since then it's not safe to disassemble the machine.

Sounds a lot like USB's power sessions...

> Yes, this is very confusing.  I think what they wanted to say there is that the
> image restore could in principle happen when the system is started after being
> in a "power off" state.  In that case, however, it wouldn't be known if it's
> safe to restore the image and continue, because the hardware might have
> changed.  For this reason, a special "sleeping" state is needed such that when
> leaving it, the PM software can detect any (substantial) hardware changes
> before even loading the entire image.

And apparently the bootloader is not expected to restore the memory image
if the hardware has changed too much.

So here's the current state of my understanding of ACPI:

	S4 is the lowest-power Sleep state.  RAM is not powered, the OS
	has stored a non-volatile memory image somewhere, and some ACPI
	state is maintained.

	S5 is misnamed, in that it isn't really a Sleep state at all --
	it's an Off state.  In fact, it is the state the computer enters
	when you first plug it in (or insert the battery).

If the OS stores a memory image and then switches to S5, at reboot the
bootloader will probably try to restore it.  (That's what p.20 says.)  
And if the user unplugs the computer (removes the battery) while it is in
S4, then upon replugging the computer will enter S5.  Thus, when waking
from either S4 or S5 the bootloader will try to restore an image if one
can be found (and if the hardware hasn't changed too much and if the user
doesn't abort the restore).

I've never encountered any documentation saying that you shouldn't unplug 
the computer while it's in hibernation.  It doesn't look like you would 
lose much by doing so, except that perhaps not as many wakeup devices are 
functional in S5 as in S4.

Now as for how all this relates to Linux:

What we do for hibernation is not an exact match for either S4 or S5.  It
may be closest to S4, but we don't use a bootloader.  Instead the boot
kernel does some sort of ACPI reset and restores the memory image all by
itself.  Whatever ACPI state information may be saved in the image is not
accessible to the boot kernel.  Conversely, the information about whether
we booted from S4 or from S5 is lost when the image overwrites the boot
kernel.

As a result, hibernation is capable of using either S4 or S5 -- as it must
be, since the user could always unplug the computer while it's in S4 --
although perhaps when using S4 it manages to confuse ACPI somewhat through
not matching the spec's expectations.

What do the differences between S4 and S5 amount to?  As far as I can 
tell, they look like this:

	ACPI expects there to be a memory image in S4.  In S5 there
	may or may not be an image.

	ACPI expects that when resuming from S4, the kernel will
	continue using some preserved ACPI state.  It expects that 
	when starting from S5, the kernel will need to reinitialize
	pretty much all the ACPI state.

	S4 involves a larger power consumption and may allow for
	more wakeup devices than S5.

And how do these relate to Linux?

	In fact, ACPI has no way of knowing whether or not there is an
	image.  The kernel is perfectly free to do whatever it wants.

	The boot kernel can't make much use of the state preserved by
	ACPI because it doesn't have access to the image kernel's
	records.  It needs to reinitialize ACPI no matter what.
	Consequently the restored kernel cannot use any preserved ACPI
	state, since this state gets wiped out by the boot kernel.
	Information about hardware changes might be available to the
	boot kernel, which could in principle then decide not to restore 
	the image.  It's not clear that this would be a good idea.  In
	any case, ACPI is limited to knowledge about devices on the
	motherboard -- it knows nothing about hotplugged devices, which
	makes the information less useful.

	Hibernation allows the user to choose whether to go to S4 or S5
	by means of /sys/power/disk.  Therefore the user gets to decide
	how the power-consumption vs. wakeup-functionality tradeoff
	should be made.

In short, the boot kernel should do whatever it needs to in order to make
ACPI happy.  This might involve telling ACPI that it has successfully
resumed from S4, even though the boot kernel is unaware of system state at
the start of hibernation.  In fact, the boot kernel has to take care of
all this before it even knows whether a valid image exists in the swap
partition.

Putting this together, it says that there should be no impediment to doing
a fresh boot from S4; i.e., not restoring a memory image but simply
letting the boot kernel continue on with a normal startup.  The corollary
is that there should be no impediment to entering S4 during a normal
shutdown.

>From the user's point of view, the differences between S4 and S5 amount to
just these: power consumption and availability of wakeup devices.  
(Perhaps also the presence of a blinking LED -- but in my experience the
blinking LED indicates STR, not hibernation.)  In the end, this is nothing 
more than the usual tradeoff between power usage and functionality.

We give the user a chance to decide how this tradeoff should go when 
entering hibernation.  Why not also give the user a chance to decide the 
tradeoff during normal shutdown?

Yes, it violates the spec in the sense that we would be entering S4 
without saving a memory image.  But we _already_ violate the spec by not 
using a bootloader to restore the image.  I don't see this as being any 
worse.


Finally, what about non-ACPI systems?  Basically this boils down to two 
choices:

	Should a memory image be stored?

	How much power/wakeup-functionality should the system
	consume/provide while it is down?

The first choice is decided by the user, by either entering hibernation or 
shutting down.  Why shouldn't the second also be decided by the user?

Alan Stern
