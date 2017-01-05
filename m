From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/2] cpufreq: Remove CPUFREQ_START notifier event
Date: Thu,  5 Jan 2017 11:34:31 +0530
Message-ID: <2188a4e88d725062c400bcb50cc41477346e36c1.1483596168.git.viresh.kumar@linaro.org>
References: <c62a8f8b1bf699b0c7834c87096d4f144c02bf1d.1483596168.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c62a8f8b1bf699b0c7834c87096d4f144c02bf1d.1483596168.git.viresh.kumar@linaro.org>
In-Reply-To: <c62a8f8b1bf699b0c7834c87096d4f144c02bf1d.1483596168.git.viresh.kumar@linaro.org>
References: <c62a8f8b1bf699b0c7834c87096d4f144c02bf1d.1483596168.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

Its not used anymore, remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c             | 3 ---
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c | 3 ---
 include/linux/cpufreq.h               | 1 -
 3 files changed, 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 53268bebdf1e..408479540566 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1246,9 +1246,6 @@ static int cpufreq_online(unsigned int cpu)
 		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 	}
 
-	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
-				     CPUFREQ_START, policy);
-
 	ret = cpufreq_init_policy(policy);
 	if (ret) {
 		pr_err("%s: Failed to initialize policy for cpu: %d (%d)\n",
diff --git a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
index dc112481a408..eeaa92251512 100644
--- a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
+++ b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
@@ -100,9 +100,6 @@ static int pmi_notifier(struct notifier_block *nb,
 	/* Should this really be called for CPUFREQ_ADJUST and CPUFREQ_NOTIFY
 	 * policy events?)
 	 */
-	if (event == CPUFREQ_START)
-		return 0;
-
 	node = cbe_cpu_to_node(policy->cpu);
 
 	pr_debug("got notified, event=%lu, node=%u\n", event, node);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 0183986b3ba6..61009c0b82c8 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -415,7 +415,6 @@ static inline void cpufreq_resume(void) {}
 /* Policy Notifiers  */
 #define CPUFREQ_ADJUST			(0)
 #define CPUFREQ_NOTIFY			(1)
-#define CPUFREQ_START			(2)
 
 #ifdef CONFIG_CPU_FREQ
 int cpufreq_register_notifier(struct notifier_block *nb, unsigned int list);
-- 
2.7.1.410.g6faf27b
