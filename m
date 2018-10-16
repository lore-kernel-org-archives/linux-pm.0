From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v8 10/15] sched: Introduce a sysctl for Energy Aware Scheduling
Date: Tue, 16 Oct 2018 11:15:08 +0100
Message-ID: <20181016101513.26919-11-quentin.perret@arm.com>
References: <20181016101513.26919-1-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016101513.26919-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org, quentin.perret@arm.com
List-Id: linux-pm@vger.kernel.org

In its current state, Energy Aware Scheduling (EAS) starts automatically
on asymmetric platforms having an Energy Model (EM). However, there are
users who want to have an EM (for thermal management for example), but
don't want EAS with it.

In order to let users disable EAS explicitly, introduce a new sysctl
called 'sched_energy_aware'. It is enabled by default so that EAS can
start automatically on platforms where it makes sense. Flipping it to 0
rebuilds the scheduling domains and disables EAS.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 include/linux/sched/sysctl.h |  7 +++++++
 kernel/sched/topology.c      | 29 +++++++++++++++++++++++++++++
 kernel/sysctl.c              | 11 +++++++++++
 3 files changed, 47 insertions(+)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index a9c32daeb9d8..99ce6d728df7 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -83,4 +83,11 @@ extern int sysctl_schedstats(struct ctl_table *table, int write,
 				 void __user *buffer, size_t *lenp,
 				 loff_t *ppos);
 
+#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
+extern unsigned int sysctl_sched_energy_aware;
+extern int sched_energy_aware_handler(struct ctl_table *table, int write,
+				 void __user *buffer, size_t *lenp,
+				 loff_t *ppos);
+#endif
+
 #endif /* _LINUX_SCHED_SYSCTL_H */
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 58bfda46ac07..e31f732d6ee7 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -203,9 +203,35 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 
 DEFINE_STATIC_KEY_FALSE(sched_energy_present);
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
+unsigned int sysctl_sched_energy_aware = 1;
 DEFINE_MUTEX(sched_energy_mutex);
 bool sched_energy_update;
 
+#ifdef CONFIG_PROC_SYSCTL
+int sched_energy_aware_handler(struct ctl_table *table, int write,
+			 void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret, state;
+
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	if (!ret && write) {
+		state = static_branch_unlikely(&sched_energy_present);
+		if (state != sysctl_sched_energy_aware) {
+			mutex_lock(&sched_energy_mutex);
+			sched_energy_update = 1;
+			rebuild_sched_domains();
+			sched_energy_update = 0;
+			mutex_unlock(&sched_energy_mutex);
+		}
+	}
+
+	return ret;
+}
+#endif
+
 static void free_pd(struct perf_domain *pd)
 {
 	struct perf_domain *tmp;
@@ -338,6 +364,9 @@ static void build_perf_domains(const struct cpumask *cpu_map)
 	struct cpufreq_policy *policy;
 	struct cpufreq_governor *gov;
 
+	if (!sysctl_sched_energy_aware)
+		goto free;
+
 	/* EAS is enabled for asymmetric CPU capacity topologies. */
 	if (!per_cpu(sd_asym_cpucapacity, cpu)) {
 		if (sched_debug()) {
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cc02050fd0c4..481309a11174 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -466,6 +466,17 @@ static struct ctl_table kern_table[] = {
 		.extra1		= &one,
 	},
 #endif
+#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
+	{
+		.procname	= "sched_energy_aware",
+		.data		= &sysctl_sched_energy_aware,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sched_energy_aware_handler,
+		.extra1		= &zero,
+		.extra2		= &one,
+	},
+#endif
 #ifdef CONFIG_PROVE_LOCKING
 	{
 		.procname	= "prove_locking",
-- 
2.19.1
