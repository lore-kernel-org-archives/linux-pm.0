From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 4/4] power: supply: sc27xx: Fix capacity saving function
Date: Tue, 15 Jan 2019 18:32:37 +0800
Message-ID: <30327406bfd6aa0559e48b766c87c6845fe059af.1547544142.git.baolin.wang@linaro.org>
References: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
In-Reply-To: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
References: <76a12fe5d0cc670266100b0587b047714c9a8a83.1547544142.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org, zhang.lyra@gmail.com, orsonzhai@gmail.com
List-Id: linux-pm@vger.kernel.org

From: Yuanjiang Yu <yuanjiang.yu@unisoc.com>

We found sometimes we can not get the saving capacity to initialize the
battery capacity, the reason is the user area registers are put on power
always-on region, so we need delay some time to wait until values are
updated successfully.

Moreover we also should clear the USER_AREA_CLEAR register after setting
the USER_AREA_SET register, otherwise we can not save the values in the
USER_AREA_SET register.

Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc27xx_fuel_gauge.c |   64 +++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index ea1349f..24895cc 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -171,10 +171,37 @@ static int sc27xx_fgu_save_boot_mode(struct sc27xx_fgu_data *data,
 	if (ret)
 		return ret;
 
+	/*
+	 * Since the user area registers are put on power always-on region,
+	 * then these registers changing time will be a little long. Thus
+	 * here we should delay 200us to wait until values are updated
+	 * successfully according to the datasheet.
+	 */
+	udelay(200);
+
+	ret = regmap_update_bits(data->regmap,
+				 data->base + SC27XX_FGU_USER_AREA_SET,
+				 SC27XX_FGU_MODE_AREA_MASK,
+				 boot_mode << SC27XX_FGU_MODE_AREA_SHIFT);
+	if (ret)
+		return ret;
+
+	/*
+	 * Since the user area registers are put on power always-on region,
+	 * then these registers changing time will be a little long. Thus
+	 * here we should delay 200us to wait until values are updated
+	 * successfully according to the datasheet.
+	 */
+	udelay(200);
+
+	/*
+	 * According to the datasheet, we should set the USER_AREA_CLEAR to 0 to
+	 * make the user area data available, otherwise we can not save the user
+	 * area data.
+	 */
 	return regmap_update_bits(data->regmap,
-				  data->base + SC27XX_FGU_USER_AREA_SET,
-				  SC27XX_FGU_MODE_AREA_MASK,
-				  boot_mode << SC27XX_FGU_MODE_AREA_SHIFT);
+				  data->base + SC27XX_FGU_USER_AREA_CLEAR,
+				  SC27XX_FGU_MODE_AREA_MASK, 0);
 }
 
 static int sc27xx_fgu_save_last_cap(struct sc27xx_fgu_data *data, int cap)
@@ -188,9 +215,36 @@ static int sc27xx_fgu_save_last_cap(struct sc27xx_fgu_data *data, int cap)
 	if (ret)
 		return ret;
 
+	/*
+	 * Since the user area registers are put on power always-on region,
+	 * then these registers changing time will be a little long. Thus
+	 * here we should delay 200us to wait until values are updated
+	 * successfully according to the datasheet.
+	 */
+	udelay(200);
+
+	ret = regmap_update_bits(data->regmap,
+				 data->base + SC27XX_FGU_USER_AREA_SET,
+				 SC27XX_FGU_CAP_AREA_MASK, cap);
+	if (ret)
+		return ret;
+
+	/*
+	 * Since the user area registers are put on power always-on region,
+	 * then these registers changing time will be a little long. Thus
+	 * here we should delay 200us to wait until values are updated
+	 * successfully according to the datasheet.
+	 */
+	udelay(200);
+
+	/*
+	 * According to the datasheet, we should set the USER_AREA_CLEAR to 0 to
+	 * make the user area data available, otherwise we can not save the user
+	 * area data.
+	 */
 	return regmap_update_bits(data->regmap,
-				  data->base + SC27XX_FGU_USER_AREA_SET,
-				  SC27XX_FGU_CAP_AREA_MASK, cap);
+				  data->base + SC27XX_FGU_USER_AREA_CLEAR,
+				  SC27XX_FGU_CAP_AREA_MASK, 0);
 }
 
 static int sc27xx_fgu_read_last_cap(struct sc27xx_fgu_data *data, int *cap)
-- 
1.7.9.5
