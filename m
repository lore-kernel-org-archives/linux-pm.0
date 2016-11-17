From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] PM / sleep: System sleep state selection interface rework
Date: Thu, 17 Nov 2016 03:22:28 +0100
Message-ID: <10655679.GVWa2Vtreo@vostro.rjw.lan>
References: <9316960.49SRRJV8RJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64942 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752679AbcKQCVh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Nov 2016 21:21:37 -0500
In-Reply-To: <9316960.49SRRJV8RJ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mario Limonciello <mario.limonciello@dell.com>, Andy Lutomirski <luto@kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are systems in which the platform doesn't support any special
sleep states, so suspend-to-idle (PM_SUSPEND_FREEZE) is the only
available system sleep state.  However, some user space frameworks
only use the "mem" and (sometimes) "standby" sleep state labels, so
the users of those systems need to modify user space in order to be
able to use system suspend at all and that may be a pain in practice.

Commit 0399d4db3edf (PM / sleep: Introduce command line argument for
sleep state enumeration) attempted to address this problem by adding
a command line argument to change the meaning of the "mem" string in
/sys/power/state to make it trigger suspend-to-idle (instead of
suspend-to-RAM).

However, there also are systems in which the platform does support
special sleep states, but suspend-to-idle is the preferred one anyway
(it even may save more energy than the platform-provided sleep states
in some cases) and the above commit doesn't help in those cases.

For this reason, rework the system sleep state selection interface
again (but preserve backwards compatibiliby).  Namely, add a new
sysfs file, /sys/power/mem_sleep, that will control the system
suspend mode triggered by writing "mem" to /sys/power/state (in
analogy with what /sys/power/disk does for hibernation).  Make it
select suspend-to-RAM ("deep" sleep) by default (if supported) and
fall back to suspend-to-idle ("s2idle") otherwise and add a new
command line argument, mem_sleep_default, allowing that default to
be overridden if need be.

At the same time, drop the relative_sleep_states command line
argument that doesn't make sense any more.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/ABI/testing/sysfs-power |   45 +++++++++--------
 Documentation/kernel-parameters.txt   |   13 ++---
 Documentation/power/states.txt        |   56 +++++++++++++--------
 kernel/power/main.c                   |   88 ++++++++++++++++++++++++++++++++--
 kernel/power/power.h                  |    3 -
 kernel/power/suspend.c                |   66 ++++++++++++++-----------
 6 files changed, 192 insertions(+), 79 deletions(-)

