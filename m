From: Adam Belay <abelay@novell.com>
Subject: [RFC] A New Power Management API
Date: Thu, 14 Apr 2005 22:46:33 -0400
Message-ID: <1113533193.3451.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============79563781490477581=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============79563781490477581==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


Hi all,

I'm in the process of designing a new power management API.  I tried to
incorporate some of the ideas and suggestions made during past
discussions.  Also, I've been studying the requirements of the PCI and
ACPI power specifications.

My current efforts are as follows:

The new API uses a power container/domain model.  As an example, a PCI
or USB bridge can be considered a power domain that contains all of its
child devices.  The API also provides a concept of power resources.
These are specific clocks and power planes that are enabled and disabled
based on the requirements of a device at given state.  A power resource
can belong to a power domain, or be in the system pool.  Power resources
are particularly useful for supporting ACPI, but I suspect they will be
needed in other places as well.

Power transitions are controlled by "power drivers".  Buses with power
management features may provide power drivers to control their devices.
Device driver authors also have the option of implementing their own
special "power driver".  In short, power transition code has been
separated from "struct bus_type".  I think this will be more robust.

I made some minimal attempts at defining power policy managers.  I will
likely expand this area as it is further discussed.  Policy managers
will probably live inside the device driver code.

One interesting aspect of this implementation is that it allows each
device to have its own unique set of power states.  It also provides a
mechanism to describe power requirements from the parent domain and/or
power resources on a per-state basis.  I tried to make the design impose
as few limits and policies as possible.

In sysfs, a tree of power devices could be created to reflect the power
dependencies and topology.  A power device may or may not belong to a
"struct device".  If it does, a link will be created to the device node.

More to come, but for now I've included the header file.  I look forward
to any comments or suggestions.

Thanks,
Adam



/*
 *  pm.h - the Power Management Interface
 *
 */

#ifndef _LINUX_PM_H
#define _LINUX_PM_H

#ifdef __KERNEL__

#include <linux/config.h>
#include <linux/list.h>
#include <asm/atomic.h>

struct device;

struct power_resource;
struct power_controller;
struct power_policy;
struct power_device;


/*
 * Global System Power States
 *
 * Reflect the status of the overall system.
 */

struct system_power_state {
	unsigned int state;
	unsigned int flags;

	struct list_head state_list;
};

extern int pm_register_system_state(struct system_power_state *state);
extern void pm_unregister_system_state(struct system_power_state *state);

extern struct sys_power_state *
pm_get_system_state_data(unsigned int state);

/* System State Flags */
/* a generalization of the current state */
#define PM_SYSTEM_STATE_USABLE		0x00000001
#define PM_SYSTEM_STATE_SLEEP		0x00000002
#define PM_SYSTEM_STATE_OFF		0x00000004
/* where suspend data is being retained, if applicable */
#define PM_SYSTEM_STATE_SUSPEND_RAM	0x00000010
#define PM_SYSTEM_STATE_SUSPEND_DISK	0x00000020
/* the emphasize at a given state */
#define PM_SYSTEM_STATE_MAX_PERFORMANCE 0x00000100
#define PM_SYSTEM_STATE_MAX_BATTERY	0x00000200
#define PM_SYSTEM_STATE_BALANCED	0x00000400


/*
 * Power Resources
 *
 * Power resources represent the physical requirements of "power devices".
 * (e.g. clocks, power planes, etc.)  Only define a power resource if your
 * PM protocol allows specific control of the resource.  If not, it can be
 * a characteristic only represented by the device power state.
 */

struct power_resource_ops {
	int (*update) (struct power_resource *power);
	int (*on) (struct power_resource *power);
	int (*off) (struct power_resource *power);
	int (*available) (struct power_resource *power,
			  unsigned int system_state);
};

struct power_resource {
	int enabled;
	struct list_head deps;
	struct power_resource_ops *ops;

	struct power_device *domain;
	unsigned int max_domain_state;
};

extern int pm_register_resource(struct power_resource *res);
extern void pm_unregister_resource(struct power_resource *res);

extern int pm_enable_resource(struct power_resource *res);
extern int pm_disable_resource(struct power_resource *res);
extern int pm_available_resource(struct power_resource *res,
				 unsigned int system_state);


/*
 * Power States
 *
 * These are used to define device-specific power states.
 */

struct power_state {
	char * name;

	unsigned int state;
	unsigned int flags;
	unsigned int power_consumption; /* in mW */
	unsigned int max_domain_state;

	struct list_head state_list;
	struct list_head deps;
};

extern void pm_add_state(struct power_device *dev, struct power_state *state);
extern void pm_remove_state(struct power_state *state);

#define PM_DEVICE_STATE_MAX_PERFORMANCE		0x00000001
#define PM_DEVICE_STATE_USABLE			0x00000002
#define PM_DEVICE_STATE_OFF			0x00000004

#define PM_DEVICE_STATE_MASK			0xffff0000 /* bus-specific values */

struct power_dependency {
	struct power_resource * res;
	struct list_head state_list;
	struct list_head device_list;
};

extern struct power_dependency * 
pm_alloc_dependency(struct power_resource * res);
extern void pm_add_dependency(struct power_state * state,
			      struct power_dependency * dep);
extern void pm_remove_dependency(struct power_dependency * dep);


/*
 * Power Devices
 *
 * Power devices are the core building block of a system's power management
 * topology.  They may require power resources, but the primary dependency
 * relationships are represented by a tree of "power devices".  This tree
 * is based on a power domain (or container) model.
 */

struct power_device {
	struct kobject		kobj;

	unsigned int		state;
	unsigned int		max_state;
	struct list_head	states;

	struct list_head	child_list;
	struct list_head	children;
	struct power_device	* domain;

	struct device		* dev;

	struct power_driver	* controller;
	struct power_policy	* policy;

	void 			* policy_data;

	int			wake_enabled;
	unsigned int		max_wake_state;
	struct list_head	wake_deps;
};

extern int pm_register_device(struct power_device *power);
extern void pm_unregister_device(struct power_device *power);

extern unsigned int pm_get_state(struct power_device *power);
extern int pm_set_state(struct power_device *power, unsigned int state);
extern int pm_available_state(struct power_device *power, unsigned int state,
			      unsigned int system_state);

extern struct power_state *
pm_get_state_data(struct power_device *power, unsigned int state);
extern int pm_add_wake_dependency(struct power_device *power,
				  struct power_dependency *dep);


/*
 * Power Drivers
 *
 * Power drivers provide information about a power device's current state and
 * mechanisms for changing that state.
 */

struct power_driver {
	char * name;

	int  (*attach) (struct power_device * power);
	void (*detach) (struct power_device * power);
	int  (*update) (struct power_device * power);
	int  (*set) (struct power_device * power, unsigned int state);
	int  (*available) (struct power_device *power,
			   unsigned int state, unsigned int system_state);
};

extern int pm_bind_power_driver(struct power_device *power,
				struct power_driver *drv);
extern void pm_unbind_power_driver(struct power_device *power);


/*
 * Power Management Policy
 *
 * Makes power management related decisions on a per "power device" basis.
 */

struct power_policy {
	(*apply) (struct power_device *power, unsigned int system_state);
};



--===============79563781490477581==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============79563781490477581==--
