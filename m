From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC patch 02/11] cpuidle / arm : a single cpuidle driver
Date: Fri, 15 Mar 2013 15:27:01 +0100
Message-ID: <1363357630-22214-3-git-send-email-daniel.lezcano@linaro.org>
References: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:61790 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754769Ab3COO1V (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Mar 2013 10:27:21 -0400
Received: by mail-wg0-f49.google.com with SMTP id ds1so2094133wgb.28
        for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2013 07:27:19 -0700 (PDT)
In-Reply-To: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, rjw@sisk.pl, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, andrew@lunn.ch

The cpuidle drivers are duplicating a lot of code and in most
of the case there is a common pattern we can factor out:

	* setup the broadcast timers
	* register the driver
	* register the devices

This arm driver is the common part between all the ARM cpuidle drivers,
with the code factored out.

It does not handle the coupled idle state for now but it is the first
step to have everyone to converge to the same code pattern.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 MAINTAINERS                    |    6 +++
 arch/arm/include/asm/cpuidle.h |    3 ++
 drivers/cpuidle/Makefile       |    1 +
 drivers/cpuidle/arm-idle.c     |  112 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 122 insertions(+)
 create mode 100644 drivers/cpuidle/arm-idle.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9561658..2c13cf3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2212,6 +2212,12 @@ S:	Maintained
 F:	arch/x86/kernel/cpuid.c
 F:	arch/x86/kernel/msr.c
 
+CPUIDLE FOR ARM
+M:	Daniel Lezcano <daniel.lezcano@linaro.org>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	drivers/cpuidle/arm-idle.c
+
 CPU POWER MONITORING SUBSYSTEM
 M:	Dominik Brodowski <linux@dominikbrodowski.net>
 M:	Thomas Renninger <trenn@suse.de>
diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
index 2fca60a..107cf23 100644
--- a/arch/arm/include/asm/cpuidle.h
+++ b/arch/arm/include/asm/cpuidle.h
@@ -9,6 +9,9 @@ static inline int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
 		struct cpuidle_driver *drv, int index) { return -ENODEV; }
 #endif
 
+extern int arm_idle_init(struct cpuidle_driver *drv);
+extern void arm_idle_exit(struct cpuidle_driver *drv);
+
 /* Common ARM WFI state */
 #define ARM_CPUIDLE_WFI_STATE_PWR(p) {\
 	.enter                  = arm_cpuidle_simple_enter,\
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index d1aba71..4816a78 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -5,5 +5,6 @@
 obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
 obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
 
+obj-$(CONFIG_ARM) += arm-idle.o
 obj-$(CONFIG_ARCH_HIGHBANK) += cpuidle-calxeda.o
 obj-$(CONFIG_ARCH_KIRKWOOD) += cpuidle-kirkwood.o
diff --git a/drivers/cpuidle/arm-idle.c b/drivers/cpuidle/arm-idle.c
new file mode 100644
index 0000000..397ff4c
--- /dev/null
+++ b/drivers/cpuidle/arm-idle.c
@@ -0,0 +1,112 @@
+/*
+ * Copyright 2012 Linaro Ltd: : Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/clockchips.h>
+#include <linux/module.h>
+#include <linux/cpuidle.h>
+
+static DEFINE_PER_CPU(struct cpuidle_device, cpuidle_device);
+static bool use_broadcast_timer = false;
+
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
+static void setup_broadcast_timer(void *arg)
+{
+        int cpu = smp_processor_id();
+        clockevents_notify((int)(arg), &cpu);
+}
+
+static bool __init arm_idle_use_broadcast(struct cpuidle_driver *drv)
+{
+	int i;
+
+	for (i = 0; i < drv->state_count; i++)
+		if (drv->states[i].flags & CPUIDLE_FLAG_TIMER_STOP)
+			return true;
+	return false;
+}
+
+static inline void arm_idle_timer_broadcast(bool enable)
+{
+	on_each_cpu(setup_broadcast_timer, enable ?
+		    (void *)CLOCK_EVT_NOTIFY_BROADCAST_ON:
+		    (void *)CLOCK_EVT_NOTIFY_BROADCAST_OFF, 1);
+}
+#else
+static inline bool __init arm_idle_use_broadcast(struct cpuidle_driver *drv)
+{
+	return false;
+}
+
+static inline void arm_idle_timer_broadcast(bool enable)
+{
+	;
+}
+#endif
+
+int __init arm_idle_init(struct cpuidle_driver *drv)
+{
+	int ret, cpu;
+	struct cpuidle_device *device;
+
+	use_broadcast_timer = arm_idle_use_broadcast(drv);
+
+	if (use_broadcast_timer)
+		arm_idle_timer_broadcast(true);
+
+	ret = cpuidle_register_driver(drv);
+	if (ret) {
+		printk(KERN_ERR "failed to register idle driver '%s'\n",
+			drv->name);
+		return ret;
+	}
+
+	for_each_online_cpu(cpu) {
+
+		device = &per_cpu(cpuidle_device, cpu);
+		device->cpu = cpu;
+		ret = cpuidle_register_device(device);
+		if (ret) {
+			printk(KERN_ERR "Failed to register cpuidle "
+			       "device for cpu%d\n", cpu);
+			goto out_unregister;
+		}
+	}
+
+out:
+	return ret;
+
+out_unregister:
+	for_each_online_cpu(cpu) {
+		device = &per_cpu(cpuidle_device, cpu);
+		cpuidle_unregister_device(device);
+	}
+
+	cpuidle_unregister_driver(drv);
+	goto out;
+}
+EXPORT_SYMBOL_GPL(arm_idle_init);
+
+void __exit arm_idle_exit(struct cpuidle_driver *drv)
+{
+	int cpu;
+	struct cpuidle_device *device;
+
+	for_each_online_cpu(cpu) {
+		device = &per_cpu(cpuidle_device, cpu);
+		cpuidle_unregister_device(device);
+	}
+
+	cpuidle_unregister_driver(drv);
+
+	if (use_broadcast_timer)
+		arm_idle_timer_broadcast(false);
+}
+EXPORT_SYMBOL_GPL(arm_idle_exit);
-- 
1.7.9.5

