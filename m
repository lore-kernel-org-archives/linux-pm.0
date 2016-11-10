From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH v7 4/8] x86/sysctl: Add sysctl for ITMT scheduling feature
Date: Thu, 10 Nov 2016 14:36:36 -0800
Message-ID: <bde18b7d3dc8dc7a351151afd7808655a3f53ae3.1478805832.git.tim.c.chen@linux.intel.com>
References: <cover.1478805832.git.tim.c.chen@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1478805832.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1478805832.git.tim.c.chen@linux.intel.com>
References: <cover.1478805832.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de
Cc: Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

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

Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Co-developed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 arch/x86/include/asm/topology.h |   7 ++-
 arch/x86/kernel/itmt.c          | 108 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 112 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 8ace951..4813df5 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -152,23 +152,26 @@ extern bool x86_topology_update;
 #include <asm/percpu.h>
 
 DECLARE_PER_CPU_READ_MOSTLY(int, sched_core_priority);
+extern unsigned int __read_mostly sysctl_sched_itmt_enabled;
 
 /* Interface to set priority of a cpu */
 void sched_set_itmt_core_prio(int prio, int core_cpu);
 
 /* Interface to notify scheduler that system supports ITMT */
-void sched_set_itmt_support(void);
+int sched_set_itmt_support(void);
 
 /* Interface to notify scheduler that system revokes ITMT support */
 void sched_clear_itmt_support(void);
 
 #else /* CONFIG_SCHED_ITMT */
 
+#define sysctl_sched_itmt_enabled	0
 static inline void sched_set_itmt_core_prio(int prio, int core_cpu)
 {
 }
-static inline void sched_set_itmt_support(void)
+static inline int sched_set_itmt_support(void)
 {
+	return 0;
 }
 static inline void sched_clear_itmt_support(void)
 {
diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index 1bd7221..9d1ef17 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -34,6 +34,68 @@ DEFINE_PER_CPU_READ_MOSTLY(int, sched_core_priority);
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
+				     void __user *buffer, size_t *lenp,
+				     loff_t *ppos)
+{
+	unsigned int old_sysctl;
+	int ret;
+
+	mutex_lock(&itmt_update_mutex);
+
+	if (!sched_itmt_capable) {
+		mutex_unlock(&itmt_update_mutex);
+		return -EINVAL;
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
  * sched_set_itmt_support() - Indicate platform supports ITMT
  *
@@ -45,14 +107,39 @@ static bool __read_mostly sched_itmt_capable;
  *
  * This must be done only after sched_set_itmt_core_prio
  * has been called to set the cpus' priorities.
+ * It must not be called with cpu hot plug lock
+ * held as we need to acquire the lock to rebuild sched domains
+ * later.
+ *
+ * Return: 0 on success
  */
-void sched_set_itmt_support(void)
+int sched_set_itmt_support(void)
 {
 	mutex_lock(&itmt_update_mutex);
 
+	if (sched_itmt_capable) {
+		mutex_unlock(&itmt_update_mutex);
+		return 0;
+	}
+
+	itmt_sysctl_header = register_sysctl_table(itmt_root_table);
+	if (!itmt_sysctl_header) {
+		mutex_unlock(&itmt_update_mutex);
+		return -ENOMEM;
+	}
+
 	sched_itmt_capable = true;
 
+	sysctl_sched_itmt_enabled = 1;
+
+	if (sysctl_sched_itmt_enabled) {
+		x86_topology_update = true;
+		rebuild_sched_domains();
+	}
+
 	mutex_unlock(&itmt_update_mutex);
+
+	return 0;
 }
 
 /**
@@ -61,13 +148,32 @@ void sched_set_itmt_support(void)
  * This function is used by the OS to indicate that it has
  * revoked the platform's support of ITMT feature.
  *
+ * It must not be called with cpu hot plug lock
+ * held as we need to acquire the lock to rebuild sched domains
+ * later.
  */
 void sched_clear_itmt_support(void)
 {
 	mutex_lock(&itmt_update_mutex);
 
+	if (!sched_itmt_capable) {
+		mutex_unlock(&itmt_update_mutex);
+		return;
+	}
 	sched_itmt_capable = false;
 
+	if (itmt_sysctl_header) {
+		unregister_sysctl_table(itmt_sysctl_header);
+		itmt_sysctl_header = NULL;
+	}
+
+	if (sysctl_sched_itmt_enabled) {
+		/* disable sched_itmt if we are no longer ITMT capable */
+		sysctl_sched_itmt_enabled = 0;
+		x86_topology_update = true;
+		rebuild_sched_domains();
+	}
+
 	mutex_unlock(&itmt_update_mutex);
 }
 
-- 
2.5.5
