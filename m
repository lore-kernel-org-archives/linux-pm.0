From: Adam Belay <abelay@novell.com>
Subject: [RFC] Power Management API (rev 1)
Date: Sun, 17 Apr 2005 17:35:46 -0400
Message-ID: <1113773748.3451.142.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============12803166627116691=="
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

--===============12803166627116691==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


Hi all,

I've made some revisions to my new power management API.  I would
appreciate any suggestions or comments.

Thanks,
Adam


Summary:

"*update" is called during a change in system state.  It will change the
values of the minimum and maximum state (and anything else).  The PM
subsystem will then iterate the tree and mark each state that is
available.

I've attempted to add some methods to "struct power_policy".

The system state flags have been changed.  Any comments?

"struct power_resource" may need to support more than on and off.  Maybe
not?


Changes:

(me)
- added "available" to power states
- added concept of min and max power state in power devices
- fixed a few typos
- revised device state flags
- style changes and cleanups
- added some real content to "struct power_policy"
- system state flag changes
- added "pm_change_system_state"
- added "pm_current_system_state"
- added kobject to power resources

Suggested by David Brownell:
- revised system state flags
- pass actual system state structure instead of int



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
struct power_driver;
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

extern struct system_power_state *
pm_get_system_state_data(unsigned int state);

extern struct system_power_state * pm_current_system_state(void);
extern int pm_change_system_state(struct system_power_state *new);

/* System State Flags */

/* a generalization of the state ---> */
/* system is usable and active */
#define PM_SYSTEM_STATE_RUNNING		0x00000001
/* system is not usable, but still mostly running */ 
#define PM_SYSTEM_STATE_SLEEPING	0x00000002
/* system not running, but some context is being retained */
#define PM_SYSTEM_STATE_SUSPENDED	0x00000004
/* system not running, power is not being used to retain context */
#define PM_SYSTEM_STATE_OFF		0x00000008
/* no wake devices, no power _at_ _all_, completely off */
#define PM_SYSTEM_STATE_NOPOWER		0x00000010

/* information about where context has been saved ---> */
#define PM_SYSTEM_CONTEXT_RAM		0x00000100
#define PM_SYSTEM_CONTEXT_NONVOLATILE	0x00000200

/* hints for the policy intentions of the state --->
 * These hints are optional and describe the general intentions of the
 * platform's designer.  The actual policy may be a combination of these hints
 * and the user's preferences */
/* no, or very little, power management */
#define PM_SYSTEM_POLICY_MAX_PERFORMACE	0x00001000
/* favor performance, but save power where it won't interrupt the user */
#define PM_SYSTEM_POLICY_ADAPTIVE	0x00002000
/* save as much power as possible while maintaining necessary functionality */
#define PM_SYSTEM_POLICY_MAX_SAVINGS	0x00004000
/* turn off everything non-critical, we're almost out of power */
#define PM_SYSTEM_POLICY_EMERGENCY	0x00008000

/* PM features supported at the state ---> */
/* the state capable of runtime power management */
#define PM_SYSTEM_FEATURE_RUNTIME	0x00010000
/* the state can be waken to a higher state */
#define PM_SYSTEM_FEATURE_WAKE		0x00020000

/* the policy manager will really damage things if it refuses or delays our requests */
#define PM_SYSTEM_FLAG_NOPOLICY		0x10000000


/*
 * Power Resources
 *
 * Power resources represent the physical requirements of "power devices".
 * (e.g. clocks, power planes, etc.)  Only define a power resource if your
 * PM protocol allows specific control of the resource.  If not, it can be
 * a characteristic only represented by the power state.
 */

struct power_resource_ops {
	unsigned int (*get) (struct power_resource *power);
	int (*update) (struct power_resource *power,
		       struct system_power_state *state);
	int (*on) (struct power_resource *power);
	int (*off) (struct power_resource *power);
};

struct power_resource {
	char * name;
	struct kobject kobj;

	int enabled;
	struct list_head deps;
	struct power_resource_ops *ops;

	struct power_device *domain;
	unsigned int max_domain_state;
	unsigned int max_system_state;
};

extern int pm_register_resource(struct power_resource *res);
extern void pm_unregister_resource(struct power_resource *res);

extern int pm_enable_resource(struct power_resource *res);
extern int pm_disable_resource(struct power_resource *res);
extern int pm_available_resource(struct power_resource *res);


/*
 * Power States
 *
 * These are used to define device-specific power states.
 */

struct power_state {
	char * name;
	int available;

	unsigned int state;
	unsigned int flags;
	unsigned int power_consumption; /* in mW */
	unsigned int max_domain_state;

	struct list_head state_list;
	struct list_head deps;
};

extern void pm_add_state(struct power_device *dev, struct power_state *state);
extern void pm_remove_state(struct power_state *state);

/* power state flags --->
 * as always, these are optional */

/* device actually works */
#define PM_DEVICE_STATE_USABLE			0x00000001
/* device is still mostly on, but saving some power and not usable */
#define PM_DEVICE_STATE_SLEEPING		0x00000002
/* device is mostly off, and most context is lost */
#define PM_DEVICE_STATE_SUSPENDED		0x00000004
/* device is totally off */
#define PM_DEVICE_STATE_OFF			0x00000008

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
	char			* name;
	struct kobject		kobj;

	unsigned int		state;
	unsigned int		min_state;
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

	int  (*attach)	(struct power_device * power);
	void (*detach)	(struct power_device * power);
	int  (*update)	(struct power_device * power,
			 struct system_power_state *state);
	int  (*get)	(struct power_device * power, unsigned int state);
	int  (*set)	(struct power_device * power, unsigned int state);
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
	(*requirements_changed)	(struct power_device * dev,
				 unsigned int new_max_state);

	(*prepare_transition)	(struct power_device * dev,
				 struct system_power_state * new);
	(*apply_transition)	(struct power_device * dev,
				 struct system_power_state * new);
};




--===============12803166627116691==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============12803166627116691==--
