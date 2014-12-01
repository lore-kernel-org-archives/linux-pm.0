From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC V1 5/8] cpufreq: shmobile: reuse dt_device.c to create cpufreq platform device
Date: Mon,  1 Dec 2014 17:11:26 +0530
Message-ID: <c0cccbcd1c4e9e11db493e1b1332ef65711cc62a.1417433163.git.viresh.kumar@linaro.org>
References: <cover.1417433163.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:54953 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398AbaLALmJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 06:42:09 -0500
Received: by mail-pa0-f46.google.com with SMTP id lj1so10951373pab.33
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2014 03:42:09 -0800 (PST)
In-Reply-To: <cover.1417433163.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417433163.git.viresh.kumar@linaro.org>
References: <cover.1417433163.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Arnd Bergmann <arnd.bergmann@linaro.org>, Rob Herring <rob.herring@linaro.org>, Grant Likely <grant.likely@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, devicetree@vger.kernel.org, santosh shilimkar <santosh.shilimkar@oracle.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mike Turquette <mike.turquette@linaro.org>, kesavan.abhilash@gmail.com, catalin.marinas@arm.com, k.chander@samsung.com, olof@lixom.net, ta.omasab@gmail.com, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>

We now have a common interface for create platform device required to probe
cpufreq-dt driver (and others as well). Lets create devices from dt_device.c
instead of platform specific code.

For shmobile, we are updating the blacklist instead of DT because the newer
kernel should be backwards compatible with older DT as well. We can update the
"compatible" property in DT but it wouldn't make a difference as we already have
imx in the blacklist.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-shmobile/Makefile  |  1 -
 arch/arm/mach-shmobile/common.h  |  7 -------
 arch/arm/mach-shmobile/cpufreq.c | 17 -----------------
 drivers/cpufreq/dt_device.c      |  3 +++
 4 files changed, 3 insertions(+), 25 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/cpufreq.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index e20f278..6780401 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -48,7 +48,6 @@ smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o platsmp-scu.o
 # PM objects
 obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
-obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
 obj-$(CONFIG_PM_RCAR)		+= pm-rcar.o
 obj-$(CONFIG_PM_RMOBILE)	+= pm-rmobile.o
 
diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 72087c7..97ddd5f 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -45,19 +45,12 @@ int shmobile_cpuidle_init(void);
 static inline int shmobile_cpuidle_init(void) { return 0; }
 #endif
 
-#ifdef CONFIG_CPU_FREQ
-int shmobile_cpufreq_init(void);
-#else
-static inline int shmobile_cpufreq_init(void) { return 0; }
-#endif
-
 extern void __iomem *shmobile_scu_base;
 
 static inline void __init shmobile_init_late(void)
 {
 	shmobile_suspend_init();
 	shmobile_cpuidle_init();
-	shmobile_cpufreq_init();
 }
 
 #endif /* __ARCH_MACH_COMMON_H */
diff --git a/arch/arm/mach-shmobile/cpufreq.c b/arch/arm/mach-shmobile/cpufreq.c
deleted file mode 100644
index 57fbff0..0000000
--- a/arch/arm/mach-shmobile/cpufreq.c
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * CPUFreq support code for SH-Mobile ARM
- *
- *  Copyright (C) 2014 Gaku Inami
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/platform_device.h>
-
-int __init shmobile_cpufreq_init(void)
-{
-	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
-	return 0;
-}
diff --git a/drivers/cpufreq/dt_device.c b/drivers/cpufreq/dt_device.c
index 33fc046..85dc002 100644
--- a/drivers/cpufreq/dt_device.c
+++ b/drivers/cpufreq/dt_device.c
@@ -29,6 +29,9 @@ static const struct of_device_id compatible_machine_match[] = {
 
 	{ .compatible = "marvell,armadaxp",	.data = "cpufreq-dt" },
 
+	{ .compatible = "renesas,sh7372",	.data = "cpufreq-dt" },
+	{ .compatible = "renesas,sh73a0",	.data = "cpufreq-dt" },
+
 	/* BLACKLIST of existing users of arm-bL-cpufreq-dt below */
 
 	/* BLACKLIST of existing users of other drivers below */
-- 
2.0.3.693.g996b0fd

