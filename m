From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 3/4] SH: cpuidle: initialize the driver's states directly
Date: Wed, 17 Apr 2013 15:32:56 +0200
Message-ID: <1366205577-11632-3-git-send-email-daniel.lezcano@linaro.org>
References: <1366205577-11632-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:51544 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966258Ab3DQNdK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Apr 2013 09:33:10 -0400
Received: by mail-we0-f177.google.com with SMTP id o7so1209747wea.8
        for <linux-pm@vger.kernel.org>; Wed, 17 Apr 2013 06:33:09 -0700 (PDT)
In-Reply-To: <1366205577-11632-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lethal@linux-sh.org, rjw@sisk.pl
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, patches@linaro.org

Like all the other drivers, let's initialize the structure a compile time
instead of init time.

The states #1 and #2 are not enabled by default. The init function will
check the features of the board in order to enable the state.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/sh/kernel/cpu/shmobile/cpuidle.c |   90 +++++++++++++++------------------
 1 file changed, 41 insertions(+), 49 deletions(-)

diff --git a/arch/sh/kernel/cpu/shmobile/cpuidle.c b/arch/sh/kernel/cpu/shmobile/cpuidle.c
index 36374cc..f024acf 100644
--- a/arch/sh/kernel/cpu/shmobile/cpuidle.c
+++ b/arch/sh/kernel/cpu/shmobile/cpuidle.c
@@ -53,59 +53,51 @@ static int cpuidle_sleep_enter(struct cpuidle_device *dev,
 
 static struct cpuidle_device cpuidle_dev;
 static struct cpuidle_driver cpuidle_driver = {
-	.name			= "sh_idle",
-	.owner			= THIS_MODULE,
+	.name   = "sh_idle",
+	.owner  = THIS_MODULE,
+	.states = {
+		{
+			.exit_latency = 1,
+			.target_residency = 1 * 2,
+			.power_usage = 3,
+			.flags = CPUIDLE_FLAG_TIME_VALID,
+			.enter = cpuidle_sleep_enter,
+			.name = "C1",
+			.desc = "SuperH Sleep Mode",
+		},
+		{
+			.exit_latency = 100,
+			.target_residency = 1 * 2,
+			.power_usage = 1,
+			.flags = CPUIDLE_FLAG_TIME_VALID,
+			.enter = cpuidle_sleep_enter,
+			.name = "C2",
+			.desc = "SuperH Sleep Mode [SF]",
+			.disabled = true,
+		},
+		{
+			.exit_latency = 2300,
+			.target_residency = 1 * 2,
+			.power_usage = 1,
+			.flags = CPUIDLE_FLAG_TIME_VALID,
+			.enter = cpuidle_sleep_enter,
+			.name = "C3",
+			.desc = "SuperH Mobile Standby Mode [SF]",
+			.disabled = true,
+		},
+	},
+	.safe_state_index = 0,
+	.state_count = 3,
 };
 
 void sh_mobile_setup_cpuidle(void)
 {
-	struct cpuidle_device *dev = &cpuidle_dev;
-	struct cpuidle_driver *drv = &cpuidle_driver;
-	struct cpuidle_state *state;
-	int i = 0;
+	if (sh_mobile_sleep_supported & SUSP_SH_SF)
+		cpuidle_driver.states[1].disabled = false;
 
-	state = &drv->states[i++];
-	snprintf(state->name, CPUIDLE_NAME_LEN, "C1");
-	strncpy(state->desc, "SuperH Sleep Mode", CPUIDLE_DESC_LEN);
-	state->exit_latency = 1;
-	state->target_residency = 1 * 2;
-	state->power_usage = 3;
-	state->flags = 0;
-	state->flags |= CPUIDLE_FLAG_TIME_VALID;
-	state->enter = cpuidle_sleep_enter;
+	if (sh_mobile_sleep_supported & SUSP_SH_STANDBY)
+		cpuidle_driver.states[2].disabled = false;
 
-	drv->safe_state_index = 0;
-
-	if (sh_mobile_sleep_supported & SUSP_SH_SF) {
-		state = &drv->states[i++];
-		snprintf(state->name, CPUIDLE_NAME_LEN, "C2");
-		strncpy(state->desc, "SuperH Sleep Mode [SF]",
-			CPUIDLE_DESC_LEN);
-		state->exit_latency = 100;
-		state->target_residency = 1 * 2;
-		state->power_usage = 1;
-		state->flags = 0;
-		state->flags |= CPUIDLE_FLAG_TIME_VALID;
-		state->enter = cpuidle_sleep_enter;
-	}
-
-	if (sh_mobile_sleep_supported & SUSP_SH_STANDBY) {
-		state = &drv->states[i++];
-		snprintf(state->name, CPUIDLE_NAME_LEN, "C3");
-		strncpy(state->desc, "SuperH Mobile Standby Mode [SF]",
-			CPUIDLE_DESC_LEN);
-		state->exit_latency = 2300;
-		state->target_residency = 1 * 2;
-		state->power_usage = 1;
-		state->flags = 0;
-		state->flags |= CPUIDLE_FLAG_TIME_VALID;
-		state->enter = cpuidle_sleep_enter;
-	}
-
-	drv->state_count = i;
-	dev->state_count = i;
-
-	cpuidle_register_driver(&cpuidle_driver);
-
-	cpuidle_register_device(dev);
+	if (!cpuidle_register_driver(&cpuidle_driver))
+		cpuidle_register_device(&cpuidle_dev);
 }
-- 
1.7.9.5

