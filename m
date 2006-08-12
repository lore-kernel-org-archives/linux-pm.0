From: david singleton <dsingleton@mvista.com>
Subject: Re: Dynanic On-The-Fly Operating points for PowerOP
Date: Sat, 12 Aug 2006 14:39:37 -0700
Message-ID: <500efb19f19650f8429a07a84909617d@mvista.com>
References: <44D8D40F.50005@mvista.com>
	<bb52214749a48f317fba09eb522537bb@nomadgs.com>
	<5da81756733c335565f969bab0c9b934@mvista.com>
	<26d93dc005e384544d9ea702baa4a4af@nomadgs.com>
	<acd2a5930608120107k36653863vdfc8bd3875d395a9@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: multipart/mixed; boundary=Apple-Mail-3-1017918455
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <acd2a5930608120107k36653863vdfc8bd3875d395a9@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--Apple-Mail-3-1017918455
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Here's the Powerop-core patch (again).  It hasn't changed much since 
the 2.6.18-rc1 version.
It's rolled forward to 2.6.18-rc4 and incorporated suggestions.  The 
/sys/power/supported_states
file only shows the names of the supported states instead of 
additional, table-like, information.

David


--Apple-Mail-3-1017918455
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream; x-unix-mode=0644;
	name="powerop-core.patch"
Content-Disposition: attachment;
	filename=powerop-core.patch


Signed-Off-by: David Singleton <dsingleton@mvista.com>

 Documentation/power/powerop.txt |  212 ++++++++++++++++++++++++++++++++++++++++
 drivers/base/core.c             |    5 
 drivers/base/driver.c           |    1 
 drivers/base/power/Makefile     |    2 
 drivers/base/power/powerop.c    |  103 +++++++++++++++++++
 drivers/base/power/resume.c     |    3 
 drivers/base/power/suspend.c    |    2 
 include/linux/device.h          |    1 
 include/linux/pm.h              |   56 ++++++++++
 kernel/power/main.c             |  189 ++++++++++++++++++++++++++++-------
 kernel/power/power.h            |    2 
 11 files changed, 532 insertions(+), 44 deletions(-)

Index: linux-2.6.17/kernel/power/main.c
===================================================================
--- linux-2.6.17.orig/kernel/power/main.c
+++ linux-2.6.17/kernel/power/main.c
@@ -49,7 +49,7 @@ void pm_set_ops(struct pm_ops * ops)
  *	the platform can enter the requested state.
  */
 
