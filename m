From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC PATCH] ARM: at91: cpuidle: encapsulate the standby code
Date: Wed, 26 Jun 2013 15:33:36 +0200
Message-ID: <1372253616-28086-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:48208 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab3FZNdY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2013 09:33:24 -0400
Received: by mail-wi0-f179.google.com with SMTP id hj3so1871409wib.6
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2013 06:33:23 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

In order to split the pm code from the cpuidle driver, add an ops for the
standby function which will be initialized by the platform data depending of
the SoC.

Cleanup also the headers included in this file as they are no longer needed.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-at91/board-usb-a926x.c |   17 +++++++++++++++-
 arch/arm/mach-at91/cpuidle.c         |   33 ++++++++++++++----------------
 arch/arm/mach-at91/pm.c              |   37 +++++++++++++++++++++++++---------
 arch/arm/mach-at91/pm.h              |    9 +++++++++
 4 files changed, 68 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-at91/board-usb-a926x.c b/arch/arm/mach-at91/board-usb-a926x.c
index 2487d94..b35f8fd 100644
--- a/arch/arm/mach-at91/board-usb-a926x.c
+++ b/arch/arm/mach-at91/board-usb-a926x.c
@@ -49,7 +49,6 @@
 #include "sam9_smc.h"
 #include "generic.h"
 
-
 static void __init ek_init_early(void)
 {
 	/* Initialize processor: 12.00 MHz crystal */
@@ -319,6 +318,19 @@ static void __init ek_add_device_leds(void)
 	at91_gpio_leds(ek_leds, ARRAY_SIZE(ek_leds));
 }
 
+#ifdef CONFIG_PM
+static struct platform_device at91_pm_device = {
+	.name = "pm-at91",
+	.id = -1,
+};
+#endif
+
+static struct platform_device *platform_devices[] __initdata = {
+#ifdef CONFIG_PM
+	&at91_pm_device,
+#endif
+};
+
 static void __init ek_board_init(void)
 {
 	/* Serial */
@@ -351,6 +363,9 @@ static void __init ek_board_init(void)
 				| AT91_SHDW_WKMODE0_LOW
 				| AT91_SHDW_RTTWKEN);
 	}
+
+	/* Platform devices */
+	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 }
 
 MACHINE_START(USB_A9263, "CALAO USB_A9263")
diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuidle.c
index 4ec6a6d..8bfaad0 100644
--- a/arch/arm/mach-at91/cpuidle.c
+++ b/arch/arm/mach-at91/cpuidle.c
@@ -13,33 +13,21 @@
  * #2 wait-for-interrupt and RAM self refresh
  */
 
-#include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/cpuidle.h>
-#include <linux/io.h>
-#include <linux/export.h>
-#include <asm/proc-fns.h>
 #include <asm/cpuidle.h>
-#include <mach/cpu.h>
-
-#include "pm.h"
 
 #define AT91_MAX_STATES	2
 
+static void (*at91_standby_ops)(void);
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
+	at91_standby_ops();
 
 	return index;
 }
@@ -60,9 +48,18 @@ static struct cpuidle_driver at91_idle_driver = {
 };
 
 /* Initialize CPU idle by registering the idle states */
-static int __init at91_init_cpuidle(void)
+int __init at91_init_cpuidle(struct platform_device *pdev)
 {
-	return cpuidle_register(&at91_idle_driver, NULL);
+	if (!pdev->dev.platform_data)
+		BUG();
+
+	at91_standby_ops = pdev->dev.platform_data;
+
+	return 0;
 }
 
-device_initcall(at91_init_cpuidle);
+static int __init at91_cpuidle_init(void)
+{
+	return cpuidle_register(&at91_idle_driver, NULL);
+}
+device_initcall(at91_cpuidle_init);
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 530db30..c5f4654 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -314,21 +314,40 @@ static const struct platform_suspend_ops at91_pm_ops = {
 	.end	= at91_pm_end,
 };
 
-static int __init at91_pm_init(void)
+static int __init at91_pm_probe(struct platform_device *pdev)
 {
-#ifdef CONFIG_AT91_SLOW_CLOCK
-	slow_clock = (void *) (AT91_IO_VIRT_BASE - at91_slow_clock_sz);
-#endif
-
-	pr_info("AT91: Power Management%s\n", (slow_clock ? " (with slow clock mode)" : ""));
-
 	/* AT91RM9200 SDRAM low-power mode cannot be used with self-refresh. */
-	if (cpu_is_at91rm9200())
+	if (of_machine_is_compatible("atmel,at91rm9200")) {
 		at91_ramc_write(0, AT91RM9200_SDRAMC_LPR, 0);
+		pdev->dev.platform_data = at91rm9200_standby;
+	} else if (of_machine_is_compatible("atmel,atmel,at91sam9g45")) {
+		pdev->dev.platform_data = at91sam9g45_standby;
+	} else {
+		pdev->dev.platform_data = at91sam9_standby;
+	}
 
 	suspend_set_ops(&at91_pm_ops);
 
 	show_reset_status();
-	return 0;
+
+	return at91_init_cpuidle(pdev);
+}
+
+static struct platform_driver at91_pm_driver = {
+	.driver = {
+		.name	 = "pm-at91",
+		.owner	 = THIS_MODULE,
+	},
+};
+
+static int __init at91_pm_init(void)
+{
+#ifdef CONFIG_AT91_SLOW_CLOCK
+	slow_clock = (void *) (AT91_IO_VIRT_BASE - at91_slow_clock_sz);
+#endif
+	pr_info("AT91: Power Management%s\n",
+		(slow_clock ? " (with slow clock mode)" : ""));
+
+	return platform_driver_probe(&at91_pm_driver, at91_pm_probe);
 }
 arch_initcall(at91_pm_init);
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index 2f5908f..897bed5 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -111,4 +111,13 @@ static inline void at91sam9_standby(void)
 	at91_ramc_write(0, AT91_SDRAMC_LPR, saved_lpr);
 }
 
+#ifdef CONFIG_CPU_IDLE
+extern int at91_init_cpuidle(struct platform_device *pdev);
+#else
+static inline int at91_init_cpuidle(struct platform_device *pdev)
+{
+	return 0;
+}
+#endif
+
 #endif
-- 
1.7.9.5

