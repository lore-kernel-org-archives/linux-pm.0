From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] Linux Power Management
Date: Sun, 8 May 2005 11:31:55 -0700
Message-ID: <200505081131.55962.david-b@pacbell.net>
References: <1115094736.28902.167.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============028857333267591656=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1115094736.28902.167.camel@localhost.localdomain>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Adam Belay <abelay@novell.com>
List-Id: linux-pm@vger.kernel.org

--===============028857333267591656==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I like the overall goals and direction, but most details are probably
premature.  Especially since the real issue is how to evolve the current
mess while not breaking things too badly (again) ...


On Monday 02 May 2005 9:32 pm, Adam Belay wrote:
> Problems with current Linux PM
> ==============================
> 
> Although the existing model is sufficient for suspend and resume, modern

That is, system-wide suspend/resume.  For suspend/resume of individual
devices, at run-time, it's quite weak.

> hardware often has more sophisticated power management features.  This
> includes runtime power management and wake events.  Also, the current
> model doesn't support power domains, a key concept in most bus hardware.
> 
> Design Goals
> ============
> 
> This project aims to provide a more useful Linux power management
> infrastructure.  Because of the wide array of power management capable
> platforms, each with its own unique protocols, it's important to have a
> flexible design.  Therefore, simplicity and a solid framework are
> favored over platform-specific quirks.

Nobody has _ever_ advocated platform-specific quirks in the core.  :)

Folk have however advocated serious design limitations in that core
which would prevent reasonable support of some platforms.  I think
that's an anti-goal.  The point of flexibility is to let such common
platform models work well ... avoiding such limitations, rather
than labeling all other platforms (e.g. non-PC ones) as "quirky"
and predestined to not working well with Linux.


> In this model, power management is not limited to sleep and suspend
> operations.  Instead, each device has the option of managing its power
> dynamically while the system is running.  Parent devices must be aware
> of the power requirements of their children.

Yes, though the parent/child statement seems a bit too strong.

Devices commonly have multiple sorts of parents; clocks, power
control, and multiple busses (such as one for control and one
for DMA) and bridges.  It probably works better for devices to
know about those parents, and only require the PM core to
accomodate those multiple relationships (rather than getting
in the way by for example insisting the hardware may only have
one such relationship, called "parent").

 
> Userspace interaction with power management policy is a key goal.  While
> policy configuration values may be specified by the user, policy
> execution should occur in kernel-space whenever possible.  Userspace
> will be notified of power events (including device state changes) via
> kevents.

I don't agree about userspace interaction as a goal, beyond the
ability to pass general policy inputs to drivers.  It's fair that
some devices might support policies like "off" and "on"; but
that's not something to expect (or require!) from all drivers.

And when the drivers do choose to export such policies, it's not
clear that the export/import is ever naturally part of some "power
management" framework.  Counter-examples include "hdparm -S" to
control hard drive power usage (drive spindown), and "xset dpms"
for displays.  (Remember that disk drive and display power usage
are classically the major drains, though current generation PCs
often push CPU or GPU usage into that category too.)

In fact I still like the idea of just removing all the sysfs
power support entirely; ripping it out since it's never worked
well, and doesn't do what's needed.  The main counter-argument
is that there'd need to be some better way to test selective
suspend in drivers, if "echo -n 3 > power/state" vanishes.
(Like, hmm, something sitting in debugfs...)


> Power States
> ============
> 
> Every "power device" or "power resource" has its own unique set of
> supported power states.  Characteristics about each state are specified
> in a "struct power_state".  This structure is intended primarily for
> gathering information.  A typical usage would be in power management
> policy decisions.

Nobody's yet answered my question about why we'd need to formalize
such a state ... other than for sysfs support.  If a component is
managing power for several others, such states would be consequences
of agreements between those components.



> Power Devices
> =============
> 
> The base object of this power management implementation is referred to
> as a "power device".  Power devices are represented by kobjects, each
> with their own children and parents.  A power device may or may not
> belong to a "struct device" in the physical device tree.
> 
> Every power device can be considered a power domain.  Each domain has
> its own power states, but also acts as a container for child power
> devices.  These children can specify what they require from the parent
> domain.  When the requirements of all children have lowered below a
> domain's current state, the parent may choose to also lower its state.

