From: Rickard Andersson <rickard.andersson@stericsson.com>
Subject: [RFC PATCH 8/8] ARM: ux500: Add ApSleep state to suspend
Date: Fri, 22 Mar 2013 17:20:12 +0100
Message-ID: <1363969212-14864-9-git-send-email-rickard.andersson@stericsson.com>
References: <1363969212-14864-1-git-send-email-rickard.andersson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:51954 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161013Ab3CVQla (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Mar 2013 12:41:30 -0400
In-Reply-To: <1363969212-14864-1-git-send-email-rickard.andersson@stericsson.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, linux-pm@vger.kernel.org
Cc: daniel.lezcano@linaro.org, hongbo.zhang@linaro.org, khilman@linaro.org, ulf.hansson@linaro.org, linus.walleij@stericsson.com, rickard.andersson@stericsson.com

Support for power save state ApSleep is
added to the platform suspend operation
hook.

Signed-off-by: Rickard Andersson <rickard.andersson@stericsson.com>
---
 arch/arm/mach-ux500/suspend.c | 57 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/suspend.c b/arch/arm/mach-ux500/suspend.c
index d1ac203..875a92d 100644
--- a/arch/arm/mach-ux500/suspend.c
+++ b/arch/arm/mach-ux500/suspend.c
@@ -10,11 +10,60 @@
  */
 
 #include <linux/suspend.h>
+#include <linux/pm_domain.h>
+#include <linux/mfd/dbx500-prcmu.h>
+
+static u32 suspend_wakeups;
+static u32 running_wakeups;
+static struct generic_pm_domain *ape_domain;
 
 static int ux500_suspend_enter(suspend_state_t state)
 {
+	int ret = 0;
+
+	/* Configure the PRCMU for a sleep wakeup */
+	prcmu_enable_wakeups(suspend_wakeups);
+
+	pm_genpd_notify_power_on_off(ape_domain, false);
+
+	prcmu_gic_decouple();
+
+	/* Copy GIC interrupt settings to PRCMU interrupt settings */
+	prcmu_copy_gic_settings();
+
+	if (prcmu_gic_pending_irq()) {
+		pr_info("suspend/resume: pending interrupt\n");
+
+		/* Recouple GIC with the interrupt bus */
+		prcmu_gic_recouple();
+		ret = -EBUSY;
+		goto exit;
+	}
+
+	if (prcmu_pending_irq()) {
+		pr_info("suspend/resume: pending interrupt prcmu\n");
+
+		/* Recouple GIC with the interrupt bus */
+		prcmu_gic_recouple();
+		ret = -EBUSY;
+		goto exit;
+	}
+
+	prcmu_set_ioforce(true);
+
+	prcmu_set_power_state(PRCMU_AP_SLEEP, false, false);
+
 	cpu_do_idle();
-	return 0;
+
+	pm_genpd_notify_power_on_off(ape_domain, true);
+
+	prcmu_set_ioforce(false);
+
+ exit:
+	/* Configure the prcmu with the wake-ups that cpuidle needs */
+	prcmu_enable_wakeups(running_wakeups);
+
+	return ret;
 }
 
 static int ux500_suspend_valid(suspend_state_t state)
@@ -29,6 +78,12 @@ static const struct platform_suspend_ops ux500_suspend_ops = {
 
 static __init int ux500_suspend_init(void)
 {
+	suspend_wakeups = PRCMU_WAKEUP(ABB) | PRCMU_WAKEUP(RTC);
+	running_wakeups = (PRCMU_WAKEUP(ARM) | PRCMU_WAKEUP(RTC) |
+				   PRCMU_WAKEUP(ABB));
+
+	ape_domain = pm_genpd_lookup_name("APE");
+
 	suspend_set_ops(&ux500_suspend_ops);
 	return 0;
 }
-- 
1.8.2

