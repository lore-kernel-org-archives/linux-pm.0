From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 16/18] thermal: exynos: cleanup code for enabling threshold
 interrupts
Date: Thu, 26 Apr 2018 13:51:31 +0200
Message-ID: <1524743493-28113-17-git-send-email-b.zolnierkie@samsung.com>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115239epcas2p2dc72353efa8375b7f70a41c570fba789@epcas2p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Cleanup code for enabling threshold interrupts in ->tmu_control
method implementations.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 101 ++++++++++++-----------------------
 1 file changed, 34 insertions(+), 67 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index abe0737..9639acf 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -76,9 +76,6 @@
 #define EXYNOS_TMU_THERM_TRIP_EN_SHIFT	12
 
 #define EXYNOS_TMU_INTEN_RISE0_SHIFT	0
-#define EXYNOS_TMU_INTEN_RISE1_SHIFT	4
-#define EXYNOS_TMU_INTEN_RISE2_SHIFT	8
-#define EXYNOS_TMU_INTEN_RISE3_SHIFT	12
 #define EXYNOS_TMU_INTEN_FALL0_SHIFT	16
 
 #define EXYNOS_EMUL_TIME	0x57F0
@@ -136,13 +133,6 @@
 #define EXYNOS7_TMU_TEMP_MASK			0x1ff
 #define EXYNOS7_PD_DET_EN_SHIFT			23
 #define EXYNOS7_TMU_INTEN_RISE0_SHIFT		0
-#define EXYNOS7_TMU_INTEN_RISE1_SHIFT		1
-#define EXYNOS7_TMU_INTEN_RISE2_SHIFT		2
-#define EXYNOS7_TMU_INTEN_RISE3_SHIFT		3
-#define EXYNOS7_TMU_INTEN_RISE4_SHIFT		4
-#define EXYNOS7_TMU_INTEN_RISE5_SHIFT		5
-#define EXYNOS7_TMU_INTEN_RISE6_SHIFT		6
-#define EXYNOS7_TMU_INTEN_RISE7_SHIFT		7
 #define EXYNOS7_EMUL_DATA_SHIFT			7
 #define EXYNOS7_EMUL_DATA_MASK			0x1ff
 
@@ -615,29 +605,27 @@ static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
-	unsigned int con, interrupt_en;
+	unsigned int con, interrupt_en = 0, i;
 
 	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
 
 	if (on) {
-		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
-		interrupt_en =
-			(of_thermal_is_trip_valid(tz, 3)
-			 << EXYNOS_TMU_INTEN_RISE3_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 2)
-			 << EXYNOS_TMU_INTEN_RISE2_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 1)
-			 << EXYNOS_TMU_INTEN_RISE1_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 0)
-			 << EXYNOS_TMU_INTEN_RISE0_SHIFT);
+		for (i = 0; i < data->ntrip; i++) {
+			if (!of_thermal_is_trip_valid(tz, i))
+				continue;
+
+			interrupt_en |=
+				(1 << (EXYNOS_TMU_INTEN_RISE0_SHIFT + i * 4));
+		}
 
 		if (data->soc != SOC_ARCH_EXYNOS4210)
 			interrupt_en |=
 				interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
-	} else {
+
+		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
+	} else
 		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
-		interrupt_en = 0; /* Disable all interrupts */
-	}
+
 	writel(interrupt_en, data->base + EXYNOS_TMU_REG_INTEN);
 	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
 }
@@ -646,36 +634,25 @@ static void exynos5433_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
-	unsigned int con, interrupt_en, pd_det_en;
+	unsigned int con, interrupt_en = 0, pd_det_en, i;
 
 	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
 
 	if (on) {
-		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
-		interrupt_en =
-			(of_thermal_is_trip_valid(tz, 7)
-			<< EXYNOS7_TMU_INTEN_RISE7_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 6)
-			<< EXYNOS7_TMU_INTEN_RISE6_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 5)
-			<< EXYNOS7_TMU_INTEN_RISE5_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 4)
-			<< EXYNOS7_TMU_INTEN_RISE4_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 3)
-			<< EXYNOS7_TMU_INTEN_RISE3_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 2)
-			<< EXYNOS7_TMU_INTEN_RISE2_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 1)
-			<< EXYNOS7_TMU_INTEN_RISE1_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 0)
-			<< EXYNOS7_TMU_INTEN_RISE0_SHIFT);
+		for (i = 0; i < data->ntrip; i++) {
+			if (!of_thermal_is_trip_valid(tz, i))
+				continue;
+
+			interrupt_en |=
+				(1 << (EXYNOS7_TMU_INTEN_RISE0_SHIFT + i));
+		}
 
 		interrupt_en |=
 			interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
-	} else {
+
+		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
+	} else
 		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
-		interrupt_en = 0; /* Disable all interrupts */
-	}
 
 	pd_det_en = on ? EXYNOS5433_PD_DET_EN : 0;
 
@@ -688,37 +665,27 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
-	unsigned int con, interrupt_en;
+	unsigned int con, interrupt_en = 0, i;
 
 	con = get_con_reg(data, readl(data->base + EXYNOS_TMU_REG_CONTROL));
 
 	if (on) {
-		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
-		con |= (1 << EXYNOS7_PD_DET_EN_SHIFT);
-		interrupt_en =
-			(of_thermal_is_trip_valid(tz, 7)
-			<< EXYNOS7_TMU_INTEN_RISE7_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 6)
-			<< EXYNOS7_TMU_INTEN_RISE6_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 5)
-			<< EXYNOS7_TMU_INTEN_RISE5_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 4)
-			<< EXYNOS7_TMU_INTEN_RISE4_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 3)
-			<< EXYNOS7_TMU_INTEN_RISE3_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 2)
-			<< EXYNOS7_TMU_INTEN_RISE2_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 1)
-			<< EXYNOS7_TMU_INTEN_RISE1_SHIFT) |
-			(of_thermal_is_trip_valid(tz, 0)
-			<< EXYNOS7_TMU_INTEN_RISE0_SHIFT);
+		for (i = 0; i < data->ntrip; i++) {
+			if (!of_thermal_is_trip_valid(tz, i))
+				continue;
+
+			interrupt_en |=
+				(1 << (EXYNOS7_TMU_INTEN_RISE0_SHIFT + i));
+		}
 
 		interrupt_en |=
 			interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
+
+		con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
+		con |= (1 << EXYNOS7_PD_DET_EN_SHIFT);
 	} else {
 		con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
 		con &= ~(1 << EXYNOS7_PD_DET_EN_SHIFT);
-		interrupt_en = 0; /* Disable all interrupts */
 	}
 
 	writel(interrupt_en, data->base + EXYNOS7_TMU_REG_INTEN);
-- 
1.9.1
