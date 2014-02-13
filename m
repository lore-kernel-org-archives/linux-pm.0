From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v4 08/13] ARM: mvebu: Allow to power down L2 cache controller in idle mode
Date: Thu, 13 Feb 2014 18:33:31 +0100
Message-ID: <1392312816-17657-9-git-send-email-gregory.clement@free-electrons.com>
References: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:51913 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752640AbaBMReH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2014 12:34:07 -0500
In-Reply-To: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

This commit adds an function which adjusts the PMSU configuration to
automatically power down the L2 and coherency fabric when we enter a
certain idle state.

This feature is part of the Power Management Service Unit of the
Armada 370 and Armada XP SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 24 ++++++++++++++++++++++--
 arch/arm/mach-mvebu/pmsu.h |  1 +
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index aa5ef7439d0f..36d946d53f54 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -28,8 +28,15 @@ static void __iomem *pmsu_mp_base;
 static void __iomem *pmsu_reset_base;
 static void __iomem *pmsu_fabric_base;
 
-#define PMSU_BOOT_ADDR_REDIRECT_OFFSET(cpu)	((cpu * 0x100) + 0x24)
-#define PMSU_RESET_CTL_OFFSET(cpu)		(cpu * 0x8)
+/* PMSU MP registers */
+#define PMSU_BOOT_ADDR_REDIRECT_OFFSET(cpu) ((cpu * 0x100) + 0x24)
+
+/* PMSU reset registers */
+#define PMSU_RESET_CTL_OFFSET(cpu)	    (cpu * 0x8)
+
+/* PMSU fabric registers */
+#define L2C_NFABRIC_PM_CTL		    0x4
+#define L2C_NFABRIC_PM_CTL_PWR_DOWN		BIT(20)
 
 static struct of_device_id of_pmsu_table[] = {
 	{.compatible = "marvell,armada-370-xp-pmsu"},
@@ -79,4 +86,17 @@ static int __init armada_370_xp_pmsu_init(void)
 	return 0;
 }
 
+void armada_370_xp_pmsu_enable_l2_powerdown_onidle(void)
+{
+	u32 reg;
+
+	if (pmsu_fabric_base == NULL)
+		return;
+
+	/* Enable L2 & Fabric powerdown in Deep-Idle mode - Fabric */
+	reg = readl(pmsu_fabric_base + L2C_NFABRIC_PM_CTL);
+	reg |= L2C_NFABRIC_PM_CTL_PWR_DOWN;
+	writel(reg, pmsu_fabric_base + L2C_NFABRIC_PM_CTL);
+}
+
 early_initcall(armada_370_xp_pmsu_init);
diff --git a/arch/arm/mach-mvebu/pmsu.h b/arch/arm/mach-mvebu/pmsu.h
index 07a737c6b95d..054cdd8b0ece 100644
--- a/arch/arm/mach-mvebu/pmsu.h
+++ b/arch/arm/mach-mvebu/pmsu.h
@@ -12,5 +12,6 @@
 #define __MACH_MVEBU_PMSU_H
 
 int armada_xp_boot_cpu(unsigned int cpu_id, void *phys_addr);
+void armada_370_xp_pmsu_enable_l2_powerdown_onidle(void);
 
 #endif	/* __MACH_370_XP_PMSU_H */
-- 
1.8.1.2

