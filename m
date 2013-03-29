From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 5/9] ARM: tegra2: cpuidle: change driver initialization
Date: Fri, 29 Mar 2013 11:31:31 +0100
Message-ID: <1364553095-25110-5-git-send-email-daniel.lezcano@linaro.org>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:60233 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab3C2Kbs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 Mar 2013 06:31:48 -0400
Received: by mail-we0-f169.google.com with SMTP id x43so271997wey.28
        for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2013 03:31:47 -0700 (PDT)
In-Reply-To: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com, swarren@wwwdotorg.org, linux-tegra@vger.kernel.org, horms+renesas@verge.net.au, santosh.shilimkar@ti.com, arnd@arndb.de, lenb@kernel.org, nsekhar@ti.com

Initialize the idle states directly in the driver structure.

That prevents extra structure declaration and memcpy at init time.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-tegra/cpuidle-tegra20.c |   40 ++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index 825ced4..1ad1a67 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -43,28 +43,32 @@ static atomic_t abort_barrier;
 static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
 				    struct cpuidle_driver *drv,
 				    int index);
+#define TEGRA20_MAX_STATES 2
+#else
+#define TEGRA20_MAX_STATES 1
 #endif
 
-static struct cpuidle_state tegra_idle_states[] = {
-	[0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
-#ifdef CONFIG_PM_SLEEP
-	[1] = {
-		.enter			= tegra20_idle_lp2_coupled,
-		.exit_latency		= 5000,
-		.target_residency	= 10000,
-		.power_usage		= 0,
-		.flags			= CPUIDLE_FLAG_TIME_VALID |
-					  CPUIDLE_FLAG_COUPLED,
-		.name			= "powered-down",
-		.desc			= "CPU power gated",
-	},
-#endif
-};
-
 static struct cpuidle_driver tegra_idle_driver = {
 	.name = "tegra_idle",
 	.owner = THIS_MODULE,
 	.en_core_tk_irqen = 1,
+	.states = {
+		ARM_CPUIDLE_WFI_STATE_PWR(600),
+#ifdef CONFIG_PM_SLEEP
+		{
+			.enter            = tegra20_idle_lp2_coupled,
+			.exit_latency     = 5000,
+			.target_residency = 10000,
+			.power_usage      = 0,
+			.flags            = CPUIDLE_FLAG_TIME_VALID |
+			CPUIDLE_FLAG_COUPLED,
+			.name             = "powered-down",
+			.desc             = "CPU power gated",
+		},
+#endif
+	},
+	.state_count = TEGRA20_MAX_STATES,
+	.safe_state_index = 0,
 };
 
 static DEFINE_PER_CPU(struct cpuidle_device, tegra_idle_device);
@@ -226,10 +230,6 @@ int __init tegra20_cpuidle_init(void)
 	tegra_tear_down_cpu = tegra20_tear_down_cpu;
 #endif
 
-	drv->state_count = ARRAY_SIZE(tegra_idle_states);
-	memcpy(drv->states, tegra_idle_states,
-			drv->state_count * sizeof(drv->states[0]));
-
 	ret = cpuidle_register_driver(&tegra_idle_driver);
 	if (ret) {
 		pr_err("CPUidle driver registration failed\n");
-- 
1.7.9.5

