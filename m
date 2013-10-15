From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH V4 1/2] ARM: at91: cpuidle: convert to platform driver
Date: Tue, 15 Oct 2013 11:41:48 +0200
Message-ID: <1381830109-1398-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:62349 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757855Ab3JOJl4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2013 05:41:56 -0400
Received: by mail-wi0-f180.google.com with SMTP id i19so641308wiw.13
        for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2013 02:41:55 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: plagnioj@jcrosoft.com, linux@maxim.org.za, nicolas.ferre@atmel.com
Cc: linux-arm-kernel@lists.infradead.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, thomas.petazzoni@free-electrons.com, b.zolnierkie@samsung.com

Using the platform driver model is a good way to separate the cpuidle specific
code from the low level pm code. It allows to remove the dependency between
these two components.

The platform_device is located in the pm code and a 'set' function has been
added to set the standby function from the AT91_SOC_START initialization
function. Each SoC with a cpuidle driver will set the standby function in the
platform_data field at init time. Then pm code will register the cpuidle
platform device.

The cpuidle driver will register the platform_driver and use the device's
platform_data as a standby callback in the idle path.

The at91_pm_enter function contains a { if then else } based on cpu_is_xx
similar to what was in cpuidle. This is considered dangerous when adding a new
SoC. Like the cpuidle driver, a standby ops is defined and assigned when the
SoC init function specifies what is its standby function and reused in the
at91_pm_enter's 'case' block.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-at91/at91rm9200.c  |    3 +++
 arch/arm/mach-at91/at91sam9260.c |    3 +++
 arch/arm/mach-at91/at91sam9261.c |    3 +++
 arch/arm/mach-at91/at91sam9263.c |    3 +++
 arch/arm/mach-at91/at91sam9g45.c |    3 +++
 arch/arm/mach-at91/at91sam9rl.c  |    3 +++
 arch/arm/mach-at91/cpuidle.c     |   29 +++++++++++++++--------------
 arch/arm/mach-at91/pm.c          |   27 +++++++++++++++++++--------
 arch/arm/mach-at91/pm.h          |    4 ++++
 9 files changed, 56 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 4aad93d..0d234f2 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -27,6 +27,7 @@
 #include "generic.h"
 #include "clock.h"
 #include "sam9_smc.h"
+#include "pm.h"
 
 /* --------------------------------------------------------------------
  *  Clocks
@@ -337,6 +338,8 @@ static void __init at91rm9200_initialize(void)
 	/* Initialize GPIO subsystem */
 	at91_gpio_init(at91rm9200_gpio,
 		cpu_is_at91rm9200_bga() ? AT91RM9200_BGA : AT91RM9200_PQFP);
+
+	at91_pm_set_standby(at91rm9200_standby);
 }
 
 
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 5de6074..ffe9ce7 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -28,6 +28,7 @@
 #include "generic.h"
 #include "clock.h"
 #include "sam9_smc.h"
+#include "pm.h"
 
 /* --------------------------------------------------------------------
  *  Clocks
@@ -351,6 +352,8 @@ static void __init at91sam9260_initialize(void)
 
 	/* Register GPIO subsystem */
 	at91_gpio_init(at91sam9260_gpio, 3);
+
+	at91_pm_set_standby(at91sam9_standby);
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 0e07932..1edbb6f 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -27,6 +27,7 @@
 #include "generic.h"
 #include "clock.h"
 #include "sam9_smc.h"
+#include "pm.h"
 
 /* --------------------------------------------------------------------
  *  Clocks
@@ -293,6 +294,8 @@ static void __init at91sam9261_initialize(void)
 
 	/* Register GPIO subsystem */
 	at91_gpio_init(at91sam9261_gpio, 3);
+
+	at91_pm_set_sandby(at91sam9_standby);
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 6ce7d18..8c81c89 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -26,6 +26,7 @@
 #include "generic.h"
 #include "clock.h"
 #include "sam9_smc.h"
