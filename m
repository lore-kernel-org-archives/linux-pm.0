From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: [RFC] Linux Power Management
Date: Tue, 03 May 2005 16:06:54 +1000
Message-ID: <1115100414.5413.89.camel@desktop.cunningham.myip.net.au>
References: <1115094736.28902.167.camel@localhost.localdomain>
Reply-To: ncunningham@cyclades.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============15444700548766122=="
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
To: Adam Belay <abelay@novell.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============15444700548766122==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Adam.

On Tue, 2005-05-03 at 14:32, Adam Belay wrote:
> Hi all,
> 
> I've been putting together some documentation for my proposed power
> management changes.  In some areas it may be different or more detailed
> than what I originally posted.  I look forward to any comments or
> suggestions.
> 
> Thanks,
> Adam
> 
> 
> 
> Improving Linux Power Management (DRAFT)
> Adam Belay
> 05/02/05

You might like to make this May 2 - my first thought was "5th of
February? That will be a bit out of date!"

> Terminology
> ===========
> 
> power state - the qualities of a device's power configuration
> minimum state - the highest power consumption, most on, state

Could highest != most on in some (rare) cases? Perhaps just put one or
the other.

> maximum state - the lowest power consumption, most off, state
> power domain - a device with a group of child devices that depend on its
> state

Before someone else queries, "its" is right. It's == it is.

> Problems with current Linux PM
> ==============================
> 
> Although the existing model is sufficient for suspend and resume, modern
> hardware often has more sophisticated power management features.  This
> includes runtime power management and wake events.  Also, the current

s/Also/In addition/

> model doesn't support power domains, a key concept in most bus hardware.
> 
> Design Goals
> ============
> 
> This project aims to provide a more useful Linux power management
> infrastructure.  Because of the wide array of power management capable
> platforms, each with its own unique protocols, it's important to have a
> flexible design.  Therefore, simplicity and a solid framework are

I would move "Therefore" to after "are".

> favored over platform-specific quirks.
> 
> In this model, power management is not limited to sleep and suspend
> operations.  Instead, each device has the option of managing its power
> dynamically while the system is running.  Parent devices must be aware
> of the power requirements of their children.
> 
> Userspace interaction with power management policy is a key goal.  While
> policy configuration values may be specified by the user, policy
> execution should occur in kernel-space whenever possible.  Userspace
> will be notified of power events (including device state changes) via

"notified of power events" implies all events. Perhaps "significant
events"? (Of course that still leaves the question as to what is
significant).

> kevents.
> 
> Power States
> ============
> 
> Every "power device" or "power resource" has its own unique set of
> supported power states.  Characteristics about each state are specified
> in a "struct power_state".  This structure is intended primarily for
> gathering information.  A typical usage would be in power management
> policy decisions.
> 
> struct power_state {
> 	char * name;			/* a human-readable name */
> 
> 	unsigned int state;		/* the state index number */
> 	unsigned int flags;		/* some flags that describe the state */

Perhaps it would be good to describe these a little more.

> 	unsigned int power_consumption; /* in mW */
> 
> 	struct list_head state_list;
> };
> 
> #define PM_DEVICE_STATE_USABLE			0x00000001
> #define PM_DEVICE_STATE_SLEEPING		0x00000002
> #define PM_DEVICE_STATE_OFF			0x00000004
> 
> #define PM_DEVICE_STATE_MASK			0xffff0000 /* controller-specific values */
> 
> It's likely that more flags will be added as they become necessary.
> 
> 
> Power Devices
> =============
> 
> The base object of this power management implementation is referred to
> as a "power device".  Power devices are represented by kobjects, each
> with their own children and parents.  A power device may or may not
> belong to a "struct device" in the physical device tree.
> 
> Every power device can be considered a power domain.  Each domain has

considered to be...

> its own power states, but also acts as a container for child power
> devices.  These children can specify what they require from the parent
> domain.  When the requirements of all children have lowered below a
> domain's current state, the parent may choose to also lower its state.
> 
> struct pm_device {
> 	char			* name;		/* a human-readable name for the device */
> 	struct kobject		kobj;
> 
> 	pm_state_t		state;		/* the current power state index value */
> 	pm_state_t		min_state;	/* the minimum supported power state */
> 	pm_state_t		max_domain_state; /* the maximum possible state of the parent */
> 	struct list_head	states;		/* a list of "struct power_state" */
> 
> 	struct list_head	child_list;
> 	struct list_head	children;	/* a list of child power devices */
> 	struct pm_device	* domain;	/* the parent power device */
> 
> 	struct device		* dev;		/* the optional driver model device */
> 
> 	struct pm_driver	* controller;	/* the power controller driver */
> 	struct pm_policy	* policy;	/* the policy driver */
> 
> 	void 			* policy_data;
> };
> 
> extern int pm_register_device(struct pm_device * dev);
> extern void pm_unregister_device(struct pm_device * dev);
> 
> extern int pm_set_state(struct pm_device * dev, pm_state_t state);
> extern int pm_set_state_force(struct pm_device * dev, pm_state_t state);
> 
> extern struct power_state *
> pm_get_state_data(struct pm_device * dev, pm_state_t state);
> 
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
> 
> struct pm_driver {
> 	char * name;
> 
> 	int  (*update)	 (struct pm_device * dev,
> 			  struct pm_sys_state * state);
> 
> 	int  (*get_state)(struct pm_device * dev);
> 	int  (*set_state)(struct pm_device * dev, pm_state_t state);
> };
> 
> 
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

