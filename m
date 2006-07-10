From: David Brownell <david-b@pacbell.net>
Subject: RFC -- updated Documentation/power/devices.txt
Date: Mon, 10 Jul 2006 15:25:43 -0700
Message-ID: <200607101525.43507.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
List-Id: linux-pm@vger.kernel.org

When I did those PM_EVENT_PRETHAW updates I did the Right Thing and
started to update its in-tree documentation too.  Seems I'm the first
person to do that in a long time ... anyway, once I tossed in =


	- PM_EVENT_PRETHAW
	- Linus' suspend_late/resume_early and suspend_prepare
	- ... and class suspend/resume
	- Wakeup events
	- Fixes to the existing docs (confusions, obsolete stuff, ...)

This turned into more of a rewrite.  So here's my current version,
which I'm circulating for comments; I'll send it as a patch after
a few days, for merging when those patches from MM go upstream.

The focus here was just to have the current ("in MM") methods, parameters,
and models presented, with enough context to help readers understand the
"why" as well as the "what" and "when" (and the "huh?").

Yes, seeing it written out this way does beg some questions.  Like
what can be done with that (here-deprecated) sysfs attribute thing,
since it's starting to look even more obviously broken.

- Dave


Most of the code in Linux is device drivers, so much of the Linux power
management code is also driver-specific.  Some drivers will do very little;
others will do a lot.

This writeup gives an overview of how drivers interact with system-wide
power management goals, emphasizing the models and interfaces that are
shared by everything that hooks up to the driver model core.  Read it as
background for the domain-specific work you'd do with any specific driver.


Two Models for Device Power Management
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Drivers will use one of these models to put devices into low-power states:

 * As part of entering a system-wide low-power state like "suspend-to-ram",
   or (mostly for systems with disks) "hibernate" (suspend-to-disk).

   This is something that device, bus, and class drivers collaborate on
   by implementing various role-specific suspend and resume methods to
   cleanly power down hardware and software subsystems, then reactivate
   them without loss of data.

   Some drivers can manage hardware wakeup events, which make the system
   leave that low-power state.  This feature may be disabled using the
   device's power/wakeup file; enabling it may cost some power usage,
   but let the whole system enter low power states more often.

 * While the system is running, independently of any other power management
   activity.  Upstream drivers will normally not know (or care) if the devi=
ce
   is in some low power state when issuing requests.

   This doesn't have, or need much infrastructure; it's just something you
   should do when writing your drivers.  For example, clk_disable() unused
   clocks as part of minimizing power drain for currently-unused hardware.
   Of course, sometimes clusters of drivers will collaborate with each
   other, which could involve task-specific power management.

There's not a lot to be said about those low power states except that they
are very system-specific, and often device-specific.

Most suspended devices will have quiesced all I/O:  no more DMA or irqs, no
more data read or written, and requests from upstream drivers are no longer
accepted.  A given bus or platform may have different requirements though.

Examples of hardware wakeup events include an alarm from a real time clock,
network wake-on-LAN packets, keyboard or mouse activity, and media insertion
or removal (for PCMCIA, MMC/SD, USB, and so on).


Bus driver methods
------------------
The core methods to suspend and resume devices reside in struct bus_type.
These are mostly of interest to people writing infrastructure for busses
like PCI or USB, or because they define the primitives that device drivers
may need to apply in domain-specific ways to their devices:

struct bus_type {
       ...
       int  (*suspend_prepare)(struct device * dev, pm_message_t state);
       int  (*suspend)(struct device * dev, pm_message_t state);
       int  (*suspend_late)(struct device * dev, pm_message_t state);

       int  (*resume)(struct device * dev);
       int  (*resume_early)(struct device * dev);
};

Bus drivers implement those methods as appropriate for the hardware and
the drivers using it; PCI works differently from USB, and so on.  Not many
people write bus drivers; most driver code is a "device driver" that
builds on top of bus-specific framework code.

For more information on these driver calls, see the description later;
they are called in phases for every device, respecting the parent-child
sequencing in the driver model treee.  Note that at this writing, not
many bus drivers leverage all of those phases, or pass them down to
lower driver levels.


EXAMPLE:  PCI device driver methods
-----------------------------------
PCI framework software calls these methods when the pci device driver bound
to a device device has provided them:

struct pci_driver {
       ...
       int  (*suspend_prepare)(struct pci_device *pdev, pm_message_t state);
       int  (*suspend)(struct pci_device *pdev, pm_message_t state);
       int  (*suspend_late)(struct pci_device *pdev, pm_message_t state);

       int  (*resume)(struct pci_device *pdev);
       int  (*resume_early)(struct pci_device *pdev);
};

Drivers will implement those methods, and call PCI-specific procedures
like pci_set_power_state() and pci_enable_wake() to manage PCI-specific
mechanisms.  Devices are suspended before their bridges enter low power
states, and likewise busses resume before their bridges.


Upper layers of driver stacks
-----------------------------
Device drivers generally have at least two interfaces, and the methods
sketched above are the ones which apply to the lower level (nearer PCI, USB,
or other bus hardware).  The network and block layers are examples of upper
level interfaces, as is a character device talking to userspace.

