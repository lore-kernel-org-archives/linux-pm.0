From: Adam Belay <ambx1@neo.rr.com>
Subject: [RFC] Some Thoughts on Device Power Management
Date: Wed, 5 Oct 2005 03:52:09 -0400
Message-ID: <20051005075209.GC3306@neo.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============94609275397491288=="
Return-path: <linux-pm-bounces@lists.osdl.org>
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
List-Id: linux-pm@vger.kernel.org

--===============94609275397491288==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi All,

I've been considering strategies for improving runtime power management,
selective suspends, and device power management in general.  Here are some
of my ideas.  I would appreciate any comments or suggestions.


suspend() and resume() need to be improved.
===========================================

- the current logical state should be clear and available (e.g. it's
difficult to determine when to resume from FREEZE or SUSPEND.)

- I'm not sure what's currently in pm_message_t, but it would nice if the
driver could be provided a reason for the state change request. (e.g.
userspace requested this change, the system is being suspended, emergency
power accounting issue, etc.)

- We need to specify global system states.  suspend/resume should be aware
of the current global system state and the target global system state.

- it should be possible to call suspend() more than once. (e.g. FREEZE
followed by SUSPEND)  No action should be taken if the current state is
equal to the requested state.

- resume should always take us back to the ON state.


We need to add start() and stop() to "struct device_driver".
============================================================
start() would enable the logical functionality of the device
stop() would disable the logical functionality of the device

ACPI has had this feature in its driver model for a while now.  It seems clear
to me that the driver core should provide this functionality for the following
reason:

A device can either be operational or disabled.  At least three different
entry points are concerned with controlling this logical state.

1.) suspend/resume
2.) probe/remove
3.) driver-specific runtime power management

In addition some drivers will also need to start/stop devices from the
following entry points:

4.) parent change required because of child logical state changes
5.) device class requests (e.g. ifconfig eth0 down)

It seems like it would be useful for the driver core to track the current
logical device state.  We could even create an iterative algorithm that
"starts" parents up the tree when a child is started.  In general, adding
start() and stop() would allow us to centralize logical state transition
code and simplify drivers.


It should be easy for device drivers to manipulate physical power states.
=========================================================================

We can use an API like the following to represent and manipulate power
resources.

struct pm_state {
	char			*name;		/* a human-readable name */
	unsigned int		state;		/* an index value */
	unsigned int		state_type;	/* a PMSTATE_TYPE */
};

enum {
	PMSTATE_TYPE_ON,	/* functional, most current, no latency */
	PMSTATE_TYPE_STANDBY,	/* not functional, less current, more latency */
	PMSTATE_TYPE_OFF,	/* not functional, least current, most latency */
};

struct pm_device {
	struct kobject		kobj;
	struct semaphore	sem;		/* protects power state etc. */
	struct pm_interface	*intf;		/* specifies the type of pm device */
	struct pm_device	*parent;	/* the power container */
	struct device		*dev;		/* the physical device if any */

	struct pm_state		*state;		/* the active power state */

	char			pm_id[PM_ID_SIZE]; /* kobject name */

	void (*release)		(struct device * dev);
};

struct pm_interface {
	const char		*name;		/* a unique name for this PM protocol */

	struct pm_attribute	*pm_attrs;	/* default group of attributes */

	int (*enter_state)	(struct pm_device *dev,
				 struct pm_state *state); /* enters a given state */
};

extern int pm_register_device(struct pm_device *dev);
extern void pm_unregister_device(struct pm_device *dev);
extern struct pm_state * __pm_get_state(struct pm_device *dev);
extern int __pm_set_state(struct pm_device *dev, struct pm_state *state);
extern int pm_set_state(struct pm_device *dev, struct pm_state *state);

extern struct pm_device * pm_get_device(struct pm_device *dev);
extern void pm_put_device(struct pm_device *dev);

In this case we would create objects in sysfs under a power subsystem.
Devices could then symlink to these objects.


PCI power management needs to be overhauled.
============================================

- pci_save_state() isn't necessary.  This information is already contained
in "struct pci_dev".

- pci_restore_state() should be more careful and not write to read-only
registers.

- We may need logic to enable ASPM when using PCI express hardware.

- PCI Bus power management isn't supported at all.

- PCI could attach to the power object model proposed above.

- PCI wake support needs to be usable for runtime power management.


ACPI needs better driver model integration.
===========================================

- ACPI devices have power states too.  We need to show them.

- ACPI power resources could be represented with the power object code.


Thanks,
Adam

--===============94609275397491288==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============94609275397491288==--
