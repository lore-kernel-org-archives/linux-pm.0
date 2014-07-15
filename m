From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH v3 7/7] PM / devfreq: Add devfreq driver for Exynos5420
Date: Wed, 16 Jul 2014 00:06:08 +0530
Message-ID: <1405449368-26430-1-git-send-email-a.kesavan@samsung.com>
References: <1400779322-4410-8-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:45905 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755891AbaGOSgl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jul 2014 14:36:41 -0400
In-Reply-To: <1400779322-4410-8-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, linux-pm@vger.kernel.org, kgene.kim@samsung.com
Cc: rjw@sisk.pl, t.figa@samsung.com, kesavan.abhilash@gmail.com, devicetree@vger.kernel.org

From: "Arjun.K.V" <arjun.kv@samsung.com>

Exynos5420 bus device devfreq driver monitors PPMU counters and
adjusts INT domain operating frequencies and voltages. Support
for 5420 has been added to the extant 5250 support.

Signed-off-by: Arjun.K.V <arjun.kv@samsung.com>
Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/devfreq/Kconfig              |   10 +-
 drivers/devfreq/exynos/exynos5_bus.c |  598 ++++++++++++++++++++++++++++------
 2 files changed, 508 insertions(+), 100 deletions(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 49e74c1..705f951 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -79,14 +79,14 @@ config ARM_EXYNOS4_BUS_DEVFREQ
 	  This does not yet operate with optimal voltages.
 
 config ARM_EXYNOS5_BUS_DEVFREQ
-	bool "ARM Exynos5250 Bus DEVFREQ Driver"
-	depends on SOC_EXYNOS5250
+	bool "ARM Exynos5 Bus DEVFREQ Driver"
+	depends on (SOC_EXYNOS5250 || SOC_EXYNOS5420)
 	select ARCH_HAS_OPP
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select PM_OPP
 	help
-	  This adds the DEVFREQ driver for Exynos5250 bus interface (vdd_int).
-	  It reads PPMU counters of memory controllers and adjusts the
-	  operating frequencies and voltages with OPP support.
+	  This adds the DEVFREQ driver for Exynos5250/5420 bus interface
+	  (vdd_int). It reads PPMU counters of memory controllers and adjusts
+	  the operating frequencies and voltages with OPP support.
 
 endif # PM_DEVFREQ
diff --git a/drivers/devfreq/exynos/exynos5_bus.c b/drivers/devfreq/exynos/exynos5_bus.c
index 1196653..7ce5b76 100644
--- a/drivers/devfreq/exynos/exynos5_bus.c
+++ b/drivers/devfreq/exynos/exynos5_bus.c
@@ -1,10 +1,10 @@
 /*
- * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2012-14 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
  *
  * EXYNOS5 INT clock frequency scaling support using DEVFREQ framework
  * Based on work done by Jonghwan Choi <jhbird.choi@samsung.com>
- * Support for only EXYNOS5250 is present.
+ * Support for EXYNOS5250 and Exynos5420 is present.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -14,23 +14,28 @@
 
 #include <linux/module.h>
 #include <linux/devfreq.h>
-#include <linux/io.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
 #include <linux/clk.h>
-#include <linux/delay.h>
 #include <linux/platform_device.h>
-#include <linux/pm_qos.h>
 #include <linux/regulator/consumer.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
 
 #include "exynos_ppmu.h"
 
-#define MAX_SAFEVOLT			1100000 /* 1.10V */
-/* Assume that the bus is saturated if the utilization is 25% */
-#define INT_BUS_SATURATION_RATIO	25
+/* Assume that we need to bump up the level if the utilization is 10% */
+#define INT_BUS_SATURATION_RATIO	10
+#define INT_VOLT_STEP_UV		12500
+
+struct exynos5_busfreq_drv_data {
+	int busf_type;
+};
+
+enum exynos5_busf_type {
+	TYPE_BUSF_EXYNOS5250,
+	TYPE_BUSF_EXYNOS5420,
+};
 
 enum int_level_idx {
 	LV_0,
@@ -41,12 +46,31 @@ enum int_level_idx {
 	_LV_END
 };
 
-enum exynos_ppmu_list {
+enum exynos5250_ppmu_list {
+	PPMU_DDR_C,
+	PPMU_DDR_L,
+	PPMU_DDR_R,
 	PPMU_RIGHT,
-	PPMU_END,
+	PPMU_END_5250,
+};
+
+enum exynos5420_ppmu_list {
+	PPMU_DMC_0_1,
+	PPMU_DMC_1_0,
+	PPMU_DMC_1_1,
+	PPMU_END_5420,
+};
+
+enum int_bus_pll {
+	C_PLL = 0,
+	D_PLL,
+	M_PLL,
+	I_PLL,
 };
 
 struct busfreq_data_int {
+	enum exynos5_busf_type type;
+	struct list_head list;
 	struct device *dev;
 	struct devfreq *devfreq;
 	struct regulator *vdd_int;
@@ -56,7 +80,11 @@ struct busfreq_data_int {
 
 	struct notifier_block pm_notifier;
 	struct mutex lock;
-	struct pm_qos_request int_req;
+
+	struct clk *mout_mpll;
+	struct clk *mout_dpll;
+	struct clk *mout_cpll;
+	struct clk *mout_ipll;
 };
 
 struct int_bus_opp_table {
@@ -70,13 +98,29 @@ struct int_clk_table {
 	unsigned long freq;
 };
 
-struct int_clk {
+struct int_simple_clk {
 	const char *clk_name;
 	struct clk *clk;
 	struct int_clk_table *freq_table;
 };
 
-static struct int_bus_opp_table exynos5_int_opp_table[] = {
+struct int_clk_info {
+	unsigned int idx;
+	unsigned long target_freq;
+	enum int_bus_pll src_pll;
+};
+
+struct int_comp_clks {
+	struct list_head node;
+	const char *mux_clk_name;   /* The parent of the div clock */
+	struct clk *mux_clk;
+	const char *div_clk_name;
+	struct clk *div_clk;
+	struct int_clk_info *clk_info;
+};
+
+static struct int_bus_opp_table *exynos5_int_opp_table;
+static struct int_bus_opp_table exynos5250_int_opp_table[] = {
 	{LV_0, 266000, 1025000},
 	{LV_1, 200000, 1025000},
 	{LV_2, 160000, 1025000},
@@ -85,7 +129,16 @@ static struct int_bus_opp_table exynos5_int_opp_table[] = {
 	{0, 0, 0},
 };
 
-static struct int_clk_table aclk_166[] = {
+static struct int_bus_opp_table exynos5420_int_opp_table[] = {
+	{LV_0, 400000, 1100000},
+	{LV_1, 333000, 1100000},
+	{LV_2, 222000, 1100000},
+	{LV_3, 111000, 1100000},
+	{LV_4,  83000, 1100000},
+	{0, 0, 0},
+};
+
+static struct int_clk_table exynos5250_aclk_166[] = {
 	{LV_0, 167000},
 	{LV_1, 111000},
 	{LV_2,  84000},
@@ -93,7 +146,7 @@ static struct int_clk_table aclk_166[] = {
 	{LV_4,  42000},
 };
 
-static struct int_clk_table aclk_200[] = {
+static struct int_clk_table exynos5250_aclk_200[] = {
 	{LV_0, 200000},
 	{LV_1, 160000},
 	{LV_2, 160000},
@@ -101,7 +154,7 @@ static struct int_clk_table aclk_200[] = {
 	{LV_4, 100000},
 };
 
-static struct int_clk_table aclk_266[] = {
+static struct int_clk_table exynos5250_aclk_266[] = {
 	{LV_0, 267000},
 	{LV_1, 200000},
 	{LV_2, 160000},
@@ -109,7 +162,7 @@ static struct int_clk_table aclk_266[] = {
 	{LV_4, 100000},
 };
 
-static struct int_clk_table aclk_333[] = {
+static struct int_clk_table exynos5250_aclk_333[] = {
 	{LV_0, 333000},
 	{LV_1, 167000},
 	{LV_2, 111000},
@@ -117,7 +170,7 @@ static struct int_clk_table aclk_333[] = {
 	{LV_4,  42000},
 };
 
-static struct int_clk_table aclk_300_disp1[] = {
+static struct int_clk_table exynos5250_aclk_300_disp1[] = {
 	{LV_0, 267000},
 	{LV_1, 267000},
 	{LV_2, 267000},
@@ -125,7 +178,7 @@ static struct int_clk_table aclk_300_disp1[] = {
 	{LV_4, 200000},
 };
 
-static struct int_clk_table aclk_300_gscl[] = {
+static struct int_clk_table exynos5250_aclk_300_gscl[] = {
 	{LV_0, 267000},
 	{LV_1, 267000},
 	{LV_2, 267000},
@@ -133,27 +186,183 @@ static struct int_clk_table aclk_300_gscl[] = {
 	{LV_4, 100000},
 };
 
-#define EXYNOS5_INT_CLK(name, tbl) {		\
+#define EXYNOS5250_INT_CLK(name, tbl) {		\
 	.clk_name = name,			\
 	.freq_table = tbl,			\
 }
 
-static struct int_clk exynos5_int_clks[] = {
-	EXYNOS5_INT_CLK("aclk166_d", aclk_166),
-	EXYNOS5_INT_CLK("aclk200_d", aclk_200),
-	EXYNOS5_INT_CLK("aclk266_d", aclk_266),
-	EXYNOS5_INT_CLK("aclk333_d", aclk_333),
-	EXYNOS5_INT_CLK("aclk300_disp1_d", aclk_300_disp1),
-	EXYNOS5_INT_CLK("aclk300_gscl_d", aclk_300_gscl),
+static struct int_simple_clk exynos5250_int_clks[] = {
+	EXYNOS5250_INT_CLK("aclk166_d", exynos5250_aclk_166),
+	EXYNOS5250_INT_CLK("aclk200_d", exynos5250_aclk_200),
+	EXYNOS5250_INT_CLK("aclk266_d", exynos5250_aclk_266),
+	EXYNOS5250_INT_CLK("aclk333_d", exynos5250_aclk_333),
+	EXYNOS5250_INT_CLK("aclk300_disp1_d", exynos5250_aclk_300_disp1),
+	EXYNOS5250_INT_CLK("aclk300_gscl_d", exynos5250_aclk_300_gscl),
+};
+
+static struct int_clk_info exynos5420_aclk_200_fsys[] = {
+	/* Level, Freq, Parent_Pll */
+	{LV_0, 200000, D_PLL},
+	{LV_1, 200000, D_PLL},
+	{LV_2, 150000, D_PLL},
+	{LV_3, 100000, D_PLL},
+	{LV_4, 100000, D_PLL},
+};
+
+static struct int_clk_info exynos5420_pclk_200_fsys[] = {
+	/* Level, Freq, Parent_Pll */
+	{LV_0, 200000, D_PLL},
+	{LV_1, 150000, D_PLL},
+	{LV_2, 150000, D_PLL},
+	{LV_3, 100000, D_PLL},
+	{LV_4, 100000, D_PLL},
+};
+
+static struct int_clk_info exynos5420_aclk_100_noc[] = {
+	/* Level, Freq, Parent_Pll */
+	{LV_0, 100000, D_PLL},
+	{LV_1,  86000, D_PLL},
+	{LV_2,  75000, D_PLL},
+	{LV_3,  75000, D_PLL},
+	{LV_4,  75000, D_PLL},
 };
 
-static int exynos5_int_set_rate(struct busfreq_data_int *data,
+static struct int_clk_info exynos5420_aclk_400_wcore[] = {
+	/* Level, Freq, Parent_Pll */
+	{LV_0, 400000, M_PLL},
+	{LV_1, 333000, C_PLL},
+	{LV_2, 333000, C_PLL},
+	{LV_3, 333000, C_PLL},
+	{LV_4, 333000, C_PLL},
+};
+
+static struct int_clk_info exynos5420_aclk_200_fsys2[] = {
+	/* Level, Freq, Parent_Pll */
+	{LV_0, 200000, D_PLL},
+	{LV_1, 200000, D_PLL},
+	{LV_2, 150000, D_PLL},
+	{LV_3, 100000, D_PLL},
+	{LV_4, 100000, D_PLL},
+};
+
+static struct int_clk_info exynos5420_aclk_400_mscl[] = {
+	/* Level, Freq, Parent_Pll */
+	{LV_0, 400000, M_PLL},
+	{LV_1, 333000, C_PLL},
+	{LV_2, 222000, C_PLL},
+	{LV_3, 167000, C_PLL},
+	{LV_4,  84000, C_PLL},
+};
+
+static struct int_clk_info exynos5420_aclk_166[] = {
+	/* Level, Freq, Parent_Pll */
+	{LV_0, 167000, C_PLL},
+	{LV_1, 134000, C_PLL},
+	{LV_2, 111000, C_PLL},
+	{LV_3,  84000, C_PLL},
+	{LV_4,  84000, C_PLL},
+};
+
+static struct int_clk_info exynos5420_aclk_266[] = {
+	/* Level, Freq, Parent_Pll */
+	{LV_0, 267000, M_PLL},
+	{LV_1, 160000, M_PLL},
+	{LV_2, 134000, M_PLL},
+	{LV_3, 134000, M_PLL},
+	{LV_4,  86000, D_PLL},
+};
+
+static struct int_clk_info exynos5420_aclk_66[] = {
+	/* Level, Freq, Parent_Pll */
+	{LV_0,  67000, C_PLL},
+	{LV_1,  67000, C_PLL},
+	{LV_2,  67000, C_PLL},
+	{LV_3,  67000, C_PLL},
+	{LV_4,  67000, C_PLL},
+};
+
+static struct int_clk_info exynos5420_aclk_300_disp1[] = {
+	/* Level, Freq, Parent_Pll */
+	{LV_0, 200000, D_PLL},
+	{LV_1, 200000, D_PLL},
+	{LV_2, 200000, D_PLL},
+	{LV_3, 200000, D_PLL},
+	{LV_4, 120000, D_PLL},
+};
+
+static struct int_clk_info exynos5420_aclk_400_disp1[] = {
+	/* Level, Freq, Parent_Pll */
+	{LV_0, 300000, D_PLL},
+	{LV_1, 300000, D_PLL},
+	{LV_2, 200000, D_PLL},
+	{LV_3, 200000, D_PLL},
+	{LV_4, 120000, D_PLL},
+};
+
+static struct int_clk_info exynos5420_aclk_300_jpeg[] = {
+	/* Level, Freq, Parent_Pll */
+	{LV_0, 300000, D_PLL},
+	{LV_1, 300000, D_PLL},
+	{LV_2, 200000, D_PLL},
+	{LV_3, 150000, D_PLL},
+	{LV_4,  75000, D_PLL},
+};
+
+#define EXYNOS5420_INT_PM_CLK(NAME, CLK, PCLK, CLK_INFO)	\
+static struct int_comp_clks int_pm_clks_##NAME = {	\
+	.mux_clk_name = CLK,				\
+	.div_clk_name = PCLK,				\
+	.clk_info = CLK_INFO,				\
+}
+
+EXYNOS5420_INT_PM_CLK(aclk_200_fsys, "aclk200_fsys",
+			"aclk200_fsys_d", exynos5420_aclk_200_fsys);
+EXYNOS5420_INT_PM_CLK(pclk_200_fsys, "pclk200_fsys",
+			"pclk200_fsys_d", exynos5420_pclk_200_fsys);
+EXYNOS5420_INT_PM_CLK(aclk_100_noc, "aclk100_noc",
+			"aclk100_noc_d", exynos5420_aclk_100_noc);
+EXYNOS5420_INT_PM_CLK(aclk_400_wcore, "aclk400_wcore",
+			"aclk400_wcore_d", exynos5420_aclk_400_wcore);
+EXYNOS5420_INT_PM_CLK(aclk_200_fsys2, "aclk200_fsys2",
+			"aclk200_fsys2_d", exynos5420_aclk_200_fsys2);
+EXYNOS5420_INT_PM_CLK(aclk_400_mscl, "aclk400_mscl",
+			"aclk400_mscl_d", exynos5420_aclk_400_mscl);
+EXYNOS5420_INT_PM_CLK(aclk_166, "aclk166",
+			"aclk166_d", exynos5420_aclk_166);
+EXYNOS5420_INT_PM_CLK(aclk_266, "aclk266",
+			"aclk266_d", exynos5420_aclk_266);
+EXYNOS5420_INT_PM_CLK(aclk_66, "aclk66",
+			"aclk66_d", exynos5420_aclk_66);
+EXYNOS5420_INT_PM_CLK(aclk_300_disp1, "aclk300_disp1",
+			"aclk300_disp1_d", exynos5420_aclk_300_disp1);
+EXYNOS5420_INT_PM_CLK(aclk_300_jpeg, "aclk300_jpeg",
+			"aclk300_jpeg_d", exynos5420_aclk_300_jpeg);
+EXYNOS5420_INT_PM_CLK(aclk_400_disp1, "aclk400_disp1",
+			"aclk400_disp1_d", exynos5420_aclk_400_disp1);
+
+static struct int_comp_clks *exynos5420_int_pm_clks[] = {
+	&int_pm_clks_aclk_200_fsys,
+	&int_pm_clks_pclk_200_fsys,
+	&int_pm_clks_aclk_100_noc,
+	&int_pm_clks_aclk_400_wcore,
+	&int_pm_clks_aclk_200_fsys2,
+	&int_pm_clks_aclk_400_mscl,
+	&int_pm_clks_aclk_166,
+	&int_pm_clks_aclk_266,
+	&int_pm_clks_aclk_66,
+	&int_pm_clks_aclk_300_disp1,
+	&int_pm_clks_aclk_300_jpeg,
+	&int_pm_clks_aclk_400_disp1,
+	NULL,
+};
+
+static int exynos5250_int_set_rate(struct busfreq_data_int *data,
 				unsigned long rate)
 {
 	int index, i;
 
-	for (index = 0; index < ARRAY_SIZE(exynos5_int_opp_table); index++) {
-		if (exynos5_int_opp_table[index].clk == rate)
+	for (index = 0; index < ARRAY_SIZE(exynos5250_int_opp_table); index++) {
+		if (exynos5250_int_opp_table[index].clk == rate)
 			break;
 	}
 
@@ -161,8 +370,8 @@ static int exynos5_int_set_rate(struct busfreq_data_int *data,
 		return -EINVAL;
 
 	/* Change the system clock divider values */
-	for (i = 0; i < ARRAY_SIZE(exynos5_int_clks); i++) {
-		struct int_clk *clk_info = &exynos5_int_clks[i];
+	for (i = 0; i < ARRAY_SIZE(exynos5250_int_clks); i++) {
+		struct int_simple_clk *clk_info = &exynos5250_int_clks[i];
 		int ret;
 
 		ret = clk_set_rate(clk_info->clk,
@@ -177,10 +386,111 @@ static int exynos5_int_set_rate(struct busfreq_data_int *data,
 	return 0;
 }
 
+static struct clk *exynos5420_find_pll(struct busfreq_data_int *data,
+				    enum int_bus_pll target_pll)
+{
+	struct clk *target_src_clk = NULL;
+
+	switch (target_pll) {
+	case C_PLL:
+		target_src_clk = data->mout_cpll;
+		break;
+	case M_PLL:
+		target_src_clk = data->mout_mpll;
+		break;
+	case D_PLL:
+		target_src_clk = data->mout_dpll;
+		break;
+	case I_PLL:
+		target_src_clk = data->mout_ipll;
+		break;
+	default:
+		break;
+	}
+
+	return target_src_clk;
+}
+
+static int exynos5420_int_set_rate(struct busfreq_data_int *data,
+		unsigned long target_freq, unsigned long pre_freq)
+{
+	unsigned int i;
+	unsigned long tar_rate;
+	int target_idx = -EINVAL;
+	int pre_idx = -EINVAL;
+	struct int_comp_clks *int_clk;
+	struct clk *new_src_pll;
+	struct clk *old_src_pll;
+	unsigned long old_src_rate, new_src_rate;
+	unsigned long rate1, rate2, rate3, rate4;
+
+	/* Find the levels for target and previous frequencies */
+	for (i = 0; i < _LV_END; i++) {
+		if (exynos5420_int_opp_table[i].clk == target_freq)
+			target_idx = exynos5420_int_opp_table[i].idx;
+		if (exynos5420_int_opp_table[i].clk == pre_freq)
+			pre_idx = exynos5420_int_opp_table[i].idx;
+	}
+
+	list_for_each_entry(int_clk, &data->list, node) {
+		tar_rate = int_clk->clk_info[target_idx].target_freq * 1000;
+
+		old_src_pll = clk_get_parent(int_clk->mux_clk);
+		new_src_pll = exynos5420_find_pll(data,
+				int_clk->clk_info[target_idx].src_pll);
+
+		if (old_src_pll == new_src_pll) {
+			/* No need to change pll */
+			clk_set_rate(int_clk->div_clk, tar_rate);
+			pr_debug("%s: %s now %lu (%lu)\n", __func__,
+				 int_clk->mux_clk_name,
+				 clk_get_rate(int_clk->div_clk), tar_rate);
+			continue;
+		}
+
+		old_src_rate = clk_get_rate(old_src_pll);
+		new_src_rate = clk_get_rate(new_src_pll);
+		rate1 = clk_get_rate(int_clk->div_clk);
+
+		/*
+		 * If we're switching to a faster PLL we should bump up the
+		 * divider before switching.
+		 */
+		if (new_src_rate > old_src_rate) {
+			int new_div;
+			unsigned long tmp_rate;
+
+			new_div = DIV_ROUND_UP(new_src_rate, tar_rate);
+			tmp_rate = DIV_ROUND_UP(old_src_rate, new_div);
+			clk_set_rate(int_clk->div_clk, tmp_rate);
+		}
+		rate2 = clk_get_rate(int_clk->div_clk);
+
+		/* We can safely change the mux now */
+		clk_set_parent(int_clk->mux_clk, new_src_pll);
+		rate3 = clk_get_rate(int_clk->div_clk);
+
+		/*
+		 * Give us a proper divider; technically not needed in the case
+		 * where we pre-calculated the divider above (the new_src_rate >
+		 * old_src_rate case), but let's be formal about it.
+		 */
+		clk_set_rate(int_clk->div_clk, tar_rate);
+		rate4 = clk_get_rate(int_clk->div_clk);
+
+		pr_debug("%s: %s => PLL %d; %lu=>%lu=>%lu=>%lu (%lu)\n",
+			 __func__, int_clk->mux_clk_name,
+			 int_clk->clk_info[target_idx].src_pll,
+			 rate1, rate2, rate3, rate4, tar_rate);
+	}
+	return 0;
+}
+
 static int exynos5_int_setvolt(struct busfreq_data_int *data,
 				unsigned long volt)
 {
-	return regulator_set_voltage(data->vdd_int, volt, MAX_SAFEVOLT);
+	return regulator_set_voltage(data->vdd_int, volt,
+				volt + INT_VOLT_STEP_UV);
 }
 
 static int exynos5_busfreq_int_target(struct device *dev, unsigned long *_freq,
@@ -218,18 +528,15 @@ static int exynos5_busfreq_int_target(struct device *dev, unsigned long *_freq,
 	if (data->disabled)
 		goto out;
 
-	if (freq > exynos5_int_opp_table[0].clk)
-		pm_qos_update_request(&data->int_req, freq * 16 / 1000);
-	else
-		pm_qos_update_request(&data->int_req, -1);
-
 	if (old_freq < freq)
 		err = exynos5_int_setvolt(data, volt);
 	if (err)
 		goto out;
 
-	err = exynos5_int_set_rate(data, freq);
-
+	if (data->type == TYPE_BUSF_EXYNOS5250)
+		err = exynos5250_int_set_rate(data, freq);
+	else
+		err = exynos5420_int_set_rate(data, freq, old_freq);
 	if (err)
 		goto out;
 
@@ -267,16 +574,20 @@ static int exynos5_int_get_dev_status(struct device *dev,
 }
 
 static struct devfreq_dev_profile exynos5_devfreq_int_profile = {
-	.initial_freq		= 160000,
-	.polling_ms		= 100,
+	.polling_ms		= 10,
 	.target			= exynos5_busfreq_int_target,
 	.get_dev_status		= exynos5_int_get_dev_status,
 };
 
-static int exynos5250_init_int_tables(struct busfreq_data_int *data)
+static int exynos5_init_int_tables(struct busfreq_data_int *data)
 {
 	int i, err = 0;
 
+	if (data->type == TYPE_BUSF_EXYNOS5250)
+		exynos5_int_opp_table = exynos5250_int_opp_table;
+	else
+		exynos5_int_opp_table = exynos5420_int_opp_table;
+
 	for (i = LV_0; i < _LV_END; i++) {
 		err = dev_pm_opp_add(data->dev, exynos5_int_opp_table[i].clk,
 				exynos5_int_opp_table[i].volt);
@@ -297,6 +608,7 @@ static int exynos5_busfreq_int_pm_notifier_event(struct notifier_block *this,
 	struct dev_pm_opp *opp;
 	unsigned long maxfreq = ULONG_MAX;
 	unsigned long freq;
+	unsigned long old_freq;
 	unsigned long volt;
 	int err = 0;
 
@@ -322,8 +634,14 @@ static int exynos5_busfreq_int_pm_notifier_event(struct notifier_block *this,
 		if (err)
 			goto unlock;
 
-		err = exynos5_int_set_rate(data, freq);
+		old_freq = data->curr_freq;
 
+		if (data->type == TYPE_BUSF_EXYNOS5250)
+			err = exynos5250_int_set_rate(data, freq);
+		else if (data->type == TYPE_BUSF_EXYNOS5420)
+			err = exynos5420_int_set_rate(data, freq, old_freq);
+		else
+			err = -EINVAL;
 		if (err)
 			goto unlock;
 
@@ -345,16 +663,38 @@ unlock:
 	return NOTIFY_DONE;
 }
 
+static const struct of_device_id exynos5_busfreq_dt_match[];
+
+static inline int exynos5_busfreq_get_driver_data(struct platform_device *pdev)
+{
+#ifdef CONFIG_OF
+	struct exynos5_busfreq_drv_data *data;
+
+	if (pdev->dev.of_node) {
+		const struct of_device_id *match;
+
+		match = of_match_node(exynos5_busfreq_dt_match,
+					pdev->dev.of_node);
+		data = (struct exynos5_busfreq_drv_data *) match->data;
+		return data->busf_type;
+	}
+#endif
+	return platform_get_device_id(pdev)->driver_data;
+}
+
 static int exynos5_busfreq_int_probe(struct platform_device *pdev)
 {
 	struct busfreq_data_int *data;
 	struct busfreq_ppmu_data *ppmu_data;
+	struct device_node *np = pdev->dev.of_node;
 	struct dev_pm_opp *opp;
 	struct device *dev = &pdev->dev;
-	struct device_node *np;
 	unsigned long initial_freq;
 	unsigned long initial_volt;
+	struct clk *mux_clk, *div_clk;
+	struct int_comp_clks *int_pm_clk;
 	int err = 0;
+	int nr_clk;
 	int i;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(struct busfreq_data_int),
@@ -364,22 +704,27 @@ static int exynos5_busfreq_int_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	INIT_LIST_HEAD(&data->list);
+	data->type = exynos5_busfreq_get_driver_data(pdev);
+
 	ppmu_data = &data->ppmu_data;
-	ppmu_data->ppmu_end = PPMU_END;
+	if (data->type == TYPE_BUSF_EXYNOS5250) {
+		ppmu_data->ppmu_end = PPMU_END_5250;
+	} else if (data->type == TYPE_BUSF_EXYNOS5420) {
+		ppmu_data->ppmu_end = PPMU_END_5420;
+	} else {
+		dev_err(dev, "Cannot determine the device id %d\n", data->type);
+		return -EINVAL;
+	}
+
 	ppmu_data->ppmu = devm_kzalloc(dev,
-				       sizeof(struct exynos_ppmu) * PPMU_END,
-				       GFP_KERNEL);
+			sizeof(struct exynos_ppmu) * (ppmu_data->ppmu_end),
+			GFP_KERNEL);
 	if (!ppmu_data->ppmu) {
 		dev_err(dev, "Failed to allocate memory for exynos_ppmu\n");
 		return -ENOMEM;
 	}
 
-	np = of_find_compatible_node(NULL, NULL, "samsung,exynos5250-ppmu");
-	if (np == NULL) {
-		pr_err("Unable to find PPMU node\n");
-		return -ENOENT;
-	}
-
 	for (i = 0; i < ppmu_data->ppmu_end; i++) {
 		/* map PPMU memory region */
 		ppmu_data->ppmu[i].hw_base = of_iomap(np, i);
@@ -388,13 +733,17 @@ static int exynos5_busfreq_int_probe(struct platform_device *pdev)
 			return -ENOMEM;
 		}
 	}
+
 	data->pm_notifier.notifier_call = exynos5_busfreq_int_pm_notifier_event;
 	data->dev = dev;
 	mutex_init(&data->lock);
 
-	err = exynos5250_init_int_tables(data);
-	if (err)
+	err = exynos5_init_int_tables(data);
+	if (err) {
+		dev_err(dev, "Cannot initialize busfreq table %d\n",
+			     data->type);
 		return err;
+	}
 
 	data->vdd_int = devm_regulator_get(dev, "vdd_int");
 	if (IS_ERR(data->vdd_int)) {
@@ -402,18 +751,70 @@ static int exynos5_busfreq_int_probe(struct platform_device *pdev)
 		return PTR_ERR(data->vdd_int);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(exynos5_int_clks); i++) {
-		struct int_clk *clk_info = &exynos5_int_clks[i];
+	if (data->type == TYPE_BUSF_EXYNOS5250) {
+		for (i = 0; i < ARRAY_SIZE(exynos5250_int_clks); i++) {
+			struct int_simple_clk *clk_info =
+				&exynos5250_int_clks[i];
+
+			clk_info->clk = devm_clk_get(dev, clk_info->clk_name);
+			if (IS_ERR(clk_info->clk)) {
+				dev_err(dev, "Failed to get clock %s\n",
+					clk_info->clk_name);
+				return PTR_ERR(clk_info->clk);
+			}
+		}
+	} else {
+		data->mout_ipll = devm_clk_get(dev, "mout_ipll");
+		if (IS_ERR(data->mout_ipll)) {
+			dev_err(dev, "Cannot get clock \"mout_ipll\"\n");
+			return PTR_ERR(data->mout_ipll);
+		}
 
-		clk_info->clk = devm_clk_get(dev, clk_info->clk_name);
-		if (IS_ERR(clk_info->clk)) {
-			dev_err(dev, "Failed to get clock %s\n",
-				clk_info->clk_name);
-			return PTR_ERR(clk_info->clk);
+		data->mout_mpll = devm_clk_get(dev, "mout_mpll");
+		if (IS_ERR(data->mout_mpll)) {
+			dev_err(dev, "Cannot get clock \"mout_mpll\"\n");
+			return PTR_ERR(data->mout_mpll);
+		}
+
+		data->mout_dpll = devm_clk_get(dev, "mout_dpll");
+		if (IS_ERR(data->mout_dpll)) {
+			dev_err(dev, "Cannot get clock \"mout_dpll\"\n");
+			return PTR_ERR(data->mout_dpll);
+		}
+
+		data->mout_cpll = devm_clk_get(dev, "mout_cpll");
+		if (IS_ERR(data->mout_cpll)) {
+			dev_err(dev, "Cannot get clock \"mout_cpll\"\n");
+			return PTR_ERR(data->mout_cpll);
+		}
+
+		for (nr_clk = 0; exynos5420_int_pm_clks[nr_clk] != NULL;
+								nr_clk++) {
+			int_pm_clk = exynos5420_int_pm_clks[nr_clk];
+			mux_clk = devm_clk_get(dev, int_pm_clk->mux_clk_name);
+			if (IS_ERR(mux_clk)) {
+				dev_err(dev, "Cannot get mux clock: %s\n",
+						int_pm_clk->mux_clk_name);
+				return PTR_ERR(mux_clk);
+			}
+			div_clk = devm_clk_get(dev, int_pm_clk->div_clk_name);
+			if (IS_ERR(div_clk)) {
+				dev_err(dev, "Cannot get div clock: %s\n",
+						int_pm_clk->div_clk_name);
+				return PTR_ERR(div_clk);
+			}
+			int_pm_clk->mux_clk = mux_clk;
+			int_pm_clk->div_clk = div_clk;
+			list_add_tail(&int_pm_clk->node, &data->list);
 		}
 	}
 
 	rcu_read_lock();
+	if (data->type == TYPE_BUSF_EXYNOS5250)
+		exynos5_devfreq_int_profile.initial_freq = 160000;
+	else
+		exynos5_devfreq_int_profile.initial_freq = 333000;
+
 	opp = dev_pm_opp_find_freq_floor(dev,
 			&exynos5_devfreq_int_profile.initial_freq);
 	if (IS_ERR(opp)) {
@@ -428,10 +829,15 @@ static int exynos5_busfreq_int_probe(struct platform_device *pdev)
 	data->curr_freq = initial_freq;
 
 	err = exynos5_int_setvolt(data, initial_volt);
-	if (err)
+	if (err) {
+		dev_err(dev, "Failed to set initial voltage\n");
 		return err;
+	}
 
-	err = exynos5_int_set_rate(data, initial_freq);
+	if (data->type == TYPE_BUSF_EXYNOS5250)
+		err = exynos5250_int_set_rate(data, initial_freq);
+	else
+		err = exynos5420_int_set_rate(data, initial_freq, initial_freq);
 	if (err) {
 		dev_err(dev, "Failed to set initial frequency\n");
 		return err;
@@ -439,28 +845,31 @@ static int exynos5_busfreq_int_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
-	busfreq_mon_reset(ppmu_data);
-
-	data->devfreq = devm_devfreq_add_device(dev, &exynos5_devfreq_int_profile,
-					   "simple_ondemand", NULL);
+	data->devfreq = devm_devfreq_add_device(dev,
+		&exynos5_devfreq_int_profile, "simple_ondemand", NULL);
 	if (IS_ERR(data->devfreq))
 		return PTR_ERR(data->devfreq);
 
+	/*
+	 * Start PPMU (Performance Profiling Monitoring Unit) to check
+	 * utilization of each IP in the Exynos4 SoC.
+	 */
+	busfreq_mon_reset(ppmu_data);
+
+	/* Register opp_notifier for Exynos5 busfreq */
 	err = devm_devfreq_register_opp_notifier(dev, data->devfreq);
 	if (err < 0) {
 		dev_err(dev, "Failed to register opp notifier\n");
 		return err;
 	}
 
+	/* Register pm_notifier for Exynos5 busfreq */
 	err = register_pm_notifier(&data->pm_notifier);
 	if (err) {
 		dev_err(dev, "Failed to setup pm notifier\n");
 		return err;
 	}
 
-	/* TODO: Add a new QOS class for int/mif bus */
-	pm_qos_add_request(&data->int_req, PM_QOS_NETWORK_THROUGHPUT, -1);
-
 	return 0;
 }
 
@@ -468,7 +877,7 @@ static int exynos5_busfreq_int_remove(struct platform_device *pdev)
 {
 	struct busfreq_data_int *data = platform_get_drvdata(pdev);
 
-	pm_qos_remove_request(&data->int_req);
+	/* Unregister all of notifier chain */
 	unregister_pm_notifier(&data->pm_notifier);
 
 	return 0;
@@ -492,8 +901,24 @@ static const struct dev_pm_ops exynos5_busfreq_int_pm = {
 static SIMPLE_DEV_PM_OPS(exynos5_busfreq_int_pm_ops, NULL,
 			 exynos5_busfreq_int_resume);
 
-/* platform device pointer for exynos5 devfreq device. */
-static struct platform_device *exynos5_devfreq_pdev;
+#ifdef CONFIG_OF
+static struct exynos5_busfreq_drv_data exynos_busfreq_data_array[] = {
+	[TYPE_BUSF_EXYNOS5250] = { TYPE_BUSF_EXYNOS5250 },
+	[TYPE_BUSF_EXYNOS5420] = { TYPE_BUSF_EXYNOS5420 },
+};
+
+static const struct of_device_id exynos5_busfreq_dt_match[] = {
+	{
+		.compatible = "samsung,exynos5250-int-busfreq",
+		.data = &exynos_busfreq_data_array[TYPE_BUSF_EXYNOS5250],
+	}, {
+		.compatible = "samsung,exynos5420-int-busfreq",
+		.data = &exynos_busfreq_data_array[TYPE_BUSF_EXYNOS5420],
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, exynos5_busfreq_dt_match);
+#endif
 
 static struct platform_driver exynos5_busfreq_int_driver = {
 	.probe		= exynos5_busfreq_int_probe,
@@ -502,35 +927,18 @@ static struct platform_driver exynos5_busfreq_int_driver = {
 		.name		= "exynos5-bus-int",
 		.owner		= THIS_MODULE,
 		.pm		= &exynos5_busfreq_int_pm_ops,
+		.of_match_table	= of_match_ptr(exynos5_busfreq_dt_match),
 	},
 };
 
 static int __init exynos5_busfreq_int_init(void)
 {
-	int ret;
-
-	ret = platform_driver_register(&exynos5_busfreq_int_driver);
-	if (ret < 0)
-		goto out;
-
-	exynos5_devfreq_pdev =
-		platform_device_register_simple("exynos5-bus-int", -1, NULL, 0);
-	if (IS_ERR(exynos5_devfreq_pdev)) {
-		ret = PTR_ERR(exynos5_devfreq_pdev);
-		goto out1;
-	}
-
-	return 0;
-out1:
-	platform_driver_unregister(&exynos5_busfreq_int_driver);
-out:
-	return ret;
+	return platform_driver_register(&exynos5_busfreq_int_driver);
 }
 late_initcall(exynos5_busfreq_int_init);
 
 static void __exit exynos5_busfreq_int_exit(void)
 {
-	platform_device_unregister(exynos5_devfreq_pdev);
 	platform_driver_unregister(&exynos5_busfreq_int_driver);
 }
 module_exit(exynos5_busfreq_int_exit);
-- 
1.7.9.5