Power management requests normally need to flow through those upper levels,
which often work in domain-oriented requests like "blank that screen".  In
some cases those upper levels will have power management intelligence that
relates to end-user activity, or other devices that work in cooperation.

When those interfaces are structured using class interfaces, there is a
standard way to have the upper layer stop issuing requests to a given
class device (and restart later):

struct class {
       ...
       int  (*suspend)(struct device * dev, pm_message_t state);
       int  (*resume)(struct device * dev);
};

Those calls are issued in specific phases of the process by which the
system enters a low power "suspend" state, or resumes from it.


Driver calls to enter System Sleep States
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
When the system enters a low power state, each device's driver is asked
to suspend the device by putting it into state compatible with the target
system state.  That's usually some version of "off", but the details are
system-specific.  Also, wakeup-enabled devices will usually stay partly
functional in order to wake the system.

When the system leaves that low power state, the device's driver is asked
to resume it.  The suspend and resume operations always go together, and
both are multi-phase operations.

For simple drivers, suspend might quiesce the device using the class code
and then turn its hardware as "off" as possible with late_suspend.  The
matching resume calls would then completely reinitialize the hardware
before reactivating its class I/O queues.

More power-aware drivers drivers will use more than one device low power
state, either at runtime or during system sleep states, and might trigger
system wakeup events.


Call Sequence Guarantees
--------------------------------------------
To ensure that bridges and similar links needed to talk to a device are
available when the device is suspended or resumed, the device tree is
walked in a bottom-up order to suspend devices.  A top-down order is
used to resume those devices.

The ordering of the device tree is defined by the order in which devices
get registered:  a child can never be registered/probed or resumed before
its parent, or removed/suspended after that parent.

The policy is that the device tree should match hardware bus topology.
(Or at least the control bus, for devices which use multiple busses.)


suspending devices
------------------
Suspending a given device is done in several phases.  Each phase will be
omitted if it's not relevant for that device.  Other devices will often
be suspending at the same time, so each phase will normally be done for
all devices before the next phase begins.

In order, the phases are:

   *	bus.suspend_prepare(dev) is called early, with all tasks active.
   	This method may sleep, and is often morphed into a device
   	driver call with bus-specific parameters.

	Drivers that need to synchronize their suspension with various
	management activities could synchronize here.  This may be a good
	point to arrange that predictable actions, like removing media from
	suspended systems, will not cause trouble on resume.

   *	class.suspend(dev) is called after tasks are frozen, for devices
	associated with a class that has such a method.

	Since I/O activity usually comes from such higher layers, this is
	a good place to quiesce all drivers of a given type (and keep such
	code out of those drivers).

   *	bus.suspend(dev) is called next.  This method may sleep, and is often
        morphed into a device driver call with bus-specific parameters.

	This call should handle parts of device suspend logic that require
	sleeping.  It probably does work to quiesce the device which hasn't
	been abstracted into class.suspend() or bus.suspend_late().

   *	bus.suspend_late(dev) is called with IRQs disabled, and with only
	one CPU active.  This may be morphed into a driver call
	with bus-specific parameters.

	This call might save low level hardware state that might otherwise
	be lost in the upcoming low power state, and actually put the
	device into a lowpower state ... so that in some cases the device
	may stay partly usable until this late.  This "late" call may also
	help when coping with hardware that behaves badly.

At the end of those phases, drivers should normally have stopped all I/O
transactions (DMA, IRQs), saved enough state that they can re-initialize
or restore previous state (as needed by the hardware), and placed the
device into a low-power state.  On many platforms they will also use
clk_disable() to gate off one or more clock sources; sometimes they will
also switch off power supplies, or reduce voltages.  A pm_message_t
parameter is currently used to nuance those semantics (described later).

When any driver sees that its device_can_wakeup(dev), it should make sure
to use the relevant hardware signals to trigger a system wakeup event.
For example, enable_irq_wake() might identify GPIO signals hooked up to
a switch or other external hardware, and pci_enable_wake() does something
similar for PCI's PME# signal.

Low Power (suspend) States
--------------------------
Device low-power states aren't very standard.  One device might only handle
"on" and "off, while another might support a dozen different versions of
"on" (how many engines are active?), plus a state that gets back to "on"
faster than from a full "off".

Some busses define rules about what different suspend states mean.  PCI
gives one example:  after the suspend sequence completes, a non-legacy
PCI device may not perform DMA or issue IRQs, and any wakeup events it
issues would be issued through the PME# bus signal.  Plus, there are
several PCI-standard device states, some of which are optional.

