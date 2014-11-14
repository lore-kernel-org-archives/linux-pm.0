From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH 2/4] thermal: exynos: add a triminfo_mask field in
 exynos_tmu_register structure
Date: Fri, 14 Nov 2014 16:48:00 +0530
Message-ID: <1415963882-3460-3-git-send-email-a.kesavan@samsung.com>
References: <1415963882-3460-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:57680 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964995AbaKNLTq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Nov 2014 06:19:46 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NF100EGO0SWVJA0@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 14 Nov 2014 20:19:44 +0900 (KST)
In-reply-to: <1415963882-3460-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org
Cc: b.zolnierkie@samsung.com, amit.daniel@samsung.com, kesavan.abhilash@gmail.com

Exynos7 has 9 bits for triminfo_25 as against older SoCs which had
only 8 bits. Add a new triminfo_mask field, to the exynos_tmu_register
structure, which will hold the mask value for the triminfo_25 register.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c      |    8 ++++----
 drivers/thermal/samsung/exynos_tmu.h      |    2 ++
 drivers/thermal/samsung/exynos_tmu_data.c |    6 ++++++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index c8caf5b..49d3bcb 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -200,19 +200,19 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 		else
 			trim_info = readl(data->base + reg->triminfo_data);
 	}
-	data->temp_error1 = trim_info & EXYNOS_TMU_TEMP_MASK;
+	data->temp_error1 = trim_info & reg->triminfo_mask;
 	data->temp_error2 = ((trim_info >> EXYNOS_TRIMINFO_85_SHIFT) &
-				EXYNOS_TMU_TEMP_MASK);
+				reg->triminfo_mask);
 
 	if (!data->temp_error1 ||
 		(pdata->min_efuse_value > data->temp_error1) ||
 		(data->temp_error1 > pdata->max_efuse_value))
-		data->temp_error1 = pdata->efuse_value & EXYNOS_TMU_TEMP_MASK;
+		data->temp_error1 = pdata->efuse_value &  reg->triminfo_mask;
 
 	if (!data->temp_error2)
 		data->temp_error2 =
 			(pdata->efuse_value >> EXYNOS_TRIMINFO_85_SHIFT) &
-			EXYNOS_TMU_TEMP_MASK;
+			reg->triminfo_mask;
 
 	rising_threshold = readl(data->base + reg->threshold_th0);
 
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index c58c766..70e0d961 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -79,6 +79,7 @@ enum soc_type {
  * @triminfo_data: register containing 2 pont trimming data
  * @triminfo_ctrl: trim info controller register.
  * @triminfo_ctrl_count: the number of trim info controller register.
+ * @triminfo_mask: mask bits for triminfo_25 in trim info controller register.
  * @tmu_ctrl: TMU main controller register.
  * @test_mux_addr_shift: shift bits of test mux address.
  * @therm_trip_mode_shift: shift bits of tripping mode in tmu_ctrl register.
@@ -111,6 +112,7 @@ struct exynos_tmu_registers {
 
 	u32	triminfo_ctrl[MAX_TRIMINFO_CTRL_REG];
 	u32	triminfo_ctrl_count;
+	u32	triminfo_mask;
 
 	u32	tmu_ctrl;
 	u32     test_mux_addr_shift;
diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
index 1724f6c..c4f12d0 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.c
+++ b/drivers/thermal/samsung/exynos_tmu_data.c
@@ -27,6 +27,7 @@
 #if defined(CONFIG_CPU_EXYNOS4210)
 static const struct exynos_tmu_registers exynos4210_tmu_registers = {
 	.triminfo_data = EXYNOS_TMU_REG_TRIMINFO,
+	.triminfo_mask = EXYNOS_TMU_TEMP_MASK,
 	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
 	.tmu_status = EXYNOS_TMU_REG_STATUS,
 	.tmu_cur_temp = EXYNOS_TMU_REG_CURRENT_TEMP,
@@ -89,6 +90,7 @@ static const struct exynos_tmu_registers exynos3250_tmu_registers = {
 	.triminfo_ctrl[0] = EXYNOS_TMU_TRIMINFO_CON1,
 	.triminfo_ctrl[1] = EXYNOS_TMU_TRIMINFO_CON2,
 	.triminfo_ctrl_count = 2,
+	.triminfo_mask = EXYNOS_TMU_TEMP_MASK,
 	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
 	.test_mux_addr_shift = EXYNOS4412_MUX_ADDR_SHIFT,
 	.therm_trip_mode_shift = EXYNOS_TMU_TRIP_MODE_SHIFT,
@@ -171,6 +173,7 @@ static const struct exynos_tmu_registers exynos4412_tmu_registers = {
 	.triminfo_data = EXYNOS_TMU_REG_TRIMINFO,
 	.triminfo_ctrl[0] = EXYNOS_TMU_TRIMINFO_CON2,
 	.triminfo_ctrl_count = 1,
+	.triminfo_mask = EXYNOS_TMU_TEMP_MASK,
 	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
 	.test_mux_addr_shift = EXYNOS4412_MUX_ADDR_SHIFT,
 	.therm_trip_mode_shift = EXYNOS_TMU_TRIP_MODE_SHIFT,
@@ -263,6 +266,7 @@ struct exynos_tmu_init_data const exynos5250_default_tmu_data = {
 #if defined(CONFIG_SOC_EXYNOS5260)
 static const struct exynos_tmu_registers exynos5260_tmu_registers = {
 	.triminfo_data = EXYNOS_TMU_REG_TRIMINFO,
+	.triminfo_mask = EXYNOS_TMU_TEMP_MASK,
 	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
 	.therm_trip_mode_shift = EXYNOS_TMU_TRIP_MODE_SHIFT,
 	.therm_trip_mode_mask = EXYNOS_TMU_TRIP_MODE_MASK,
@@ -342,6 +346,7 @@ struct exynos_tmu_init_data const exynos5260_default_tmu_data = {
 #if defined(CONFIG_SOC_EXYNOS5420)
 static const struct exynos_tmu_registers exynos5420_tmu_registers = {
 	.triminfo_data = EXYNOS_TMU_REG_TRIMINFO,
+	.triminfo_mask = EXYNOS_TMU_TEMP_MASK,
 	.tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
 	.therm_trip_mode_shift = EXYNOS_TMU_TRIP_MODE_SHIFT,
 	.therm_trip_mode_mask = EXYNOS_TMU_TRIP_MODE_MASK,
@@ -429,6 +434,7 @@ struct exynos_tmu_init_data const exynos5420_default_tmu_data = {
 #if defined(CONFIG_SOC_EXYNOS5440)
 static const struct exynos_tmu_registers exynos5440_tmu_registers = {
 	.triminfo_data = EXYNOS5440_TMU_S0_7_TRIM,
+	.triminfo_mask = EXYNOS_TMU_TEMP_MASK,
 	.tmu_ctrl = EXYNOS5440_TMU_S0_7_CTRL,
 	.therm_trip_mode_shift = EXYNOS_TMU_TRIP_MODE_SHIFT,
 	.therm_trip_mode_mask = EXYNOS_TMU_TRIP_MODE_MASK,
-- 
1.7.9.5

