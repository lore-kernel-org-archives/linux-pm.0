Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398C325B090;
	Tue, 21 Jul 2026 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784636813; cv=none; b=O8Ivr1EKpElYC7mHAo/veddVdrQKUmNTOrPfvbdQBL8oqCDub/KdGqDxG/Czh3wZeXNHJgsa0g6CTVilis9ZreeeGx5DZY2jUn47Ip8ZHSx8vjHIHuNZK5c7PMjBVgSuw6dkncU4QihsOUoJvmo4xSEUvoNaG7LXzWsDGKpzJNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784636813; c=relaxed/simple;
	bh=hAd/n3f/aPd0kv/ld47dJjfh5HgbJegGDG2sWqzBw8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTgITGtqOt/kPkyBpP3r9LewODjZmUMABupiGdtM+02SVWLYnkWPPuzajpSmPaHilY1chj6zVlv974n6mdsch8TvYA3RBVELYDCaMulBksKS/AMhAfG4W4nEdcXoeUKDu7eat/I6YLeVeF6lyOvgVDJSaJ4tZHGdy7FrrEJpfPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.205])
	by gateway (Coremail) with SMTP id _____8Bx1+qIZV9qMaEFAA--.22068S3;
	Tue, 21 Jul 2026 20:26:48 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.205])
	by front1 (Coremail) with SMTP id qMiowJCxPsdxZV9qofsTAA--.41890S3;
	Tue, 21 Jul 2026 20:26:45 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	zhanghongchen <zhanghongchen@loongson.cn>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mfd@lists.linux.dev,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 4/4] thermal/drivers/loongson2: Add support for Loongson-2K0300
Date: Tue, 21 Jul 2026 20:26:18 +0800
Message-ID: <25a52158e4281a9ae666f46b840527f78497e95a.1784619512.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1784619512.git.zhoubinbin@loongson.cn>
References: <cover.1784619512.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxPsdxZV9qofsTAA--.41890S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEPCGpe808JFwAAsR
X-Coremail-Antispam: 1Uk129KBj93XoW3WFyUurWxGw43Zr1kWrWfWFX_yoWfAr43pa
	47AFy5KFZ7Gr48uw1jyr1DZr4Yvr13tFZxXFs7Gw1rW393t34agFy7tF1FvrWfCFZ8JFy7
	ZryDKFWUua4DX3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Wrv_ZF1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j2XdUUUUUU=

Add support for the thermal sensor found on the Loongson-2K0300 SoC.

The Loongson-2K0300 thermal sensor uses a 10-bit ADC and requires
per-chip calibration. The calibration offset is stored in the CHIP ID
registers, which are accessed via syscon. The driver reads this offset
and applies it when converting the raw ADC value to millicelsius.

To handle old fuse versions that cannot be calibrated correctly, the
driver includes a fallback formula and a validity check. Once invalid
data is detected, the driver falls back to the old formula for future
reads and warns the user.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/thermal/loongson2_thermal.c | 112 +++++++++++++++++++++++++---
 1 file changed, 100 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index d7d221c3136d..e8d11e592a1f 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -2,9 +2,11 @@
 /*
  * Author: zhanghongchen <zhanghongchen@loongson.cn>
  *         Yinbo Zhu <zhuyinbo@loongson.cn>
- * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
+ *         Binbin Zhou <zhoubinbin@loongson.cn>
+ * Copyright (C) 2022-2026 Loongson Technology Corporation Limited
  */
 
+#include <linux/bitfield.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/minmax.h>
@@ -14,6 +16,9 @@
 #include <linux/property.h>
 #include <linux/thermal.h>
 #include <linux/units.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/syscore_ops.h>
 
 #include "thermal_hwmon.h"
 
@@ -23,28 +28,48 @@
 #define LOONGSON2_THSENS_CTRL_LOW_REG	0x8
 #define LOONGSON2_THSENS_STATUS_REG	0x10
 #define LOONGSON2_THSENS_OUT_REG	0x14
+#define LOONGSON2_THSENS_CFG_REG	0x18
 
 #define LOONGSON2_THSENS_INT_LO		BIT(0)
 #define LOONGSON2_THSENS_INT_HIGH	BIT(1)
 #define LOONGSON2_THSENS_INT_EN		(LOONGSON2_THSENS_INT_LO | \
 					 LOONGSON2_THSENS_INT_HIGH)
