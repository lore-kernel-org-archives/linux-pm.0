From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v2 2/4] ARM: mvebu: Add standby support
Date: Tue, 30 Jun 2015 19:18:58 +0200
Message-ID: <1435684740-24912-3-git-send-email-gregory.clement@free-electrons.com>
References: <1435684740-24912-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:50944 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751080AbbF3RUd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2015 13:20:33 -0400
In-Reply-To: <1435684740-24912-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Until now only one Armada XP and one Armada 388 based board supported
suspend to ram. However, most of the recent mvebu SoCs can support the
standby mode. Unlike for the suspend to ram, nothing special have to
be done for these SoCs. This patch allows the system to use the
standby mode on Armada 370, 38x, 39x and XP SoCs. There are issues
with the Armada 375, and the support would be added (if possible) in a
future patch.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/common.h   |  5 ++--
 arch/arm/mach-mvebu/pm-board.c | 17 ++++++++-----
 arch/arm/mach-mvebu/pm.c       | 57 ++++++++++++++++++++++++++++++++++++------
 3 files changed, 64 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index 3e0aca1f288a..341d35d7185a 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -25,6 +25,7 @@ int mvebu_system_controller_get_soc_id(u32 *dev, u32 *rev);
 
 void __iomem *mvebu_get_scu_base(void);
 
-int mvebu_pm_init(void (*board_pm_enter)(void __iomem *sdram_reg, u32 srcmd));
-
+int mvebu_pm_suspend_init(void (*board_pm_enter)(void __iomem *sdram_reg,
+							u32 srcmd));
+void mvebu_pm_register_init(int (*board_pm_init)(void));
 #endif
diff --git a/arch/arm/mach-mvebu/pm-board.c b/arch/arm/mach-mvebu/pm-board.c
index acc69e369c8b..b471a0421262 100644
--- a/arch/arm/mach-mvebu/pm-board.c
+++ b/arch/arm/mach-mvebu/pm-board.c
@@ -82,10 +82,6 @@ static int __init mvebu_armada_pm_init(void)
 	struct device_node *gpio_ctrl_np;
 	int ret = 0, i;
 
-	if (!of_machine_is_compatible("marvell,axp-gp") &&
-	    !of_machine_is_compatible("marvell,a388-gp"))
-		return -ENODEV;
-
 	np = of_find_node_by_name(NULL, "pm_pic");
 	if (!np)
 		return -ENODEV;
@@ -135,11 +131,20 @@ static int __init mvebu_armada_pm_init(void)
 	if (!gpio_ctrl)
 		return -ENOMEM;
 
-	mvebu_pm_init(mvebu_armada_pm_enter);
+	mvebu_pm_suspend_init(mvebu_armada_pm_enter);
 
 out:
 	of_node_put(np);
 	return ret;
 }
 
-late_initcall(mvebu_armada_pm_init);
+int __init mvebu_armada_pm_register(void)
+{
+	if (of_machine_is_compatible("marvell,axp-gp") ||
+		of_machine_is_compatible("marvell,a388-gp"))
+		mvebu_pm_register_init(mvebu_armada_pm_init);
+
+	return 0;
+}
+
+arch_initcall(mvebu_armada_pm_register);
diff --git a/arch/arm/mach-mvebu/pm.c b/arch/arm/mach-mvebu/pm.c
index f249c8e04bd4..264073a777d8 100644
--- a/arch/arm/mach-mvebu/pm.c
+++ b/arch/arm/mach-mvebu/pm.c
@@ -34,6 +34,8 @@
 
 static void (*mvebu_board_pm_enter)(void __iomem *sdram_reg, u32 srcmd);
 static void __iomem *sdram_ctrl;
+static bool is_suspend_mem_available;
+static int (*mvebu_board_pm_init)(void);
 
 static int mvebu_pm_powerdown(unsigned long data)
 {
@@ -204,13 +206,10 @@ static int mvebu_pm_store_bootinfo(void)
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
@@ -226,16 +225,58 @@ static int mvebu_pm_enter(suspend_state_t state)
 	set_cpu_coherent();
 
 	cpu_pm_exit();
+	return 0;
+}
 
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
 	return 0;
 }
 
+static int mvebu_pm_valid(suspend_state_t state)
+{
+	return ((state == PM_SUSPEND_STANDBY) ||
+		(is_suspend_mem_available && (state == PM_SUSPEND_MEM)));
+}
+
 static const struct platform_suspend_ops mvebu_pm_ops = {
 	.enter = mvebu_pm_enter,
-	.valid = suspend_valid_only_mem,
+	.valid = mvebu_pm_valid,
 };
 
-int __init mvebu_pm_init(void (*board_pm_enter)(void __iomem *sdram_reg, u32 srcmd))
+void __init mvebu_pm_register_init(int (*board_pm_init)(void))
+{
+	mvebu_board_pm_init = board_pm_init;
+}
+
+static int __init mvebu_pm_init(void)
+{
+
+	if (!of_machine_is_compatible("marvell,armadaxp") &&
+			!of_machine_is_compatible("marvell,armada370") &&
+			!of_machine_is_compatible("marvell,armada380") &&
+			!of_machine_is_compatible("marvell,armada390"))
+		return -ENODEV;
+
+	if (mvebu_board_pm_init)
+		if (mvebu_board_pm_init())
+			pr_warn("Registering suspend init for this board failed\n");
+	suspend_set_ops(&mvebu_pm_ops);
+
+	return 0;
+}
+
+int __init mvebu_pm_suspend_init(void (*board_pm_enter)(void __iomem *sdram_reg,
+								u32 srcmd))
 {
 	struct device_node *np;
 	struct resource res;
@@ -267,7 +308,9 @@ int __init mvebu_pm_init(void (*board_pm_enter)(void __iomem *sdram_reg, u32 src
 
 	mvebu_board_pm_enter = board_pm_enter;
 
-	suspend_set_ops(&mvebu_pm_ops);
+	is_suspend_mem_available = true;
 
 	return 0;
 }
+
+late_initcall(mvebu_pm_init);
-- 
2.1.0

