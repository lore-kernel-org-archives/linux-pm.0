From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/3] ARM: ux500: cpuidle: Instantiate the driver from platform device
Date: Tue, 16 Jul 2013 01:25:24 +0200
Message-ID: <1373930726-15475-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:57458 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755007Ab3GOXZa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2013 19:25:30 -0400
Received: by mail-we0-f175.google.com with SMTP id t59so21488wes.34
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2013 16:25:29 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linus.walleij@linaro.org, patches@linaro.org

From: Linus Walleij <linus.walleij@linaro.org>

To break the dependency on the "id.h" file we move the cpuidle driver
to a platform device. Now we only call the probe() on this driver if
we find a corresponding platform device (which is spawned from the
PRCMU MFD driver).

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-ux500/cpuidle.c |   17 +++++++++++------
 drivers/mfd/db8500-prcmu.c    |    4 ++++
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-ux500/cpuidle.c b/arch/arm/mach-ux500/cpuidle.c
index a45dd09..c0cb37c 100644
--- a/arch/arm/mach-ux500/cpuidle.c
+++ b/arch/arm/mach-ux500/cpuidle.c
@@ -16,12 +16,12 @@
 #include <linux/smp.h>
 #include <linux/mfd/dbx500-prcmu.h>
 #include <linux/platform_data/arm-ux500-pm.h>
+#include <linux/platform_device.h>
 
 #include <asm/cpuidle.h>
 #include <asm/proc-fns.h>
 
 #include "db8500-regs.h"
-#include "id.h"
 
 static atomic_t master = ATOMIC_INIT(0);
 static DEFINE_SPINLOCK(master_lock);
@@ -113,11 +113,8 @@ static struct cpuidle_driver ux500_idle_driver = {
 	.state_count = 2,
 };
 
-int __init ux500_idle_init(void)
+static int __init dbx500_cpuidle_probe(struct platform_device *pdev)
 {
-	if (!(cpu_is_u8500_family() || cpu_is_ux540_family()))
-		return -ENODEV;
-
 	/* Configure wake up reasons */
 	prcmu_enable_wakeups(PRCMU_WAKEUP(ARM) | PRCMU_WAKEUP(RTC) |
 			     PRCMU_WAKEUP(ABB));
@@ -125,4 +122,12 @@ int __init ux500_idle_init(void)
 	return cpuidle_register(&ux500_idle_driver, NULL);
 }
 
-device_initcall(ux500_idle_init);
+static struct platform_driver dbx500_cpuidle_plat_driver = {
+	.driver = {
+		.name = "cpuidle-dbx500",
+		.owner = THIS_MODULE,
+	},
+	.probe = dbx500_cpuidle_probe,
+};
+
+module_platform_driver(dbx500_cpuidle_plat_driver);
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 3c157fa..0d68eb1 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -3094,6 +3094,10 @@ static struct mfd_cell db8500_prcmu_devs[] = {
 		.pdata_size = sizeof(db8500_cpufreq_table),
 	},
 	{
+		.name = "cpuidle-dbx500",
+		.of_compatible = "stericsson,cpuidle-dbx500",
+	},
+	{
 		.name = "db8500-thermal",
 		.num_resources = ARRAY_SIZE(db8500_thsens_resources),
 		.resources = db8500_thsens_resources,
-- 
1.7.9.5