-static int suspend_prepare(suspend_state_t state)
+static int suspend_prepare(struct powerop * state)
 {
 	int error = 0;
 	unsigned int free_pages;
@@ -82,7 +82,7 @@ static int suspend_prepare(suspend_state
 	}
 
 	if (pm_ops->prepare) {
-		if ((error = pm_ops->prepare(state)))
+		if ((error = pm_ops->prepare(state->type)))
 			goto Thaw;
 	}
 
@@ -94,7 +94,7 @@ static int suspend_prepare(suspend_state
 	return 0;
  Finish:
 	if (pm_ops->finish)
-		pm_ops->finish(state);
+		pm_ops->finish(state->type);
  Thaw:
 	thaw_processes();
  Enable_cpu:
@@ -104,7 +104,7 @@ static int suspend_prepare(suspend_state
 }
 
 
-int suspend_enter(suspend_state_t state)
+int suspend_enter(struct powerop * state)
 {
 	int error = 0;
 	unsigned long flags;
@@ -115,7 +115,7 @@ int suspend_enter(suspend_state_t state)
 		printk(KERN_ERR "Some devices failed to power down\n");
 		goto Done;
 	}
-	error = pm_ops->enter(state);
+	error = pm_ops->enter(state->type);
 	device_power_up();
  Done:
 	local_irq_restore(flags);
@@ -131,36 +131,99 @@ int suspend_enter(suspend_state_t state)
  *	console that we've allocated. This is not called for suspend-to-disk.
  */
 
-static void suspend_finish(suspend_state_t state)
+static void suspend_finish(struct powerop * state)
 {
 	device_resume();
 	resume_console();
 	thaw_processes();
 	enable_nonboot_cpus();
 	if (pm_ops && pm_ops->finish)
-		pm_ops->finish(state);
+		pm_ops->finish(state->type);
 	pm_restore_console();
 }
 
 
+struct powerop *current_state;
+struct powerop pm_states = {
+	.name = "default",
+	.type = PM_SUSPEND_ON,
+};
+
+static struct powerop standby = {
+	.name = "standby",
+	.description = "Power-On Suspend ACPI State: S1",
+	.type = PM_SUSPEND_STANDBY,
+};
+struct powerop *powerop_standby;
 
+static struct powerop mem = {
+	.name = "mem",
+	.description = "Suspend-to-RAM ACPI State: S3",
+	.type = PM_SUSPEND_MEM,
+};
+struct powerop *powerop_mem;
 
-static const char * const pm_states[PM_SUSPEND_MAX] = {
-	[PM_SUSPEND_STANDBY]	= "standby",
-	[PM_SUSPEND_MEM]	= "mem",
 #ifdef CONFIG_SOFTWARE_SUSPEND
-	[PM_SUSPEND_DISK]	= "disk",
-#endif
+struct powerop disk = {
+	.name = "disk",
+	.description = "Suspend-to-disk ACPI State: S4",
+	.type = PM_SUSPEND_DISK,
 };
+struct powerop *powerop_disk;
+#endif
 
-static inline int valid_state(suspend_state_t state)
+/*
+ *
+ */
+static int pm_change_state(struct powerop *state)
+{
+	int error = -EINVAL;
+	int len = strlen(state->name);
+	struct powerop *this, *next;
+	struct list_head *head = &pm_states.list;
+
+	/*
+	 * list_find new operating point.
+	 * compare to current operating point.
+	 * if different change to new operating point.
+	 */
+	list_for_each_entry_safe(this, next, head, list) {
+		if (strncmp(state->name, this->name, len) == 0) {
+			if ((strcmp(current_state->name, this->name)) == 0) {
+				return 0;
+			}
+
+			if (this->prepare_transition(current_state, this)) {
+				break;
+			}
+
+			if (this->transition(current_state, this)) {
+				break;
+			}
+
+			/*
+			 * now lets wait for the transition latency
+			 */
+			udelay(this->latency);
+
+			error = this->finish_transition(current_state, this);
+
+			if (error == 0)
+				current_state = this;
+			break;
+		}
+	}
+	return error;
+}
+
+static inline int valid_state(struct powerop * state)
 {
 	/* Suspend-to-disk does not really need low-level support.
 	 * It can work with reboot if needed. */
-	if (state == PM_SUSPEND_DISK)
+	if (state->type == PM_SUSPEND_DISK)
 		return 1;
 
-	if (pm_ops && pm_ops->valid && !pm_ops->valid(state))
+	if (pm_ops && pm_ops->valid && !pm_ops->valid(state->type))
 		return 0;
 	return 1;
 }
@@ -168,7 +231,7 @@ static inline int valid_state(suspend_st
 
 /**
  *	enter_state - Do common work of entering low-power state.
- *	@state:		pm_state structure for state we're entering.
+ *	@state:		powerop structure for state we're entering.
  *
  *	Make sure we're the only ones trying to enter a sleep state. Fail
  *	if someone has beat us to it, since we don't want anything weird to
@@ -177,7 +240,7 @@ static inline int valid_state(suspend_st
  *	we've woken up).
  */
 
-static int enter_state(suspend_state_t state)
+static int enter_state(struct powerop *state)
 {
 	int error;
 
@@ -186,16 +249,21 @@ static int enter_state(suspend_state_t s
 	if (down_trylock(&pm_sem))
 		return -EBUSY;
 
-	if (state == PM_SUSPEND_DISK) {
+	if (state->type == PM_SUSPEND_DISK) {
 		error = pm_suspend_disk();
 		goto Unlock;
 	}
 
-	pr_debug("PM: Preparing system for %s sleep\n", pm_states[state]);
+	if (state->type == PM_FREQ_CHANGE) {
+		error = pm_change_state(state);
+		goto Unlock;
+	}
+
+	pr_debug("PM: Preparing system for %s sleep\n", state->name);
 	if ((error = suspend_prepare(state)))
 		goto Unlock;
 
-	pr_debug("PM: Entering %s sleep\n", pm_states[state]);
+	pr_debug("PM: Entering %s sleep\n", state->name);
 	error = suspend_enter(state);
 
 	pr_debug("PM: Finishing wakeup.\n");
@@ -211,7 +279,15 @@ static int enter_state(suspend_state_t s
  */
 int software_suspend(void)
 {
-	return enter_state(PM_SUSPEND_DISK);
+	struct powerop *this, *next;
+	struct list_head *head = &pm_states.list;
+	int error = 0;
+
+	list_for_each_entry_safe(this, next, head, list) {
+		if (this->type == PM_SUSPEND_DISK)
+			error= enter_state(this);
+	}
+	return error;
 }
 
 
@@ -223,16 +299,44 @@ int software_suspend(void)
  *	structure, and enter (above).
  */
 
-int pm_suspend(suspend_state_t state)
+int pm_suspend(struct powerop * state)
 {
-	if (state > PM_SUSPEND_ON && state <= PM_SUSPEND_MAX)
+	if (state->type > PM_SUSPEND_ON && state->type <= PM_SUSPEND_MAX)
 		return enter_state(state);
 	return -EINVAL;
 }
 
+decl_subsys(power,NULL,NULL);
 
+/**
+ *	supported_states - control system power state.
+ *
+ *	show() returns what states are supported, which are no longer
+ * 	hard-coded to just 'standby' (Power-On Suspend), 'mem' (Suspend-to-RAM),
+ *	and *'disk' (Suspend-to-Disk), but show all the power states.
+ *
+ *	store() unwritable
+ */
 
-decl_subsys(power,NULL,NULL);
+static ssize_t supported_states_show(struct subsystem * subsys, char * buf)
+{
+	struct powerop *this, *next;
+	struct list_head *head = &pm_states.list;
+	char * s = buf;
+
+	list_for_each_entry_safe(this, next, head, list) {
+		s += sprintf(s,"%s\n", this->name);
+	}
+
+	return (s - buf);
+}
+
+static ssize_t supported_states_store(struct subsystem * subsys, const char *buf, size_t n)
+{
+	return -EINVAL;
+}
+
+power_attr(supported_states);
 
 
 /**
@@ -248,36 +352,28 @@ decl_subsys(power,NULL,NULL);
 
 static ssize_t state_show(struct subsystem * subsys, char * buf)
 {
-	int i;
 	char * s = buf;
 
-	for (i = 0; i < PM_SUSPEND_MAX; i++) {
-		if (pm_states[i] && valid_state(i))
-			s += sprintf(s,"%s ", pm_states[i]);
-	}
-	s += sprintf(s,"\n");
+	s += sprintf(s,"%s\n", current_state->name);
 	return (s - buf);
 }
 
 static ssize_t state_store(struct subsystem * subsys, const char * buf, size_t n)
 {
-	suspend_state_t state = PM_SUSPEND_STANDBY;
-	const char * const *s;
+	struct powerop *this, *next;
+	struct list_head *head = &pm_states.list;
 	char *p;
-	int error;
+	int error = -EINVAL;
 	int len;
 
 	p = memchr(buf, '\n', n);
 	len = p ? p - buf : n;
-
-	for (s = &pm_states[state]; state < PM_SUSPEND_MAX; s++, state++) {
-		if (*s && !strncmp(buf, *s, len))
+	list_for_each_entry_safe(this, next, head, list) {
+		if (!strncmp(buf, this->name, len)) {
+			error = enter_state(this);
 			break;
+		}
 	}
-	if (state < PM_SUSPEND_MAX && *s)
-		error = enter_state(state);
-	else
-		error = -EINVAL;
 	return error ? error : n;
 }
 
@@ -285,6 +381,7 @@ power_attr(state);
 
 static struct attribute * g[] = {
 	&state_attr.attr,
+	&supported_states_attr.attr,
 	NULL,
 };
 
@@ -295,9 +392,21 @@ static struct attribute_group attr_group
 
 static int __init pm_init(void)
 {
+
 	int error = subsystem_register(&power_subsys);
 	if (!error)
 		error = sysfs_create_group(&power_subsys.kset.kobj,&attr_group);
+
+	INIT_LIST_HEAD(&pm_states.list);
+
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	list_add(&disk.list, &pm_states.list);
+	powerop_disk = &disk;
+#endif
+	list_add(&mem.list, &pm_states.list);
+	list_add(&standby.list, &pm_states.list);
+	current_state = &pm_states;
+
 	return error;
 }
 
Index: linux-2.6.17/include/linux/pm.h
===================================================================
--- linux-2.6.17.orig/include/linux/pm.h
+++ linux-2.6.17/include/linux/pm.h
@@ -108,7 +108,59 @@ typedef int __bitwise suspend_state_t;
 #define PM_SUSPEND_STANDBY	((__force suspend_state_t) 1)
 #define PM_SUSPEND_MEM		((__force suspend_state_t) 3)
 #define PM_SUSPEND_DISK		((__force suspend_state_t) 4)
-#define PM_SUSPEND_MAX		((__force suspend_state_t) 5)
+#define PM_FREQ_CHANGE		((__force suspend_state_t) 5)
+#define PM_VOLT_CHANGE		((__force suspend_state_t) 6)
+#define PM_SUSPEND_MAX		((__force suspend_state_t) 7)
+
+#define PM_NAME_SIZE            16
+#define PM_DESCRIPTION_SIZE     48
+
+struct powerop {
+	struct list_head list;
+	suspend_state_t type;
+	char name[PM_NAME_SIZE];
+	char description[PM_DESCRIPTION_SIZE];
+	unsigned int frequency;		/* in KHz */
+	unsigned int voltage;		/* mV */
+	unsigned int latency;		/* transition latency in us */
+	int     (*prepare_transition)(struct powerop *cur, struct powerop *new);
+	int     (*transition)(struct powerop *cur, struct powerop *new);
+	int     (*finish_transition)(struct powerop *cur, struct powerop *new);
+
+	void *md_data;			/* arch dependent data (dpm_opt) */
+};
+
+struct constraint_param {
+	int id;
+	int min;
+	int max;
+};
+
+#define CONSTRAINT_PARAMS_MAX 20
+
+struct constraints {
+	int asserted;
+	int count;
+	int violations;
+	struct constraint_param param[CONSTRAINT_PARAMS_MAX];
+	struct list_head entry;
+};
+
+enum {
+	SCALE_PRECHANGE,
+	SCALE_POSTCHANGE,
+	SCALE_MAX
+};
+
+extern struct powerop pm_states;
+extern struct powerop *current_state;
+extern unsigned long powerop_compute_lpj(unsigned long ref, u_int div, u_int mult);
+struct notifier_block;
+extern void powerop_register_scale(struct notifier_block *nb, int level);
+extern void powerop_unregister_scale(struct notifier_block *nb, int level);
+extern int powerop_driver_scale(int level, struct powerop *new);
+extern void assert_constraints(struct constraints *);
+extern void deassert_constraints(struct constraints *);
 
 typedef int __bitwise suspend_disk_method_t;
 
@@ -128,7 +180,7 @@ struct pm_ops {
 
 extern void pm_set_ops(struct pm_ops *);
 extern struct pm_ops *pm_ops;
-extern int pm_suspend(suspend_state_t state);
+extern int pm_suspend(struct powerop *state);
 
 
 /*
Index: linux-2.6.17/kernel/power/power.h
===================================================================
--- linux-2.6.17.orig/kernel/power/power.h
+++ linux-2.6.17/kernel/power/power.h
@@ -113,4 +113,4 @@ extern int swsusp_resume(void);
 extern int swsusp_read(void);
 extern int swsusp_write(void);
 extern void swsusp_close(void);
-extern int suspend_enter(suspend_state_t state);
+extern int suspend_enter(struct powerop * state);
Index: linux-2.6.17/Documentation/power/powerop.txt
===================================================================
--- /dev/null
+++ linux-2.6.17/Documentation/power/powerop.txt
@@ -0,0 +1,212 @@
+
+The PowerOp Power Management infrastructure.
+
+David Singleton <dsingleton@mvista.com>
+
+25 July 2006
+
+Copyright (c) 2006 MontaVista Software Inc.
+
+0. Introduction
+
+The goal of PowerOp power management is to provide a framework that unifies
+and simplifies the various power management infrastructures in Linux.  The
+three infrastructures Power Op is concerned with are:
+
+	1) basic suspend/resume power management (CONFIG_PM)
+
+	2) basic processor frequency management (CONFIG_CPUFREQ)
+
+	3) SourceForge's Dynamic Power Management (CONFIG_DPM)
+
+All three power management infrastructures are concerned with controlling
+power states of the system, and interestingly enough they all perform the
+same basic operational steps to control changes in power state.
+
+PowerOp encapsulates supported system states into the concept of an
+operating point.  The operating point is defined by a simple structure
+that presents an architecture independent interface to the core power
+management framework and provides architecture/board dependent interface
+through both an op vector of function pointers to platform and operating
+point dependent functions.  The powerop structure also contains a
+pointer to the architecture and platform specific data needs to transition
+to the operating point.
+
+Encapsulated operating points can be manipulated via their name, making
+the user interface simple.  The interface to PowerOp is through two sysfs files.
+The first file, /sys/power/state, shows the operating point at which the
+system is currently operating.  The second file, /sys/power/supported_states,
+show the operating points supported by the system.  This file is a readonly
+file.  It cannot be changed by the user.  To transition to a new operating
+point the user, or powerop manager daemon, simply writes the name of
+the new operating point into /sys/power/state.
+
+PowerOp uses the existing power management sysfs infrastructure and extends it
+to perform cpufreq and dynamic power management operations. The traditional
+suspend to memory or disk (or swap) infrastructure has the correct operational
+structure that supports all types of power state change.
+
+1) Concepts borrowed from existing power management infrastructures.
+
+	a) The CPUFREQ table based frequency control makes controlling cpu
+	frequency simple and straight forward.  The user doesn't get to set
+	the cpu to any speed, but only to supported speeds that have been
+	provided by the hardware vendor and validated.
+
+	b) The steps to transition to an new operating point is correctly
+	defined by the three steps followed by suspend code:
+
+		step 1) suspend_prepare
+
+		step 2) suspend_enter
+
+		step 3) suspend_finish
+
+	These steps describe the steps used by both CPUFREQ and Dynamic Power
+	Management.
+
+	c) Dynamic Power Management treats all types of power states as
+	operating points, wether it's a suspend operating point, a particular
+	frequency, or a specific voltage.
+
+2) Unification of power management infrastructures in PowerOp.
+
+By combining the best of all of these power management infrastructures
+PowerOp uses the operational structure of tradition power management (PM) and
+converts all power states, frequency, voltage, idle or suspend to the CPUFREQ
+concept of only supported and validated operating points.
+
+PowerOp then becomes a simplified power management infrastructure in that
+only operating points that are supported and validated are available
+to the user.  Control of all operating points are done by the operating
+point name.  The user cannot supply invalid, or malicious,
+parameters that would hang or crash the system.
+
+1) PowerOp interface.
+
+To simplify power management all operations take place through two sysfs
+files, /sys/power/state and /sys/power/supported_states.  The 'state' file
+shows the current operating point of the system.  The readonly
+'supported_states' file shows the operating points the system supports.
+
+Supported operating points are displayed by name.
+
+The supported_states file contains rows of names.  The name space of operating
+points has been chosen to make the user space power manager simpler as well.
+The names PowerOp uses to define a basic or stock set of frequency based
+operating points are:
+
+		lowest
+		low
+		mediumlow
+		medium
+		mediumhigh
+		high
+		highest
+
+By using the same names regardless of the frequency behind the name
+the powerop manager can use some simple rules based decision making
+as to when to transition to a new operating point.  The power manager
+can then be constructed to make decisions based on speed versus power
+consumption without knowing exactly the frequencies or voltages behind
+the operating point names.  The names present operating points relationship
+to each other.
+
+To allow user space notification of events, like low battery, lid of
+the notebook being closed, etc.  PowerOp notifies the user through
+the hotplug interface.
+
+
+2) PowerOP Operating Points.
+
+An operating point is represented by the powerop struct which contains:
+
+struct powerop {
+        struct list_head list;
+        suspend_state_t type;
+        char name[PM_NAME_SIZE];
+        char description[PM_DESCRIPTION_SIZE];
+        unsigned int frequency;         /* in KHz */
+        unsigned int voltage;           /* mV */
+        unsigned int latency;           /* transition latency in us */
+        int     (*prepare_transition)(struct powerop *cur, struct powerop *new);
+        int     (*transition)(struct powerop *cur, struct powerop *new);
+        int     (*finish_transition)(struct powerop *cur, struct powerop *new);
+
+        void *md_data;                  /* arch dependent data  */
+};
+
+Each operating point has its own functions for preparing to transition,
+transitioning and finishing transition.  Cpu frequency operating points
+will probably share their op vectors, idle and suspend operating points my have
+different op vectors.
+
+
+3) Traditional Operation of Power Management Code.
+
+All three power management infrastructures have the same operational model.
+All three follow the PM model of preparing to suspend,  suspending,
+and finish the state change.  It was easiest to follow the model
+enforced by the traditional power management and use the three step process of:
+
+ 	1) get ready to change state
+	2) change state
+	3) finish changes
+
+Cpufreq infrastructure makes three calls to change the frequency of the
+processor:
+
+	1) cpufreq_notify_transition(&freq, CPUFREQ_PRECHANGE);
+
+	2) acpi_processor_set_performance (data, j, next_state);
+
+	3) cpufreq_notify_transition(&freq, CPUFREQ_POSTCHANGE);
+
+DPM uses these three calls to change frequency and/or voltage:
+
+	1) dpm_driver_scale(SCALE_PRECHANGE, new);
+
+	2) clk_set_rate(prcm_set, new->md_opt.prcm_clock);
+
+	3) dpm_driver_scale(SCALE_POSTCHANGE, new);
+
+PM uses these three calls to suspend:
+
+	1) suspend_prepare(state);
+
+	2) suspend_enter(state->type);
+
+	3) suspend_finish(state);
+
+
+4) PowerOP Operation.
+
+PowerOP uses the following three calls to transition to a new operating
+point.
+
+	prepare_to_transition(cur_state, new_state);
+
+	transition(cur_state, new_state);
+
+	finish_transistion(cur_state, new_state);
+
+The parameters are pointers to operating point structures, struct powerop.
+
+Power OP is a simplified version of all three of these infrastructures in
+that it only deals with operating points, and more specifically with
+supported operating points.  Power Op presents a set of supported operating
+points to the user.  This is similar to the cpufreq table concept in that
+only supported and validated frequencies are avaliable.
+
+The definition of the operating point is done in a manner similar to cpufreqs
+in that the supported operating frequency, voltage and transition latency,
+are predefined (by the hardware vendor) and validated.
+
+The user maninuplates the operting points of the system by the
+name of the operating points.  This simplifies both the code and the
+control of the system's operating points in the PowerOp daemon.
+
+All supported operating points are defined at compile time and
+the user sets the system to different operating points by
+the operating point name.
+
Index: linux-2.6.17/drivers/base/core.c
===================================================================
--- linux-2.6.17.orig/drivers/base/core.c
+++ linux-2.6.17/drivers/base/core.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/kdev_t.h>
+#include <linux/pm.h>
 
 #include <asm/semaphore.h>
 
