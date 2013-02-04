From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 3/4][V2] davinci: cpuidle - remove the ops
Date: Mon,  4 Feb 2013 13:01:43 +0100
Message-ID: <1359979304-8715-4-git-send-email-daniel.lezcano@linaro.org>
References: <1359979304-8715-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:52746 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755453Ab3BDMB5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Feb 2013 07:01:57 -0500
Received: by mail-wi0-f181.google.com with SMTP id hm6so1507499wib.2
        for <linux-pm@vger.kernel.org>; Mon, 04 Feb 2013 04:01:56 -0800 (PST)
In-Reply-To: <1359979304-8715-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: khilman@deeprootsystems.com, nsekhar@ti.com
Cc: patches@linaro.org, linaro-dev@lists.linaro.org, davinci-linux-open-source@linux.davincidsp.com, lenb@kernel.org, linux-pm@vger.kernel.org

With one function handling the idle state and a single variable,
the usage of the davinci_ops is overkill.

This patch removes these ops and simplify the code.

Furthermore, the 'driver_data' field is no longer used, we have
1 of the 3 remaining user of this field removed.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/cpuidle.c |   33 ++-------------------------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
index 697febe..5e430bf 100644
--- a/arch/arm/mach-davinci/cpuidle.c
+++ b/arch/arm/mach-davinci/cpuidle.c
@@ -25,12 +25,6 @@
 
 #define DAVINCI_CPUIDLE_MAX_STATES	2
 
-struct davinci_ops {
-	void (*enter) (void);
-	void (*exit) (void);
-	u32 flags;
-};
-
 static DEFINE_PER_CPU(struct cpuidle_device, davinci_cpuidle_device);
 static void __iomem *ddr2_reg_base;
 static bool ddr2_pdown;
@@ -54,39 +48,17 @@ static void davinci_save_ddr_power(int enter, bool pdown)
 	__raw_writel(val, ddr2_reg_base + DDR2_SDRCR_OFFSET);
 }
 
-static void davinci_c2state_enter(void)
-{
-	davinci_save_ddr_power(1, ddr2_pdown);
-}
-
-static void davinci_c2state_exit(void)
-{
-	davinci_save_ddr_power(0, ddr2_pdown);
-}
-
-static struct davinci_ops davinci_states[DAVINCI_CPUIDLE_MAX_STATES] = {
-	[1] = {
-		.enter	= davinci_c2state_enter,
-		.exit	= davinci_c2state_exit,
-	},
-};
-
 /* Actual code that puts the SoC in different idle states */
 static int davinci_enter_idle(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 						int index)
 {
-	struct cpuidle_state_usage *state_usage = &dev->states_usage[index];
-	struct davinci_ops *ops = cpuidle_get_statedata(state_usage);
-
-	if (ops && ops->enter)
-		ops->enter();
+	davinci_save_ddr_power(1, ddr2_pdown);
 
 	index = cpuidle_wrap_enter(dev,	drv, index,
 				arm_cpuidle_simple_enter);
 
-	if (ops && ops->exit)
-		ops->exit();
+	davinci_save_ddr_power(0, ddr2_pdown);
 
 	return index;
 }
@@ -123,7 +95,6 @@ static int __init davinci_cpuidle_probe(struct platform_device *pdev)
 	ddr2_reg_base = pdata->ddr2_ctlr_base;
 
 	ddr2_pdown = pdata->ddr2_pdown;
-	cpuidle_set_statedata(&device->states_usage[1], &davinci_states[1]);
 
 	device->state_count = DAVINCI_CPUIDLE_MAX_STATES;
 
-- 
1.7.9.5