Index: linux-pm/kernel/power/main.c
===================================================================
--- linux-pm.orig/kernel/power/main.c
+++ linux-pm/kernel/power/main.c
@@ -78,6 +78,78 @@ static ssize_t pm_async_store(struct kob
 
 power_attr(pm_async);
 
+#ifdef CONFIG_SUSPEND
+static ssize_t mem_sleep_show(struct kobject *kobj, struct kobj_attribute *attr,
+			      char *buf)
+{
+	char *s = buf;
+	suspend_state_t i;
+
+	for (i = PM_SUSPEND_MIN; i < PM_SUSPEND_MAX; i++)
+		if (mem_sleep_states[i]) {
+			const char *label = mem_sleep_states[i];
+
+			if (mem_sleep_current == i)
+				s += sprintf(s, "[%s] ", label);
+			else
+				s += sprintf(s, "%s ", label);
+		}
+
+	/* Convert the last space to a newline if needed. */
+	if (s != buf)
+		*(s-1) = '\n';
+
+	return (s - buf);
+}
+
+static suspend_state_t decode_suspend_state(const char *buf, size_t n)
+{
+	suspend_state_t state;
+	char *p;
+	int len;
+
+	p = memchr(buf, '\n', n);
+	len = p ? p - buf : n;
+
+	for (state = PM_SUSPEND_MIN; state < PM_SUSPEND_MAX; state++) {
+		const char *label = mem_sleep_states[state];
+
+		if (label && len == strlen(label) && !strncmp(buf, label, len))
+			return state;
+	}
+
+	return PM_SUSPEND_ON;
+}
+
+static ssize_t mem_sleep_store(struct kobject *kobj, struct kobj_attribute *attr,
+			       const char *buf, size_t n)
+{
+	suspend_state_t state;
+	int error;
+
+	error = pm_autosleep_lock();
+	if (error)
+		return error;
+
+	if (pm_autosleep_state() > PM_SUSPEND_ON) {
+		error = -EBUSY;
+		goto out;
+	}
+
+	state = decode_suspend_state(buf, n);
+	if (state < PM_SUSPEND_MAX && state > PM_SUSPEND_ON)
+		mem_sleep_current = state;
+	else
+		error = -EINVAL;
+
+ out:
+	pm_autosleep_unlock();
+	return error ? error : n;
+}
+
+power_attr(mem_sleep);
+#endif /* CONFIG_SUSPEND */
+
 #ifdef CONFIG_PM_DEBUG
 int pm_test_level = TEST_NONE;
 
@@ -368,12 +440,16 @@ static ssize_t state_store(struct kobjec
 	}
 
 	state = decode_state(buf, n);
-	if (state < PM_SUSPEND_MAX)
+	if (state < PM_SUSPEND_MAX) {
+		if (state == PM_SUSPEND_MEM)
+			state = mem_sleep_current;
+
 		error = pm_suspend(state);
-	else if (state == PM_SUSPEND_MAX)
+	} else if (state == PM_SUSPEND_MAX) {
 		error = hibernate();
-	else
+	} else {
 		error = -EINVAL;
+	}
 
  out:
 	pm_autosleep_unlock();
@@ -485,6 +561,9 @@ static ssize_t autosleep_store(struct ko
 	    && strcmp(buf, "off") && strcmp(buf, "off\n"))
 		return -EINVAL;
 
+	if (state == PM_SUSPEND_MEM)
+		state = mem_sleep_current;
+
 	error = pm_autosleep_set_state(state);
 	return error ? error : n;
 }
