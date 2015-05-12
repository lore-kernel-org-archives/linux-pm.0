From: Michael Turquette <mturquette@linaro.org>
Subject: [PATCH RFC v2 3/4] sched: expose capacity_of in sched.h
Date: Mon, 11 May 2015 19:13:14 -0700
Message-ID: <1431396795-32439-4-git-send-email-mturquette@linaro.org>
References: <1431396795-32439-1-git-send-email-mturquette@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431396795-32439-1-git-send-email-mturquette@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, preeti@linux.vnet.ibm.com, Morten.Rasmussen@arm.com, riel@redhat.com, efault@gmx.de, nicolas.pitre@linaro.org, daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, amit.kucheria@linaro.org, juri.lelli@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, ashwin.chaugule@linaro.org, alex.shi@linaro.org, abelvesa@gmail.com, Michael Turquette <mturquette@linaro.org>
List-Id: linux-pm@vger.kernel.org

capacity_of is of use to a cpu frequency scaling policy based on cfs
load tracking and cpu capacity utilization metrics. Expose this call in
sched.h so it can be used in such a policy.

Signed-off-by: Michael Turquette <mturquette@linaro.org>
---
Changes in v2:
	Do not expose get_cpu_usage or capacity_orig_of in sched.h
	Expose capacity_of instead

 kernel/sched/fair.c  | 5 -----
 kernel/sched/sched.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 75aec8d..d27ded9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4361,11 +4361,6 @@ static unsigned long target_load(int cpu, int type)
 	return max(rq->cpu_load[type-1], total);
 }
 
-static unsigned long capacity_of(int cpu)
-{
-	return cpu_rq(cpu)->cpu_capacity;
-}
-
 static unsigned long capacity_orig_of(int cpu)
 {
 	return cpu_rq(cpu)->cpu_capacity_orig;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e0e1299..4925bc4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1396,6 +1396,11 @@ unsigned long arch_scale_freq_capacity(struct sched_domain *sd, int cpu)
 }
 #endif
 
+static inline unsigned long capacity_of(int cpu)
+{
+	return cpu_rq(cpu)->cpu_capacity;
+}
+
 static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta)
 {
 	rq->rt_avg += rt_delta * arch_scale_freq_capacity(NULL, cpu_of(rq));
-- 
1.9.1