@@ -362,6 +363,8 @@ int device_add(struct device *dev)
 		up(&dev->class->sem);
 	}
 
+	assert_constraints(dev->constraints);
+
 	/* notify platform of device entry */
 	if (platform_notify)
 		platform_notify(dev);
@@ -467,6 +470,8 @@ void device_del(struct device * dev)
 	}
 	device_remove_file(dev, &dev->uevent_attr);
 
+	deassert_constraints(dev->constraints);
+
 	/* Notify the platform of the removal, in case they
 	 * need to do anything...
 	 */
Index: linux-2.6.17/drivers/base/driver.c
===================================================================
--- linux-2.6.17.orig/drivers/base/driver.c
+++ linux-2.6.17/drivers/base/driver.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/string.h>
+#include <linux/pm.h>
 #include "base.h"
 
 #define to_dev(node) container_of(node, struct device, driver_list)
Index: linux-2.6.17/drivers/base/power/resume.c
===================================================================
--- linux-2.6.17.orig/drivers/base/power/resume.c
+++ linux-2.6.17/drivers/base/power/resume.c
@@ -10,6 +10,7 @@
 
 #include <linux/device.h>
 #include <linux/resume-trace.h>
+#include <linux/pm.h>
 #include "../base.h"
 #include "power.h"
 
