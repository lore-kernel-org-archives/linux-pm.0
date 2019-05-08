From: douglas.raillard@arm.com
Subject: [RFC PATCH 5/7] sched/cpufreq: sugov_cpu_is_busy for shared policy
Date: Wed,  8 May 2019 18:42:59 +0100
Message-ID: <20190508174301.4828-6-douglas.raillard@arm.com>
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

Allow using sugov_cpu_is_busy() from sugov_update_shared(). This means
that the heuristic needs to return stable results across multiple calls
for a given CPU, even if there has been no utilization change since last
call.

sugov_cpu_is_busy() currently both checks business status and updates
the counters, so let's decouple the two actions.

Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index a52c66559321..a12b7e5bc028 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -178,12 +178,17 @@ static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
 {
 	unsigned long idle_calls = tick_nohz_get_idle_calls_cpu(sg_cpu->cpu);
 	bool ret = idle_calls == sg_cpu->saved_idle_calls;
+	return ret;
+}
 
+static void sugov_cpu_is_busy_update(struct sugov_cpu *sg_cpu)
+{
+	unsigned long idle_calls = tick_nohz_get_idle_calls_cpu(sg_cpu->cpu);
 	sg_cpu->saved_idle_calls = idle_calls;
-	return ret;
 }
 #else
 static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
+static void sugov_cpu_is_busy_update(struct sugov_cpu *sg_cpu) {}
 #endif /* CONFIG_NO_HZ_COMMON */
 
 /**
@@ -503,6 +508,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 		return;
 
 	busy = sugov_cpu_is_busy(sg_cpu);
+	sugov_cpu_is_busy_update(sg_cpu);
 
 	util = sugov_get_util(sg_cpu);
 	max = sg_cpu->max;
-- 
2.21.0
