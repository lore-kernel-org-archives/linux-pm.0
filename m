From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v6 06/14] sched/topology: Lowest CPU asymmetry sched_domain level pointer
Date: Mon, 20 Aug 2018 10:44:12 +0100
Message-ID: <20180820094420.26590-7-quentin.perret@arm.com>
References: <20180820094420.26590-1-quentin.perret@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820094420.26590-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org, quentin.perret@arm.com
List-Id: linux-pm@vger.kernel.org

Add another member to the family of per-cpu sched_domain shortcut
pointers. This one, sd_asym_cpucapacity, points to the lowest level
at which the SD_ASYM_CPUCAPACITY flag is set. While at it, rename the
sd_asym shortcut to sd_asym_packing to avoid confusions.

Generally speaking, the largest opportunity to save energy via
scheduling comes from a smarter exploitation of heterogeneous platforms
(i.e. big.LITTLE). Consequently, the sd_asym_cpucapacity shortcut will
be used at first as the lowest domain where Energy-Aware Scheduling
(EAS) should be applied. For example, it is possible to apply EAS within
a socket on a multi-socket system, as long as each socket has an
asymmetric topology. Cross-sockets wake-up balancing will only happen
when the system is over-utilized, or this_cpu and prev_cpu are in
different sockets.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 kernel/sched/fair.c     | 2 +-
 kernel/sched/sched.h    | 3 ++-
 kernel/sched/topology.c | 8 ++++++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c60616796483..c28c7adcc7b3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9167,7 +9167,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		}
 	}
 
-	sd = rcu_dereference(per_cpu(sd_asym, cpu));
+	sd = rcu_dereference(per_cpu(sd_asym_packing, cpu));
 	if (sd) {
 		for_each_cpu(i, sched_domain_span(sd)) {
 			if (i == cpu ||
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 97d79429e755..4b884e467545 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1203,7 +1203,8 @@ DECLARE_PER_CPU(int, sd_llc_size);
 DECLARE_PER_CPU(int, sd_llc_id);
 DECLARE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
 DECLARE_PER_CPU(struct sched_domain *, sd_numa);
-DECLARE_PER_CPU(struct sched_domain *, sd_asym);
+DECLARE_PER_CPU(struct sched_domain *, sd_asym_packing);
+DECLARE_PER_CPU(struct sched_domain *, sd_asym_cpucapacity);
 extern struct static_key_false sched_asym_cpucapacity;
 
 struct sched_group_capacity {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 545e2c7b6e66..4c6a36a8d7b8 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -508,7 +508,8 @@ DEFINE_PER_CPU(int, sd_llc_size);
 DEFINE_PER_CPU(int, sd_llc_id);
 DEFINE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
 DEFINE_PER_CPU(struct sched_domain *, sd_numa);
-DEFINE_PER_CPU(struct sched_domain *, sd_asym);
+DEFINE_PER_CPU(struct sched_domain *, sd_asym_packing);
+DEFINE_PER_CPU(struct sched_domain *, sd_asym_cpucapacity);
 DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
 
 static void update_top_cache_domain(int cpu)
@@ -534,7 +535,10 @@ static void update_top_cache_domain(int cpu)
 	rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
 
 	sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
-	rcu_assign_pointer(per_cpu(sd_asym, cpu), sd);
+	rcu_assign_pointer(per_cpu(sd_asym_packing, cpu), sd);
+
+	sd = lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY);
+	rcu_assign_pointer(per_cpu(sd_asym_cpucapacity, cpu), sd);
 }
 
 /*
-- 
2.17.1
