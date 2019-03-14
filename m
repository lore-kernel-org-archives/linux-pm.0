From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 7/7] cpufreq: Call transition notifiers only once for each policy
Date: Thu, 14 Mar 2019 12:12:53 +0530
Message-ID: <f98b170e408ec425c8d23067514cf063c8025c6e.1552545525.git.viresh.kumar@linaro.org>
References: <cover.1552545525.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1552545525.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Now that all the transition notifier callbacks are updated to not rely
on freqs->cpu and perform actions for all CPUs in the freqs->cpus field,
it is time to get rid of freqs->cpu field and call the notifiers only
once for each cpufreq policy.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 18 +++++++++---------
 include/linux/cpufreq.h   |  1 -
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b1b012169f00..ecea73598956 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -306,6 +306,8 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
 				      struct cpufreq_freqs *freqs,
 				      unsigned int state)
 {
+	int cpu;
+
 	BUG_ON(irqs_disabled());
 
 	if (cpufreq_disabled())
@@ -331,10 +333,8 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
 			}
 		}
 
-		for_each_cpu(freqs->cpu, policy->cpus) {
-			srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
-						 CPUFREQ_PRECHANGE, freqs);
-		}
+		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
+					 CPUFREQ_PRECHANGE, freqs);
 
 		adjust_jiffies(CPUFREQ_PRECHANGE, freqs);
 		break;
@@ -344,11 +344,11 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
 		pr_debug("FREQ: %u - CPUs: %*pbl\n", freqs->new,
 			 cpumask_pr_args(policy->cpus));
 
-		for_each_cpu(freqs->cpu, policy->cpus) {
-			trace_cpu_frequency(freqs->new, freqs->cpu);
-			srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
-						 CPUFREQ_POSTCHANGE, freqs);
-		}
+		for_each_cpu(cpu, policy->cpus)
+			trace_cpu_frequency(freqs->new, cpu);
+
+		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
+					 CPUFREQ_POSTCHANGE, freqs);
 
 		cpufreq_stats_record_transition(policy, freqs->new);
 		policy->cur = freqs->new;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index dd318363dfc2..1af7ecad30c1 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -44,7 +44,6 @@ enum cpufreq_table_sorting {
 
 struct cpufreq_freqs {
 	struct cpumask *cpus;
-	unsigned int cpu;	/* cpu nr */
 	unsigned int old;
 	unsigned int new;
 	u8 flags;		/* flags of cpufreq_driver, see below. */
-- 
2.21.0.rc0.269.g1a574e7a288b
