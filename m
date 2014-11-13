From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 25/33] thermal: exynos: remove TMU_SUPPORT_FALLING_TRIP flag
Date: Thu, 13 Nov 2014 16:01:20 +0100
Message-ID: <1415890888-8881-26-git-send-email-b.zolnierkie@samsung.com>
References: <1415890888-8881-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1415890888-8881-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Replace TMU_SUPPORT_FALLING_TRIP flag check in
exynos[4210,5440]_tmu_control() by an explicit check
for a SoC type (all SoC types except Exynos4210 have
TMU_SUPPORT_FALLING_TRIP flag set in their struct
exynos_tmu_init_data instances).

There should be no functional changes caused by this patch.

Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c      |  6 ++----
 drivers/thermal/samsung/exynos_tmu.h      |  7 ++-----
 drivers/thermal/samsung/exynos_tmu_data.c | 20 ++++++++------------
 3 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 1b3c2f4..6795ddc 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -373,7 +373,7 @@ static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
 			pdata->trigger_enable[2] << EXYNOS_TMU_INTEN_RISE2_SHIFT |
 			pdata->trigger_enable[1] << EXYNOS_TMU_INTEN_RISE1_SHIFT |
 			pdata->trigger_enable[0] << EXYNOS_TMU_INTEN_RISE0_SHIFT;
-		if (TMU_SUPPORTS(pdata, FALLING_TRIP))
+		if (data->soc != SOC_ARCH_EXYNOS4210)
 			interrupt_en |=
 				interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
 	} else {
@@ -399,9 +399,7 @@ static void exynos5440_tmu_control(struct platform_device *pdev, bool on)
 			pdata->trigger_enable[2] << EXYNOS5440_TMU_INTEN_RISE2_SHIFT |
 			pdata->trigger_enable[1] << EXYNOS5440_TMU_INTEN_RISE1_SHIFT |
 			pdata->trigger_enable[0] << EXYNOS5440_TMU_INTEN_RISE0_SHIFT;
-		if (TMU_SUPPORTS(pdata, FALLING_TRIP))
-			interrupt_en |=
-				interrupt_en << EXYNOS5440_TMU_INTEN_FALL0_SHIFT;
+		interrupt_en |= interrupt_en << EXYNOS5440_TMU_INTEN_FALL0_SHIFT;
 	} else {
 		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
 		interrupt_en = 0; /* Disable all interrupts */
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index c4c0aa5..ed83d3d 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -51,8 +51,6 @@ enum soc_type {
  *			temperature to the TMU controller.
  * TMU_SUPPORT_MULTI_INST - This features denotes that the soc
  *			has many instances of TMU.
- * TMU_SUPPORT_FALLING_TRIP - This features shows that interrupt can
- *			be registered for falling trips also.
  * TMU_SUPPORT_EMUL_TIME - This features allows to set next temp emulation
  *			sample time.
  * TMU_SUPPORT_ADDRESS_MULTIPLE - This feature tells that the different TMU
@@ -61,9 +59,8 @@ enum soc_type {
  */
 #define TMU_SUPPORT_EMULATION			BIT(0)
 #define TMU_SUPPORT_MULTI_INST			BIT(1)
-#define TMU_SUPPORT_FALLING_TRIP		BIT(2)
-#define TMU_SUPPORT_EMUL_TIME			BIT(3)
-#define TMU_SUPPORT_ADDRESS_MULTIPLE		BIT(4)
+#define TMU_SUPPORT_EMUL_TIME			BIT(2)
+#define TMU_SUPPORT_ADDRESS_MULTIPLE		BIT(3)
 
 #define TMU_SUPPORTS(a, b)	(a->features & TMU_SUPPORT_ ## b)
 
diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
index d35ec15..39b9651 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.c
+++ b/drivers/thermal/samsung/exynos_tmu_data.c
@@ -101,8 +101,7 @@ struct exynos_tmu_init_data const exynos4210_default_tmu_data = {
 		.temp_level = 95, \
 	}, \
 	.freq_tab_count = 2, \
-	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_FALLING_TRIP | \
-			TMU_SUPPORT_EMUL_TIME)
+	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_EMUL_TIME)
 #endif
 
 #if defined(CONFIG_SOC_EXYNOS3250)
@@ -154,8 +153,7 @@ struct exynos_tmu_init_data const exynos3250_default_tmu_data = {
 		.temp_level = 95, \
 	}, \
 	.freq_tab_count = 2, \
-	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_FALLING_TRIP | \
-			TMU_SUPPORT_EMUL_TIME)
+	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_EMUL_TIME)
 #endif
 
 #if defined(CONFIG_SOC_EXYNOS4412)
@@ -223,8 +221,7 @@ struct exynos_tmu_init_data const exynos5250_default_tmu_data = {
 #define EXYNOS5260_TMU_DATA \
 	__EXYNOS5260_TMU_DATA \
 	.type = SOC_ARCH_EXYNOS5260, \
-	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_FALLING_TRIP | \
-			TMU_SUPPORT_EMUL_TIME)
+	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_EMUL_TIME)
 
 struct exynos_tmu_init_data const exynos5260_default_tmu_data = {
 	.tmu_data = {
@@ -278,14 +275,13 @@ struct exynos_tmu_init_data const exynos5260_default_tmu_data = {
 #define EXYNOS5420_TMU_DATA \
 	__EXYNOS5420_TMU_DATA \
 	.type = SOC_ARCH_EXYNOS5420, \
-	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_FALLING_TRIP | \
-			TMU_SUPPORT_EMUL_TIME)
+	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_EMUL_TIME)
 
 #define EXYNOS5420_TMU_DATA_SHARED \
 	__EXYNOS5420_TMU_DATA \
 	.type = SOC_ARCH_EXYNOS5420_TRIMINFO, \
-	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_FALLING_TRIP | \
-			TMU_SUPPORT_EMUL_TIME | TMU_SUPPORT_ADDRESS_MULTIPLE)
+	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_EMUL_TIME | \
+			TMU_SUPPORT_ADDRESS_MULTIPLE)
 
 struct exynos_tmu_init_data const exynos5420_default_tmu_data = {
 	.tmu_data = {
@@ -319,8 +315,8 @@ struct exynos_tmu_init_data const exynos5420_default_tmu_data = {
 	.second_point_trim = 70, \
 	.default_temp_offset = 25, \
 	.type = SOC_ARCH_EXYNOS5440, \
-	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_FALLING_TRIP | \
-			TMU_SUPPORT_MULTI_INST | TMU_SUPPORT_ADDRESS_MULTIPLE),
+	.features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_MULTI_INST | \
+			TMU_SUPPORT_ADDRESS_MULTIPLE),
 
 struct exynos_tmu_init_data const exynos5440_default_tmu_data = {
 	.tmu_data = {
-- 
1.8.2.3