@@ -602,6 +681,9 @@ static struct attribute * g[] = {
 #ifdef CONFIG_PM_SLEEP
 	&pm_async_attr.attr,
 	&wakeup_count_attr.attr,
+#ifdef CONFIG_SUSPEND
+	&mem_sleep_attr.attr,
+#endif
 #ifdef CONFIG_PM_AUTOSLEEP
 	&autosleep_attr.attr,
 #endif
Index: linux-pm/kernel/power/power.h
===================================================================
--- linux-pm.orig/kernel/power/power.h
+++ linux-pm/kernel/power/power.h
@@ -189,8 +189,9 @@ extern void swsusp_show_speed(ktime_t, k
 
 #ifdef CONFIG_SUSPEND
 /* kernel/power/suspend.c */
-extern const char *pm_labels[];
 extern const char *pm_states[];
+extern const char *mem_sleep_states[];
+extern suspend_state_t mem_sleep_current;
 
 extern int suspend_devices_and_enter(suspend_state_t state);
 #else /* !CONFIG_SUSPEND */
Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -32,8 +32,19 @@
 
 #include "power.h"
 
-const char *pm_labels[] = { "mem", "standby", "freeze", NULL };
-const char *pm_states[PM_SUSPEND_MAX];
+const char *pm_states[PM_SUSPEND_MAX] = {
+	[PM_SUSPEND_FREEZE] = "freeze",
+	[PM_SUSPEND_MEM] = "mem",
+};
+const char * const mem_sleep_labels[] = {
+	[PM_SUSPEND_FREEZE] = "s2idle",
+	[PM_SUSPEND_STANDBY] = "shallow",
+	[PM_SUSPEND_MEM] = "deep",
+};
+const char *mem_sleep_states[PM_SUSPEND_MAX];
+
+suspend_state_t mem_sleep_current = PM_SUSPEND_FREEZE;
+static suspend_state_t mem_sleep_default = PM_SUSPEND_MEM;
 
 unsigned int pm_suspend_global_flags;
 EXPORT_SYMBOL_GPL(pm_suspend_global_flags);
@@ -110,30 +121,29 @@ static bool valid_state(suspend_state_t
 	return suspend_ops && suspend_ops->valid && suspend_ops->valid(state);
 }
 
-/*
- * If this is set, the "mem" label always corresponds to the deepest sleep state
- * available, the "standby" label corresponds to the second deepest sleep state
- * available (if any), and the "freeze" label corresponds to the remaining
- * available sleep state (if there is one).
- */
-static bool relative_states;
-
 void __init pm_states_init(void)
 {
 	/*
-	 * freeze state should be supported even without any suspend_ops,
-	 * initialize pm_states accordingly here
+	 * Suspend-to-idle should be supported even without any suspend_ops,
+	 * initialize mem_sleep_states[] accordingly here.
 	 */
-	pm_states[PM_SUSPEND_FREEZE] = pm_labels[relative_states ? 0 : 2];
+	mem_sleep_states[PM_SUSPEND_FREEZE] = mem_sleep_labels[PM_SUSPEND_FREEZE];
 }
 
-static int __init sleep_states_setup(char *str)
+static int __init mem_sleep_default_setup(char *str)
 {
-	relative_states = !strncmp(str, "1", 1);
+	suspend_state_t state;
+
+	for (state = PM_SUSPEND_FREEZE; state <= PM_SUSPEND_MEM; state++)
+		if (mem_sleep_labels[state] &&
+		    !strcmp(str, mem_sleep_labels[state])) {
+			mem_sleep_default = state;
+			break;
+		}
+
 	return 1;
 }
-
-__setup("relative_sleep_states=", sleep_states_setup);
+__setup("mem_sleep_default=", mem_sleep_default_setup);
 
 /**
  * suspend_set_ops - Set the global suspend method table.
@@ -141,21 +151,21 @@ __setup("relative_sleep_states=", sleep_
  */
 void suspend_set_ops(const struct platform_suspend_ops *ops)
 {
-	suspend_state_t i;
-	int j = 0;
-
 	lock_system_sleep();
 
 	suspend_ops = ops;
-	for (i = PM_SUSPEND_MEM; i >= PM_SUSPEND_STANDBY; i--)
-		if (valid_state(i)) {
-			pm_states[i] = pm_labels[j++];
-		} else if (!relative_states) {
-			pm_states[i] = NULL;
-			j++;
-		}
 
-	pm_states[PM_SUSPEND_FREEZE] = pm_labels[j];
+	if (valid_state(PM_SUSPEND_STANDBY)) {
+		mem_sleep_states[PM_SUSPEND_STANDBY] = mem_sleep_labels[PM_SUSPEND_STANDBY];
+		pm_states[PM_SUSPEND_STANDBY] = "standby";
+		if (mem_sleep_default == PM_SUSPEND_STANDBY)
+			mem_sleep_current = PM_SUSPEND_STANDBY;
+	}
+	if (valid_state(PM_SUSPEND_MEM)) {
+		mem_sleep_states[PM_SUSPEND_MEM] = mem_sleep_labels[PM_SUSPEND_MEM];
+		if (mem_sleep_default == PM_SUSPEND_MEM)
+			mem_sleep_current = PM_SUSPEND_MEM;
+	}
 
 	unlock_system_sleep();
 }
Index: linux-pm/Documentation/ABI/testing/sysfs-power
===================================================================
--- linux-pm.orig/Documentation/ABI/testing/sysfs-power
+++ linux-pm/Documentation/ABI/testing/sysfs-power
@@ -7,30 +7,35 @@ Description:
 		subsystem.
 
 What:		/sys/power/state
-Date:		May 2014
+Date:		November 2016
 Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
 Description:
 		The /sys/power/state file controls system sleep states.
 		Reading from this file returns the available sleep state
-		labels, which may be "mem", "standby", "freeze" and "disk"
-		(hibernation).  The meanings of the first three labels depend on
-		the relative_sleep_states command line argument as follows:
-		 1) relative_sleep_states = 1
-		    "mem", "standby", "freeze" represent non-hibernation sleep
-		    states from the deepest ("mem", always present) to the
-		    shallowest ("freeze").  "standby" and "freeze" may or may
-		    not be present depending on the capabilities of the
-		    platform.  "freeze" can only be present if "standby" is
-		    present.
-		 2) relative_sleep_states = 0 (default)
-		    "mem" - "suspend-to-RAM", present if supported.
-		    "standby" - "power-on suspend", present if supported.
-		    "freeze" - "suspend-to-idle", always present.
-
-		Writing to this file one of these strings causes the system to
-		transition into the corresponding state, if available.  See
-		Documentation/power/states.txt for a description of what
-		"suspend-to-RAM", "power-on suspend" and "suspend-to-idle" mean.
+		labels, which may be "mem" (suspend), "standby" (power-on
+		suspend), "freeze" (suspend-to-idle) and "disk" (hibernation).
+
+		Writing one of the above strings to this file causes the system
+		to transition into the corresponding state, if available.
+
+		See Documentation/power/states.txt for more information.
+
+What:		/sys/power/mem_sleep
+Date:		November 2016
+Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Description:
+		The /sys/power/mem_sleep file controls the operating mode of
+		system suspend.  Reading from it returns the available modes
+		as "s2idle" (always present), "shallow" and "deep" (present if
+		supported).  The mode that will be used on subsequent attempts
+		to suspend the system (by writing "mem" to the /sys/power/state
+		file described above) is enclosed in square brackets.
+
+		Writing one of the above strings to this file causes the mode
+		represented by it to be used on subsequent attempts to suspend
+		the system.
+
+		See Documentation/power/states.txt for more information.
 
 What:		/sys/power/disk
 Date:		September 2006
