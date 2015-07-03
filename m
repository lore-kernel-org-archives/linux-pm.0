From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v3 2/4] ARM: mvebu: Add standby support
Date: Fri,  3 Jul 2015 13:55:51 +0200
Message-ID: <1435924553-22428-3-git-send-email-gregory.clement@free-electrons.com>
References: <1435924553-22428-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:34756 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754851AbbGCL4R (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2015 07:56:17 -0400
In-Reply-To: <1435924553-22428-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Until now only one Armada XP and one Armada 388 based board supported
suspend to ram. However, most of the recent mvebu SoCs can support the
standby mode. Unlike for the suspend to ram, nothing special has to be
done for these SoCs. This patch allows the system to use the standby
mode on Armada 370, 38x, 39x and XP SoCs. There are issues with the
Armada 375, and the support might be added (if possible) in a future
patch.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/common.h   |  4 ++--
 arch/arm/mach-mvebu/pm-board.c | 12 ++++++++--
 arch/arm/mach-mvebu/pm.c       | 52 +++++++++++++++++++++++++++++++++++-------
 3 files changed, 56 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index 3e0aca1f288a..6b775492cfad 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -25,6 +25,6 @@ int mvebu_system_controller_get_soc_id(u32 *dev, u32 *rev);
 
 void __iomem *mvebu_get_scu_base(void);
 
-int mvebu_pm_init(void (*board_pm_enter)(void __iomem *sdram_reg, u32 srcmd));
-
+int mvebu_pm_suspend_init(void (*board_pm_enter)(void __iomem *sdram_reg,
+							u32 srcmd));
 #endif
diff --git a/arch/arm/mach-mvebu/pm-board.c b/arch/arm/mach-mvebu/pm-board.c
index acc69e369c8b..16a4b480c16a 100644
--- a/arch/arm/mach-mvebu/pm-board.c
+++ b/arch/arm/mach-mvebu/pm-board.c
@@ -135,11 +135,19 @@ static int __init mvebu_armada_pm_init(void)
 	if (!gpio_ctrl)
 		return -ENOMEM;
 
-	mvebu_pm_init(mvebu_armada_pm_enter);
+	mvebu_pm_suspend_init(mvebu_armada_pm_enter);
 
 out:
 	of_node_put(np);
 	return ret;
 }
 
-late_initcall(mvebu_armada_pm_init);
+/*
+ * Registering the mvebu_board_pm_enter callback must be done before
+ * the platform_suspend_ops will be registered. In the same time we
+ * also need to have the gpio devices registered. That's why we use a
+ * device_initcall_sync which is called after all the device_initcall
+ * (used by the gpio device) but before the late_initcall (used to
+ * register the platform_suspend_ops)
+ */
+device_initcall_sync(mvebu_armada_pm_init);
diff --git a/arch/arm/mach-mvebu/pm.c b/arch/arm/mach-mvebu/pm.c
index f249c8e04bd4..db31cbb6e2c8 100644
--- a/arch/arm/mach-mvebu/pm.c
+++ b/arch/arm/mach-mvebu/pm.c
@@ -204,13 +204,10 @@ static int mvebu_pm_store_bootinfo(void)
 	return 0;
 }
 
-static int mvebu_pm_enter(suspend_state_t state)
+static int mvebu_enter_suspend(void)
 {
 	int ret;
 
-	if (state != PM_SUSPEND_MEM)
-		return -EINVAL;
-
 	ret = mvebu_pm_store_bootinfo();
 	if (ret)
 		return ret;
@@ -226,16 +223,57 @@ static int mvebu_pm_enter(suspend_state_t state)
 	set_cpu_coherent();
 
 	cpu_pm_exit();
+	return 0;
+}
+
+static int mvebu_pm_enter(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		cpu_do_idle();
+		break;
+	case PM_SUSPEND_MEM:
+		return mvebu_enter_suspend();
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int mvebu_pm_valid(suspend_state_t state)
+{
+	if (state == PM_SUSPEND_STANDBY)
+		return 1;
+
+	if (state == PM_SUSPEND_MEM && mvebu_board_pm_enter != NULL)
+		return 1;
 
 	return 0;
 }
 
 static const struct platform_suspend_ops mvebu_pm_ops = {
 	.enter = mvebu_pm_enter,
-	.valid = suspend_valid_only_mem,
+	.valid = mvebu_pm_valid,
 };
 
-int __init mvebu_pm_init(void (*board_pm_enter)(void __iomem *sdram_reg, u32 srcmd))
+static int __init mvebu_pm_init(void)
+{
+	if (!of_machine_is_compatible("marvell,armadaxp") &&
+	    !of_machine_is_compatible("marvell,armada370") &&
+	    !of_machine_is_compatible("marvell,armada380") &&
+	    !of_machine_is_compatible("marvell,armada390"))
+		return -ENODEV;
+
+	suspend_set_ops(&mvebu_pm_ops);
+
+	return 0;
+}
+
+
+late_initcall(mvebu_pm_init);
+
+int __init mvebu_pm_suspend_init(void (*board_pm_enter)(void __iomem *sdram_reg,
+							u32 srcmd))
 {
 	struct device_node *np;
 	struct resource res;
@@ -267,7 +305,5 @@ int __init mvebu_pm_init(void (*board_pm_enter)(void __iomem *sdram_reg, u32 src
 
 	mvebu_board_pm_enter = board_pm_enter;
 
-	suspend_set_ops(&mvebu_pm_ops);
-
 	return 0;
 }
-- 
2.1.0

