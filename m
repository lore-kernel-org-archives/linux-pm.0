From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv5 PATCH 45/46] sched/cpufreq_sched: modify pcpu_capacity handling
Date: Tue,  7 Jul 2015 19:24:28 +0100
Message-ID: <1436293469-25707-46-git-send-email-morten.rasmussen@arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri Lelli <juri.lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Juri Lelli <juri.lelli@arm.com>

Use the cpu argument of cpufreq_sched_set_cap() to handle per_cpu writes,
as the thing can be called remotely (e.g., from load balacing code).

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 kernel/sched/cpufreq_sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_sched.c b/kernel/sched/cpufreq_sched.c
index 06ff183..b81ac779 100644
--- a/kernel/sched/cpufreq_sched.c
+++ b/kernel/sched/cpufreq_sched.c
@@ -151,7 +151,7 @@ void cpufreq_sched_set_cap(int cpu, unsigned long capacity)
 	unsigned long capacity_max = 0;
 
 	/* update per-cpu capacity request */
-	__this_cpu_write(pcpu_capacity, capacity);
+	per_cpu(pcpu_capacity, cpu) = capacity;
 
 	policy = cpufreq_cpu_get(cpu);
 	if (IS_ERR_OR_NULL(policy)) {
-- 
1.9.1
