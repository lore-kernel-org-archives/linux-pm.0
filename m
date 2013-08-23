From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 08/12] ARM: mvebu: Allow to power down L2 cache controller in idle mode
Date: Fri, 23 Aug 2013 08:53:13 +0200
Message-ID: <1377240797-4047-9-git-send-email-gregory.clement@free-electrons.com>
References: <1377240797-4047-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47892 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754871Ab3HWGxm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2013 02:53:42 -0400
In-Reply-To: <1377240797-4047-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Lior Amsalem <alior@marvell.com>, Maen Suleiman <maen@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Eran Ben-Avi <benavi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ike Pan <ike.pan@canonical.com>, Chris Van Hoof <vanhoof@canonical.com>, Dan Frazier <dann.frazier@canonical.com>, Leif Lindholm <leif.lindholm@arm.com>, Jon Masters <jcm@redhat.com>, David Marlin <dmarlin@redhat.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Atsushi Yamagata <yamagata@plathome.co.jp>, Hironobu Shibata <h-shibata@plathome.co.jp>, Tomonori Kimura <kimura@plathome.co.jp>

This commit adds an exported function which allows to power down the
L2 cache controller and the Coherency Fabric when the CPU goes into
deep idle mode.

This feature is part of the Power Management Service Unit of the
Armada 370 and Armada XP SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c         | 14 ++++++++++++++
 include/linux/armada-370-xp-pmsu.h | 16 ++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 include/linux/armada-370-xp-pmsu.h

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 1d147fe..bb7f606 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -30,6 +30,9 @@ static void __iomem *pmsu_fabric_base;
 #define PMSU_BOOT_ADDR_REDIRECT_OFFSET(cpu)	((cpu * 0x100) + 0x24)
 #define PMSU_RESET_CTL_OFFSET(cpu)		(cpu * 0x8)
 
+#define L2C_NFABRIC_PM_CTL		    0x4
+#define L2C_NFABRIC_PM_CTL_PWR_DOWN	    (1 << 20)
+
 static struct of_device_id of_pmsu_table[] = {
 	{.compatible = "marvell,armada-370-xp-pmsu"},
 	{ /* end of list */ },
@@ -77,4 +80,15 @@ int __init armada_370_xp_pmsu_init(void)
 	return 0;
 }
 
+void armada_370_xp_pmsu_enable_l2_powerdown_onidle(void)
+{
+	int reg;
+
+	/* Enable L2 & Fabric powerdown in Deep-Idle mode - Fabric */
+	reg = readl(pmsu_fabric_base + L2C_NFABRIC_PM_CTL);
+	reg |= L2C_NFABRIC_PM_CTL_PWR_DOWN;
+	writel(reg, pmsu_fabric_base + L2C_NFABRIC_PM_CTL);
+}
+EXPORT_SYMBOL_GPL(armada_370_xp_pmsu_enable_l2_powerdown_onidle);
+
 early_initcall(armada_370_xp_pmsu_init);
diff --git a/include/linux/armada-370-xp-pmsu.h b/include/linux/armada-370-xp-pmsu.h
new file mode 100644
index 0000000..f85cbf7
--- /dev/null
+++ b/include/linux/armada-370-xp-pmsu.h
@@ -0,0 +1,16 @@
+/*
+ * Power Management Service Unit (PMSU) support for Armada 370/XP platforms.
+ *
+ * Copyright (C) 2013 Marvell
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ARMADA_370_XP__PMSU_H
+#define __ARMADA_370_XP__PMSU_H
+
+void armada_370_xp_pmsu_enable_l2_powerdown_onidle(void);
+
+#endif	/* __ARMADA_370_XP__PMSU_H */
-- 
1.8.1.2

