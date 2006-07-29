From: david singleton <dsingleton@mvista.com>
Subject: Re: PowerOp Design and working patch
Date: Fri, 28 Jul 2006 17:38:11 -0700
Message-ID: <c6333353f00bb7fd435ef518dc8cee21@mvista.com>
References: <242d827d33807b6b46608a26ed29c273@mvista.com>
	<20060728233837.GG2140@kroah.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: multipart/mixed; boundary=Apple-Mail-8--267367630
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060728233837.GG2140@kroah.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: David Singleton <daviado@gmail.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--Apple-Mail-8--267367630
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed


On Jul 28, 2006, at 4:38 PM, Greg KH wrote:

> On Fri, Jul 28, 2006 at 03:31:41PM -0700, david singleton wrote:
>> Here is a patch that implements a version of the PowerOp concept.
>
> Any chance of breaking this up into logical patches that do one thing 
> at
> a time so it can be reviewed better?
>
> thanks,
>
> greg k-h
>
Here's powerop-core.patch,  powerop-cpufreq.patch and 
powerop-x86-centrino.patch.

David


--Apple-Mail-8--267367630
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream; x-unix-mode=0644;
	name="powerop-core.patch"
Content-Disposition: attachment;
	filename=powerop-core.patch

 Documentation/power/powerop.txt |  168 +++++++++++++++++++++++++++++++++++
 include/linux/pm.h              |   26 +++++
 kernel/power/main.c             |  189 +++++++++++++++++++++++++++++++---------
 kernel/power/power.h            |    2 
 4 files changed, 341 insertions(+), 44 deletions(-)

Index: linux-2.6.17/kernel/power/main.c
===================================================================
--- linux-2.6.17.orig/kernel/power/main.c
+++ linux-2.6.17/kernel/power/main.c
@@ -49,7 +49,7 @@ void pm_set_ops(struct pm_ops * ops)
  *	the platform can enter the requested state.
  */
 
-static int suspend_prepare(suspend_state_t state)
+static int suspend_prepare(struct power_op * state)
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
+int suspend_enter(struct power_op * state)
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
@@ -131,36 +131,94 @@ int suspend_enter(suspend_state_t state)
  *	console that we've allocated. This is not called for suspend-to-disk.
  */
 
-static void suspend_finish(suspend_state_t state)
+static void suspend_finish(struct power_op * state)
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
 
 
+struct power_op *current_state;
+struct power_op pm_states = {
+	.name = "default",
+	.type = PM_SUSPEND_ON,
+};
 
