From: Thara Gopinath <thara.gopinath@linaro.org>
Subject: [RFC PATCH 1/7] sched/pelt.c: Add option to make load and util calculations frequency invariant
Date: Tue,  9 Oct 2018 12:24:56 -0400
Message-ID: <1539102302-9057-2-git-send-email-thara.gopinath@linaro.org>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, amit.kachhap@gmail.com, viresh.kumar@linaro.org, javi.merino@kernel.org, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, quentin.perret@arm.com, ionela.voinescu@arm.com, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

Add an additional parametr in accumulate_sum to allow optional
frequency adjustment of load and utilization. When considering
rt/dl load/util, it is correct to scale it to the current cpu
frequency. On the other hand, thermal pressure(max capped frequency)
is frequency invariant.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 kernel/sched/pelt.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 35475c0..05b8798 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -107,7 +107,8 @@ static u32 __accumulate_pelt_segments(u64 periods, u32 d1, u32 d3)
  */
 static __always_inline u32
 accumulate_sum(u64 delta, int cpu, struct sched_avg *sa,
-	       unsigned long load, unsigned long runnable, int running)
+	       unsigned long load, unsigned long runnable, int running,
+		int freq_adjusted)
 {
 	unsigned long scale_freq, scale_cpu;
 	u32 contrib = (u32)delta; /* p == 0 -> delta < 1024 */
@@ -137,7 +138,8 @@ accumulate_sum(u64 delta, int cpu, struct sched_avg *sa,
 	}
 	sa->period_contrib = delta;
 
-	contrib = cap_scale(contrib, scale_freq);
+	if (freq_adjusted)
+		contrib = cap_scale(contrib, scale_freq);
 	if (load)
 		sa->load_sum += load * contrib;
 	if (runnable)
@@ -178,7 +180,8 @@ accumulate_sum(u64 delta, int cpu, struct sched_avg *sa,
  */
 static __always_inline int
 ___update_load_sum(u64 now, int cpu, struct sched_avg *sa,
-		  unsigned long load, unsigned long runnable, int running)
+		  unsigned long load, unsigned long runnable, int running,
+			int freq_adjusted)
 {
 	u64 delta;
 
@@ -221,7 +224,8 @@ ___update_load_sum(u64 now, int cpu, struct sched_avg *sa,
 	 * Step 1: accumulate *_sum since last_update_time. If we haven't
 	 * crossed period boundaries, finish.
 	 */
-	if (!accumulate_sum(delta, cpu, sa, load, runnable, running))
+	if (!accumulate_sum(delta, cpu, sa, load, runnable, running,
+						freq_adjusted))
 		return 0;
 
 	return 1;
@@ -272,7 +276,7 @@ int __update_load_avg_blocked_se(u64 now, int cpu, struct sched_entity *se)
 	if (entity_is_task(se))
 		se->runnable_weight = se->load.weight;
 
-	if (___update_load_sum(now, cpu, &se->avg, 0, 0, 0)) {
+	if (___update_load_sum(now, cpu, &se->avg, 0, 0, 0, 1)) {
 		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
 		return 1;
 	}
@@ -286,7 +290,7 @@ int __update_load_avg_se(u64 now, int cpu, struct cfs_rq *cfs_rq, struct sched_e
 		se->runnable_weight = se->load.weight;
 
 	if (___update_load_sum(now, cpu, &se->avg, !!se->on_rq, !!se->on_rq,
-				cfs_rq->curr == se)) {
+				cfs_rq->curr == se, 1)) {
 
 		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
 		cfs_se_util_change(&se->avg);
@@ -301,7 +305,7 @@ int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq)
 	if (___update_load_sum(now, cpu, &cfs_rq->avg,
 				scale_load_down(cfs_rq->load.weight),
 				scale_load_down(cfs_rq->runnable_weight),
-				cfs_rq->curr != NULL)) {
+				cfs_rq->curr != NULL, 1)) {
 
 		___update_load_avg(&cfs_rq->avg, 1, 1);
 		return 1;
@@ -326,7 +330,7 @@ int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
 	if (___update_load_sum(now, rq->cpu, &rq->avg_rt,
 				running,
 				running,
-				running)) {
+				running, 1)) {
 
 		___update_load_avg(&rq->avg_rt, 1, 1);
 		return 1;
@@ -349,7 +353,7 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 	if (___update_load_sum(now, rq->cpu, &rq->avg_dl,
 				running,
 				running,
-				running)) {
+				running, 1)) {
 
 		___update_load_avg(&rq->avg_dl, 1, 1);
 		return 1;
@@ -385,11 +389,11 @@ int update_irq_load_avg(struct rq *rq, u64 running)
 	ret = ___update_load_sum(rq->clock - running, rq->cpu, &rq->avg_irq,
 				0,
 				0,
-				0);
+				0, 1);
 	ret += ___update_load_sum(rq->clock, rq->cpu, &rq->avg_irq,
 				1,
 				1,
-				1);
+				1, 1);
 
 	if (ret)
 		___update_load_avg(&rq->avg_irq, 1, 1);
-- 
2.1.4
