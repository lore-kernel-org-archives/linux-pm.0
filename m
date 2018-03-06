From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 06/12] thermal: exynos: remove parsing of
 samsung,tmu_reference_voltage property
Date: Tue, 06 Mar 2018 15:43:49 +0100
Message-ID: <1520347435-22970-7-git-send-email-b.zolnierkie@samsung.com>
References: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180306144453epcas2p2d440c954c21c800e21f121418d7e5ec8@epcas2p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, b.zolnierkie@samsung.com, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Since pdata reference_voltage values are SoC (not platform) specific
just move it from platform data to struct exynos_tmu_data instance.
Then remove parsing of samsung,tmu_reference_voltage property.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 18 +++++++++++++++---
 drivers/thermal/samsung/exynos_tmu.h |  4 ----
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 02d34cf..12bbf79 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -123,6 +123,8 @@
 
 #define EXYNOS5433_PD_DET_EN			1
 
+#define EXYNOS5433_G3D_BASE			0x10070000
+
 /*exynos5440 specific registers*/
 #define EXYNOS5440_TMU_S0_7_TRIM		0x000
 #define EXYNOS5440_TMU_S0_7_CTRL		0x020
@@ -190,6 +192,9 @@
  * @max_efuse_value: maximum valid trimming data
  * @temp_error1: fused value of the first point trim.
  * @temp_error2: fused value of the second point trim.
+ * @reference_voltage: reference voltage of amplifier
+ *	in the positive-TC generator block
+ *	0 < reference_voltage <= 31
  * @regulator: pointer to the TMU regulator structure.
  * @reg_conf: pointer to structure to register with core thermal.
  * @ntrip: number of supported trip points.
@@ -213,6 +218,7 @@ struct exynos_tmu_data {
 	u32 min_efuse_value;
 	u32 max_efuse_value;
 	u16 temp_error1, temp_error2;
+	u8 reference_voltage;
 	struct regulator *regulator;
 	struct thermal_zone_device *tzd;
 	unsigned int ntrip;
@@ -387,7 +393,7 @@ static u32 get_con_reg(struct exynos_tmu_data *data, u32 con)
 		con |= (EXYNOS4412_MUX_ADDR_VALUE << EXYNOS4412_MUX_ADDR_SHIFT);
 
 	con &= ~(EXYNOS_TMU_REF_VOLTAGE_MASK << EXYNOS_TMU_REF_VOLTAGE_SHIFT);
-	con |= pdata->reference_voltage << EXYNOS_TMU_REF_VOLTAGE_SHIFT;
+	con |= data->reference_voltage << EXYNOS_TMU_REF_VOLTAGE_SHIFT;
 
 	con &= ~(EXYNOS_TMU_BUF_SLOPE_SEL_MASK << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
 	con |= (pdata->gain << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
@@ -1154,8 +1160,6 @@ static int exynos_of_sensor_conf(struct device_node *np,
 
 	ret = of_property_read_u32(np, "samsung,tmu_gain", &value);
 	pdata->gain = (u8)value;
-	of_property_read_u32(np, "samsung,tmu_reference_voltage", &value);
-	pdata->reference_voltage = (u8)value;
 
 	of_property_read_u32(np, "samsung,tmu_cal_type", &pdata->cal_type);
 
@@ -1210,6 +1214,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_read = exynos4210_tmu_read;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 4;
+		data->reference_voltage = 7;
 		data->efuse_value = 55;
 		data->min_efuse_value = 40;
 		data->max_efuse_value = 100;
@@ -1226,6 +1231,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 4;
+		data->reference_voltage = 16;
 		data->efuse_value = 55;
 		if (data->soc != SOC_ARCH_EXYNOS5420 &&
 		    data->soc != SOC_ARCH_EXYNOS5420_TRIMINFO)
@@ -1241,6 +1247,10 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 8;
+		if (res.start == EXYNOS5433_G3D_BASE)
+			data->reference_voltage = 23;
+		else
+			data->reference_voltage = 16;
 		data->efuse_value = 75;
 		data->min_efuse_value = 40;
 		data->max_efuse_value = 150;
@@ -1252,6 +1262,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_set_emulation = exynos5440_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos5440_tmu_clear_irqs;
 		data->ntrip = 4;
+		data->reference_voltage = 16;
 		data->efuse_value = 0x5d2d;
 		data->min_efuse_value = 16;
 		data->max_efuse_value = 76;
@@ -1263,6 +1274,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
 		data->ntrip = 8;
+		data->reference_voltage = 17;
 		data->efuse_value = 75;
 		data->min_efuse_value = 15;
 		data->max_efuse_value = 100;
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 4c49312..9f4318c 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -42,16 +42,12 @@ enum soc_type {
  * struct exynos_tmu_platform_data
  * @gain: gain of amplifier in the positive-TC generator block
  *	0 < gain <= 15
- * @reference_voltage: reference voltage of amplifier
- *	in the positive-TC generator block
- *	0 < reference_voltage <= 31
  * @cal_type: calibration type for temperature
  *
  * This structure is required for configuration of exynos_tmu driver.
  */
 struct exynos_tmu_platform_data {
 	u8 gain;
-	u8 reference_voltage;
 
 	u32 cal_type;
 };
-- 
1.9.1
