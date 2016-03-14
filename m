From: Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH 3/8] sched/cpufreq: new cfs capacity margin helpers
Date: Sun, 13 Mar 2016 22:22:07 -0700
Message-ID: <1457932932-28444-4-git-send-email-mturquette+renesas@baylibre.com>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Introduce helper functions that allow cpufreq governors to change the
value of the capacity margin applied to the cfs_rq->avg.util_avg signal.
This allows for run-time tuning of the margin.

A follow-up patch will update the schedutil governor to use these
helpers.

Signed-off-by: Michael Turquette <mturquette+renesas@baylibre.com>
---
 include/linux/sched.h  |  3 +++
 kernel/sched/cpufreq.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1fa9b52..f18a99b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2372,6 +2372,9 @@ void cpufreq_set_freq_update_hook(int cpu, struct freq_update_hook *hook,
 			void (*func)(struct freq_update_hook *hook, u64 time,
 				     unsigned long util, unsigned long max));
 void cpufreq_clear_freq_update_hook(int cpu);
+unsigned long cpufreq_get_cfs_capacity_margin(void);
+void cpufreq_set_cfs_capacity_margin(unsigned long margin);
+void cpufreq_reset_cfs_capacity_margin(void);
 #endif
 
 #ifdef CONFIG_SCHED_AUTOGROUP
diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
index bd012c2..a126b58 100644
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq.c
@@ -61,6 +61,59 @@ void cpufreq_clear_freq_update_hook(int cpu)
 EXPORT_SYMBOL_GPL(cpufreq_clear_freq_update_hook);
 
 /**
+ * cpufreq_get_cfs_capacity_margin - Get global cfs enqueue capacity margin
+ *
+ * margin is a percentage of capacity that is applied to the current
+ * utilization when selecting a new capacity state or cpu frequency. The value
+ * should be normalized to the range of [0..SCHED_CAPACITY_SCALE], where
+ * SCHED_CAPACITY_SCALE is 100% of the normalized capacity, or equivalent to
+ * multiplying the utilization by one.
+ *
+ * This function returns the current global cfs enqueue capacity margin
+ */
+unsigned long cpufreq_get_cfs_capacity_margin(void)
+{
+	return cfs_capacity_margin;
+}
+EXPORT_SYMBOL_GPL(cpufreq_get_cfs_capacity_margin);
+
+/**
+ * cpufreq_set_cfs_capacity_margin - Set global cfs enqueue capacity margin
+ * @margin: new capacity margin
+ *
+ * margin is a percentage of capacity that is applied to the current
+ * utilization when selecting a new capacity state or cpu frequency. The value
+ * should be normalized to the range of [0..SCHED_CAPACITY_SCALE], where
+ * SCHED_CAPACITY_SCALE is 100% of the normalized capacity, or equivalent to
+ * multiplying the utilization by one.
+ *
+ * For instance, to add a 25% margin to a utilization, margin should be 1280,
+ * which is 1.25x 1024, the default for SCHED_CAPACITY_SCALE.
+ */
+void cpufreq_set_cfs_capacity_margin(unsigned long margin)
+{
+	cfs_capacity_margin = margin;
+}
+EXPORT_SYMBOL_GPL(cpufreq_set_cfs_capacity_margin);
+
+/**
+ * cpufreq_reset_cfs_capacity_margin - Reset global cfs enqueue cap margin
+ *
+ * margin is a percentage of capacity that is applied to the current
+ * utilization when selecting a new capacity state or cpu frequency. The value
+ * should be normalized to the range of [0..SCHED_CAPACITY_SCALE], where
+ * SCHED_CAPACITY_SCALE is 100% of the normalized capacity, or equivalent to
+ * multiplying the utilization by one.
+ *
+ * This function resets the global margin to its default value.
+ */
+void cpufreq_reset_cfs_capacity_margin(void)
+{
+	cfs_capacity_margin = CAPACITY_MARGIN_DEFAULT;
+}
+EXPORT_SYMBOL_GPL(cpufreq_reset_cfs_capacity_margin);
+
+/**
  * cpufreq_update_util - Take a note about CPU utilization changes.
  * @time: Current time.
  * @util: CPU utilization.
-- 
2.1.4
