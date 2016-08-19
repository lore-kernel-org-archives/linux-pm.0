From: Steve Muckle <steve.muckle@linaro.org>
Subject: [PATCH] sched: cpufreq: ignore SMT when determining max cpu capacity
Date: Fri, 19 Aug 2016 13:43:47 -0700
Message-ID: <1471639427-16006-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Steve Muckle <smuckle@linaro.org>
List-Id: linux-pm@vger.kernel.org

PELT does not consider SMT when scaling its utilization values via
arch_scale_cpu_capacity(). The value in rq->cpu_capacity_orig does
take SMT into consideration though and therefore may be smaller than
the utilization reported by PELT.

On an Intel i7-3630QM for example rq->cpu_capacity_orig is 589 but
util_avg scales up to 1024. This means that a 50% utilized CPU will show
up in schedutil as ~86% busy.

Fix this by using the same CPU scaling value in schedutil as that which
is used by PELT.

Signed-off-by: Steve Muckle <smuckle@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 60d985f4dc47..cb8a77b1ef1b 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -147,7 +147,9 @@ static unsigned int get_next_freq(struct sugov_cpu *sg_cpu, unsigned long util,
 static void sugov_get_util(unsigned long *util, unsigned long *max)
 {
 	struct rq *rq = this_rq();
-	unsigned long cfs_max = rq->cpu_capacity_orig;
+	unsigned long cfs_max;
+
+	cfs_max = arch_scale_cpu_capacity(NULL, smp_processor_id());
 
 	*util = min(rq->cfs.avg.util_avg, cfs_max);
 	*max = cfs_max;
-- 
2.7.3
