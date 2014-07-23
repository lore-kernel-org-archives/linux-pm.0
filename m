From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv3 06/16] ARM: mvebu: make the cpuidle initialization more generic
Date: Wed, 23 Jul 2014 15:00:43 +0200
Message-ID: <1406120453-29291-7-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1406120453-29291-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:40689 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751513AbaGWNBD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jul 2014 09:01:03 -0400
In-Reply-To: <1406120453-29291-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

In preparation to the addition of the cpuidle support for more SoCs,
this patch moves the Armada XP specific initialization to a separate
function.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 501d450..e976c3e 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -311,31 +311,39 @@ static struct notifier_block mvebu_v7_cpu_pm_notifier = {
 	.notifier_call = mvebu_v7_cpu_pm_notify,
 };
 
-static int __init mvebu_v7_cpu_pm_init(void)
+static int __init armada_xp_cpuidle_init(void)
 {
 	struct device_node *np;
 
-	/*
-	 * Check that all the requirements are available to enable
-	 * cpuidle. So far, it is only supported on Armada XP, cpuidle
-	 * needs the coherency fabric and the PMSU enabled
-	 */
-
-	if (!of_machine_is_compatible("marvell,armadaxp"))
-		return 0;
-
 	np = of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric");
 	if (!np)
-		return 0;
+		return -ENODEV;
 	of_node_put(np);
 
+	mvebu_v7_cpuidle_device.dev.platform_data = armada_370_xp_cpu_suspend;
+
+	return 0;
+}
+
+static int __init mvebu_v7_cpu_pm_init(void)
+{
+	struct device_node *np;
+	int ret;
+
 	np = of_find_matching_node(NULL, of_pmsu_table);
 	if (!np)
 		return 0;
 	of_node_put(np);
 
+	if (of_machine_is_compatible("marvell,armadaxp"))
+		ret = armada_xp_cpuidle_init();
+	else
+		return 0;
+
+	if (ret)
+		return ret;
+
 	mvebu_v7_pmsu_enable_l2_powerdown_onidle();
-	mvebu_v7_cpuidle_device.dev.platform_data = armada_370_xp_cpu_suspend;
 	platform_device_register(&mvebu_v7_cpuidle_device);
 	cpu_pm_register_notifier(&mvebu_v7_cpu_pm_notifier);
 
-- 
2.0.0

