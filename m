From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 11/16] cpuidle: powernv: Convert to hotplug state machine
Date: Thu, 18 Aug 2016 14:57:26 +0200
Message-ID: <20160818125731.27256-12-bigeasy@linutronix.de>
References: <20160818125731.27256-1-bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160818125731.27256-1-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, rt@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Install the callbacks via the state machine.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/cpuidle/cpuidle-powernv.c | 50 +++++++++++++++++----------------------
 include/linux/cpuhotplug.h        |  1 +
 2 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index f7ca891b5b59..081e688102a7 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -119,39 +119,29 @@ static struct cpuidle_state powernv_states[CPUIDLE_STATE_MAX] = {
 		.enter = snooze_loop },
 };
 
-static int powernv_cpuidle_add_cpu_notifier(struct notifier_block *n,
-			unsigned long action, void *hcpu)
+static int powernv_cpuidle_cpu_online(unsigned int cpu)
 {
-	int hotcpu = (unsigned long)hcpu;
-	struct cpuidle_device *dev =
-				per_cpu(cpuidle_devices, hotcpu);
+	struct cpuidle_device *dev = per_cpu(cpuidle_devices, cpu);
 
 	if (dev && cpuidle_get_driver()) {
-		switch (action) {
-		case CPU_ONLINE:
-		case CPU_ONLINE_FROZEN:
-			cpuidle_pause_and_lock();
-			cpuidle_enable_device(dev);
-			cpuidle_resume_and_unlock();
-			break;
-
-		case CPU_DEAD:
-		case CPU_DEAD_FROZEN:
-			cpuidle_pause_and_lock();
-			cpuidle_disable_device(dev);
-			cpuidle_resume_and_unlock();
-			break;
-
-		default:
-			return NOTIFY_DONE;
-		}
+		cpuidle_pause_and_lock();
+		cpuidle_enable_device(dev);
+		cpuidle_resume_and_unlock();
 	}
-	return NOTIFY_OK;
+	return 0;
 }
 
-static struct notifier_block setup_hotplug_notifier = {
-	.notifier_call = powernv_cpuidle_add_cpu_notifier,
-};
+static int powernv_cpuidle_cpu_dead(unsigned int cpu)
+{
+	struct cpuidle_device *dev = per_cpu(cpuidle_devices, cpu);
+
+	if (dev && cpuidle_get_driver()) {
+		cpuidle_pause_and_lock();
+		cpuidle_disable_device(dev);
+		cpuidle_resume_and_unlock();
+	}
+	return 0;
+}
 
 /*
  * powernv_cpuidle_driver_init()
@@ -355,7 +345,11 @@ static int __init powernv_processor_idle_init(void)
 		return retval;
 	}
 
-	register_cpu_notifier(&setup_hotplug_notifier);
+	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "CPUIDLE_POWERNV_ONLINE",
+				  powernv_cpuidle_cpu_online, NULL);
+	cpuhp_setup_state_nocalls(CPUHP_CPUIDLE_POWERNV_DEAD,
+				  "CPUIDLE_POWERNV_DEAD", NULL,
+				  powernv_cpuidle_cpu_dead);
 	printk(KERN_DEBUG "powernv_idle_driver registered\n");
 	return 0;
 }
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index baecc4faf028..6a08fd142b8c 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -20,6 +20,7 @@ enum cpuhp_state {
 	CPUHP_SOFTIRQ_DEAD,
 	CPUHP_NET_MVNETA_DEAD,
 	CPUHP_CPUIDLE_PSERIES_DEAD,
+	CPUHP_CPUIDLE_POWERNV_DEAD,
 	CPUHP_WORKQUEUE_PREP,
 	CPUHP_POWER_NUMA_PREPARE,
 	CPUHP_HRTIMERS_PREPARE,
-- 
2.9.3
