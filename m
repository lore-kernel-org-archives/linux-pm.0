From: Michael Turquette <mturquette@linaro.org>
Subject: [PATCH RFC v2 2/4] sched: sched feature for cpu frequency selection
Date: Mon, 11 May 2015 19:13:13 -0700
Message-ID: <1431396795-32439-3-git-send-email-mturquette@linaro.org>
References: <1431396795-32439-1-git-send-email-mturquette@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431396795-32439-1-git-send-email-mturquette@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, preeti@linux.vnet.ibm.com, Morten.Rasmussen@arm.com, riel@redhat.com, efault@gmx.de, nicolas.pitre@linaro.org, daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, amit.kucheria@linaro.org, juri.lelli@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, ashwin.chaugule@linaro.org, alex.shi@linaro.org, abelvesa@gmail.com, Michael Turquette <mturquette@linaro.org>
List-Id: linux-pm@vger.kernel.org

This patch introduces the SCHED_ENERGY_FREQ sched feature, which is
implemented using jump labels when SCHED_DEBUG is defined. It is
statically set to false when SCHED_DEBUG is not defined and thus
disabled by default.

Signed-off-by: Michael Turquette <mturquette@linaro.org>
---
Changes in v2:
	none

 kernel/sched/fair.c     | 5 +++++
 kernel/sched/features.h | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 46855d0..75aec8d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4207,6 +4207,11 @@ static inline void hrtick_update(struct rq *rq)
 }
 #endif
 
+static inline bool sched_energy_freq(void)
+{
+	return sched_feat(SCHED_ENERGY_FREQ);
+}
+
 /*
  * The enqueue_task method is called before nr_running is
  * increased. Here we update the fair scheduling stats and
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 91e33cd..77381cf 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -96,3 +96,9 @@ SCHED_FEAT(NUMA_FAVOUR_HIGHER, true)
  */
 SCHED_FEAT(NUMA_RESIST_LOWER, false)
 #endif
+
+/*
+ * Scheduler-driven CPU frequency selection aimed to save energy based on
+ * load tracking
+ */
+SCHED_FEAT(SCHED_ENERGY_FREQ, false)
-- 
1.9.1
