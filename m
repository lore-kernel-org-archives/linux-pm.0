From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv3 12/16] cpuidle: mvebu: add Armada 370 support
Date: Wed, 23 Jul 2014 15:00:49 +0200
Message-ID: <1406120453-29291-13-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1406120453-29291-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:40741 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753813AbaGWNBJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jul 2014 09:01:09 -0400
In-Reply-To: <1406120453-29291-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

This commit adds the list of cpuidle states supported by the Armada
370 SoC in the cpuidle-mvebu-v7 driver, as well as the necessary logic
around it to support this SoC.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/cpuidle/cpuidle-mvebu-v7.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-mvebu-v7.c b/drivers/cpuidle/cpuidle-mvebu-v7.c
index 7252fd8..d23597f 100644
--- a/drivers/cpuidle/cpuidle-mvebu-v7.c
+++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
@@ -70,11 +70,32 @@ static struct cpuidle_driver armadaxp_idle_driver = {
 	.state_count = 3,
 };
 
+static struct cpuidle_driver armada370_idle_driver = {
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
-
 	mvebu_v7_cpu_suspend = pdev->dev.platform_data;
-	return cpuidle_register(&armadaxp_idle_driver, NULL);
+
+	if (!strcmp(pdev->dev.driver->name, "cpuidle-armada-xp"))
+		return cpuidle_register(&armadaxp_idle_driver, NULL);
+	else if (!strcmp(pdev->dev.driver->name, "cpuidle-armada-370"))
+		return cpuidle_register(&armada370_idle_driver, NULL);
+	else
+		return -EINVAL;
 }
 
 static struct platform_driver armadaxp_cpuidle_plat_driver = {
@@ -87,6 +108,16 @@ static struct platform_driver armadaxp_cpuidle_plat_driver = {
 
 module_platform_driver(armadaxp_cpuidle_plat_driver);
 
+static struct platform_driver armada370_cpuidle_plat_driver = {
+	.driver = {
+		.name = "cpuidle-armada-370",
+		.owner = THIS_MODULE,
+	},
+	.probe = mvebu_v7_cpuidle_probe,
+};
+
+module_platform_driver(armada370_cpuidle_plat_driver);
+
 MODULE_AUTHOR("Gregory CLEMENT <gregory.clement@free-electrons.com>");
 MODULE_DESCRIPTION("Marvell EBU v7 cpuidle driver");
 MODULE_LICENSE("GPL");
-- 
2.0.0

