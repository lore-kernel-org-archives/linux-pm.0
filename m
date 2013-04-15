From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC patch 1/2] ARM: at91: cpuidle: encapsulate the standby code
Date: Mon, 15 Apr 2013 15:29:57 +0200
Message-ID: <1366032598-23053-2-git-send-email-daniel.lezcano@linaro.org>
References: <1366032598-23053-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:47216 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361Ab3DONaD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Apr 2013 09:30:03 -0400
Received: by mail-wg0-f52.google.com with SMTP id n12so4715556wgh.7
        for <linux-pm@vger.kernel.org>; Mon, 15 Apr 2013 06:30:02 -0700 (PDT)
In-Reply-To: <1366032598-23053-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux@maxim.org.za, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, rjw@sisk.pl, plagnioj@jcrosoft.com, linux-pm@vger.kernel.org
Cc: linaro-kernel@lists.linaro.org

In order to split the pm code from the cpuidle driver, add an ops for the
standby function which will be initialized by the pm init functions directly,
thus no need of the SoC specific headers.

Cleanup also the headers included in this file as they are no longer needed.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-at91/cpuidle.c |   19 ++++---------------
 arch/arm/mach-at91/pm.c      |    8 +++++++-
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuidle.c
index 48f1228..b2bec92 100644
--- a/arch/arm/mach-at91/cpuidle.c
+++ b/arch/arm/mach-at91/cpuidle.c
@@ -13,32 +13,21 @@
  * #2 wait-for-interrupt and RAM self refresh
  */
 
-#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/init.h>
-#include <linux/platform_device.h>
 #include <linux/cpuidle.h>
-#include <linux/io.h>
-#include <linux/export.h>
-#include <asm/proc-fns.h>
 #include <asm/cpuidle.h>
-#include <mach/cpu.h>
-
-#include "pm.h"
 
 #define AT91_MAX_STATES	2
 
+extern void (*at91_standby_ops)(void);
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
-	else
-		at91sam9_standby();
-
+	at91_standby_ops();
 	return index;
 }
 
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 73f1f25..f456e86 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -39,6 +39,8 @@
 #include "at91_rstc.h"
 #include "at91_shdwc.h"
 
+void (*at91_standby_ops)(void);
+
 static void __init show_reset_status(void)
 {
 	static char reset[] __initdata = "reset";
@@ -321,8 +323,12 @@ static int __init at91_pm_init(void)
 	pr_info("AT91: Power Management%s\n", (slow_clock ? " (with slow clock mode)" : ""));
 
 	/* AT91RM9200 SDRAM low-power mode cannot be used with self-refresh. */
-	if (cpu_is_at91rm9200())
+	if (cpu_is_at91rm9200()) {
 		at91_ramc_write(0, AT91RM9200_SDRAMC_LPR, 0);
+		at91_standby_ops = at91rm9200_standby;
+	} else if (cpu_is_at91sam9g45())
+		at91_standby_ops= at91sam9g45_standby;
+	else at91_standby_ops = at91sam9_standby;
 
 	suspend_set_ops(&at91_pm_ops);
 
-- 
1.7.9.5

