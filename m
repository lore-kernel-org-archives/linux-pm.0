From: Yuyang Du <yuyang.du@intel.com>
Subject: [RFC PATCH 9/9 v4] Implement Workload Consolidation in periodic load balance
Date: Wed, 25 Jun 2014 08:36:08 +0800
Message-ID: <1403656568-32445-10-git-send-email-yuyang.du@intel.com>
References: <1403656568-32445-1-git-send-email-yuyang.du@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403656568-32445-1-git-send-email-yuyang.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com, peterz@infradead.org, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: arjan.van.de.ven@intel.com, len.brown@intel.com, alan.cox@intel.com, mark.gross@intel.com, morten.rasmussen@arm.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rajeev.d.muralidhar@intel.com, vishwesh.m.rudramuni@intel.com, nicole.chalhoub@intel.com, ajaya.durg@intel.com, harinarayanan.seshadri@intel.com, jacob.jun.pan@linux.intel.com, Yuyang Du <yuyang.du@intel.com>
List-Id: linux-pm@vger.kernel.org

1) Skip pulling task to the non-consolidated CPUs.

2) In addition, for consolidated Idle CPU, we aggressively pull tasks from
   non-consolidated CPUs.

Signed-off-by: Yuyang Du <yuyang.du@intel.com>
---
 kernel/sched/fair.c |   50 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 549f6e0..7fcd2d0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7371,17 +7371,53 @@ static void nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle, struc
 static void run_rebalance_domains(struct softirq_action *h)
 {
 	struct rq *this_rq = this_rq();
+	int this_cpu = cpu_of(this_rq);
+	struct sched_domain *sd;
 	enum cpu_idle_type idle = this_rq->idle_balance ?
 						CPU_IDLE : CPU_NOT_IDLE;
 
-	rebalance_domains(this_rq, idle);
+	sd = per_cpu(sd_wc, this_cpu);
+	if (sd) {
+		struct cpumask *nonshielded_cpus = __get_cpu_var(load_balance_mask);
 
-	/*
-	 * If this cpu has a pending nohz_balance_kick, then do the
-	 * balancing on behalf of the other idle cpus whose ticks are
-	 * stopped.
-	 */
-	nohz_idle_balance(this_rq, idle);
+		/*
+		 * if we encounter shielded cpus here, don't do balance on them
+		 */
+		cpumask_copy(nonshielded_cpus, cpu_active_mask);
+
+		rcu_read_lock();
+		wc_nonshielded_mask(this_cpu, sd, nonshielded_cpus);
+		rcu_read_unlock();
+
+		/*
+		 * aggressively unload the shielded cpus to unshielded cpus
+		 */
+		wc_unload(nonshielded_cpus, sd);
+
+		if (cpumask_test_cpu(this_cpu, nonshielded_cpus)) {
+			struct cpumask *idle_cpus = __get_cpu_var(local_cpu_mask);
+			cpumask_and(idle_cpus, nonshielded_cpus, nohz.idle_cpus_mask);
+
+			rebalance_domains(this_rq, idle);
+
+			/*
+			 * If this cpu has a pending nohz_balance_kick, then do the
+			 * balancing on behalf of the other idle cpus whose ticks are
+			 * stopped.
+			 */
+			nohz_idle_balance(this_rq, idle, idle_cpus);
+		}
+	}
+	else {
+		rebalance_domains(this_rq, idle);
+
+		/*
+		 * If this cpu has a pending nohz_balance_kick, then do the
+		 * balancing on behalf of the other idle cpus whose ticks are
+		 * stopped.
+		 */
+		nohz_idle_balance(this_rq, idle, nohz.idle_cpus_mask);
+	}
 }
 
 /*
-- 
1.7.9.5
