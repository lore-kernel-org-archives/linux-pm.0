From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v7 11/11] ARM: mvebu: register the cpuidle driver for the Armada XP SoCs
Date: Mon, 14 Apr 2014 17:10:14 +0200
Message-ID: <1397488214-20685-12-git-send-email-gregory.clement@free-electrons.com>
References: <1397488214-20685-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397488214-20685-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The cpuidle is a platform driver so we register the device just after
the initialization of the board in an arch_initcall.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 9ea2bb44d573..e105e33cf3f0 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/of_address.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
 #include <linux/smp.h>
 #include <linux/resource.h>
 #include <asm/cacheflush.h>
@@ -65,6 +66,10 @@ static void __iomem *pmsu_mp_base;
 extern void ll_disable_coherency(void);
 extern void ll_enable_coherency(void);
 
+static struct platform_device armada_xp_cpuidle_device = {
+	.name = "cpuidle-armada-370-xp",
+};
+
 static struct of_device_id of_pmsu_table[] = {
 	{ .compatible = "marvell,armada-370-pmsu", },
 	{ .compatible = "marvell,armada-370-xp-pmsu", },
@@ -281,4 +286,36 @@ static struct notifier_block armada_370_xp_cpu_pm_notifier = {
 	.notifier_call = armada_370_xp_cpu_pm_notify,
 };
 
+int __init armada_370_xp_cpu_pm_init(void)
+{
+	struct device_node *np;
+
+	/*
+	 * Check that all the requirements are available to enable
+	 * cpuidle. So far, it is only supported on Armada XP, cpuidle
+	 * needs the coherency fabric and the PMSU enabled
+	 */
+
+	if (!of_machine_is_compatible("marvell,armadaxp"))
+		return 0;
+
+	np = of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric");
+	if (!np)
+		return 0;
+	of_node_put(np);
+
+	np = of_find_matching_node(NULL, of_pmsu_table);
+	if (!np)
+		return 0;
+	of_node_put(np);
+
+	armada_370_xp_pmsu_enable_l2_powerdown_onidle();
+	armada_xp_cpuidle_device.dev.platform_data = armada_370_xp_cpu_suspend;
+	platform_device_register(&armada_xp_cpuidle_device);
+	cpu_pm_register_notifier(&armada_370_xp_cpu_pm_notifier);
+
+	return 0;
+}
+
+arch_initcall(armada_370_xp_cpu_pm_init);
 early_initcall(armada_370_xp_pmsu_init);
-- 
1.8.1.2
