From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 05/18] cpuidle: make a single register function for all
Date: Wed, 10 Apr 2013 16:22:10 +0200
Message-ID: <1365603743-5618-6-git-send-email-daniel.lezcano@linaro.org>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:61582 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936727Ab3DJOWp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Apr 2013 10:22:45 -0400
Received: by mail-wi0-f178.google.com with SMTP id ez12so523704wid.11
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2013 07:22:44 -0700 (PDT)
In-Reply-To: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

The usual scheme to initialize a cpuidle driver on a SMP is:

	cpuidle_register_driver(drv);
	for_each_possible_cpu(cpu) {
		device = &per_cpu(cpuidle_dev, cpu);
		cpuidle_register_device(device);
	}

This code is duplicated in each cpuidle driver.

On UP systems, it is done this way:

	cpuidle_register_driver(drv);
	device = &per_cpu(cpuidle_dev, cpu);
	cpuidle_register_device(device);

On UP, the macro 'for_each_cpu' does one iteration:

#define for_each_cpu(cpu, mask)                 \
        for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)

Hence, the initialization loop is the same for UP than SMP.

Beside, we saw different bugs / mis-initialization / return code unchecked in
the different drivers, the code is duplicated including bugs. After fixing all
these ones, it appears the initialization pattern is the same for everyone.

Let's add a wrapper function doing this initialization with a cpumask parameter
for the coupled idle states and use it for all the drivers.

That will save a lot of LOC, consolidate the code, and the modifications in the
future could be done in a single place. Another benefit is the consolidation of
the cpuidle_device variable which is now in the cpuidle framework and no longer
spread accross the different arch specific drivers.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.c |   65 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/cpuidle.h   |    9 +++++--
 2 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 0da795b..3a5454b 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -24,6 +24,7 @@
 #include "cpuidle.h"
 
 DEFINE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
+DEFINE_PER_CPU(struct cpuidle_device, cpuidle_dev);
 
 DEFINE_MUTEX(cpuidle_lock);
 LIST_HEAD(cpuidle_detected_devices);
@@ -453,6 +454,70 @@ void cpuidle_unregister_device(struct cpuidle_device *dev)
 
 EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
 
+/*
+ * cpuidle_unregister: unregister a driver and the devices. This function
+ * can be used only if the driver has been previously registered through
+ * the cpuidle_register function.
+ *
+ * @drv: a valid pointer to a struct cpuidle_driver
+ */
+void cpuidle_unregister(struct cpuidle_driver *drv)
+{
+	int cpu;
+	struct cpuidle_device *device;
+
+	for_each_possible_cpu(cpu) {
+		device = &per_cpu(cpuidle_dev, cpu);
+		cpuidle_unregister_device(device);
+	}
+
+	cpuidle_unregister_driver(drv);
+}
+EXPORT_SYMBOL_GPL(cpuidle_unregister);
+
+/**
+ * cpuidle_register: registers the driver and the cpu devices with the
+ * coupled_cpus passed as parameter. This function is used for all common
+ * initialization pattern there are in the arch specific drivers. The
+ * devices is globally defined in this file.
+ *
+ * @drv         : a valid pointer to a struct cpuidle_driver
+ * @coupled_cpus: a cpumask for the coupled states
+ *
+ * Returns 0 on success, < 0 otherwise
+ */
+int cpuidle_register(struct cpuidle_driver *drv,
+		     const struct cpumask *const coupled_cpus)
+{
+	int ret, cpu;
+	struct cpuidle_device *device;
+
+	ret = cpuidle_register_driver(drv);
+	if (ret) {
+		printk(KERN_ERR "failed to register cpuidle driver\n");
+		return ret;
+	}
+
+	for_each_possible_cpu(cpu) {
+		device = &per_cpu(cpuidle_dev, cpu);
+		device->cpu = cpu;
+#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
+		device->coupled_cpus = *coupled_cpus;
+#endif
+		ret = cpuidle_register_device(device);
+		if (!ret)
+			continue;
+
+		printk(KERN_ERR "Failed to register cpuidle "
+		       "device for cpu%d\n", cpu);
+		cpuidle_unregister(drv);
+		break;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpuidle_register);
+
 #ifdef CONFIG_SMP
 
 static void smp_callback(void *v)
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 79e3811..3c86faa 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -123,7 +123,9 @@ extern void cpuidle_driver_unref(void);
 extern void cpuidle_unregister_driver(struct cpuidle_driver *drv);
 extern int cpuidle_register_device(struct cpuidle_device *dev);
 extern void cpuidle_unregister_device(struct cpuidle_device *dev);
-
+extern int cpuidle_register(struct cpuidle_driver *drv,
+			    const struct cpumask *const coupled_cpus);
+extern void cpuidle_unregister(struct cpuidle_driver *drv);
 extern void cpuidle_pause_and_lock(void);
 extern void cpuidle_resume_and_unlock(void);
 extern void cpuidle_pause(void);
@@ -148,7 +150,10 @@ static inline void cpuidle_unregister_driver(struct cpuidle_driver *drv) { }
 static inline int cpuidle_register_device(struct cpuidle_device *dev)
 {return -ENODEV; }
 static inline void cpuidle_unregister_device(struct cpuidle_device *dev) { }
-
+static inline int cpuidle_register(struct cpuidle_driver *drv,
+				   const struct cpumask *const coupled_cpus)
+{return -ENODEV; }
+static inline void cpuidle_unregister(struct cpuidle_driver *drv) { }
 static inline void cpuidle_pause_and_lock(void) { }
 static inline void cpuidle_resume_and_unlock(void) { }
 static inline void cpuidle_pause(void) { }
-- 
1.7.9.5