Index: linux-pm/Documentation/power/states.txt
===================================================================
--- linux-pm.orig/Documentation/power/states.txt
+++ linux-pm/Documentation/power/states.txt
@@ -8,25 +8,41 @@ for each state.
 
 The states are represented by strings that can be read or written to the
 /sys/power/state file.  Those strings may be "mem", "standby", "freeze" and
-"disk", where the last one always represents hibernation (Suspend-To-Disk) and
-the meaning of the remaining ones depends on the relative_sleep_states command
-line argument.
-
-For relative_sleep_states=1, the strings "mem", "standby" and "freeze" label the
-available non-hibernation sleep states from the deepest to the shallowest,
-respectively.  In that case, "mem" is always present in /sys/power/state,
-because there is at least one non-hibernation sleep state in every system.  If
-the given system supports two non-hibernation sleep states, "standby" is present
-in /sys/power/state in addition to "mem".  If the system supports three
-non-hibernation sleep states, "freeze" will be present in /sys/power/state in
-addition to "mem" and "standby".
+"disk", where the last three always represent Power-On Suspend (if supported),
+Suspend-To-Idle and hibernation (Suspend-To-Disk), respectively.
 
-For relative_sleep_states=0, which is the default, the following descriptions
-apply.
+The meaning of the "mem" string is controlled by the /sys/power/mem_sleep file.
+It contains strings representing the available modes of system suspend that may
+be triggered by writing "mem" to /sys/power/state.  These modes are "s2idle"
+(Suspend-To-Idle), "shallow" (Power-On Suspend) and "deep" (Suspend-To-RAM).
+The "s2idle" mode is always available, while the other ones are only available
+if supported by the platform (if not supported, the strings representing them
+are not present in /sys/power/mem_sleep).  The string representing the suspend
+mode to be used subsequently is enclosed in square brackets.  Writing one of
+the other strings present in /sys/power/mem_sleep to it causes the suspend mode
+to be used subsequently to change to the one represented by that string.
+
+Consequently, there are two ways to cause the system to go into the
+Suspend-To-Idle sleep state.  The first one is to write "freeze" directly to
+/sys/power/state.  The second one is to write "s2idle" to /sys/power/mem_sleep
+and then to wrtie "mem" to /sys/power/state.  Similarly, there are two ways
+to cause the system to go into the Power-On Suspend sleep state (the strings to
+write to the control files in that case are "standby" or "shallow" and "mem",
+respectively) if that state is supported by the platform.  In turn, there is
+only one way to cause the system to go into the Suspend-To-RAM state (write
+"deep" into /sys/power/mem_sleep and "mem" into /sys/power/state).
+
+The default suspend mode (ie. the one to be used without writing anything into
+/sys/power/mem_sleep) is either "deep" (if Suspend-To-RAM is supported) or
+"s2idle", but it can be overridden by the value of the "mem_sleep_default"
+parameter in the kernel command line.
 
