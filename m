From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/2] ARM: at91: cpuidle: convert to platform driver
Date: Sat, 12 Oct 2013 17:51:38 +0200
Message-ID: <1381593099-1184-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:53970 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258Ab3JLPvm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 12 Oct 2013 11:51:42 -0400
Received: by mail-we0-f175.google.com with SMTP id t61so5384276wes.20
        for <linux-pm@vger.kernel.org>; Sat, 12 Oct 2013 08:51:41 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com
Cc: linux-arm-kernel@lists.infradead.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

Use the platform driver model to separate the cpuidle specific code from
the low level pm code. It allows to remove the dependency between
these two components.

Tested-on usb-a9263 (at91sam9263)

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-at91/cpuidle.c |   29 +++++++++++++++--------------
 arch/arm/mach-at91/pm.c      |   16 +++++++++++++++-
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuidle.c
index 4ec6a6d..6cdc76d 100644
--- a/arch/arm/mach-at91/cpuidle.c
+++ b/arch/arm/mach-at91/cpuidle.c
@@ -21,26 +21,17 @@
 #include <linux/export.h>
 #include <asm/proc-fns.h>
 #include <asm/cpuidle.h>
-#include <mach/cpu.h>
-
-#include "pm.h"
 
 #define AT91_MAX_STATES	2
 
+static void (*at91_standby)(void);
+
 /* Actual code that puts the SoC in different idle states */
 static int at91_enter_idle(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 			       int index)
 {
-	if (cpu_is_at91rm9200())
-		at91rm9200_standby();
-	else if (cpu_is_at91sam9g45())
-		at91sam9g45_standby();
-	else if (cpu_is_at91sam9263())
-		at91sam9263_standby();
-	else
-		at91sam9_standby();
-
+	at91_standby();
 	return index;
 }
 
@@ -60,9 +51,19 @@ static struct cpuidle_driver at91_idle_driver = {
 };
 
 /* Initialize CPU idle by registering the idle states */
-static int __init at91_init_cpuidle(void)
+static int __init at91_cpuidle_probe(struct platform_device *dev)
 {
+	at91_standby = (void *)(dev->dev.platform_data);
+	
 	return cpuidle_register(&at91_idle_driver, NULL);
 }
 
-device_initcall(at91_init_cpuidle);
+static struct platform_driver at91_cpuidle_driver = {
+	.driver = {
+		.name = "cpuidle-at91",
+		.owner = THIS_MODULE,
+	},
+	.probe = at91_cpuidle_probe,
+};
+
+module_platform_driver(at91_cpuidle_driver);
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 15afb5d..debdbf8 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -314,6 +314,10 @@ static const struct platform_suspend_ops at91_pm_ops = {
 	.end	= at91_pm_end,
 };
 
+static struct platform_device at91_cpuidle_device = {
+	.name = "cpuidle-at91",
+};
+
 static int __init at91_pm_init(void)
 {
 #ifdef CONFIG_AT91_SLOW_CLOCK
@@ -323,8 +327,18 @@ static int __init at91_pm_init(void)
 	pr_info("AT91: Power Management%s\n", (slow_clock ? " (with slow clock mode)" : ""));
 
 	/* AT91RM9200 SDRAM low-power mode cannot be used with self-refresh. */
-	if (cpu_is_at91rm9200())
+	if (cpu_is_at91rm9200()) {
+		at91_cpuidle_device.dev.platform_data = at91rm9200_standby;
 		at91_ramc_write(0, AT91RM9200_SDRAMC_LPR, 0);
+	} else if (cpu_is_at91sam9g45()) {
+		at91_cpuidle_device.dev.platform_data = at91sam9g45_standby;
+	} else if (cpu_is_at91sam9263()) {
+		at91_cpuidle_device.dev.platform_data = at91sam9263_standby;
+	} else {
+		at91_cpuidle_device.dev.platform_data = at91sam9_standby;
+	}
+	
+	platform_device_register(&at91_cpuidle_device);
 
 	suspend_set_ops(&at91_pm_ops);
 
-- 
1.7.9.5

