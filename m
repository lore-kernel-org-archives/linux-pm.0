From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFC PATCH 01/14] sched/cpufreq_sched: use static key for cpu frequency selection
Date: Wed, 19 Aug 2015 19:47:11 +0100
Message-ID: <1440010044-3402-2-git-send-email-patrick.bellasi@arm.com>
References: <1440010044-3402-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440010044-3402-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri Lelli <juri.lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Juri Lelli <juri.lelli@arm.com>

Introduce a static key to only affect scheduler hot paths when sched
governor is enabled.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 kernel/sched/cpufreq_sched.c | 14 ++++++++++++++
 kernel/sched/fair.c          |  2 ++
 kernel/sched/sched.h         |  6 ++++++
 3 files changed, 22 insertions(+)

diff --git a/kernel/sched/cpufreq_sched.c b/kernel/sched/cpufreq_sched.c
index 5020f24..2968f3a 100644
--- a/kernel/sched/cpufreq_sched.c
+++ b/kernel/sched/cpufreq_sched.c
@@ -203,6 +203,18 @@ out:
 	return;
 }
 
+static inline void set_sched_energy_freq(void)
+{
+	if (!sched_energy_freq())
+		static_key_slow_inc(&__sched_energy_freq);
+}
+
+static inline void clear_sched_energy_freq(void)
+{
+	if (sched_energy_freq())
+		static_key_slow_dec(&__sched_energy_freq);
+}
+
 static int cpufreq_sched_start(struct cpufreq_policy *policy)
 {
 	struct gov_data *gd;
@@ -243,6 +255,7 @@ static int cpufreq_sched_start(struct cpufreq_policy *policy)
 
 	policy->governor_data = gd;
 	gd->policy = policy;
+	set_sched_energy_freq();
 	return 0;
 
 err:
@@ -254,6 +267,7 @@ static int cpufreq_sched_stop(struct cpufreq_policy *policy)
 {
 	struct gov_data *gd = policy->governor_data;
 
+	clear_sched_energy_freq();
 	if (cpufreq_driver_might_sleep()) {
 		kthread_stop(gd->task);
 	}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a04b074..b35d90b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4075,6 +4075,8 @@ static inline void hrtick_update(struct rq *rq)
 }
 #endif
 
+struct static_key __sched_energy_freq __read_mostly = STATIC_KEY_INIT_FALSE;
+
 /*
  * The enqueue_task method is called before nr_running is
  * increased. Here we update the fair scheduling stats and
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c5af84b..07ab036 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1415,6 +1415,12 @@ unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
 }
 #endif
 
+extern struct static_key __sched_energy_freq;
+static inline bool sched_energy_freq(void)
+{
+	return static_key_false(&__sched_energy_freq);
+}
+
 #ifdef CONFIG_CPU_FREQ_GOV_SCHED
 void cpufreq_sched_set_cap(int cpu, unsigned long util);
 #else
-- 
2.5.0