"...and fill in..."

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
> 
> struct pm_resource_ops {
> 	int (*update) (struct pm_resource * res,
> 		       struct pm_sys_state * state);
> 
> 	int (*get_state) (struct pm_resource * res);
> 	int (*set_state) (struct pm_resource * res, pm_state_t state);
> };
> 
> struct pm_resource {
> 	char * name;
> 	struct kobject kobj;
> 
> 	pm_state_t		state;		/* the current power state index value */
> 	struct list_head	states;		/* a list of "struct power_state" */
> 	
> 	struct power_resource_ops *ops;		/* operations for controlling the power resource */
> };
> 
> extern int pm_register_resource(struct power_resource * res);
> extern void pm_unregister_resource(struct power_resource * res);
> 
> extern int pm_set_resource(struct pm_resource * res, pm_state_t state);
> 
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
> struct power_policy {
> 	(*requirements_changed)	(struct pm_device * dev,
> 				 pm_state_t new_max_state);

I'd like to see a description of what this does too :>

> 	(*prepare)		(struct pm_device * dev,
> 				 struct pm_sys_state * new);
> 	(*enter)		(struct pm_device * dev,
> 				 struct pm_sys_state * new);
> };
> 
> "prepare" is called to stop dynamic power management and prepare for a
> global system state change.  "enter" is called to make the actually
> state change.  The policy manager will then call, at its discretion,
> "pm_set_state".
> 
> In the case of resuming, "enter" will actually enable dynamic power
> management if it's available.

Am I right in thinking this implies that one of the flags in a power
state specifies whether the device can choose to change from this state
to another?

> "enter" is required, "requirements_changed" and "prepare" are optional.
> 
> Standard policies will be provided.  As an example, most PCI devices
> have simple power management requirements, so they will use a generic
> PCI policy manager.  The PCI policy manager might then have its own
> hooks (e.g. state selection for wake).
> 
> Device Drivers
> ==============
> 
> Linux device drivers must often save and restore state during power
> transitions.  The following API is proposed:
> 
> ->prepare_state(struct device * dev, pm_state_t state,
>                 unsigned int reason);
> ->complete_state(struct device * dev, pm_state_t state,
>                 unsigned int reason);
> 
> The following would be an example of a typical transition:
> 
> 1.) the policy manager decides to put a PCI ethernet card into D3 from
> D0.
> 2.) ->prepare_state is called, the ethernet driver saves its state
> information and disables the hardware
> 3.) the power driver's ->set_state function is called, and power is
> actually removed.
> 4.) ->complete_state is called to cleanup and make any final
> adjustments.
> 
> * In the case of D3->D0 ->complete_state would restore state.
> 
> Possible "reasons" might include DYNAMIC_PM, HALT, REBOOT, SUSPEND,
> RESUME, etc.
> 
> This API is different from the current ->suspend and ->resume because it
> applies to situations outside of system suspend (e.g. runtime power
> management) and has an emphasis on specific device power states.

I wonder whether reason implies state. Eg. Hard disk driver:

DYNAMIC_PM: Not relevant?
HALT: Flush data, power down device.
REBOOT: Flush data. Don't power down device.
SUSPEND: Flush data. Save state. Power down.
RESUME: Power up if necessary (might be post SUSPEND or QUIESCE).
Restore state.
(My invention) QUIESCE: Flush data. Save state.

I'm assuming here that, independent of all this, the driver knows
whether it was actually used or not, and might therefore not power up
until it sees activity, for example.

> System Suspend
> ==============
> 
> The following would be a typical flow of execution when transitioning to
> a sleep state: (note... this focuses on only the device aspect, there
> are firmware issues, process freezing, etc.)
> 
> 1.) ->prepare is called for each policy manager from the leafs of the
> tree to the root, preventing existing states from changing.
> 2.) ->update is called for each power device, from the root of the tree
> to the leafs.  Each power device then reflects the new available states.
> 3.) ->enter is called for each policy manager from the leafs of the tree
> to the root, resulting in actual state changes.

s/leafs/leaves/

> So each device doing the following while walking through the tree:
> ->prepare_state
> ->set_state
> ->complete_state
> 
> Conclusion
> ==========
> 
> This document provides a basic summary of a proposed power management
> design plan.  It is currently a draft.  Feel free to make any comments
> or suggest revisions.

Hope this is helpful.

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net


--===============15444700548766122==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============15444700548766122==--
