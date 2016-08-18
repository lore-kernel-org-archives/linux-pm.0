From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 10/16] cpuidle: pseries: Convert to hotplug state machine
Date: Thu, 18 Aug 2016 14:57:25 +0200
Message-ID: <20160818125731.27256-11-bigeasy@linutronix.de>
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
 drivers/cpuidle/cpuidle-pseries.c | 50 +++++++++++++++++----------------------
 include/linux/cpuhotplug.h        |  1 +
 2 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index 07135e009d8b..10c4c51cd840 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -171,39 +171,29 @@ static struct cpuidle_state shared_states[] = {
 		.enter = &shared_cede_loop },
 };
 
-static int pseries_cpuidle_add_cpu_notifier(struct notifier_block *n,
-			unsigned long action, void *hcpu)
+static int pseries_cpuidle_cpu_online(unsigned int cpu)
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
-	.notifier_call = pseries_cpuidle_add_cpu_notifier,
-};
+static int pseries_cpuidle_cpu_dead(unsigned int cpu)
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
  * pseries_cpuidle_driver_init()
@@ -273,7 +263,11 @@ static int __init pseries_processor_idle_init(void)
 		return retval;
 	}
 
-	register_cpu_notifier(&setup_hotplug_notifier);
+	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "CPUIDLE_PSERIES_ONLINE",
+				  pseries_cpuidle_cpu_online, NULL);
+	cpuhp_setup_state_nocalls(CPUHP_CPUIDLE_PSERIES_DEAD,
+				  "CPUIDLE_PSERIES_DEAD", NULL,
+				  pseries_cpuidle_cpu_dead);
 	printk(KERN_DEBUG "pseries_idle_driver registered\n");
 	return 0;
 }
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 5811954809af..baecc4faf028 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -19,6 +19,7 @@ enum cpuhp_state {
 	CPUHP_MM_WRITEBACK_DEAD,
 	CPUHP_SOFTIRQ_DEAD,
 	CPUHP_NET_MVNETA_DEAD,
+	CPUHP_CPUIDLE_PSERIES_DEAD,
 	CPUHP_WORKQUEUE_PREP,
 	CPUHP_POWER_NUMA_PREPARE,
 	CPUHP_HRTIMERS_PREPARE,
-- 
2.9.3
