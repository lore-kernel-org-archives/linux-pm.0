From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/4] davinci: cpuidle - move code to prevent forward declaration
Date: Fri,  1 Feb 2013 14:48:13 +0100
Message-ID: <1359726495-8024-3-git-send-email-daniel.lezcano@linaro.org>
References: <1359726495-8024-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:40211 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756058Ab3BANsa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Feb 2013 08:48:30 -0500
Received: by mail-wi0-f169.google.com with SMTP id l13so81887wie.0
        for <linux-pm@vger.kernel.org>; Fri, 01 Feb 2013 05:48:29 -0800 (PST)
In-Reply-To: <1359726495-8024-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: nsekhar@ti.com, khilman@ti.com
Cc: patches@linaro.org, linaro-dev@lists.linaro.org, davinci-linux-open-source@linux.davincidsp.com, lenb@kernel.org, linux-pm@vger.kernel.org

The patch is mindless, it just moves the idle function below in the file
in order to prevent forward declaration in the next patch.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-davinci/cpuidle.c |   72 +++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
index ebb8808..9438672 100644
--- a/arch/arm/mach-davinci/cpuidle.c
+++ b/arch/arm/mach-davinci/cpuidle.c
@@ -31,42 +31,6 @@ struct davinci_ops {
 	u32 flags;
 };
 
-/* Actual code that puts the SoC in different idle states */
-static int davinci_enter_idle(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv,
-						int index)
-{
-	struct cpuidle_state_usage *state_usage = &dev->states_usage[index];
-	struct davinci_ops *ops = cpuidle_get_statedata(state_usage);
-
-	if (ops && ops->enter)
-		ops->enter();
-
-	index = cpuidle_wrap_enter(dev,	drv, index,
-				arm_cpuidle_simple_enter);
-
-	if (ops && ops->exit)
-		ops->exit();
-
-	return index;
-}
-
-static struct cpuidle_driver davinci_idle_driver = {
-	.name			= "cpuidle-davinci",
-	.owner			= THIS_MODULE,
-	.en_core_tk_irqen	= 1,
-	.states[0]		= ARM_CPUIDLE_WFI_STATE,
-	.states[1]		= {
-		.enter			= davinci_enter_idle,
-		.exit_latency		= 10,
-		.target_residency	= 100000,
-		.flags			= CPUIDLE_FLAG_TIME_VALID,
-		.name			= "DDR SR",
-		.desc			= "WFI and DDR Self Refresh",
-	},
-	.state_count = DAVINCI_CPUIDLE_MAX_STATES,
-};
-
 static DEFINE_PER_CPU(struct cpuidle_device, davinci_cpuidle_device);
 static void __iomem *ddr2_reg_base;
 static bool ddr2_pdown = false;
@@ -107,6 +71,42 @@ static struct davinci_ops davinci_states[DAVINCI_CPUIDLE_MAX_STATES] = {
 	},
 };
 
+/* Actual code that puts the SoC in different idle states */
+static int davinci_enter_idle(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv,
+						int index)
+{
+	struct cpuidle_state_usage *state_usage = &dev->states_usage[index];
+	struct davinci_ops *ops = cpuidle_get_statedata(state_usage);
+
+	if (ops && ops->enter)
+		ops->enter();
+
+	index = cpuidle_wrap_enter(dev,	drv, index,
+				arm_cpuidle_simple_enter);
+
+	if (ops && ops->exit)
+		ops->exit();
+
+	return index;
+}
+
+static struct cpuidle_driver davinci_idle_driver = {
+	.name			= "cpuidle-davinci",
+	.owner			= THIS_MODULE,
+	.en_core_tk_irqen	= 1,
+	.states[0]		= ARM_CPUIDLE_WFI_STATE,
+	.states[1]		= {
+		.enter			= davinci_enter_idle,
+		.exit_latency		= 10,
+		.target_residency	= 100000,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "DDR SR",
+		.desc			= "WFI and DDR Self Refresh",
+	},
+	.state_count = DAVINCI_CPUIDLE_MAX_STATES,
+};
+
 static int __init davinci_cpuidle_probe(struct platform_device *pdev)
 {
 	int ret;
-- 
1.7.9.5

