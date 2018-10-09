From: Thara Gopinath <thara.gopinath@linaro.org>
Subject: [RFC PATCH 2/7] sched/pelt.c: Add support to track thermal pressure
Date: Tue,  9 Oct 2018 12:24:57 -0400
Message-ID: <1539102302-9057-3-git-send-email-thara.gopinath@linaro.org>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, amit.kachhap@gmail.com, viresh.kumar@linaro.org, javi.merino@kernel.org, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, quentin.perret@arm.com, ionela.voinescu@arm.com, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

Extrapolating on the exisitng framework to track rt/dl utilization using
pelt signals, add a similar mechanism to track thermal pressue. The
difference here from rt/dl utilization tracking is that, instead of
tracking time spent by a cpu running a rt/dl task through util_avg,
the average thermal pressure is tracked through load_avg.
In order to track average thermal pressure, a new sched_avg variable
avg_thermal is introduced. Function update_thermal_avg can be called
to do the periodic bookeeping (accumulate, decay and average)
of the thermal pressure.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 kernel/sched/pelt.c  | 14 ++++++++++++++
 kernel/sched/pelt.h  |  7 +++++++
 kernel/sched/sched.h |  1 +
 3 files changed, 22 insertions(+)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 05b8798..7034ede 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -362,6 +362,20 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 	return 0;
 }
 
+int update_thermal_avg(u64 now, struct rq *rq, u64 capacity)
+{
+	if (___update_load_sum(now, rq->cpu, &rq->avg_thermal,
+				capacity,
+				capacity,
+				capacity, 0)) {
+
+		___update_load_avg(&rq->avg_thermal, 1, 1);
+		return 1;
+	}
+
+	return 0;
+}
+
 #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
 /*
  * irq:
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index d2894db..cc5a3ad 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -5,6 +5,7 @@ int __update_load_avg_se(u64 now, int cpu, struct cfs_rq *cfs_rq, struct sched_e
 int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq);
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
+int update_thermal_avg(u64 now, struct rq *rq, u64 capacity);
 
 #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
 int update_irq_load_avg(struct rq *rq, u64 running);
@@ -67,6 +68,12 @@ update_irq_load_avg(struct rq *rq, u64 running)
 {
 	return 0;
 }
+
+static inline int
+update_thermal_avg(u64 now, struct rq *rq, u64 capacity)
+{
+	return 0;
+}
 #endif
 
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4a2e8ca..30b40a5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -859,6 +859,7 @@ struct rq {
 #define HAVE_SCHED_AVG_IRQ
 	struct sched_avg	avg_irq;
 #endif
+	struct sched_avg	avg_thermal;
 	u64			idle_stamp;
 	u64			avg_idle;
 
-- 
2.1.4