-state:		Suspend-To-Idle
+The properties of all of the sleep states are described below.
+
+
+State:		Suspend-To-Idle
 ACPI state:	S0
-Label:		"freeze"
+Label:		"s2idle" ("freeze")
 
 This state is a generic, pure software, light-weight, system sleep state.
 It allows more energy to be saved relative to runtime idle by freezing user
@@ -35,13 +51,13 @@ lower-power than available at run time),
 spend more time in their idle states.
 
 This state can be used for platforms without Power-On Suspend/Suspend-to-RAM
-support, or it can be used in addition to Suspend-to-RAM (memory sleep)
-to provide reduced resume latency.  It is always supported.
+support, or it can be used in addition to Suspend-to-RAM to provide reduced
+resume latency.  It is always supported.
 
 
 State:		Standby / Power-On Suspend
 ACPI State:	S1
-Label:		"standby"
+Label:		"shallow" ("standby")
 
 This state, if supported, offers moderate, though real, power savings, while
 providing a relatively low-latency transition back to a working system.  No
@@ -58,7 +74,7 @@ state.
 
 State:		Suspend-to-RAM
 ACPI State:	S3
-Label:		"mem"
+Label:		"deep"
 
 This state, if supported, offers significant power savings as everything in the
 system is put into a low-power state, except for memory, which should be placed
Index: linux-pm/Documentation/kernel-parameters.txt
===================================================================
--- linux-pm.orig/Documentation/kernel-parameters.txt
+++ linux-pm/Documentation/kernel-parameters.txt
@@ -2334,6 +2334,12 @@ bytes respectively. Such letter suffixes
 			memory contents and reserves bad memory
 			regions that are detected.
 
+	mem_sleep_default=	[SUSPEND] Default system suspend mode:
+			s2idle  - Suspend-To-Idle
+			shallow - Power-On Suspend or equivalent (if supported)
+			deep    - Suspend-To-RAM or equivalent (if supported)
+			See Documentation/power/states.txt.
+
 	meye.*=		[HW] Set MotionEye Camera parameters
 			See Documentation/video4linux/meye.txt.
 
@@ -3677,13 +3683,6 @@ bytes respectively. Such letter suffixes
 			[KNL, SMP] Set scheduler's default relax_domain_level.
 			See Documentation/cgroup-v1/cpusets.txt.
 
-	relative_sleep_states=
-			[SUSPEND] Use sleep state labeling where the deepest
-			state available other than hibernation is always "mem".
-			Format: { "0" | "1" }
-			0 -- Traditional sleep state labels.
-			1 -- Relative sleep state labels.
-
 	reserve=	[KNL,BUGS] Force the kernel to ignore some iomem area
 
 	reservetop=	[X86-32]

