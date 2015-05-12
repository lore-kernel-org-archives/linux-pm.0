From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv4 PATCH 26/34] sched: Store system-wide maximum cpu capacity in root domain
Date: Tue, 12 May 2015 20:39:01 +0100
Message-ID: <1431459549-18343-27-git-send-email-morten.rasmussen@arm.com>
References: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, preeti@linux.vnet.ibm.com, mturquette@linaro.org, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, morten.rasmussen@arm.com
List-Id: linux-pm@vger.kernel.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

To be able to compare the capacity of the target cpu with the highest
cpu capacity of the system in the wakeup path, store the system-wide
maximum cpu capacity in the root domain.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/core.c  | 8 ++++++++
 kernel/sched/sched.h | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8818bf0..d307db8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6848,6 +6848,7 @@ static int build_sched_domains(const struct cpumask *cpu_map,
 	enum s_alloc alloc_state;
 	struct sched_domain *sd;
 	struct s_data d;
+	struct rq *rq;
 	int i, ret = -ENOMEM;
 
 	alloc_state = __visit_domain_allocation_hell(&d, cpu_map);
@@ -6901,11 +6902,18 @@ static int build_sched_domains(const struct cpumask *cpu_map,
 	/* Attach the domains */
 	rcu_read_lock();
 	for_each_cpu(i, cpu_map) {
+		rq = cpu_rq(i);
 		sd = *per_cpu_ptr(d.sd, i);
 		cpu_attach_domain(sd, d.rd, i);
+
+		if (rq->cpu_capacity_orig > rq->rd->max_cpu_capacity)
+			rq->rd->max_cpu_capacity = rq->cpu_capacity_orig;
 	}
 	rcu_read_unlock();
 
+	rq = cpu_rq(cpumask_first(cpu_map));
+	pr_info("Max cpu capacity: %lu\n", rq->rd->max_cpu_capacity);
+
 	ret = 0;
 error:
 	__free_domain_allocs(&d, alloc_state, cpu_map);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a5d2d69..95c8ff7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -553,6 +553,9 @@ struct root_domain {
 	 */
 	cpumask_var_t rto_mask;
 	struct cpupri cpupri;
+
+	/* Maximum cpu capacity in the system. */
+	unsigned long max_cpu_capacity;
 };
 
 extern struct root_domain def_root_domain;
-- 
1.9.1
