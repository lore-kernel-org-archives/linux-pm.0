From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 06/10] x86/sysctl: Add sysctl for ITMT scheduling feature
Date: Wed, 21 Sep 2016 12:19:08 -0700
Message-ID: <1474485552-141429-7-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1474485552-141429-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474485552-141429-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, tim.c.chen@linux.intel.com, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Tim Chen <tim.c.chen@linux.intel.com>

Intel Turbo Boost Max Technology 3.0 (ITMT) feature
allows some cores to be boosted to higher turbo
frequency than others.

Add /proc/sys/kernel/sched_itmt_enabled so operator
can enable/disable scheduling of tasks that favor cores
with higher turbo boost frequency potential.

By default, system that is ITMT capable and single
socket has this feature turned on.  It is more likely
to be lightly loaded and operates in Turbo range.

When there is a change in the ITMT scheduling operation
desired, a rebuild of the sched domain is initiated
so the scheduler can set up sched domains with appropriate
flag to enable/disable ITMT scheduling operations.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 arch/x86/include/asm/topology.h |  1 +
 arch/x86/kernel/itmt.c          | 98 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 637d847..78e56f0 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -155,6 +155,7 @@ extern bool x86_topology_update;
 #include <asm/percpu.h>
 
 DECLARE_PER_CPU_READ_MOSTLY(int, sched_core_priority);
+extern unsigned int __read_mostly sysctl_sched_itmt_enabled;
 
 /* Interface to set priority of a cpu */
 void sched_set_itmt_core_prio(int prio, int core_cpu);
diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index 3e1636b..e7c96fe 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -33,6 +33,67 @@ static DEFINE_MUTEX(itmt_update_mutex);
 /* Boolean to track if system has ITMT capabilities */
 static bool __read_mostly sched_itmt_capable;
 
+/*
+ * Boolean to control whether we want to move processes to cpu capable
+ * of higher turbo frequency for cpus supporting Intel Turbo Boost Max
+ * Technology 3.0.
+ *
+ * It can be set via /proc/sys/kernel/sched_itmt_enabled
+ */
+unsigned int __read_mostly sysctl_sched_itmt_enabled;
+
+static int sched_itmt_update_handler(struct ctl_table *table, int write,
+			      void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret;
+	unsigned int old_sysctl;
+
+	mutex_lock(&itmt_update_mutex);
+
+	if (!sched_itmt_capable) {
+		mutex_unlock(&itmt_update_mutex);
+		return 0;
+	}
+
+	old_sysctl = sysctl_sched_itmt_enabled;
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+
+	if (!ret && write && old_sysctl != sysctl_sched_itmt_enabled) {
+		x86_topology_update = true;
+		rebuild_sched_domains();
+	}
+
+	mutex_unlock(&itmt_update_mutex);
+
+	return ret;
+}
+
+static unsigned int zero;
+static unsigned int one = 1;
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
 /**
  * sched_set_itmt_support - Indicate platform support ITMT
  * @itmt_supported: indicate platform's CPU has ITMT capability
@@ -45,13 +106,46 @@ static bool __read_mostly sched_itmt_capable;
  *
  * This must be done only after sched_set_itmt_core_prio
  * has been called to set the cpus' priorities.
+ *
+ * It must not be called with cpu hot plug lock
+ * held as we need to acquire the lock to rebuild sched domains
+ * later.
  */
 void sched_set_itmt_support(bool itmt_supported)
 {
 	mutex_lock(&itmt_update_mutex);
 
-	if (itmt_supported != sched_itmt_capable)
-		sched_itmt_capable = itmt_supported;
+	if (itmt_supported == sched_itmt_capable) {
+		mutex_unlock(&itmt_update_mutex);
+		return;
+	}
+	sched_itmt_capable = itmt_supported;
+
+	if (itmt_supported) {
+		itmt_sysctl_header =
+			register_sysctl_table(itmt_root_table);
+		if (!itmt_sysctl_header) {
+			mutex_unlock(&itmt_update_mutex);
+			return;
+		}
+		/*
+		 * ITMT capability automatically enables ITMT
+		 * scheduling for small systems (single node).
+		 */
+		if (topology_num_packages() == 1)
+			sysctl_sched_itmt_enabled = 1;
+	} else {
+		if (itmt_sysctl_header)
+			unregister_sysctl_table(itmt_sysctl_header);
+	}
+
+	if (sysctl_sched_itmt_enabled) {
+		/* disable sched_itmt if we are no longer ITMT capable */
+		if (!itmt_supported)
+			sysctl_sched_itmt_enabled = 0;
+		x86_topology_update = true;
+		rebuild_sched_domains();
+	}
 
 	mutex_unlock(&itmt_update_mutex);
 }
-- 
2.7.4
