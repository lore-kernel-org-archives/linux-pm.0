From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2] cpuidle: Add 'high' and 'low' idle state metrics
Date: Wed, 05 Dec 2018 23:33:40 +0100
Message-ID: <3956581.Kf8ajzdeNX@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Giovanni Gherdovich <ggherdovich@suse.cz>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpuidle: Add 'high' and 'low' idle state metrics

Add two new metrics for CPU idle states, "high" and "low", to count
the number of times the given state had been asked for (or entered
from the kernel's perspective), but the observed idle duration turned
out to be too high or too low for it (respectively).

These mertics help to estimate the quality of the CPU idle governor
in use.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2: Compute the "low" metric as the number of times the entered
       state has been too shallow for sure (and not just probably)
       by taking that state's exit latency into account when computing
       it (the "high" metric computation did that in the previous version
       too).

---
 Documentation/ABI/testing/sysfs-devices-system-cpu |    7 ++++
 Documentation/admin-guide/pm/cpuidle.rst           |   10 ++++++
 drivers/cpuidle/cpuidle.c                          |   31 ++++++++++++++++++++-
 drivers/cpuidle/sysfs.c                            |    6 ++++
 include/linux/cpuidle.h                            |    2 +
 5 files changed, 55 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -202,7 +202,6 @@ int cpuidle_enter_state(struct cpuidle_d
 	struct cpuidle_state *target_state = &drv->states[index];
 	bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
 	ktime_t time_start, time_end;
-	s64 diff;
 
 	/*
 	 * Tell the time framework to switch to a broadcast timer because our
@@ -248,6 +247,9 @@ int cpuidle_enter_state(struct cpuidle_d
 		local_irq_enable();
 
 	if (entered_state >= 0) {
+		s64 diff, delay = drv->states[entered_state].exit_latency;
+		int i;
+
 		/*
 		 * Update cpuidle counters
 		 * This can be moved to within driver enter routine,
@@ -260,6 +262,33 @@ int cpuidle_enter_state(struct cpuidle_d
 		dev->last_residency = (int)diff;
 		dev->states_usage[entered_state].time += dev->last_residency;
 		dev->states_usage[entered_state].usage++;
+
+		if (diff < drv->states[entered_state].target_residency) {
+			for (i = entered_state - 1; i >= 0; i--) {
+				if (drv->states[i].disabled ||
+				    dev->states_usage[i].disable)
+					continue;
+
+				/* Shallower states are enabled, so update. */
+				dev->states_usage[entered_state].high++;
+				break;
+			}
+		} else if (diff > delay) {
+			for (i = entered_state + 1; i < drv->state_count; i++) {
+				if (drv->states[i].disabled ||
+				    dev->states_usage[i].disable)
+					continue;
+
+				/*
+				 * Update if a deeper state would have been a
+				 * better match for the observed idle duration.
+				 */
+				if (diff - delay >= drv->states[i].target_residency)
+					dev->states_usage[entered_state].low++;
+
+				break;
+			}
+		}
 	} else {
 		dev->last_residency = 0;
 	}
Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -33,6 +33,8 @@ struct cpuidle_state_usage {
 	unsigned long long	disable;
 	unsigned long long	usage;
 	unsigned long long	time; /* in US */
+	unsigned long long	high; /* Number of times it's been too deep */
+	unsigned long long	low;  /* Number of times it's been too shallow */
 #ifdef CONFIG_SUSPEND
 	unsigned long long	s2idle_usage;
 	unsigned long long	s2idle_time; /* in US */
Index: linux-pm/drivers/cpuidle/sysfs.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/sysfs.c
+++ linux-pm/drivers/cpuidle/sysfs.c
@@ -301,6 +301,8 @@ define_show_state_str_function(name)
 define_show_state_str_function(desc)
 define_show_state_ull_function(disable)
 define_store_state_ull_function(disable)
+define_show_state_ull_function(high)
+define_show_state_ull_function(low)
 
 define_one_state_ro(name, show_state_name);
 define_one_state_ro(desc, show_state_desc);
@@ -310,6 +312,8 @@ define_one_state_ro(power, show_state_po
 define_one_state_ro(usage, show_state_usage);
 define_one_state_ro(time, show_state_time);
 define_one_state_rw(disable, show_state_disable, store_state_disable);
+define_one_state_ro(high, show_state_high);
+define_one_state_ro(low, show_state_low);
 
 static struct attribute *cpuidle_state_default_attrs[] = {
 	&attr_name.attr,
@@ -320,6 +324,8 @@ static struct attribute *cpuidle_state_d
 	&attr_usage.attr,
 	&attr_time.attr,
 	&attr_disable.attr,
+	&attr_high.attr,
+	&attr_low.attr,
 	NULL
 };
 
Index: linux-pm/Documentation/admin-guide/pm/cpuidle.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/cpuidle.rst
+++ linux-pm/Documentation/admin-guide/pm/cpuidle.rst
@@ -404,9 +404,19 @@ object corresponding to it, as follows:
 ``disable``
 	Whether or not this idle state is disabled.
 
+``high``
+	Total number of times this idle state had been asked for, but the
+	observed idle duration was certainly too short to match its target
+	residency.
+
 ``latency``
 	Exit latency of the idle state in microseconds.
 
+``low``
+	Total number of times this idle state had been asked for, but cerainly
+	a deeper idle state would have been a better match for the observed idle
+	duration.
+
 ``name``
 	Name of the idle state.
 
Index: linux-pm/Documentation/ABI/testing/sysfs-devices-system-cpu
===================================================================
--- linux-pm.orig/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ linux-pm/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -145,6 +145,8 @@ What:		/sys/devices/system/cpu/cpuX/cpui
 		/sys/devices/system/cpu/cpuX/cpuidle/stateN/power
 		/sys/devices/system/cpu/cpuX/cpuidle/stateN/time
 		/sys/devices/system/cpu/cpuX/cpuidle/stateN/usage
+		/sys/devices/system/cpu/cpuX/cpuidle/stateN/high
+		/sys/devices/system/cpu/cpuX/cpuidle/stateN/low
 Date:		September 2007
 KernelVersion:	v2.6.24
 Contact:	Linux power management list <linux-pm@vger.kernel.org>
@@ -166,6 +168,11 @@ Description:
 
 		usage: (RO) Number of times this state was entered (a count).
 
+		high: (RO) Number of times this state was entered, but the
+		      observed CPU target residency was too high for it (a count).
+
+		low: (RO) Number of times this state was entered, but the
+		     observed CPU target residency was too low for it (a count).
 
 What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/desc
 Date:		February 2008
