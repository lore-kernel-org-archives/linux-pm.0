From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 04/12] thermal: exynos: remove parsing of
 samsung,tmu_noise_cancel_mode property
Date: Tue, 06 Mar 2018 15:43:47 +0100
Message-ID: <1520347435-22970-5-git-send-email-b.zolnierkie@samsung.com>
References: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180306144445epcas1p1b2dee15107098f5974e3c41403594ffc@epcas1p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

All SoCs use the same value (4) for the noise cancel mode so just
make it explicit and remove parsing of samsung,tmu_noise_cancel_mode
property.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 10 ++++------
 drivers/thermal/samsung/exynos_tmu.h |  3 ---
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 5877dd4..adfd9ef 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -168,6 +168,8 @@
 #define EXYNOS_FIRST_POINT_TRIM			25
 #define EXYNOS_SECOND_POINT_TRIM		85
 
+#define EXYNOS_NOISE_CANCEL_MODE		4
+
 #define MCELSIUS	1000
 /**
  * struct exynos_tmu_data : A structure to hold the private data of the TMU
@@ -386,10 +388,8 @@ static u32 get_con_reg(struct exynos_tmu_data *data, u32 con)
 	con &= ~(EXYNOS_TMU_BUF_SLOPE_SEL_MASK << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
 	con |= (pdata->gain << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
 
-	if (pdata->noise_cancel_mode) {
-		con &= ~(EXYNOS_TMU_TRIP_MODE_MASK << EXYNOS_TMU_TRIP_MODE_SHIFT);
-		con |= (pdata->noise_cancel_mode << EXYNOS_TMU_TRIP_MODE_SHIFT);
-	}
+	con &= ~(EXYNOS_TMU_TRIP_MODE_MASK << EXYNOS_TMU_TRIP_MODE_SHIFT);
+	con |= (EXYNOS_NOISE_CANCEL_MODE << EXYNOS_TMU_TRIP_MODE_SHIFT);
 
 	return con;
 }
@@ -1153,8 +1153,6 @@ static int exynos_of_sensor_conf(struct device_node *np,
 	pdata->gain = (u8)value;
 	of_property_read_u32(np, "samsung,tmu_reference_voltage", &value);
 	pdata->reference_voltage = (u8)value;
-	of_property_read_u32(np, "samsung,tmu_noise_cancel_mode", &value);
-	pdata->noise_cancel_mode = (u8)value;
 
 	of_property_read_u32(np, "samsung,tmu_efuse_value",
 			     &pdata->efuse_value);
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index a5d8c9c..b111a01 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -45,8 +45,6 @@ enum soc_type {
  * @reference_voltage: reference voltage of amplifier
  *	in the positive-TC generator block
  *	0 < reference_voltage <= 31
- * @noise_cancel_mode: noise cancellation mode
- *	000, 100, 101, 110 and 111 can be different modes
  * @efuse_value: platform defined fuse value
  * @min_efuse_value: minimum valid trimming data
  * @max_efuse_value: maximum valid trimming data
@@ -57,7 +55,6 @@ enum soc_type {
 struct exynos_tmu_platform_data {
 	u8 gain;
 	u8 reference_voltage;
-	u8 noise_cancel_mode;
 
 	u32 efuse_value;
 	u32 min_efuse_value;
-- 
1.9.1
