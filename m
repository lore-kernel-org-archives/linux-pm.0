From: douglas.raillard@arm.com
Subject: [RFC PATCH 4/7] sched/cpufreq: Move up sugov_cpu_is_busy()
Date: Wed,  8 May 2019 18:42:58 +0100
Message-ID: <20190508174301.4828-5-douglas.raillard@arm.com>
References: <20190508174301.4828-1-douglas.raillard@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190508174301.4828-1-douglas.raillard@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, quentin.perret@arm.com, douglas.raillard@arm.com, patrick.bellasi@arm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

From: Douglas RAILLARD <douglas.raillard@arm.com>

Move sugov_cpu_is_busy() static function of cpufreq_schedutil.c higher
in the file so it can be used by other functions.

Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index f4173a7c0f01..a52c66559321 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -173,6 +173,19 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
 	}
 }
 
+#ifdef CONFIG_NO_HZ_COMMON
+static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
+{
+	unsigned long idle_calls = tick_nohz_get_idle_calls_cpu(sg_cpu->cpu);
+	bool ret = idle_calls == sg_cpu->saved_idle_calls;
+
+	sg_cpu->saved_idle_calls = idle_calls;
+	return ret;
+}
+#else
+static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
+#endif /* CONFIG_NO_HZ_COMMON */
+
 /**
  * get_next_freq - Compute a new frequency for a given cpufreq policy.
  * @sg_policy: schedutil policy object to compute the new frequency for.
@@ -462,19 +475,6 @@ static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
 	return max(boost, util);
 }
 
-#ifdef CONFIG_NO_HZ_COMMON
-static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
-{
-	unsigned long idle_calls = tick_nohz_get_idle_calls_cpu(sg_cpu->cpu);
-	bool ret = idle_calls == sg_cpu->saved_idle_calls;
-
-	sg_cpu->saved_idle_calls = idle_calls;
-	return ret;
-}
-#else
-static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
-#endif /* CONFIG_NO_HZ_COMMON */
-
 /*
  * Make sugov_should_update_freq() ignore the rate limit when DL
  * has increased the utilization.
-- 
2.21.0