-
-static const char * const pm_states[PM_SUSPEND_MAX] = {
-	[PM_SUSPEND_STANDBY]	= "standby",
-	[PM_SUSPEND_MEM]	= "mem",
+static struct power_op standby = {
+	.name = "standby",
+	.description = "Power-On Suspend ACPI State: S1",
+	.type = PM_SUSPEND_STANDBY,
+};
+static struct power_op mem = {
+	.name = "mem   ",
+	.description = "Suspend-to-RAM ACPI State: S3",
+	.type = PM_SUSPEND_MEM,
+};
 #ifdef CONFIG_SOFTWARE_SUSPEND
-	[PM_SUSPEND_DISK]	= "disk",
-#endif
+static struct power_op disk = {
+	.name = "disk  ",
+	.description = "Suspend-to-disk ACPI State: S4",
+	.type = PM_SUSPEND_DISK,
 };
+#endif
 
-static inline int valid_state(suspend_state_t state)
+/*
+ *
+ */
+static int pm_change_state(struct power_op *state)
+{
+	int error = -EINVAL;
+	int len = strlen(state->name);
+	struct power_op *this, *next;
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
+static inline int valid_state(struct power_op * state)
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
@@ -168,7 +226,7 @@ static inline int valid_state(suspend_st
 
 /**
  *	enter_state - Do common work of entering low-power state.
- *	@state:		pm_state structure for state we're entering.
+ *	@state:		power_op structure for state we're entering.
  *
  *	Make sure we're the only ones trying to enter a sleep state. Fail
  *	if someone has beat us to it, since we don't want anything weird to
@@ -177,7 +235,7 @@ static inline int valid_state(suspend_st
  *	we've woken up).
  */
 
-static int enter_state(suspend_state_t state)
+static int enter_state(struct power_op *state)
 {
 	int error;
 
@@ -186,16 +244,21 @@ static int enter_state(suspend_state_t s
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
@@ -211,7 +274,15 @@ static int enter_state(suspend_state_t s
  */
 int software_suspend(void)
 {
-	return enter_state(PM_SUSPEND_DISK);
+	struct power_op *this, *next;
+	struct list_head *head = &pm_states.list;
+	int error = 0;
+
+	list_for_each_entry_safe(this, next, head, list) {
+		if (this->type == PM_SUSPEND_DISK)
+			error= enter_state(this);
+	}
+	return error;
 }
 
 
@@ -223,16 +294,48 @@ int software_suspend(void)
  *	structure, and enter (above).
  */
 
-int pm_suspend(suspend_state_t state)
+int pm_suspend(struct power_op * state)
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
+	struct power_op *this, *next;
+	struct list_head *head = &pm_states.list;
+	const char *header =  "< Name >    <Frequency>  <Voltage>  <Transition Latency>  < Description >\n";
+	char * s = buf;
+
+	s += sprintf(s, "%s", header);
+	list_for_each_entry_safe(this, next, head, list) {
+		s += sprintf(s,"%s %dKHz %dmV %dus %s\n", this->name,
+		   this->frequency, this->voltage, this->latency,
+		   this->description);
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
@@ -248,36 +351,28 @@ decl_subsys(power,NULL,NULL);
 
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
+	struct power_op *this, *next;
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
 
@@ -285,6 +380,7 @@ power_attr(state);
 
 static struct attribute * g[] = {
 	&state_attr.attr,
+	&supported_states_attr.attr,
 	NULL,
 };
 
@@ -295,9 +391,20 @@ static struct attribute_group attr_group
 
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
@@ -108,7 +108,29 @@ typedef int __bitwise suspend_state_t;
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
+struct power_op {
+	struct list_head list;
+	suspend_state_t type;
+	char name[PM_NAME_SIZE];
+	char description[PM_DESCRIPTION_SIZE];
+	unsigned int frequency;		/* in KHz */
+	unsigned int voltage;		/* mV */
+	unsigned int latency;		/* transition latency in us */
+	int     (*prepare_transition)(struct power_op *cur, struct power_op *new);
+	int     (*transition)(struct power_op *cur, struct power_op *new);
+	int     (*finish_transition)(struct power_op *cur, struct power_op *new);
+
+	void *md_data;			/* arch dependent data (dpm_opt) */
+};
+extern struct power_op pm_states;
+extern struct power_op *current_state;
 
 typedef int __bitwise suspend_disk_method_t;
 
@@ -128,7 +150,7 @@ struct pm_ops {
 
 extern void pm_set_ops(struct pm_ops *);
 extern struct pm_ops *pm_ops;
-extern int pm_suspend(suspend_state_t state);
+extern int pm_suspend(struct power_op *state);
 
 
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
+extern int suspend_enter(struct power_op * state);
Index: linux-2.6.17/Documentation/power/powerop.txt
===================================================================
--- /dev/null
+++ linux-2.6.17/Documentation/power/powerop.txt
@@ -0,0 +1,168 @@
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
+PowerOp uses the existing power management sysfs infrastructure and extends it
+to perform cpufreq and dynamic power management operations. The traditional
+suspend to memory or disk (or swap) infrastructure has the correct operational
+structure that supports all types of power state change.
+
+The CPUFREQ table based frequency control makes controlling cpu frequency
+simple and straight forward.  The user doesn't get to set the cpu to
+any speed, but only to supported speeds that have been provided by
+the hardware vendor and validated.
+
+Dynamic Power Management treats all types of power states as operating points,
+wether it's a suspend operating point, a particular frequency, or a specific
+voltage.
+
+By combining the best of all of these power management infrastructures
+PowerOp uses the operational structure of tradition CONFIG_PM power
+management and converts all power states, frequency, voltage, idle or
+suspend to the CPUFREQ concept of only supported and validated operating
+points.
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
+Supported operating points are displayed in tuple format of:
+
+<name, frequency, voltage, transition latency, description>
+
+The supported_states file contains rows of tuples with each
+tuple describing a supported operating point of the system.
+The supported_states file looks like a merge between the old
+/sys/power/state file and a cpufreq table.
+
+The system can transition to any of the supported states by simply
+storing the operating point name in the /sys/power/state file.
+
+To allow user space notification of events, like low battery, lid of
+the notebook being closed, etc.  PowerOp notifies the user through
+the hotplug interface.
+
+
+2) PowerOP Operating Points.
+
+An operating point is represented by the power_op struct which contains:
+
+struct power_op {
+        struct list_head list;
+        suspend_state_t type;
+        char name[PM_NAME_SIZE];
+        char description[PM_DESCRIPTION_SIZE];
+        unsigned int frequency;         /* in KHz */
+        unsigned int voltage;           /* mV */
+        unsigned int latency;           /* transition latency in us */
+        int     (*prepare_transition)(struct power_op *cur, struct power_op *new);
+        int     (*transition)(struct power_op *cur, struct power_op *new);
+        int     (*finish_transition)(struct power_op *cur, struct power_op *new);
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
+	3) dpm_driver_scale(SCALE_POStCHANGE, new);
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
+The parameters are pointers to operating point structures, struct power_op.
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

--Apple-Mail-8--267367630
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed




--Apple-Mail-8--267367630
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream; x-unix-mode=0644;
	name="powerop-cpufreq.patch"
Content-Disposition: attachment;
	filename=powerop-cpufreq.patch

 drivers/cpufreq/cpufreq.c |   34 ++++++++++++++++++++++++++++++++++
 include/linux/cpufreq.h   |    2 ++
 2 files changed, 36 insertions(+)

Index: linux-2.6.17/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-2.6.17.orig/drivers/cpufreq/cpufreq.c
+++ linux-2.6.17/drivers/cpufreq/cpufreq.c
@@ -226,6 +226,33 @@ static void adjust_jiffies(unsigned long
 static inline void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci) { return; }
 #endif
 
+int cpufreq_prepare_transition(struct power_op *cur, struct power_op *new)
+{
+	struct cpufreq_freqs freqs;
+
+	freqs.old = cur->frequency;
+	freqs.new = new->frequency;
+	freqs.cpu = 0;
+	freqs.flags = cpufreq_driver->flags;
+	blocking_notifier_call_chain(&cpufreq_transition_notifier_list,
+			CPUFREQ_PRECHANGE, &freqs);
+	adjust_jiffies(CPUFREQ_PRECHANGE, &freqs);
+	return 0;
+}
+
+int cpufreq_finish_transition(struct power_op *cur, struct power_op *new)
+{
+	struct cpufreq_freqs freqs;
+
+	freqs.old = cur->frequency;
+	freqs.new = new->frequency;
+	freqs.cpu = 0;
+	freqs.flags = cpufreq_driver->flags;
+	adjust_jiffies(CPUFREQ_POSTCHANGE, &freqs);
+	blocking_notifier_call_chain(&cpufreq_transition_notifier_list,
+			CPUFREQ_POSTCHANGE, &freqs);
+	return 0;
+}
 
 /**
  * cpufreq_notify_transition - call notifier chain and adjust_jiffies
@@ -884,6 +911,12 @@ static void cpufreq_out_of_sync(unsigned
 }
 
 
+#ifdef CONFIG_PM
+unsigned int cpufreq_quick_get(unsigned int cpu)
+{
+	return (current_state->frequency * 1000);
+}
+#else
 /**
  * cpufreq_quick_get - get the CPU frequency (in kHz) frpm policy->cur
  * @cpu: CPU number
@@ -905,6 +938,7 @@ unsigned int cpufreq_quick_get(unsigned 
 
 	return (ret);
 }
+#endif
 EXPORT_SYMBOL(cpufreq_quick_get);
 
 
Index: linux-2.6.17/include/linux/cpufreq.h
===================================================================
--- linux-2.6.17.orig/include/linux/cpufreq.h
+++ linux-2.6.17/include/linux/cpufreq.h
@@ -271,6 +271,8 @@ static inline unsigned int cpufreq_quick
 	return 0;
 }
 #endif
+int cpufreq_prepare_transition(struct power_op *cur, struct power_op *new);
+int cpufreq_finish_transition(struct power_op *cur, struct power_op *new);
 
 
 /*********************************************************************

--Apple-Mail-8--267367630
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed




--Apple-Mail-8--267367630
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream; x-unix-mode=0644;
	name="powerop-x86-centrino.patch"
Content-Disposition: attachment;
	filename=powerop-x86-centrino.patch


 arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c |  108 ++++++++++++++++++++++
 1 files changed, 108 insertions(+)

Index: linux-2.6.17/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
===================================================================
--- linux-2.6.17.orig/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
+++ linux-2.6.17/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
@@ -20,6 +20,7 @@
 #include <linux/sched.h>	/* current */
 #include <linux/delay.h>
 #include <linux/compiler.h>
+#include <linux/pm.h>
 
 #ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
 #include <linux/acpi.h>
@@ -160,6 +161,80 @@ static struct cpufreq_frequency_table ba
 	OP(1400, 1484),
 	{ .frequency = CPUFREQ_TABLE_END }
 };
+#ifdef CONFIG_PM
+/*
+ * this is the formula for OP.  We need the perfctl
+ * msr value to change to a new frequency.
+ * We'll save it in the machine dependent variable md_data.
+ */
+static void set_perfctl_msr(struct power_op *pm)
+{
+	unsigned int msr = pm->frequency/100;
+	unsigned int v = pm->voltage - 700;
+
+	msr = (unsigned int)(msr << 8);
+	msr |= (unsigned int)(v / 16);
+	pm->md_data = (void *)msr;
+}
+
+static int centrino_transition(struct power_op *cur, struct power_op *new);
+
+static struct power_op mhz600 = {
+        .name = "600MHz",
+        .description = "Low Frequency state",
+        .type = PM_FREQ_CHANGE,
+        .frequency = 600,
+        .voltage = 956,
+	.latency = 100,
+	.prepare_transition  = cpufreq_prepare_transition,
+	.transition = centrino_transition,
+	.finish_transition = cpufreq_finish_transition,
+};
+static struct power_op mhz800 = {
+        .name = "800MHz",
+        .description = "Lower Frequency state",
+        .type = PM_FREQ_CHANGE,
+        .frequency = 800,
+        .voltage = 1180,
+	.latency = 100,
+	.prepare_transition  = cpufreq_prepare_transition,
+	.transition = centrino_transition,
+	.finish_transition = cpufreq_finish_transition,
+};
+static struct power_op ghz1 = {
+        .name = "1GHz",
+        .description = "Med Frequency state",
+        .type = PM_FREQ_CHANGE,
+        .frequency = 1000,
+        .voltage = 1308,
+	.latency = 100,
+	.prepare_transition  = cpufreq_prepare_transition,
+	.transition = centrino_transition,
+	.finish_transition = cpufreq_finish_transition,
+};
+static struct power_op ghz12 = {
+        .name = "1.2GHz",
+        .description = "High Frequency state",
+        .type = PM_FREQ_CHANGE,
+        .frequency = 1200,
+        .voltage = 1436,
+	.latency = 100,
+	.prepare_transition  = cpufreq_prepare_transition,
+	.transition = centrino_transition,
+	.finish_transition = cpufreq_finish_transition,
+};
+static struct power_op ghz14 = {
+        .name = "1.4GHz",
+        .description = "Highest Frequency state",
+        .type = PM_FREQ_CHANGE,
+        .frequency = 1400,
+        .voltage = 1484,
+	.latency = 100,
+	.prepare_transition  = cpufreq_prepare_transition,
+	.transition = centrino_transition,
+	.finish_transition = cpufreq_finish_transition,
+};
+#endif
 
 /* Intel Pentium M processor 1.50GHz (Banias) */
 static struct cpufreq_frequency_table banias_1500[] =
@@ -266,6 +341,19 @@ static int centrino_cpu_init_table(struc
 	dprintk("found \"%s\": max frequency: %dkHz\n",
 	       model->model_name, model->max_freq);
 
+#ifdef CONFIG_PM
+	list_add_tail(&mhz600.list, &pm_states.list);
+	set_perfctl_msr(&mhz600);
+	list_add_tail(&mhz800.list, &pm_states.list);
+	set_perfctl_msr(&mhz800);
+	list_add_tail(&ghz1.list, &pm_states.list);
+	set_perfctl_msr(&ghz1);
+	list_add_tail(&ghz12.list, &pm_states.list);
+	set_perfctl_msr(&ghz12);
+	list_add_tail(&ghz14.list, &pm_states.list);
+	set_perfctl_msr(&ghz14);
+	current_state = &ghz14;
+#endif
 	return 0;
 }
 
@@ -620,6 +708,26 @@ static int centrino_verify (struct cpufr
 	return cpufreq_frequency_table_verify(policy, centrino_model[policy->cpu]->op_points);
 }
 
+static int centrino_transition(struct power_op *cur, struct power_op *new)
+{
+	unsigned int msr, oldmsr = 0, h = 0;
+
+	if (cur == new)
+		return 0;
+
+	msr = (unsigned int)new->md_data;
+	rdmsr(MSR_IA32_PERF_CTL, oldmsr, h);
+
+	/* all but 16 LSB are reserved, treat them with care */
+	oldmsr &= ~0xffff;
+	msr &= 0xffff;
+	oldmsr |= msr;
+
+	wrmsr(MSR_IA32_PERF_CTL, oldmsr, h);
+
+	return 0;
+}
+
 /**
  * centrino_setpolicy - set a new CPUFreq policy
  * @policy: new policy

--Apple-Mail-8--267367630
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed



--Apple-Mail-8--267367630
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Apple-Mail-8--267367630--
