From: Alan Stern <stern@rowland.harvard.edu>
Subject: Autosuspend/autoresume support for USB, and PM notifications
Date: Tue, 30 May 2006 11:36:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0605301022130.5821-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: USB development list <linux-usb-devel@lists.sourceforge.net>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

I'm starting to work on adding autosuspend/autoresume support for the USB
generic-device driver and the hub interface driver.  Just to be clear
about this, autosuspend and autoresume are forms of runtime power
management.  They are suspend events created automatically by a driver
when it determines that its device is idle and resume events created
automatically by a driver when it needs to use a suspended device.

Going hand-in-hand with autosuspend/autoresume is the need to propagate PM
events up the device tree.  When a device suspends, its parent should be
notified so that the parent can decide whether to autosuspend.  Likewise,
if a device needs to resume, it may first have to ask its parent to
resume.

USB seems like a good place to start developing this stuff.  It's
self-contained and it already has a well defined specification for
suspend/resume at the hardware level.  For now, PM event propagation will
stop when it reaches the upper edge of the USB subsystem.  Ultimately this
mechanism could be added to the PM core, so that event notifications would
cross subsystem boundaries.

Initial design thoughts have pointed out some weaknesses in the current PM 
messaging model, in terms of not supplying enough information to drivers.

At the higher level, a driver might need to know the source of a PM 
request:

	System sleep transition;

	User PM request made through sysfs;

	Device-initiated remote wakeup request;

	Driver-initiated autosuspend/autoresume.

At the lower level, a driver needs to know how to handle the request:

	Should autosuspend be enabled at all?

	Should a power change notice be propagated up the device tree?

	Should a suspend request be ignored if the driver is in use?

	Should autoresume requests be ignored?

	Should the device's remote wakeup setting be enabled?

	Should the device's power level be changed?

The answers to some of these questions will depend on the source of a 
request.  Here is a brief discussion...


The struct pm_message, as currently used for conveying PM request 
information, does not provide any way to distinguish between system-level 
PM events and runtime PM events.  At some stage we certainly need to add a 
way of doing this, perhaps a new PM_EVENT_RUNTIME code.

Autosuspend/autoresume and remote wakeup requests can be told apart from
each other and the other two because they arrive by different pathways.  
However at some point all these events will have to go through common
code, and if this code uses a pm_message struct then once again, the
ability to distinguish will be lost (unless we add even more PM_EVENT
codes).

	Should autosuspend be enabled at all?

This is a policy question and it should be decided in userspace.  For now 
we can ignore the question.  In principle, autosuspend for individual 
devices can be disabled by turning off the may_wakeup attribute.  On a 
larger scale, it's not clear whether we want to disable autosuspend at the 
level of drivers, subsystems, or the entire kernel.  This can be 
determined later.

	Should a power change notice be propagated up the device tree?

It never hurts to do so.  For system-sleep transitions it's not necessary,
because the PM core will iterate through the entire tree anyhow.  For
other sorts of transitions we definitely _do_ want to propagate the
information, unless perhaps autosuspend is disabled.  To keep things
simple, I'll always do it.

	Should a suspend request be ignored if the driver is in use?

A USB device is in use when its usbfs device file is open or its
configuration is being changed.  A hub interface is in use while the
hub_events() routine is running.  In either case, we clearly don't want to
do an autosuspend at such times.  But we do want to suspend for
system-sleep transitions, and we probably do want to obey requests coming 
via sysfs.  Obviously this requires the ability to tell where a suspend 
request originated.

	Should autoresume requests be ignored?

During a system-sleep transition, definitely yes.  During most such 
transitions there can't be any autoresume requests to begin with, because 
these requests are created by processes that will be frozen.  But some 
kinds of sleep transitions _don't_ freeze user processes (STR on powermac,
for example).  Should autoresume be allowed then?  I don't know.

Following autosuspend we certainly do want to allow autoresume.  
Following a runtime sysfs suspend request, it's not clear.  Probably we
do.  After all, ignoring autoresume requests would cause programs like
lsusb to fail.

	Should the device's remote wakeup setting be enabled?

In general this is controlled by the may_wakeup attribute.  But there are 
certain times when we don't want to enable remote wakeup at all: during 
FREEZE and PRETHAW.  Of course, if remote wakeup isn't enabled then we 
will never do an autosuspend.

	Should the device's power level be changed?

This is perhaps the trickiest question of all, and the answer will vary 
according to the driver.  For FREEZE/PRETHAW the power level does not need 
to be changed.  USB is a little peculiar in that for system-sleep 
transitions, the power level doesn't need to be changed either; devices 
will automatically suspend themselves when the root hub is suspended.  Of 
course, for runtime PM we will always want to change the power level.

Not changing the power level is merely a time-saving optimization.  For 
now it will be simplest always to change it.


Here's another consideration.  Propagating PM-change notifications up the
device tree will potentially involve lengthy recursions and thus deep
stacks.  At each stage we should try to minimize the amount of
information that needs to be passed on the stack.  In particular this
means that if pm_message structs are used for the notifications, we must
be very careful to prevent them from bloating with cruft.

I imagine we'll eventually need to add some sort of opaque pointer to
struct pm_message, for holding driver-specific information.  Apart from
that there should be nothing more than a single integer (or long), perhaps
divided into a few bit fields so that all the necessary information can be
included.  It may turn out that with a few new PM_EVENT codes, almost no 
extra information will be needed.

Alan Stern



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
