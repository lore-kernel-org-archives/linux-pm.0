Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC4F3BF68F;
	Thu, 17 Sep 2026 11:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643761; cv=none; b=F9JecTApW76S5/mS9wnHG8U672Vw5K3F/NQgzNSWrT94fUWdD2/OEhvwK0De1G7AHQx0AK5tC5Bh/EGgd5h3wImyTR+OhWMc5az3NwyJqdGXXh24qh/9jacG7ddiKYJkTtRR6vBaWKd5Qo5wijeGeRpwstiKt7Yxpn4mPye0snE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643761; c=relaxed/simple;
	bh=uPizAG4nI3FS/QLagOS8il8eqEamlMmxb7OjmTKpqaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7/Z3LIo1urtaGDqOGlWNkpEjymJuttEamTDSX4P1bPiVivTYaDx41DdSZQ06BZL15GB7lIXoA4BDtlusMh9rSQGZTX9B2pdjU9GPeU3TD/8w0ID8d4e7YaCN0fMlz2xS0alV70At2vS+TBZkM1SO6Vebkn4eOdkjA+bi2eVoh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.112])
	by gateway (Coremail) with SMTP id _____8BxrtLpy6tqQP8MAA--.38028S3;
	Thu, 17 Sep 2026 19:15:53 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.112])
	by front1 (Coremail) with SMTP id qMiowJDxBc3my6tqOc4hAA--.44812S2;
	Thu, 17 Sep 2026 19:15:52 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	zhanghongchen <zhanghongchen@loongson.cn>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v5 4/4] thermal/drivers/loongson2: Add support for Loongson-2K0300
Date: Thu, 17 Sep 2026 19:15:43 +0800
Message-ID: <6985dce54bb5b87bb232c714d236b7cb82eeb58c.1789546118.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1789546118.git.zhoubinbin@loongson.cn>
References: <cover.1789546118.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxBc3my6tqOc4hAA--.44812S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgENCGqrWncIxQAAsn
X-Coremail-Antispam: 1Uk129KBj93XoW3WrW5Kw1UtFyUGw43XrW5urX_yoW3Jr1Dpa
	y7AFy5KFW8Gr48uw4jyr1DZF4Yvr17tFZxZFs7Kw1ru397t34aqrW7tF1FvrW3CFs8JFy7
	ZrWqkFWUCa4DX3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxhiSDUUUU

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
 drivers/thermal/loongson2_thermal.c | 94 ++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index fb4793a9bc55..8930a8a75da7 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -2,9 +2,11 @@
 /*
  * Author: zhanghongchen <zhanghongchen@loongson.cn>
  *         Yinbo Zhu <zhuyinbo@loongson.cn>
+ *         Binbin Zhou <zhoubinbin@loongson.cn>
  * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
  */
 
+#include <linux/bitfield.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/minmax.h>
@@ -13,6 +15,9 @@
 #include <linux/property.h>
 #include <linux/thermal.h>
 #include <linux/units.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/syscore_ops.h>
 
 #include "thermal_hwmon.h"
 
@@ -22,18 +27,34 @@
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
+#define LOONGSON2_THSENS_OUT_11B_MASK	GENMASK(10, 0)
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
@@ -42,8 +63,11 @@ struct loongson2_thermal_chip_data {
 };
 
 struct loongson2_thermal_data {
+	struct device *dev;
 	void __iomem *ctrl_reg;
 	void __iomem *temp_reg;
+	struct regmap *regmap_cfg;
+	u32 flags;
 	const struct loongson2_thermal_chip_data *chip_data;
 };
 
@@ -71,13 +95,54 @@ static int loongson2_thermal_set(struct loongson2_thermal_data *data,
 	return 0;
 }
 
+static int loongson2_2k0300_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct loongson2_thermal_data *tdata = thermal_zone_device_priv(tz);
+	int calib_data, calib_offset, temp_mc, raw_adc;
+	u32 chip_id0 = 0, chip_id1 = 0;
+
+	writel(0xff03, tdata->ctrl_reg + LOONGSON2_THSENS_CFG_REG);
+	raw_adc = FIELD_GET(LOONGSON2_THSENS_OUT_11B_MASK,
+			    readl(tdata->ctrl_reg + LOONGSON2_THSENS_OUT_REG));
+
+	if (tdata->flags & LS2K0300_OLD_FUSE_FLAG) {
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
+	temp_mc = (raw_adc + calib_offset) * 570 - 394700;
+
+	/* For old fuse which can not read right thermal data */
+	if (temp_mc < LS2K0300_LOWEST_VALID_TEMP || temp_mc > LS2K0300_HIGHEST_VALID_TEMP) {
+		dev_warn_once(tdata->dev, "It's an old fuse, thermal %d is not right\n", temp_mc);
+		tdata->flags |= LS2K0300_OLD_FUSE_FLAG;
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
@@ -112,6 +177,11 @@ static int loongson2_thermal_set_trips(struct thermal_zone_device *tz, int low,
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
@@ -134,6 +204,8 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	data->chip_data = device_get_match_data(dev);
+	data->flags = data->chip_data->flags;
+	data->dev = dev;
 
 	data->ctrl_reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->ctrl_reg))
@@ -146,6 +218,14 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 			return PTR_ERR(data->temp_reg);
 	}
 
+	/* The chip id register is needed for Loongson-2K0300 */
+	if (data->chip_data->flags & LS2K0300_CHIP_ID_FLAG) {
+		data->regmap_cfg =
+			syscon_regmap_lookup_by_phandle(dev->of_node, "loongson,chipid");
+		if (IS_ERR(data->regmap_cfg))
+			return PTR_ERR(data->regmap_cfg);
+	}
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
@@ -178,6 +258,12 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct loongson2_thermal_chip_data loongson2_thermal_ls2k0300_data = {
+	.thermal_sensor_sel = 0,
+	.flags = LS2K0300_CHIP_ID_FLAG,
+	.thermal_ops = &loongson2_2k0300_of_thermal_ops,
+};
+
 static const struct loongson2_thermal_chip_data loongson2_thermal_ls2k1000_data = {
 	.thermal_sensor_sel = 0,
 	.flags = 0,
@@ -191,6 +277,10 @@ static const struct loongson2_thermal_chip_data loongson2_thermal_ls2k2000_data
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

