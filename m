From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/4] davinci: cpuidle - use global variable for ddr2 flag
Date: Fri,  1 Feb 2013 14:48:12 +0100
Message-ID: <1359726495-8024-2-git-send-email-daniel.lezcano@linaro.org>
References: <1359726495-8024-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:44854 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755309Ab3BANsT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Feb 2013 08:48:19 -0500
Received: by mail-we0-f180.google.com with SMTP id k14so2888232wer.25
        for <linux-pm@vger.kernel.org>; Fri, 01 Feb 2013 05:48:18 -0800 (PST)
In-Reply-To: <1359726495-8024-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: nsekhar@ti.com, khilman@ti.com
Cc: patches@linaro.org, linaro-dev@lists.linaro.org, davinci-linux-open-source@linux.davincidsp.com, lenb@kernel.org, linux-pm@vger.kernel.org

Replace the flag by a simple global boolean in the cpuidle.c.
That will allow to cleanup the rest of the code right after,
because the ops won't make sense anymore.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-davinci/cpuidle.c |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
index 9107691..ebb8808 100644
--- a/arch/arm/mach-davinci/cpuidle.c
+++ b/arch/arm/mach-davinci/cpuidle.c
@@ -26,8 +26,8 @@
 #define DAVINCI_CPUIDLE_MAX_STATES	2
 
 struct davinci_ops {
-	void (*enter) (u32 flags);
-	void (*exit) (u32 flags);
+	void (*enter) (void);
+	void (*exit) (void);
 	u32 flags;
 };
 
@@ -40,20 +40,17 @@ static int davinci_enter_idle(struct cpuidle_device *dev,
 	struct davinci_ops *ops = cpuidle_get_statedata(state_usage);
 
 	if (ops && ops->enter)
-		ops->enter(ops->flags);
+		ops->enter();
 
 	index = cpuidle_wrap_enter(dev,	drv, index,
 				arm_cpuidle_simple_enter);
 
 	if (ops && ops->exit)
-		ops->exit(ops->flags);
+		ops->exit();
 
 	return index;
 }
 
-/* fields in davinci_ops.flags */
-#define DAVINCI_CPUIDLE_FLAGS_DDR2_PWDN	BIT(0)
-
 static struct cpuidle_driver davinci_idle_driver = {
 	.name			= "cpuidle-davinci",
 	.owner			= THIS_MODULE,
@@ -72,6 +69,7 @@ static struct cpuidle_driver davinci_idle_driver = {
 
 static DEFINE_PER_CPU(struct cpuidle_device, davinci_cpuidle_device);
 static void __iomem *ddr2_reg_base;
+static bool ddr2_pdown = false;
 
 static void davinci_save_ddr_power(int enter, bool pdown)
 {
@@ -92,14 +90,14 @@ static void davinci_save_ddr_power(int enter, bool pdown)
 	__raw_writel(val, ddr2_reg_base + DDR2_SDRCR_OFFSET);
 }
 
-static void davinci_c2state_enter(u32 flags)
+static void davinci_c2state_enter(void)
 {
-	davinci_save_ddr_power(1, !!(flags & DAVINCI_CPUIDLE_FLAGS_DDR2_PWDN));
+	davinci_save_ddr_power(1, ddr2_pdown);
 }
 
-static void davinci_c2state_exit(u32 flags)
+static void davinci_c2state_exit(void)
 {
-	davinci_save_ddr_power(0, !!(flags & DAVINCI_CPUIDLE_FLAGS_DDR2_PWDN));
+	davinci_save_ddr_power(0, ddr2_pdown);
 }
 
 static struct davinci_ops davinci_states[DAVINCI_CPUIDLE_MAX_STATES] = {
@@ -124,8 +122,7 @@ static int __init davinci_cpuidle_probe(struct platform_device *pdev)
 
 	ddr2_reg_base = pdata->ddr2_ctlr_base;
 
-	if (pdata->ddr2_pdown)
-		davinci_states[1].flags |= DAVINCI_CPUIDLE_FLAGS_DDR2_PWDN;
+	ddr2_pdown = pdata->ddr2_pdown;
 	cpuidle_set_statedata(&device->states_usage[1], &davinci_states[1]);
 
 	device->state_count = DAVINCI_CPUIDLE_MAX_STATES;
-- 
1.7.9.5

