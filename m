From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 01/11] sched, cpuset: Add regenerate_sched_domains function to rebuild all sched domains
Date: Thu, 18 Aug 2016 15:36:42 -0700
Message-ID: <1471559812-19967-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1471559812-19967-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471559812-19967-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, rjw@rjwysocki.net, peterz@infradead.org
Cc: x86@kernel.org, bp@suse.de, sudeep.holla@arm.com, ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, alexey.klimov@arm.com, viresh.kumar@linaro.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, lenb@kernel.org, tim.c.chen@linux.intel.com, srinivas.pandruvada@linux.intel.com, paul.gortmaker@windriver.com, jpoimboe@redhat.com, mcgrof@kernel.org, jgross@suse.com, robert.moore@intel.com, dvyukov@google.com, jeyu@redhat.com
List-Id: linux-pm@vger.kernel.org

From: Tim Chen <tim.c.chen@linux.intel.com>

The current rebuild_sched_domains will only rebuild the sched domains
unless the cpumask changes.  However, in some scenarios when the
topology flag value changes, it will not rebuild the sched domain.

We create a regenerate_sched_domains function that will always
rebuild all the sched domains to take care of this scenario.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 include/linux/cpuset.h |  2 ++
 include/linux/sched.h  |  3 +++
 kernel/cpuset.c        | 32 +++++++++++++++++++++++++-------
 kernel/sched/core.c    | 25 ++++++++++++++++++++++---
 4 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index bfc204e..9f948fa 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -102,6 +102,8 @@ extern int current_cpuset_is_being_rebound(void);
 
 extern void rebuild_sched_domains(void);
 
+extern void regenerate_sched_domains(void);
+
 extern void cpuset_print_current_mems_allowed(void);
 
 /*
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 62c68e5..3301959 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1152,6 +1152,9 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
 extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 				    struct sched_domain_attr *dattr_new);
 
+extern void regen_partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
+				    struct sched_domain_attr *dattr_new);
+
 /* Allocate an array of sched domains, for partition_sched_domains(). */
 cpumask_var_t *alloc_sched_domains(unsigned int ndoms);
 void free_sched_domains(cpumask_var_t doms[], unsigned int ndoms);
diff --git a/kernel/cpuset.c b/kernel/cpuset.c
index c7fd277..f6f7c17 100644
--- a/kernel/cpuset.c
+++ b/kernel/cpuset.c
@@ -794,10 +794,12 @@ done:
  * which has that flag enabled, or if any cpuset with a non-empty
  * 'cpus' is removed, then call this routine to rebuild the
  * scheduler's dynamic sched domains.
+ * If forced flag is set, then we will always regenerate all new
+ * sched domains.
  *
  * Call with cpuset_mutex held.  Takes get_online_cpus().
  */
-static void rebuild_sched_domains_locked(void)
+static void rebuild_sched_domains_locked(bool rebuild_all)
 {
 	struct sched_domain_attr *attr;
 	cpumask_var_t *doms;
@@ -818,12 +820,17 @@ static void rebuild_sched_domains_locked(void)
 	ndoms = generate_sched_domains(&doms, &attr);
 
 	/* Have scheduler rebuild the domains */
-	partition_sched_domains(ndoms, doms, attr);
+	if (rebuild_all)
+		/* Will rebuild a complete set of all sched domains */
+		regen_partition_sched_domains(ndoms, doms, attr);
+	else
+		/* Rebuild only sched domains with changed cpu masks */
+		partition_sched_domains(ndoms, doms, attr);
 out:
 	put_online_cpus();
 }
 #else /* !CONFIG_SMP */
-static void rebuild_sched_domains_locked(void)
+static void rebuild_sched_domains_locked(bool forced)
 {
 }
 #endif /* CONFIG_SMP */
@@ -831,7 +838,18 @@ static void rebuild_sched_domains_locked(void)
 void rebuild_sched_domains(void)
 {
 	mutex_lock(&cpuset_mutex);
-	rebuild_sched_domains_locked();
+	rebuild_sched_domains_locked(false);
+	mutex_unlock(&cpuset_mutex);
+}
+
+/*
+ * Similar to rebuild_sched domains, but will force
+ * all sched domains to be always rebuilt.
+ */
+void regenerate_sched_domains(void)
+{
+	mutex_lock(&cpuset_mutex);
+	rebuild_sched_domains_locked(true);
 	mutex_unlock(&cpuset_mutex);
 }
 
@@ -919,7 +937,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct cpumask *new_cpus)
 	rcu_read_unlock();
 
 	if (need_rebuild_sched_domains)
-		rebuild_sched_domains_locked();
+		rebuild_sched_domains_locked(false);
 }
 
 /**
@@ -1267,7 +1285,7 @@ static int update_relax_domain_level(struct cpuset *cs, s64 val)
 		cs->relax_domain_level = val;
 		if (!cpumask_empty(cs->cpus_allowed) &&
 		    is_sched_load_balance(cs))
-			rebuild_sched_domains_locked();
+			rebuild_sched_domains_locked(true);
 	}
 
 	return 0;
@@ -1333,7 +1351,7 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 	spin_unlock_irq(&callback_lock);
 
 	if (!cpumask_empty(trialcs->cpus_allowed) && balance_flag_changed)
-		rebuild_sched_domains_locked();
+		rebuild_sched_domains_locked(false);
 
 	if (spread_flag_changed)
 		update_tasks_flags(cs);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2a906f2..ec752da 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7069,8 +7069,9 @@ static int dattrs_equal(struct sched_domain_attr *cur, int idx_cur,
  *
  * Call with hotplug lock held
  */
-void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
-			     struct sched_domain_attr *dattr_new)
+static void __partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
+			     struct sched_domain_attr *dattr_new,
+			     int need_domain_rebuild)
 {
 	int i, j, n;
 	int new_topology;
@@ -7081,7 +7082,7 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 	unregister_sched_domain_sysctl();
 
 	/* Let architecture update cpu core mappings. */
-	new_topology = arch_update_cpu_topology();
+	new_topology = arch_update_cpu_topology() | need_domain_rebuild;
 
 	n = doms_new ? ndoms_new : 0;
 
@@ -7132,6 +7133,24 @@ match2:
 	mutex_unlock(&sched_domains_mutex);
 }
 
+/*
+ * Generate sched domains only when the cpumask or domain attr changes
+ */
+void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
+			     struct sched_domain_attr *dattr_new)
+{
+	__partition_sched_domains(ndoms_new, doms_new, dattr_new, 0);
+}
+
+/*
+ * Generate new sched domains always
+ */
+void regen_partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
+			     struct sched_domain_attr *dattr_new)
+{
+	__partition_sched_domains(ndoms_new, doms_new, dattr_new, 1);
+}
+
 static int num_cpus_frozen;	/* used to mark begin/end of suspend/resume */
 
 /*
-- 
2.7.4
