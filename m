From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH V3 3/3] ARM: at91: pm: use standby callback instead of cpu_is
Date: Tue, 15 Oct 2013 09:50:32 +0200
Message-ID: <1381823432-24944-3-git-send-email-daniel.lezcano@linaro.org>
References: <1381823432-24944-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:64385 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651Ab3JOHux (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2013 03:50:53 -0400
Received: by mail-wg0-f42.google.com with SMTP id n12so2294468wgh.5
        for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2013 00:50:51 -0700 (PDT)
In-Reply-To: <1381823432-24944-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: plagnioj@jcrosoft.com, linux@maxim.org.za, nicolas.ferre@atmel.com
Cc: linux-arm-kernel@lists.infradead.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, thomas.petazzoni@free-electrons.com, b.zolnierkie@samsung.com

The cpuidle's platform_device has the standby function set for the correct
SoC when supported in the platform data. Remove the { if then else } statements
in the at91_pm_enter by using directly the standby ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-at91/pm.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 76f8cbf..baeb4a4a 100644
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
@@ -335,8 +331,10 @@ static int __init at91_pm_init(void)
 	if (cpu_is_at91rm9200())
 		at91_ramc_write(0, AT91RM9200_SDRAMC_LPR, 0);
 	
-	if (at91_cpuidle_device.dev.platform_data)
+	if (at91_cpuidle_device.dev.platform_data) {
+		at91_pm_standby = at91_cpuidle_device.dev.platform_data;
 		platform_device_register(&at91_cpuidle_device);
+	}
 
 	suspend_set_ops(&at91_pm_ops);
 
-- 
1.7.9.5

