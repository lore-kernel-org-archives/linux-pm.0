From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v2] PM / EM: Expose the Energy Model in debugfs
Date: Tue, 22 Jan 2019 16:42:47 +0000
Message-ID: <20190122164247.19439-1-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rafael@kernel.org, peterz@infradead.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dietmar.eggemann@arm.com, gregkh@linuxfoundation.org, quentin.perret@arm.com
List-Id: linux-pm@vger.kernel.org

The recently introduced Energy Model (EM) framework manages power cost
tables of CPUs. These tables are currently only visible from kernel
space. However, in order to debug the behaviour of subsystems that use
the EM (EAS for example), it is often required to know what the power
costs are from userspace.

For this reason, introduce under /sys/kernel/debug/energy_model a set of
directories representing the performance domains of the system. Each
performance domain contains a set of sub-directories representing the
different capacity states (cs) and their attributes, as well as a file
exposing the related CPUs.

The resulting hierarchy is as follows on Arm juno r0 for example:

    /sys/kernel/debug/energy_model
    ├── pd0
    │   ├── cpus
    │   ├── cs:450000
    │   │   ├── cost
    │   │   ├── frequency
    │   │   └── power
    │   ├── cs:575000
    │   │   ├── cost
    │   │   ├── frequency
    │   │   └── power
    │   ├── cs:700000
    │   │   ├── cost
    │   │   ├── frequency
    │   │   └── power
    │   ├── cs:775000
    │   │   ├── cost
    │   │   ├── frequency
    │   │   └── power
    │   └── cs:850000
    │       ├── cost
    │       ├── frequency
    │       └── power
    └── pd1
        ├── cpus
        ├── cs:1100000
        │   ├── cost
        │   ├── frequency
        │   └── power
        ├── cs:450000
        │   ├── cost
        │   ├── frequency
        │   └── power
        ├── cs:625000
        │   ├── cost
        │   ├── frequency
        │   └── power
        ├── cs:800000
        │   ├── cost
        │   ├── frequency
        │   └── power
        └── cs:950000
            ├── cost
            ├── frequency
            └── power

Signed-off-by: Quentin Perret <quentin.perret@arm.com>

---

V2: removed check on return value of debugfs_create_* (Greg KH)
---
 kernel/power/energy_model.c | 57 +++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index d9dc2c38764a..7d66ee68aaaf 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -10,6 +10,7 @@
 
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
+#include <linux/debugfs.h>
 #include <linux/energy_model.h>
 #include <linux/sched/topology.h>
 #include <linux/slab.h>
@@ -23,6 +24,60 @@ static DEFINE_PER_CPU(struct em_perf_domain *, em_data);
  */
 static DEFINE_MUTEX(em_pd_mutex);
 
+#ifdef CONFIG_DEBUG_FS
+static struct dentry *rootdir;
+
+static void em_debug_create_cs(struct em_cap_state *cs, struct dentry *pd)
+{
+	struct dentry *d;
+	char name[24];
+
+	snprintf(name, sizeof(name), "cs:%lu", cs->frequency);
+
+	/* Create per-cs directory */
+	d = debugfs_create_dir(name, pd);
+	debugfs_create_ulong("frequency", 0444, d, &cs->frequency);
+	debugfs_create_ulong("power", 0444, d, &cs->power);
+	debugfs_create_ulong("cost", 0444, d, &cs->cost);
+}
+
+static int em_debug_cpus_show(struct seq_file *s, void *unused)
+{
+	seq_printf(s, "%*pbl\n", cpumask_pr_args(to_cpumask(s->private)));
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(em_debug_cpus);
+
+static void em_debug_create_pd(struct em_perf_domain *pd, int cpu)
+{
+	struct dentry *d;
+	char name[8];
+	int i;
+
+	snprintf(name, sizeof(name), "pd%d", cpu);
+
+	/* Create the directory of the performance domain */
+	d = debugfs_create_dir(name, rootdir);
+
+	debugfs_create_file("cpus", 0444, d, pd->cpus, &em_debug_cpus_fops);
+
+	/* Create a sub-directory for each capacity state */
+	for (i = 0; i < pd->nr_cap_states; i++)
+		em_debug_create_cs(&pd->table[i], d);
+}
+
+static int __init em_debug_init(void)
+{
+	/* Create /sys/kernel/debug/energy_model directory */
+	rootdir = debugfs_create_dir("energy_model", NULL);
+
+	return 0;
+}
+core_initcall(em_debug_init);
+#else /* CONFIG_DEBUG_FS */
+static void em_debug_create_pd(struct em_perf_domain *pd, int cpu) {}
+#endif
 static struct em_perf_domain *em_create_pd(cpumask_t *span, int nr_states,
 						struct em_data_callback *cb)
 {
@@ -102,6 +157,8 @@ static struct em_perf_domain *em_create_pd(cpumask_t *span, int nr_states,
 	pd->nr_cap_states = nr_states;
 	cpumask_copy(to_cpumask(pd->cpus), span);
 
+	em_debug_create_pd(pd, cpu);
+
 	return pd;
 
 free_cs_table:
-- 
2.20.1
