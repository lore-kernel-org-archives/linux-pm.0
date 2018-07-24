From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v5 05/14] sched/topology: Reference the Energy Model of CPUs when available
Date: Tue, 24 Jul 2018 13:25:12 +0100
Message-ID: <20180724122521.22109-6-quentin.perret@arm.com>
References: <20180724122521.22109-1-quentin.perret@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724122521.22109-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org, quentin.perret@arm.com
List-Id: linux-pm@vger.kernel.org

The existing scheduling domain hierarchy is defined to map to the cache
topology of the system. However, Energy Aware Scheduling (EAS) requires
more knowledge about the platform, and specifically needs to know about
the span of Frequency Domains (FD), which do not always align with
caches.

To address this issue, use the Energy Model (EM) of the system to extend
the scheduler topology code with a representation of the FDs, alongside
the scheduling domains. More specifically, a linked list of FDs is
attached to each root domain. When multiple root domains are in use,
each list contains only the FDs covering the CPUs of its root domain. If
a FD spans over CPUs of two different root domains, it will be
duplicated in both lists.

The lists are fully maintained by the scheduler from
partition_sched_domains() in order to cope with hotplug and cpuset
changes. As for scheduling domains, the list are protected by RCU to
ensure safe concurrent updates.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 kernel/sched/sched.h    |  23 +++++++
 kernel/sched/topology.c | 139 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 158 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2a72f1b9be0f..fdf6924d53e7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -44,6 +44,7 @@
 #include <linux/ctype.h>
 #include <linux/debugfs.h>
 #include <linux/delayacct.h>
+#include <linux/energy_model.h>
 #include <linux/init_task.h>
 #include <linux/kprobes.h>
 #include <linux/kthread.h>
@@ -700,6 +701,12 @@ static inline bool sched_asym_prefer(int a, int b)
 	return arch_asym_cpu_priority(a) > arch_asym_cpu_priority(b);
 }
 
+struct freq_domain {
+	struct em_freq_domain *obj;
+	struct freq_domain *next;
+	struct rcu_head rcu;
+};
+
 /*
  * We add the notion of a root-domain which will be used to define per-domain
  * variables. Each exclusive cpuset essentially defines an island domain by
@@ -748,6 +755,14 @@ struct root_domain {
 	struct cpupri		cpupri;
 
 	unsigned long		max_cpu_capacity;
+
+#ifdef CONFIG_ENERGY_MODEL
+	/*
+	 * NULL-terminated list of frequency domains intersecting with the
+	 * CPUs of the rd. Protected by RCU.
+	 */
+	struct freq_domain *fd;
+#endif
 };
 
 extern struct root_domain def_root_domain;
@@ -2203,3 +2218,11 @@ static inline unsigned long cpu_util_irq(struct rq *rq)
 
 #endif
 #endif
+
+#ifdef CONFIG_SMP
+#ifdef CONFIG_ENERGY_MODEL
+#define freq_domain_span(fd) (to_cpumask(((fd)->obj->cpus)))
+#else
+#define freq_domain_span(fd) NULL
+#endif
+#endif
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 05a831427bc7..ade1eae9d21b 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -201,6 +201,121 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 	return 1;
 }
 