-#define LOONGSON2_THSENS_OUT_MASK	0xFF
+#define LOONGSON2_THSENS_OUT_8B_MASK	0xFF
+#define LOONGSON2_THSENS_OUT_10B_MASK	GENMASK(10, 0)
+
+#define LS2K0300_CHIP_ID0		0x10
+#define LS2K0300_CHIP_ID1		0x14
+#define LS2K0300_EXTERN_ID		BIT(4)
+#define LS2K0300_ID0_VAL_MASK		GENMASK(31, 20)
+#define LS2K0300_ID1_VAL_MASK		GENMASK(15, 0)
+
+#define LS2K0300_COMP_VAL_MASK		GENMASK(14, 0)
+#define LS2K0300_COMP_SIGN_BIT		BIT(15)
+
+#define LS2K0300_LOWEST_VALID_TEMP	(-55000)
+#define LS2K0300_HIGHEST_VALID_TEMP	(125000)
 
 /*
  * This flag is used to indicate the temperature reading
  * method of the Loongson-2K2000
  */
 #define LS2K2000_THSENS_OUT_FLAG	BIT(0)
+#define LS2K0300_CHIP_ID_FLAG		BIT(1)
+#define LS2K0300_OLD_FUSE_FLAG		BIT(2)
 
 struct loongson2_thermal_chip_data {
 	unsigned int thermal_sensor_sel;
 	unsigned int flags;
+	const struct thermal_zone_device_ops *thermal_ops;
 };
 
 struct loongson2_thermal_data {
+	int calib_offset;
+	struct device *dev;
 	void __iomem *ctrl_reg;
 	void __iomem *temp_reg;
-	const struct loongson2_thermal_chip_data *chip_data;
+	struct regmap *regmap_cfg;
+	struct loongson2_thermal_chip_data *chip_data;
 };
 
 static void loongson2_set_ctrl_regs(struct loongson2_thermal_data *data,
@@ -71,13 +96,55 @@ static int loongson2_thermal_set(struct loongson2_thermal_data *data,
 	return 0;
 }
 
+static int loongson2_2k0300_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct loongson2_thermal_data *tdata = thermal_zone_device_priv(tz);
+	int calib_data, calib_offset, temp_mc, raw_adc;
+	u32 chip_id0, chip_id1;
+
+	writel(0xff03, tdata->ctrl_reg + LOONGSON2_THSENS_CFG_REG);
+	raw_adc = FIELD_GET(LOONGSON2_THSENS_OUT_10B_MASK,
+			    readl(tdata->ctrl_reg + LOONGSON2_THSENS_OUT_REG));
+
+	if (tdata->chip_data->flags & LS2K0300_OLD_FUSE_FLAG) {
+		*temp = raw_adc * 569 - 394700;
+		return 0;
+	}
+
+	regmap_read(tdata->regmap_cfg, LS2K0300_CHIP_ID0, &chip_id0);
+	regmap_read(tdata->regmap_cfg, LS2K0300_CHIP_ID1, &chip_id1);
+
+	if (chip_id0 & LS2K0300_EXTERN_ID) {
+		calib_data = FIELD_GET(LS2K0300_ID1_VAL_MASK, chip_id1);
+		calib_offset = FIELD_GET(LS2K0300_COMP_VAL_MASK, calib_data);
+		if (calib_data & LS2K0300_COMP_SIGN_BIT)
+			calib_offset = -calib_offset;
+	} else {
+		calib_data = FIELD_GET(LS2K0300_ID0_VAL_MASK, chip_id0);
+		calib_offset = FIELD_GET(LS2K0300_COMP_VAL_MASK, calib_data);
+	}
+
+	tdata->calib_offset = calib_offset;
+	temp_mc = (raw_adc + calib_offset) * 570 - 394700;
+
+	/* For old fuse which can not read right thermal data */
+	if (temp_mc < LS2K0300_LOWEST_VALID_TEMP || temp_mc > LS2K0300_HIGHEST_VALID_TEMP) {
+		dev_warn_once(tdata->dev, "It's an old fuse, thermal %d is not right\n", temp_mc);
+		tdata->chip_data->flags |= LS2K0300_OLD_FUSE_FLAG;
+		temp_mc = raw_adc * 569 - 394700;
+	}
+	*temp = temp_mc;
+
+	return 0;
+}
+
 static int loongson2_2k1000_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	int val;
 	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
 
 	val = readl(data->ctrl_reg + LOONGSON2_THSENS_OUT_REG);
