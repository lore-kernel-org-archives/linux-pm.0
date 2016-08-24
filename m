From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 12/16 v2] cpuidle: coupled: Convert to hotplug state machine
Date: Wed, 24 Aug 2016 11:14:44 +0200
Message-ID: <20160824091444.brdr5zpbxjvh6n3f@linutronix.de>
References: <20160818125731.27256-1-bigeasy@linutronix.de>
 <20160818125731.27256-13-bigeasy@linutronix.de>
 <57BC5CB4.409@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57BC5CB4.409@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, rt@linutronix.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Install the callbacks via the state machine.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1…v2: - refactor the code to drop the out label.
       - make error path in cpuidle_coupled_init() simpler

 drivers/cpuidle/coupled.c  | 75 +++++++++++++++++++---------------------------
 include/linux/cpuhotplug.h |  1 +
 2 files changed, 32 insertions(+), 44 deletions(-)

diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
index d5657d50ac40..5ba1a8913421 100644
--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -749,65 +749,52 @@ static void cpuidle_coupled_allow_idle(struct cpuidle_coupled *coupled)
 	put_cpu();
 }
 
-/**
- * cpuidle_coupled_cpu_notify - notifier called during hotplug transitions
- * @nb: notifier block
- * @action: hotplug transition
- * @hcpu: target cpu number
- *
- * Called when a cpu is brought on or offline using hotplug.  Updates the
- * coupled cpu set appropriately
- */
-static int cpuidle_coupled_cpu_notify(struct notifier_block *nb,
-		unsigned long action, void *hcpu)
+static int coupled_cpu_online(unsigned int cpu)
 {
-	int cpu = (unsigned long)hcpu;
 	struct cpuidle_device *dev;
 
-	switch (action & ~CPU_TASKS_FROZEN) {
-	case CPU_UP_PREPARE:
-	case CPU_DOWN_PREPARE:
-	case CPU_ONLINE:
-	case CPU_DEAD:
-	case CPU_UP_CANCELED:
-	case CPU_DOWN_FAILED:
-		break;
-	default:
-		return NOTIFY_OK;
-	}
-
 	mutex_lock(&cpuidle_lock);
 
 	dev = per_cpu(cpuidle_devices, cpu);
-	if (!dev || !dev->coupled)
-		goto out;
-
-	switch (action & ~CPU_TASKS_FROZEN) {
-	case CPU_UP_PREPARE:
-	case CPU_DOWN_PREPARE:
-		cpuidle_coupled_prevent_idle(dev->coupled);
-		break;
-	case CPU_ONLINE:
-	case CPU_DEAD:
+	if (dev && dev->coupled) {
 		cpuidle_coupled_update_online_cpus(dev->coupled);
-		/* Fall through */
-	case CPU_UP_CANCELED:
-	case CPU_DOWN_FAILED:
 		cpuidle_coupled_allow_idle(dev->coupled);
-		break;
 	}
 
-out:
 	mutex_unlock(&cpuidle_lock);
-	return NOTIFY_OK;
+	return 0;
 }
 
-static struct notifier_block cpuidle_coupled_cpu_notifier = {
-	.notifier_call = cpuidle_coupled_cpu_notify,
-};
+static int coupled_cpu_up_prepare(unsigned int cpu)
+{
+	struct cpuidle_device *dev;
+
+	mutex_lock(&cpuidle_lock);
+
+	dev = per_cpu(cpuidle_devices, cpu);
+	if (dev && dev->coupled)
+		cpuidle_coupled_prevent_idle(dev->coupled);
+
+	mutex_unlock(&cpuidle_lock);
+	return 0;
+}
 
 static int __init cpuidle_coupled_init(void)
 {
-	return register_cpu_notifier(&cpuidle_coupled_cpu_notifier);
+	int ret;
+
+	ret = cpuhp_setup_state_nocalls(CPUHP_CPUIDLE_COUPLED_PREPARE,
+					"CPUIDLE_COUPLED_PREPARE",
+					coupled_cpu_up_prepare,
+					coupled_cpu_online);
+	if (ret)
+		return ret;
+	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					"CPUIDLE_COUPLED_ONLINE",
+					coupled_cpu_online,
+					coupled_cpu_up_prepare);
+	if (ret < 0)
+		cpuhp_remove_state_nocalls(CPUHP_CPUIDLE_COUPLED_PREPARE);
+	return ret;
 }
 core_initcall(cpuidle_coupled_init);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 14b58a9d1450..965acec06d4e 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -30,6 +30,7 @@ enum cpuhp_state {
 	CPUHP_SLAB_PREPARE,
 	CPUHP_RCUTREE_PREP,
 	CPUHP_MD_RAID5_PREPARE,
+	CPUHP_CPUIDLE_COUPLED_PREPARE,
 	CPUHP_NOTIFY_PREPARE,
 	CPUHP_TIMERS_DEAD,
 	CPUHP_BRINGUP_CPU,
-- 
2.9.3
