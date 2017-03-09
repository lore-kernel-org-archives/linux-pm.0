From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC 1/9] sched: cpufreq: add cpu to update_util_data
Date: Thu,  9 Mar 2017 17:15:11 +0530
Message-ID: <529d5f2d865f5982f7e0d4a7a44176e81f50ffc5.1489058244.git.viresh.kumar@linaro.org>
References: <cover.1489058244.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1489058244.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1489058244.git.viresh.kumar@linaro.org>
References: <cover.1489058244.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Steve Muckle <smuckle.linux@gmail.com>

Upcoming support for scheduler cpufreq callbacks on remote wakeups
will require the client to know what the target CPU is that the
callback is being invoked for. Add this information into the callback
data structure.

Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/sched/cpufreq.h | 1 +
 kernel/sched/cpufreq.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index d2be2ccbb372..f798f63d93e8 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -16,6 +16,7 @@
 #ifdef CONFIG_CPU_FREQ
 struct update_util_data {
        void (*func)(struct update_util_data *data, u64 time, unsigned int flags);
+	int cpu;
 };
 
 void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
index dbc51442ecbc..ee4c596b71b4 100644
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq.c
@@ -42,6 +42,7 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
 		return;
 
 	data->func = func;
+	data->cpu = cpu;
 	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
 }
 EXPORT_SYMBOL_GPL(cpufreq_add_update_util_hook);
-- 
2.7.1.410.g6faf27b
