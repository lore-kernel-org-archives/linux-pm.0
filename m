From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 10/16 v2] cpuidle: pseries: Convert to hotplug state machine
Date: Wed, 24 Aug 2016 11:09:24 +0200
Message-ID: <20160824090924.qroq3qm4l6f2czct@linutronix.de>
References: <20160818125731.27256-1-bigeasy@linutronix.de>
 <20160818125731.27256-11-bigeasy@linutronix.de>
 <57BB23CB.2080908@linaro.org>
 <20160822190404.i56qlimrqkhozacn@linutronix.de>
 <57BC5AAC.7070707@linaro.org>
 <20160823163206.xe7dg7ulzj4pzzrs@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:59147 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932572AbcHXJJf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Aug 2016 05:09:35 -0400
Content-Disposition: inline
In-Reply-To: <20160823163206.xe7dg7ulzj4pzzrs@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, rt@linutronix.de

Install the callbacks via the state machine.

v1…v2: Use only CPUHP_CPUIDLE_DEAD (requested by Daniel Lezcano)

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/cpuidle/cpuidle-pseries.c | 53 ++++++++++++++++++---------------------
 include/linux/cpuhotplug.h        |  1 +
 2 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index 07135e009d8b..abbce8f96d93 100644
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
@@ -273,7 +263,14 @@ static int __init pseries_processor_idle_init(void)
 		return retval;
 	}
 
-	register_cpu_notifier(&setup_hotplug_notifier);
+	retval = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					   "CPUIDLE_PSERIES_ONLINE",
+					   pseries_cpuidle_cpu_online, NULL);
+	WARN_ON(retval < 0);
+	retval = cpuhp_setup_state_nocalls(CPUHP_CPUIDLE_DEAD,
+					   "CPUIDLE_PSERIES_DEAD", NULL,
+					   pseries_cpuidle_cpu_dead);
+	WARN_ON(retval < 0);
 	printk(KERN_DEBUG "pseries_idle_driver registered\n");
 	return 0;
 }
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 5811954809af..14b58a9d1450 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -19,6 +19,7 @@ enum cpuhp_state {
 	CPUHP_MM_WRITEBACK_DEAD,
 	CPUHP_SOFTIRQ_DEAD,
 	CPUHP_NET_MVNETA_DEAD,
+	CPUHP_CPUIDLE_DEAD,
 	CPUHP_WORKQUEUE_PREP,
 	CPUHP_POWER_NUMA_PREPARE,
 	CPUHP_HRTIMERS_PREPARE,
-- 
2.9.3