As Alan observed, this doesn't necessarily seem to require a new
kind of data structure.  The problems with the existing framework
are more at the level of imposing too much policy (and the wrong
kind!) about the power relationships of devices.

And for example the current pm_parent seems like it could help to
manage such a "power domain"...


> Power Drivers
> =============
> 
> Power drivers are specialized drivers with knowledge of a specific power
> management protocol.  They provide a mechanism for changing the power
> state, and update the "struct pm_device" to reflect which states are
> available during a global system state transition.
> 
> Legacy or ISA devices may choose to implement their own power driver.
> Most bus technologies (e.g. PCI) will provide a more general power
> driver.
> 
> Power state index values are specific to the power driver.

What is a "power management protocol"?  And what "power state" is
being changed?  I don't quite see a need for such a thing; and if
it were to exist, it should have "protocol" specific identifiers
rather than "power state index values" to abuse (by offering the
ability to pass them between "protocols").


> Power Resources
> ===============
> 
> Generally speaking, "power resources" are power planes, clocks, etc.
> that can be individually controlled.
> 
> Not every power management object fits into the power domain model,
> especially in embedded systems and for ACPI.  Therefore, this
> abstraction is needed to complement power domains and fills in any gaps
> in the power management object topology.
> 
> Power resources are independent of power domains.  Like power devices,
> they may have their own list of power states.  However, their
> representation is more simplistic than power devices.  The power
> management subsystem does not attempt to determine how power devices
> depend on power resources or when power resources should be configured
> as this is implementation specific.
> 
> The main goal behind power resource objects is to provide a framework
> for some standardization, export this information to sysfs for
> debugging, and act as a stub for future expansion.

If it's for debugging, it should be exported with debugfs!!

The other arguments aren't convincing to me, in terms of having
any sort of standardized API.  The notion is fine, but the
examples you gave don't seem to need "generic" APIs.  Clocks
demonstrably don't; I've pointed out the one ARM uses there,
it can't be at all generic.

I could believe it'd be good to have a semi-generic API to
switch power though ... and maybe even a way for platform
device resources to include power switch resources, so the
drivers would get rid of related board-specific knowledge.


> Power Management Policy
> =======================
> 
> Each power device will have a policy manager.  Policy managers make
> power management decisions based on user configurable settings and data
> gathered from device drivers.  Generally this will include activity
> timers and other methods of determining device idleness.
> 
> Most of the power policy manager implementation is device specific, but
> a few basic notifications are provided by the power management
> subsystem.  This includes when the system state is about to change or
> when the net requirements of child devices have changed.
> 
> ...
> 
> Standard policies will be provided.  As an example, most PCI devices
> have simple power management requirements, so they will use a generic
> PCI policy manager.  The PCI policy manager might then have its own
> hooks (e.g. state selection for wake).

Again, given that I don't see a strong need for a separate "power device"
(vs normal "device"), I don't see a need for separate drivers here.

I think the methods you sketched are a bit overly complex.  Two phase
protocols have tended to not work well -- nobody implements them right,
they're hard to test -- so "prepare" worries me.  The call reporting
changed requirements doesn't attract me, since it seems like it should
be subsumed by the "enter" call.

And that "enter" call looks like the "suspend" call used to look ... but
instead of "pm_message_t" it's got something that's actually useful.
And yes, I think pm_message_t was broken-as-designed, and still
needs fixing.


> Device Drivers
> ==============
> 
> Linux device drivers must often save and restore state during power
> transitions.  

Sure, but that doesn't mean there need to be APIs that every driver
would have to handle ... or that they couldn't just save/restore
that state automatically during suspend/resume calls.


> Conclusion
> ==========
> 
> This document provides a basic summary of a proposed power management
> design plan.  It is currently a draft.  Feel free to make any comments
> or suggest revisions.

Slim it down, and work on having incremental updates to the existing
infrastructure.

- Dave


--===============028857333267591656==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============028857333267591656==--
