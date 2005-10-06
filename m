From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Some Thoughts on Device Power Management
Date: Thu, 6 Oct 2005 12:55:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0510061247130.6024-100000@iolanthe.rowland.org>
References: <20051005075209.GC3306@neo.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============578986246783181=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051005075209.GC3306@neo.rr.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============578986246783181==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 5 Oct 2005, Adam Belay wrote:

> We need to add start() and stop() to "struct device_driver".
> ============================================================
> start() would enable the logical functionality of the device
> stop() would disable the logical functionality of the device
> 
> ACPI has had this feature in its driver model for a while now.  It seems clear
> to me that the driver core should provide this functionality for the following
> reason:
> 
> A device can either be operational or disabled.  At least three different
> entry points are concerned with controlling this logical state.
> 
> 1.) suspend/resume
> 2.) probe/remove
> 3.) driver-specific runtime power management
> 
> In addition some drivers will also need to start/stop devices from the
> following entry points:
> 
> 4.) parent change required because of child logical state changes
> 5.) device class requests (e.g. ifconfig eth0 down)
> 
> It seems like it would be useful for the driver core to track the current
> logical device state.  We could even create an iterative algorithm that
> "starts" parents up the tree when a child is started.  In general, adding
> start() and stop() would allow us to centralize logical state transition
> code and simplify drivers.

I don't see the need for this.  A few types of devices, like network
interfaces, can benefit from the On/Off distinction.  Most devices/drivers
can't.  Either they're always on, or else their off state is the same as
their suspended or unbound state.

> It should be easy for device drivers to manipulate physical power states.
> =========================================================================
> 
> We can use an API like the following to represent and manipulate power
> resources.
> 
> struct pm_state {
> 	char			*name;		/* a human-readable name */
> 	unsigned int		state;		/* an index value */
> 	unsigned int		state_type;	/* a PMSTATE_TYPE */
> };

The name is enough.  There's no need for state or state_type.

> enum {
> 	PMSTATE_TYPE_ON,	/* functional, most current, no latency */
> 	PMSTATE_TYPE_STANDBY,	/* not functional, less current, more latency */
> 	PMSTATE_TYPE_OFF,	/* not functional, least current, most latency */
> };

This isn't needed (who would use it?) and it's incomplete.  For instance, 
PCI has two states between ON and OFF.

> struct pm_device {
> 	struct kobject		kobj;
> 	struct semaphore	sem;		/* protects power state etc. */
> 	struct pm_interface	*intf;		/* specifies the type of pm device */
> 	struct pm_device	*parent;	/* the power container */
> 	struct device		*dev;		/* the physical device if any */
> 
> 	struct pm_state		*state;		/* the active power state */
> 
> 	char			pm_id[PM_ID_SIZE]; /* kobject name */
> 
> 	void (*release)		(struct device * dev);
> };

Who needs a new pm_device?  Would there ever be a struct pm_device that
wasn't part of a struct device (or maybe a class_device)?

> struct pm_interface {
> 	const char		*name;		/* a unique name for this PM protocol */
> 
> 	struct pm_attribute	*pm_attrs;	/* default group of attributes */
> 
> 	int (*enter_state)	(struct pm_device *dev,
> 				 struct pm_state *state); /* enters a given state */
> };
> 
> extern int pm_register_device(struct pm_device *dev);
> extern void pm_unregister_device(struct pm_device *dev);
> extern struct pm_state * __pm_get_state(struct pm_device *dev);
> extern int __pm_set_state(struct pm_device *dev, struct pm_state *state);
> extern int pm_set_state(struct pm_device *dev, struct pm_state *state);
> 
> extern struct pm_device * pm_get_device(struct pm_device *dev);
> extern void pm_put_device(struct pm_device *dev);
> 
> In this case we would create objects in sysfs under a power subsystem.
> Devices could then symlink to these objects.

Ditto for the rest of this.  It's a lot of overhead that would serve no 
useful purpose.

> PCI power management needs to be overhauled.
> ============================================
> 
> - pci_save_state() isn't necessary.  This information is already contained
> in "struct pci_dev".
> 
> - pci_restore_state() should be more careful and not write to read-only
> registers.
> 
> - We may need logic to enable ASPM when using PCI express hardware.
> 
> - PCI Bus power management isn't supported at all.
> 
> - PCI could attach to the power object model proposed above.
> 
> - PCI wake support needs to be usable for runtime power management.

This is a separate issue, more properly discussed on a PCI mailing list.

> ACPI needs better driver model integration.
> ===========================================
> 
> - ACPI devices have power states too.  We need to show them.
> 
> - ACPI power resources could be represented with the power object code.

What's the difference between an ACPI device and a regular device?

Alan Stern


--===============578986246783181==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============578986246783181==--