-	*temp = ((val & LOONGSON2_THSENS_OUT_MASK) - HECTO) * KILO;
+	*temp = ((val & LOONGSON2_THSENS_OUT_8B_MASK) - HECTO) * KILO;
 
 	return 0;
 }
@@ -112,6 +179,11 @@ static int loongson2_thermal_set_trips(struct thermal_zone_device *tz, int low,
 	return loongson2_thermal_set(data, low/MILLI, high/MILLI, true);
 }
 
+static const struct thermal_zone_device_ops loongson2_2k0300_of_thermal_ops = {
+	.get_temp = loongson2_2k0300_get_temp,
+	.set_trips = loongson2_thermal_set_trips,
+};
+
 static const struct thermal_zone_device_ops loongson2_2k1000_of_thermal_ops = {
 	.get_temp = loongson2_2k1000_get_temp,
 	.set_trips = loongson2_thermal_set_trips,
@@ -124,7 +196,6 @@ static const struct thermal_zone_device_ops loongson2_2k2000_of_thermal_ops = {
 
 static int loongson2_thermal_probe(struct platform_device *pdev)
 {
-	const struct thermal_zone_device_ops *thermal_ops;
 	struct device *dev = &pdev->dev;
 	struct loongson2_thermal_data *data;
 	struct thermal_zone_device *tzd;
@@ -134,7 +205,8 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	data->chip_data = device_get_match_data(dev);
+	data->dev = dev;
+	data->chip_data = (struct loongson2_thermal_chip_data *)device_get_match_data(dev);
 
 	data->ctrl_reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->ctrl_reg))
@@ -145,10 +217,14 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 		data->temp_reg = devm_platform_ioremap_resource(pdev, 1);
 		if (IS_ERR(data->temp_reg))
 			return PTR_ERR(data->temp_reg);
+	}
 
-		thermal_ops = &loongson2_2k2000_of_thermal_ops;
-	} else {
-		thermal_ops = &loongson2_2k1000_of_thermal_ops;
+	/* The chip id register is needed for Loongson-2K0300 */
+	if (data->chip_data->flags & LS2K0300_CHIP_ID_FLAG) {
+		data->regmap_cfg =
+			syscon_regmap_lookup_by_phandle(dev->of_node, "loongson,chipid");
+		if (IS_ERR(data->regmap_cfg))
+			return PTR_ERR(data->regmap_cfg);
 	}
 
 	irq = platform_get_irq(pdev, 0);
@@ -160,7 +236,7 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 	loongson2_thermal_set(data, 0, 0, false);
 
 	for (i = 0; i <= LOONGSON2_MAX_SENSOR_SEL_NUM; i++) {
-		tzd = devm_thermal_of_zone_register(dev, i, data, thermal_ops);
+		tzd = devm_thermal_of_zone_register(dev, i, data, data->chip_data->thermal_ops);
 		if (!IS_ERR(tzd))
 			break;
 
@@ -183,17 +259,29 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct loongson2_thermal_chip_data loongson2_thermal_ls2k1000_data = {
+static struct loongson2_thermal_chip_data loongson2_thermal_ls2k0300_data = {
+	.thermal_sensor_sel = 0,
+	.flags = LS2K0300_CHIP_ID_FLAG,
+	.thermal_ops = &loongson2_2k0300_of_thermal_ops,
+};
+
+static struct loongson2_thermal_chip_data loongson2_thermal_ls2k1000_data = {
 	.thermal_sensor_sel = 0,
 	.flags = 0,
+	.thermal_ops = &loongson2_2k1000_of_thermal_ops,
 };
 
-static const struct loongson2_thermal_chip_data loongson2_thermal_ls2k2000_data = {
+static struct loongson2_thermal_chip_data loongson2_thermal_ls2k2000_data = {
 	.thermal_sensor_sel = 0,
 	.flags = LS2K2000_THSENS_OUT_FLAG,
+	.thermal_ops = &loongson2_2k2000_of_thermal_ops,
 };
 
 static const struct of_device_id of_loongson2_thermal_match[] = {
+	{
+		.compatible = "loongson,ls2k0300-thermal",
+		.data = &loongson2_thermal_ls2k0300_data,
+	},
 	{
 		.compatible = "loongson,ls2k1000-thermal",
 		.data = &loongson2_thermal_ls2k1000_data,
-- 
2.52.0