In contrast, integrated system-on-chip processors often use irqs as the
wakeup event sources (so drivers would call enable_irq_wake) and might
be able to treat DMA completion as a wakeup event (sometimes DMA can stay
active too, it'd only be the CPU and some peripherals that sleeps).

Some details here may be platform-specific.  Systems may have devices that
may be fully active in certain sleep states, such as an LCD display that's
refreshed using DMA while most of the system is sleeping lightly ... and
its framebuffer might even be updated by a DSP or other non-Linux CPU while
the Linux control processor stays idle.

Moreover, the specific actions taken may depend on the target system state.
One target system state might allow a given device to be very operational;
another might require a hard shut down with re-initialization on resume.


pm_message_t meaning
--------------------
Parameters to suspend calls include the device affected and a message of
type pm_message_t, which has one field:  the event.  If driver does not
recognize the event code, suspend calls may abort the request and return
a negative errno.  However, most drivers will be fine if they implement
PM_EVENT_SUSPEND semantics for all messages.

The event codes are used to nuance the goal of suspending the device,
and mostly matter when creating or resuming suspend-to-disk snapshots:

PM_EVENT_SUSPEND -- quiesce the driver and put hardware into a low-power
    state.  When used with system sleep states like "suspend-to-RAM" or
    "standby", the upcoming resume() call will often be able to rely on
    state kept in hardware, or issue system wakeup events.  When used
    instead with suspend-to-disk, few devices support this capability;
    most are completely powered off.

PM_EVENT_FREEZE -- quiesce the driver, but don't necessarily change into
    any low power mode.  The driver's resume() will often be called soon.
    Wakeup events are not allowed.

PM_EVENT_PRETHAW -- quiesce the driver, knowing that the upcoming resume()
    will restore a suspend-to-disk snapshot from a different kernel image.
    Drivers that are smart enough to look at their hardware state during
    resume() processing need that state to be correct ... a PRETHAW could
    be used to invalidate that state (by resetting the device).  Other
    drivers might handle this the same way as PM_EVENT_FREEZE.

There's also PM_EVENT_ON, a value which never appears as a suspend event
but is sometimes used to record the "not suspended" device state.


Resuming Devices
----------------
Resuming is similarly done in multiple phases:

   *	bus.resume_early(dev) is called with IRQs disabled, and with
   	only one CPU active.

	This reverses the effects of bus.suspend_late().

   *	bus.resume(dev) is called next.  This may be morphed into a device
   	driver call with bus-specific parameters.

	This reverses the effects of bus.suspend().

   *	class.resume(dev) is called for devices associated with a class
	that has such a method.

	This reverses the effects of class.suspend(), and would usually
	reactivate the device's I/O queue.

Drivers need to be able to handle hardware which has been reset since
the suspend methods were called, for example by complete reinitialization.
(This is the hardest part, and the one most protected by NDA'd documents
and chip errata.) At the end of those phases, drivers should normally be
as functional as they were before resume():  I/O can be performed using DMA
and IRQs, and the relevant clocks are gated on.

However, the details here may again be platform-specific.  For example,
some systems support multiple "run" states, and the mode in effect at
the end of resume() might not be the one which preceded suspension.
That means availability of certain clocks or power supplies changed,
which could easily affect how a driver works.


System devices
--------------
System devices follow a slightly different API, which can be found in

	include/linux/sysdev.h
	drivers/base/sys.c

System devices will only be suspended with interrupts disabled, and
after all other devices have been suspended. On resume, they will be
resumed before any other devices, and also with interrupts disabled.

That is, sysdev_driver.suspend() is called right after the suspend_late()
phase; sysdev_driver.resume() is called before the resume_early() phase.


Runtime Power Management
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Many devices are able to dynamically power down while the system is still
running. This feature is useful for devices that are not being used, and
can offer significant power savings on a running system; these devices
often support a range of runtime power states.  Those states will in some
cases (like PCI) be constrained by a bus the device uses, and will usually
be states that are also used in system sleep states.

Normally runtime power management is handled by the drivers without specific
userspace intervention, by techniques that include disabling unused clocks
and switching off unused power supplies.  For now you can also test some of
this functionality through sysfs.

	DEPRECATED:  USE "power/state" ONLY FOR DRIVER TESTING.
	IT WILL BE REMOVED, AND REPLACED WITH SOMETHING WHICH
	GIVES MORE APPROPRIATE ACCESS TO THE RANGE OF POWER STATES
	EACH TYPE OF DEVICE AND BUS SUPPORTS THROUGH ITS DRIVER.

In each device's directory, there is a 'power' directory, which
contains at least a 'state' file. Reading from this file displays what
power state the device is currently in. Writing to this file initiates
a transition to the specified power state, which must currently be a
number: '0' for 'on', or either '2' or '3' for 'suspended' (which
sometimes also implies reset, especially in conjunction with deeper
system sleep states).

The PM core will call the ->suspend() method in the bus_type object
that the device belongs to if the specified state is not 0, or
->resume() if it is.

When using this interface to suspend, the PM core does not call the
bus.suspend_prepare() or bus.suspend_late() methods.  When using it
to resume, the PM core does not call the bus.resume_early() method.

Nothing will happen if the specified state is the same state the
device is currently in.

The driver is responsible for saving the working state of the device
and putting it into the low-power state specified. If this was
successful, it returns 0, and the device's power_state field is
updated.

The drivers must also take care not to suspend a device that is
currently in use. It is their responsibility to provide their own
exclusion mechanisms.

There is currently no way to know what states a device or driver
supports a priori. This may change in the future.