@@ -37,6 +38,8 @@ int resume_device(struct device * dev)
 	if (dev->bus && dev->bus->resume) {
 		dev_dbg(dev,"resuming\n");
 		error = dev->bus->resume(dev);
+		if (!error)
+			assert_constraints(dev->constraints);
 	}
 	up(&dev->sem);
 	TRACE_RESUME(error);
Index: linux-2.6.17/drivers/base/power/suspend.c
===================================================================
--- linux-2.6.17.orig/drivers/base/power/suspend.c
+++ linux-2.6.17/drivers/base/power/suspend.c
@@ -75,6 +75,8 @@ int suspend_device(struct device * dev, 
 			);
 		error = dev->bus->suspend(dev, state);
 		suspend_report_result(dev->bus->suspend, error);
+		if (!error)
+			deassert_constraints(dev->constraints);
 	}
 	up(&dev->sem);
 	return error;
Index: linux-2.6.17/include/linux/device.h
===================================================================
--- linux-2.6.17.orig/include/linux/device.h
+++ linux-2.6.17/include/linux/device.h
@@ -333,6 +333,7 @@ struct device {
 
 	struct dma_coherent_mem	*dma_mem; /* internal for coherent mem
 					     override */
+	struct constraints      *constraints;
 
 	/* class_device migration path */
 	struct list_head	node;
Index: linux-2.6.17/drivers/base/power/powerop.c
===================================================================
--- /dev/null
+++ linux-2.6.17/drivers/base/power/powerop.c
@@ -0,0 +1,103 @@
+/*
+ * powerop.c -- PowerOp Power Management support (hotplug events and device
+ * scaling).
+ *
+ * (c) 2006 MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express or
+ * implied.
+ */
+
+#include <linux/device.h>
+#include <linux/pm.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/notifier.h>
+
+#include "power.h"
+static RAW_NOTIFIER_HEAD(powerop_scale_notifier);
+static DECLARE_MUTEX(powerop_scale_sem);
+
+/* This function may be called by the platform frequency scaler before
+   or after a frequency change, in order to let drivers adjust any
+   clocks or calculations for the new frequency. */
+
+int powerop_driver_scale(int level, struct powerop *newop)
+{
+        if (down_trylock(&powerop_scale_sem))
+                return 1;
+
+        raw_notifier_call_chain(&powerop_scale_notifier, level, newop);
+        up(&powerop_scale_sem);
+	return 0;
+}
+
+void powerop_register_scale(struct notifier_block *nb, int level)
+{
+        down(&powerop_scale_sem);
+        raw_notifier_chain_register(&powerop_scale_notifier, nb);
+        up(&powerop_scale_sem);
+}
+
+void powerop_unregister_scale(struct notifier_block *nb, int level)
+{
+        down(&powerop_scale_sem);
+        raw_notifier_chain_unregister(&powerop_scale_notifier, nb);
+        up(&powerop_scale_sem);
+}
+
+EXPORT_SYMBOL(powerop_driver_scale);
+EXPORT_SYMBOL(powerop_register_scale);
+EXPORT_SYMBOL(powerop_unregister_scale);
+
+LIST_HEAD(powerop_constraints);
+DECLARE_MUTEX(powerop_constraints_sem);
+
+void assert_constraints(struct constraints *constraints)
+{
+        if (! constraints || constraints->asserted)
+                return;
+
+        down(&powerop_constraints_sem);
+        constraints->asserted = 1;
+        list_add_tail(&constraints->entry, &powerop_constraints);
+        up(&powerop_constraints_sem);
+
+}
+
+void deassert_constraints(struct constraints *constraints)
+{
+        if (! constraints || ! constraints->asserted)
+                return;
+
+        down(&powerop_constraints_sem);
+        constraints->asserted = 0;
+        list_del_init(&constraints->entry);
+        up(&powerop_constraints_sem);
+}
+
+EXPORT_SYMBOL(assert_constraints);
+EXPORT_SYMBOL(deassert_constraints);
+
+unsigned long powerop_compute_lpj(unsigned long ref, u_int div, u_int mult)
+{
+	unsigned long new_jiffy_l, new_jiffy_h;
+
+	/*
+	 * Recalculate loops_per_jiffy.  We do it this way to
+	 * avoid math overflow on 32-bit machines.  Maybe we
+	 * should make this architecture dependent?  If you have
+	 * a better way of doing this, please replace!
+	 *
+	 *    new = old * mult / div
+	 */
+	 new_jiffy_h = ref / div;
+	 new_jiffy_l = (ref % div) / 100;
+	 new_jiffy_h *= mult;
+	 new_jiffy_l = new_jiffy_l * mult / div;
+
+	 return new_jiffy_h + new_jiffy_l * 100;
+}
+
Index: linux-2.6.17/drivers/base/power/Makefile
===================================================================
--- linux-2.6.17.orig/drivers/base/power/Makefile
+++ linux-2.6.17/drivers/base/power/Makefile
@@ -1,4 +1,4 @@
-obj-y			:= shutdown.o
+obj-y			:= shutdown.o powerop.o
 obj-$(CONFIG_PM)	+= main.o suspend.o resume.o runtime.o sysfs.o
 obj-$(CONFIG_PM_TRACE)	+= trace.o
 

--Apple-Mail-3-1017918455
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Apple-Mail-3-1017918455--
