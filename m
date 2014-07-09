From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv2 13/17] cpuidle: mvebu: add Armada 370 support
Date: Wed,  9 Jul 2014 15:40:17 +0200
Message-ID: <1404913221-17343-14-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47370 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755577AbaGINkp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jul 2014 09:40:45 -0400
In-Reply-To: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

This commit adds the list of cpuidle states supported by the Armada
370 SoC in the cpuidle-mvebu-v7 driver, as well as the necessary logic
around it to support this SoC.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/cpuidle/cpuidle-mvebu-v7.c | 18 ++++++++++++++++++
 include/linux/mvebu-v7-cpuidle.h   |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-mvebu-v7.c b/drivers/cpuidle/cpuidle-mvebu-v7.c
index 82c545bb..5de147f 100644
--- a/drivers/cpuidle/cpuidle-mvebu-v7.c
+++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
@@ -72,6 +72,22 @@ static struct cpuidle_driver armadaxp_cpuidle_driver = {
 	.state_count = 3,
 };
 
+static struct cpuidle_driver armada370_cpuidle_driver = {
+	.name			= "armada_370_idle",
+	.states[0]		= ARM_CPUIDLE_WFI_STATE,
+	.states[1]		= {
+		.enter			= mvebu_v7_enter_idle,
+		.exit_latency		= 100,
+		.power_usage		= 5,
+		.target_residency	= 1000,
+		.flags			= (CPUIDLE_FLAG_TIME_VALID |
+					   MVEBU_V7_FLAG_DEEP_IDLE),
+		.name			= "Deep Idle",
+		.desc			= "CPU and L2 Fabric power down",
+	},
+	.state_count = 2,
+};
+
 static int mvebu_v7_cpuidle_probe(struct platform_device *pdev)
 {
 	struct cpuidle_driver *drv;
@@ -80,6 +96,8 @@ static int mvebu_v7_cpuidle_probe(struct platform_device *pdev)
 
 	if (pcpuidle->type == CPUIDLE_ARMADA_XP)
 		drv = &armadaxp_cpuidle_driver;
+	else if (pcpuidle->type == CPUIDLE_ARMADA_370)
+		drv = &armada370_cpuidle_driver;
 	else
 		return -EINVAL;
 
diff --git a/include/linux/mvebu-v7-cpuidle.h b/include/linux/mvebu-v7-cpuidle.h
index 00fde86..6d54ae1 100644
--- a/include/linux/mvebu-v7-cpuidle.h
+++ b/include/linux/mvebu-v7-cpuidle.h
@@ -16,6 +16,7 @@
 
 enum mvebu_v7_cpuidle_types {
 	CPUIDLE_ARMADA_XP,
+	CPUIDLE_ARMADA_370,
 };
 
 struct mvebu_v7_cpuidle {
-- 
2.0.0

