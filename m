From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 5/8] sched,x86: Enable Turbo Boost Max Technology
Date: Thu,  1 Sep 2016 13:33:41 -0700
Message-ID: <1472762024-88771-6-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1472762024-88771-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:44332 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756855AbcIAVHx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Sep 2016 17:07:53 -0400
In-Reply-To: <1472762024-88771-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, peterz@infradead.org
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tim.c.chen@linux.intel.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Tim Chen <tim.c.chen@linux.intel.com>

On some Intel cores, they can boosted to a higher turbo frequency than
the other cores on the same die.  So we prefer processes to be run on
them vs other lower frequency ones for extra performance.

We extend the asym packing feature in the scheduler to support packing
task to the higher frequency core at the core sched domain level.

We set up a core priority metric to abstract the core preferences based
on the maximum boost frequency.  The priority is instantiated such that
the core with a higher priority is favored over the core with lower
priority when making scheduling decision using ASYM_PACKING.  The smt
threads that are of higher number are discounted in their priority so
we will not try to pack tasks onto all the threads of a favored core
before using other cpu cores.  The cpu that's of the highest priority
in a sched_group is recorded in sched_group->asym_prefer_cpu during
initialization to save lookup during load balancing.

A sysctl variable /proc/sys/kernel/sched_itmt_enabled is provided so
the scheduling based on favored core can be turned on or off at run time.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 arch/x86/Kconfig                |   9 +++
 arch/x86/include/asm/topology.h |  18 +++++
 arch/x86/kernel/Makefile        |   1 +
 arch/x86/kernel/itmt.c          | 161 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/smpboot.c       |   1 -
 5 files changed, 189 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/itmt.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2a1f0ce..6dfb97d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -927,6 +927,15 @@ config SCHED_MC
 	  making when dealing with multi-core CPU chips at a cost of slightly
 	  increased overhead in some places. If unsure say N here.
 
+config SCHED_ITMT
+	bool "Intel Turbo Boost Max Technology (ITMT) scheduler support"
+	depends on SCHED_MC && CPU_SUP_INTEL && X86_INTEL_PSTATE
+	---help---
+	  ITMT enabled scheduler support improves the CPU scheduler's decision
+	  to move tasks to cpu core that can be boosted to a higher frequency
+	  than others. It will have better performance at a cost of slightly
+	  increased overhead in task migrations. If unsure say N here.
+
 source "kernel/Kconfig.preempt"
 
 config UP_LATE_INIT
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 8d6df77..ac86a0b 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -150,7 +150,25 @@ void x86_pci_root_bus_resources(int bus, struct list_head *resources);
 extern bool x86_topology_update;
 
 #ifdef CONFIG_SCHED_ITMT
+#include <asm/percpu.h>
+
+DECLARE_PER_CPU_READ_MOSTLY(int, sched_core_priority);
 extern unsigned int __read_mostly sysctl_sched_itmt_enabled;
+
+/* Interface to set priority of a cpu */
+void sched_set_itmt_core_prio(int prio, int core_cpu);
+
+/* Interface to notify scheduler that system supports ITMT */
+void set_sched_itmt(bool support_itmt);
+
+#else /* CONFIG_SCHED_ITMT */
+
+static inline void set_sched_itmt(bool support_itmt)
+{
+}
+static inline void sched_set_itmt_core_prio(int prio, int core_cpu)
+{
+}
 #endif /* CONFIG_SCHED_ITMT */
 
 #endif /* _ASM_X86_TOPOLOGY_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0503f5b..2008335 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -124,6 +124,7 @@ obj-$(CONFIG_EFI)			+= sysfb_efi.o
 
 obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o
 obj-$(CONFIG_TRACING)			+= tracepoint.o
+obj-$(CONFIG_SCHED_ITMT)		+= itmt.o
 
 ###
 # 64 bit specific files
diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
new file mode 100644
index 0000000..5e991bd
--- /dev/null
+++ b/arch/x86/kernel/itmt.c
@@ -0,0 +1,161 @@
+/*
+ * itmt.c: Functions and data structures for enabling
+ *	   scheduler to favor scheduling on cores that
+ *	   can be boosted to a higher frequency using
+ *	   Intel Turbo Boost Max Technology 3.0
+ *
+ * (C) Copyright 2016 Intel Corporation
+ * Author: Tim Chen <tim.c.chen@linux.intel.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ */
+
+#include <linux/sched.h>
+#include <linux/cpumask.h>
+#include <linux/cpuset.h>
+#include <asm/mutex.h>
+#include <linux/sched.h>
+#include <linux/sysctl.h>
+#include <linux/nodemask.h>
+
+DEFINE_PER_CPU_READ_MOSTLY(int, sched_core_priority);
+static DEFINE_MUTEX(itmt_update_mutex);
+
+static unsigned int zero;
+static unsigned int one = 1;
+
+/*
+ * Boolean to control whether we want to move processes to cpu capable
+ * of higher turbo frequency for cpus supporting Intel Turbo Boost Max
+ * Technology 3.0.
+ *
+ * It can be set via /proc/sys/kernel/sched_itmt_enabled
+ */
+unsigned int __read_mostly sysctl_sched_itmt_enabled;
+
+/*
+ * The pstate_driver calls set_sched_itmt to indicate if the system
+ * is ITMT capable.
+ */
+static bool __read_mostly sched_itmt_capable;
+
+int arch_asym_cpu_priority(int cpu)
+{
+	return per_cpu(sched_core_priority, cpu);
+}
+
+static void enable_sched_itmt(bool enable_itmt)
+{
+	mutex_lock(&itmt_update_mutex);
+
+	sysctl_sched_itmt_enabled = enable_itmt;
+	x86_topology_update = true;
+	rebuild_sched_domains();
+
+	mutex_unlock(&itmt_update_mutex);
+}
+
+static int sched_itmt_update_handler(struct ctl_table *table, int write,
+			      void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret;
+
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+
+	if (ret || !write)
+		return ret;
+
+	enable_sched_itmt(sysctl_sched_itmt_enabled);
+
+	return ret;
+}
+
+static struct ctl_table itmt_kern_table[] = {
+	{
+		.procname	= "sched_itmt_enabled",
+		.data		= &sysctl_sched_itmt_enabled,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sched_itmt_update_handler,
+		.extra1		= &zero,
+		.extra2		= &one,
+	},
+	{}
+};
+
+static struct ctl_table itmt_root_table[] = {
+	{
+		.procname	= "kernel",
+		.mode		= 0555,
+		.child		= itmt_kern_table,
+	},
+	{}
+};
+
+static struct ctl_table_header *itmt_sysctl_header;
+
+/*
+ * The boot code will find out the max boost frequency
+ * and call this function to set a priority proportional
+ * to the max boost frequency. CPU with higher boost
+ * frequency will receive higher priority.
+ */
+void sched_set_itmt_core_prio(int prio, int core_cpu)
+{
+	int cpu, i = 1;
+
+	for_each_cpu(cpu, topology_sibling_cpumask(core_cpu)) {
+		int smt_prio;
+
+		/*
+		 * Discount the priority of sibling so that we don't
+		 * pack all loads to the same core before using other cores.
+		 */
+		smt_prio = prio * smp_num_siblings / i;
+		i++;
+		per_cpu(sched_core_priority, cpu) = smt_prio;
+	}
+}
+
+/*
+ * During boot up, boot code will detect if the system
+ * is ITMT capable and call set_sched_itmt.
+ *
+ * This should be call after sched_set_itmt_core_prio
+ * has been called to set the cpus' priorities.
+ *
+ * This function should be called without cpu hot plug lock
+ * as we need to acquire the lock to rebuild sched domains
+ * later.
+ */
+void set_sched_itmt(bool itmt_capable)
+{
+	mutex_lock(&itmt_update_mutex);
+
+	if (itmt_capable != sched_itmt_capable) {
+
+		if (itmt_capable) {
+			itmt_sysctl_header =
+				register_sysctl_table(itmt_root_table);
+			/*
+			 * ITMT capability automatically enables ITMT
+			 * scheduling for client systems (single node).
+			 */
+			if (topology_num_packages() == 1)
+				sysctl_sched_itmt_enabled = 1;
+		} else {
+			if (itmt_sysctl_header)
+				unregister_sysctl_table(itmt_sysctl_header);
+			sysctl_sched_itmt_enabled = 0;
+		}
+
+		sched_itmt_capable = itmt_capable;
+		x86_topology_update = true;
+		rebuild_sched_domains();
+	}
+
+	mutex_unlock(&itmt_update_mutex);
+}
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 737b9edf..17f3ac7 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -109,7 +109,6 @@ static bool logical_packages_frozen __read_mostly;
 /* Maximum number of SMT threads on any online core */
 int __max_smt_threads __read_mostly;
 
-unsigned int __read_mostly sysctl_sched_itmt_enabled;
 /* Flag to indicate if a complete sched domain rebuild is required */
 bool x86_topology_update;
 
-- 
2.7.4

