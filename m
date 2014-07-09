From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv2 14/17] cpuidle: mvebu: add Armada 38x support
Date: Wed,  9 Jul 2014 15:40:18 +0200
Message-ID: <1404913221-17343-15-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47389 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755676AbaGINkr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jul 2014 09:40:47 -0400
In-Reply-To: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

This commit adds the list of cpuidle states supported by the Armada
38x SoC in the cpuidle-mvebu-v7 driver, as well as the necessary logic
around it to support this SoC.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/cpuidle/cpuidle-mvebu-v7.c | 19 ++++++++++++++++++-
 include/linux/mvebu-v7-cpuidle.h   |  1 +
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-mvebu-v7.c b/drivers/cpuidle/cpuidle-mvebu-v7.c
index 5de147f..8bfac4d 100644
--- a/drivers/cpuidle/cpuidle-mvebu-v7.c
+++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
@@ -1,5 +1,5 @@
 /*
- * Marvell Armada 370 and Armada XP SoC cpuidle driver
+ * Marvell Armada 370, 38x and XP SoC cpuidle driver
  *
  * Copyright (C) 2014 Marvell
  *
@@ -88,6 +88,21 @@ static struct cpuidle_driver armada370_cpuidle_driver = {
 	.state_count = 2,
 };
 
+static struct cpuidle_driver armada38x_cpuidle_driver = {
+	.name			= "armada_38x_idle",
+	.states[0]		= ARM_CPUIDLE_WFI_STATE,
+	.states[1]		= {
+		.enter			= mvebu_v7_enter_idle,
+		.exit_latency		= 10,
+		.power_usage		= 5,
+		.target_residency	= 100,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "Idle",
+		.desc			= "CPU and SCU power down",
+	},
+	.state_count = 2,
+};
+
 static int mvebu_v7_cpuidle_probe(struct platform_device *pdev)
 {
 	struct cpuidle_driver *drv;
@@ -98,6 +113,8 @@ static int mvebu_v7_cpuidle_probe(struct platform_device *pdev)
 		drv = &armadaxp_cpuidle_driver;
 	else if (pcpuidle->type == CPUIDLE_ARMADA_370)
 		drv = &armada370_cpuidle_driver;
+	else if (pcpuidle->type == CPUIDLE_ARMADA_38X)
+		drv = &armada38x_cpuidle_driver;
 	else
 		return -EINVAL;
 
diff --git a/include/linux/mvebu-v7-cpuidle.h b/include/linux/mvebu-v7-cpuidle.h
index 6d54ae1..73f6d32 100644
--- a/include/linux/mvebu-v7-cpuidle.h
+++ b/include/linux/mvebu-v7-cpuidle.h
@@ -17,6 +17,7 @@
 enum mvebu_v7_cpuidle_types {
 	CPUIDLE_ARMADA_XP,
 	CPUIDLE_ARMADA_370,
+	CPUIDLE_ARMADA_38X,
 };
 
 struct mvebu_v7_cpuidle {
-- 
2.0.0