+#ifdef CONFIG_ENERGY_MODEL
+static void free_fd(struct freq_domain *fd)
+{
+	struct freq_domain *tmp;
+
+	while (fd) {
+		tmp = fd->next;
+		kfree(fd);
+		fd = tmp;
+	}
+}
+
+static void free_rd_fd(struct root_domain *rd)
+{
+	free_fd(rd->fd);
+}
+
+static struct freq_domain *find_fd(struct freq_domain *fd, int cpu)
+{
+	while (fd) {
+		if (cpumask_test_cpu(cpu, freq_domain_span(fd)))
+			return fd;
+		fd = fd->next;
+	}
+
+	return NULL;
+}
+
+static struct freq_domain *fd_init(int cpu)
+{
+	struct em_freq_domain *obj = em_cpu_get(cpu);
+	struct freq_domain *fd;
+
+	if (!obj) {
+		if (sched_debug())
+			pr_info("%s: no EM found for CPU%d\n", __func__, cpu);
+		return NULL;
+	}
+
+	fd = kzalloc(sizeof(*fd), GFP_KERNEL);
+	if (!fd)
+		return NULL;
+	fd->obj = obj;
+
+	return fd;
+}
+
+static void freq_domain_debug(const struct cpumask *cpu_map,
+						struct freq_domain *fd)
+{
+	if (!sched_debug() || !fd)
+		return;
+
+	printk(KERN_DEBUG "root_domain %*pbl: fd:", cpumask_pr_args(cpu_map));
+
+	while (fd) {
+		printk(KERN_CONT " { fd%d cpus=%*pbl nr_cstate=%d }",
+				cpumask_first(freq_domain_span(fd)),
+				cpumask_pr_args(freq_domain_span(fd)),
+				em_fd_nr_cap_states(fd->obj));
+		fd = fd->next;
+	}
+
+	printk(KERN_CONT "\n");
+}
+
+static void destroy_freq_domain_rcu(struct rcu_head *rp)
+{
+	struct freq_domain *fd;
+
+	fd = container_of(rp, struct freq_domain, rcu);
+	free_fd(fd);
+}
+
+static void build_freq_domains(const struct cpumask *cpu_map)
+{
+	struct freq_domain *fd = NULL, *tmp;
+	int cpu = cpumask_first(cpu_map);
+	struct root_domain *rd = cpu_rq(cpu)->rd;
+	int i;
+
+	for_each_cpu(i, cpu_map) {
+		/* Skip already covered CPUs. */
+		if (find_fd(fd, i))
+			continue;
+
+		/* Create the new fd and add it to the local list. */
+		tmp = fd_init(i);
+		if (!tmp)
+			goto free;
+		tmp->next = fd;
+		fd = tmp;
+	}
+
+	freq_domain_debug(cpu_map, fd);
+
+	/* Attach the new list of frequency domains to the root domain. */
+	tmp = rd->fd;
+	rcu_assign_pointer(rd->fd, fd);
+	if (tmp)
+		call_rcu(&tmp->rcu, destroy_freq_domain_rcu);
+
+	return;
+
+free:
+	free_fd(fd);
+	tmp = rd->fd;
+	rcu_assign_pointer(rd->fd, NULL);
+	if (tmp)
+		call_rcu(&tmp->rcu, destroy_freq_domain_rcu);
+}
+#else
+static void free_rd_fd(struct root_domain *rd) { }
+#endif
+
 static void free_rootdomain(struct rcu_head *rcu)
 {
 	struct root_domain *rd = container_of(rcu, struct root_domain, rcu);
@@ -211,6 +326,7 @@ static void free_rootdomain(struct rcu_head *rcu)
 	free_cpumask_var(rd->rto_mask);
 	free_cpumask_var(rd->online);
 	free_cpumask_var(rd->span);
+	free_rd_fd(rd);
 	kfree(rd);
 }
 
@@ -1882,8 +1998,8 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 	/* Destroy deleted domains: */
 	for (i = 0; i < ndoms_cur; i++) {
 		for (j = 0; j < n && !new_topology; j++) {
-			if (cpumask_equal(doms_cur[i], doms_new[j])
-			    && dattrs_equal(dattr_cur, i, dattr_new, j))
+			if (cpumask_equal(doms_cur[i], doms_new[j]) &&
+			    dattrs_equal(dattr_cur, i, dattr_new, j))
 				goto match1;
 		}
 		/* No match - a current sched domain not in new doms_new[] */
@@ -1903,8 +2019,8 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 	/* Build new domains: */
 	for (i = 0; i < ndoms_new; i++) {
 		for (j = 0; j < n && !new_topology; j++) {
-			if (cpumask_equal(doms_new[i], doms_cur[j])
-			    && dattrs_equal(dattr_new, i, dattr_cur, j))
+			if (cpumask_equal(doms_new[i], doms_cur[j]) &&
+			    dattrs_equal(dattr_new, i, dattr_cur, j))
 				goto match2;
 		}
 		/* No match - add a new doms_new */
@@ -1913,6 +2029,21 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 		;
 	}
 
+#ifdef CONFIG_ENERGY_MODEL
+	/* Build freq domains: */
+	for (i = 0; i < ndoms_new; i++) {
+		for (j = 0; j < n; j++) {
+			if (cpumask_equal(doms_new[i], doms_cur[j]) &&
+			    cpu_rq(cpumask_first(doms_cur[j]))->rd->fd)
+				goto match3;
+		}
+		/* No match - add freq domains for a new rd */
+		build_freq_domains(doms_new[i]);
+match3:
+		;
+	}
+#endif
+
 	/* Remember the new sched domains: */
 	if (doms_cur != &fallback_doms)
 		free_sched_domains(doms_cur, ndoms_cur);
-- 
2.18.0
