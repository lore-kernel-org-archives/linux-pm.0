From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFC PATCH 09/14] sched/tune: add sysctl interface to define a boost value
Date: Wed, 19 Aug 2015 19:47:19 +0100
Message-ID: <1440010044-3402-10-git-send-email-patrick.bellasi@arm.com>
References: <1440010044-3402-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53368 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752369AbbHSSry (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 19 Aug 2015 14:47:54 -0400
In-Reply-To: <1440010044-3402-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

The current (CFS) scheduler implementation does not allow "to boost"
tasks performance by running them at a higher OPP compared to the
minimum required to meet their workload demands.

To support tasks performance boosting the scheduler should provide a
"knob" which allows to tune how much the system is going to be optimised
for energy efficiency vs performance.

This patch is the first of a series which provides a simple interface to
define a tuning knob. One system-wide "boost" tunable is exposed via:
  /proc/sys/kernel/sched_cfs_boost
which can be configured in the range [0..100], to define a percentage
where:
  - 0%   boost requires to operate in "standard" mode by scheduling
         tasks at the minimum capacities required by the workload demand
  - 100% boost requires to push at maximum the task performances,
         "regardless" of the incurred energy consumption

A boost value in between these two boundaries is used to bias the
power/performance trade-off, the higher the boost value the more the
scheduler is biased toward performance boosting instead of energy
efficiency.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
---
 include/linux/sched/sysctl.h | 16 ++++++++++++++++
 init/Kconfig                 | 26 ++++++++++++++++++++++++++
 kernel/sched/Makefile        |  1 +
 kernel/sched/tune.c          | 17 +++++++++++++++++
 kernel/sysctl.c              | 11 +++++++++++
 5 files changed, 71 insertions(+)
 create mode 100644 kernel/sched/tune.c

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index c9e4731..4479e48 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -77,6 +77,22 @@ extern int sysctl_sched_rt_runtime;
 extern unsigned int sysctl_sched_cfs_bandwidth_slice;
 #endif
 
+#ifdef CONFIG_SCHED_TUNE
+extern unsigned int sysctl_sched_cfs_boost;
+int sysctl_sched_cfs_boost_handler(struct ctl_table *table, int write,
+				   void __user *buffer, size_t *length,
+				   loff_t *ppos);
+static inline unsigned int get_sysctl_sched_cfs_boost(void)
+{
+	return sysctl_sched_cfs_boost;
+}
+#else
+static inline unsigned int get_sysctl_sched_cfs_boost(void)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_SCHED_AUTOGROUP
 extern unsigned int sysctl_sched_autogroup_enabled;
 #endif
diff --git a/init/Kconfig b/init/Kconfig
index af09b4f..7fa3419 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1220,6 +1220,32 @@ config SCHED_AUTOGROUP
 	  desktop applications.  Task group autogeneration is currently based
 	  upon task session.
 
+config SCHED_TUNE
+	bool "Boosting for CFS tasks (EXPERIMENTAL)"
+	help
+	  This option enables the system-wide support for task boosting.
+	  When this support is enabled a new sysctl interface is exposed to
+	  userspace via:
+	     /proc/sys/kernel/sched_cfs_boost
+	  which allows to set a system-wide boost value in range [0..100].
+
+	  The currently boosting strategy is implemented in such a way that:
+	  - a 0% boost value requires to operate in "standard" mode by
+	    scheduling all tasks at the minimum capacities required by their
+	    workload demand
+	  - a 100% boost value requires to push at maximum the task
+	    performances, "regardless" of the incurred energy consumption
+
+	  A boost value in between these two boundaries is used to bias the
+	  power/performance trade-off, the higher the boost value the more the
+	  scheduler is biased toward performance boosting instead of energy
+	  efficiency.
+
+	  Since this support exposes a single system-wide knob, the specified
+	  boost value is applied to all (CFS) tasks in the system.
+
+	  If unsure, say N.
+
 config SYSFS_DEPRECATED
 	bool "Enable deprecated sysfs features to support old userspace tools"
 	depends on SYSFS
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 90ed832..f804ef3 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -18,5 +18,6 @@ obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o
 obj-$(CONFIG_SCHED_AUTOGROUP) += auto_group.o
 obj-$(CONFIG_SCHEDSTATS) += stats.o
 obj-$(CONFIG_SCHED_DEBUG) += debug.o
+obj-$(CONFIG_SCHED_TUNE) += tune.o
 obj-$(CONFIG_CGROUP_CPUACCT) += cpuacct.o
 obj-$(CONFIG_CPU_FREQ_GOV_SCHED) += cpufreq_sched.o
diff --git a/kernel/sched/tune.c b/kernel/sched/tune.c
new file mode 100644
index 0000000..4c44b1a
--- /dev/null
+++ b/kernel/sched/tune.c
@@ -0,0 +1,17 @@
+#include "sched.h"
+
+unsigned int sysctl_sched_cfs_boost __read_mostly;
+
+int
+sysctl_sched_cfs_boost_handler(struct ctl_table *table, int write,
+			       void __user *buffer, size_t *lenp,
+			       loff_t *ppos)
+{
+	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+
+	if (ret || !write)
+		return ret;
+
+	return 0;
+}
+
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 19b62b5..2b4673e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -433,6 +433,17 @@ static struct ctl_table kern_table[] = {
 		.extra1		= &one,
 	},
 #endif
+#ifdef CONFIG_SCHED_TUNE
+	{
+		.procname	= "sched_cfs_boost",
+		.data		= &sysctl_sched_cfs_boost,
+		.maxlen		= sizeof(sysctl_sched_cfs_boost),
+		.mode		= 0644,
+		.proc_handler	= &sysctl_sched_cfs_boost_handler,
+		.extra1		= &zero,
+		.extra2		= &one_hundred,
+	},
+#endif
 #ifdef CONFIG_PROVE_LOCKING
 	{
 		.procname	= "prove_locking",
-- 
2.5.0