+#include "pm.h"
 
 /* --------------------------------------------------------------------
  *  Clocks
@@ -330,6 +331,8 @@ static void __init at91sam9263_initialize(void)
 
 	/* Register GPIO subsystem */
 	at91_gpio_init(at91sam9263_gpio, 5);
+
+	at91_pm_set_standby(at91sam9263_standby);
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 474ee04..8460f52 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -26,6 +26,7 @@
 #include "generic.h"
 #include "clock.h"
 #include "sam9_smc.h"
+#include "pm.h"
 
 /* --------------------------------------------------------------------
  *  Clocks
@@ -379,6 +380,8 @@ static void __init at91sam9g45_initialize(void)
 
 	/* Register GPIO subsystem */
 	at91_gpio_init(at91sam9g45_gpio, 5);
+
+	at91_pm_set_standby(at91sam9g45_standby);
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index d4ec0d9..c7986e4 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -27,6 +27,7 @@
 #include "generic.h"
 #include "clock.h"
 #include "sam9_smc.h"
+#include "pm.h"
 
 /* --------------------------------------------------------------------
  *  Clocks
@@ -296,6 +297,8 @@ static void __init at91sam9rl_initialize(void)
 
 	/* Register GPIO subsystem */
 	at91_gpio_init(at91sam9rl_gpio, 4);
+
+	at91_pm_set_standby(at91sam9_standby);
 }
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuidle.c
index 4ec6a6d..a077437 100644
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
+static int at91_cpuidle_probe(struct platform_device *dev)
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
index 15afb5d..9986542 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -39,6 +39,8 @@
 #include "at91_rstc.h"
 #include "at91_shdwc.h"
 
+static void (*at91_pm_standby)(void);
+
 static void __init show_reset_status(void)
 {
 	static char reset[] __initdata = "reset";
@@ -266,14 +268,8 @@ static int at91_pm_enter(suspend_state_t state)
 			 * For ARM 926 based chips, this requirement is weaker
 			 * as at91sam9 can access a RAM in self-refresh mode.
 			 */
-			if (cpu_is_at91rm9200())
-				at91rm9200_standby();
-			else if (cpu_is_at91sam9g45())
-				at91sam9g45_standby();
-			else if (cpu_is_at91sam9263())
-				at91sam9263_standby();
-			else
-				at91sam9_standby();
+			if (at91_pm_standby)
+				at91_pm_standby();
 			break;
 
 		case PM_SUSPEND_ON:
@@ -314,6 +310,18 @@ static const struct platform_suspend_ops at91_pm_ops = {
 	.end	= at91_pm_end,
 };
 
+static struct platform_device at91_cpuidle_device = {
+	.name = "cpuidle-at91",
+};
+
+void at91_pm_set_standby(void (*at91_standby)(void))
+{
+	if (at91_standby) {
+		at91_cpuidle_device.dev.platform_data = at91_standby;
+		at91_pm_standby = at91_standby;
+	}
+}
+
 static int __init at91_pm_init(void)
 {
 #ifdef CONFIG_AT91_SLOW_CLOCK
@@ -325,6 +333,9 @@ static int __init at91_pm_init(void)
 	/* AT91RM9200 SDRAM low-power mode cannot be used with self-refresh. */
 	if (cpu_is_at91rm9200())
 		at91_ramc_write(0, AT91RM9200_SDRAMC_LPR, 0);
+	
+	if (at91_cpuidle_device.dev.platform_data)
+		platform_device_register(&at91_cpuidle_device);
 
 	suspend_set_ops(&at91_pm_ops);
 
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index 2f5908f..76dd1a7 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -11,9 +11,13 @@
 #ifndef __ARCH_ARM_MACH_AT91_PM
 #define __ARCH_ARM_MACH_AT91_PM
 
+#include <asm/proc-fns.h>
+
 #include <mach/at91_ramc.h>
 #include <mach/at91rm9200_sdramc.h>
 
+extern void at91_pm_set_standby(void (*at91_standby)(void));
+
 /*
  * The AT91RM9200 goes into self-refresh mode with this command, and will
  * terminate self-refresh automatically on the next SDRAM access.
-- 
1.7.9.5

