Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589A3397E85;
	Fri, 10 Jul 2026 08:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671938; cv=none; b=pfe9jPLNnehaRXwHYakpQ5Iv14Oh+ZLTq+nrxZsiwt8m8zT//yiwSXJY2XAiC+YDp/XGvRqjtyjyhG4Moo6xBdJ24tlnMoeIMRRwvJH0S2X3jcHKu6eUU+YeiA4ij9oz/btvHmfA52LXrF8bwoDhAzaAs8UdVrJP7uhWwEAx2C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671938; c=relaxed/simple;
	bh=noKs33TJZorLDIcKqQG4GC8+hvDY0J+qKj32q8KUzrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HguprKAyz/Z0r7aDRaBikQVx/9MdNtcOONDKi1uACPWAiuUBw5XWmJFjBf4upl4mocdT+bcsoP1STzr2Vgx0o0RDKAkGM/yx5291SwaMk+YbEnyD1xTg3Gbow9LQvt9vvyB0rVHWwmN5pUDEIwrRzZ249nH3wuZoW1G35KkXVrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.155])
	by gateway (Coremail) with SMTP id _____8Dxeet3rFBqIzQCAA--.9121S3;
	Fri, 10 Jul 2026 16:25:27 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.155])
	by front1 (Coremail) with SMTP id qMiowJBxEuRtrFBqEx4IAA--.24690S4;
	Fri, 10 Jul 2026 16:25:25 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 2/2] thermal/drivers/loongson2: Add thermal driver support for Loongson-2K0300
Date: Fri, 10 Jul 2026 16:25:00 +0800
Message-ID: <e5a574b2ae0e5e0ec32fe81c0ccd03eb3ad5a164.1783670011.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1783670011.git.zhoubinbin@loongson.cn>
References: <cover.1783670011.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxEuRtrFBqEx4IAA--.24690S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEECGpQcs0EvgAAsz
X-Coremail-Antispam: 1Uk129KBj93XoW3WFyfuw1DurWxZFy8ZFy3WrX_yoW3Ar15pa
	4UA3s8KrWkGr4Uuw1jyr1DZr4Yvry3tFZxXFs7Gw1fW393t34agFy8tF1FvrWfCFZ8JFyU
	ZryqgrZrua4DX3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsDDJDUUUU

The Loongson-2K0300 SoC uses a new thermal sensor that requires reading
a separate CPU ID register to obtain hardware version information. This
version info is used as a correction factor (fix_data) in the
temperature calculation formula.

Its thermal sensor requires the following hardware-specific handling:
 - Read chip ID register (offset 0x0 and 0x4) to get the compensation
   value (comp_val). The value is stored in either bits [31:20] of the
   ID0 register or bits [15:0] of the ID1 register, depending on the
   EXTERN_ID bit.

 - The compensation value is a signed 15-bit field; extract the value
   and apply sign accordingly.

Additionally, some early Loongson-2K0300 chips may have an old fuse that
yields invalid temperature readings outside the -55 to 125 range. In
such cases, the driver falls back to a simplified formula (raw * 569 -
394700) and logs a warning, ensuring the system can still function
without crashing.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/thermal/loongson2_thermal.c | 83 ++++++++++++++++++++++++++---
 1 file changed, 77 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index ea4dd2fb1f47..a7eb87070aa9 100644
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
@@ -23,27 +25,44 @@
 #define LOONGSON2_THSENS_CTRL_LOW_REG	0x8
 #define LOONGSON2_THSENS_STATUS_REG	0x10
 #define LOONGSON2_THSENS_OUT_REG	0x14
+#define LOONGSON2_THSENS_CFG_REG	0x18
 
 #define LOONGSON2_THSENS_INT_LO		BIT(0)
 #define LOONGSON2_THSENS_INT_HIGH	BIT(1)
 #define LOONGSON2_THSENS_INT_EN		(LOONGSON2_THSENS_INT_LO | \
 					 LOONGSON2_THSENS_INT_HIGH)
 #define LOONGSON2_THSENS_OUT_MASK	0xFF
+#define LS2K0300_THSENS_OUT_MASK	GENMASK(10, 0)
+
+#define LS2K0300_CHIP_ID1		0x4
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
 
 struct loongson2_thermal_chip_data {
 	unsigned int thermal_sensor_sel;
 	unsigned int flags;
+	const struct thermal_zone_device_ops *thermal_ops;
 };
 
 struct loongson2_thermal_data {
+	struct device *dev;
 	void __iomem *ctrl_reg;
 	void __iomem *temp_reg;
+	void __iomem *id_reg;
 	const struct loongson2_thermal_chip_data *chip_data;
 };
 
@@ -71,6 +90,38 @@ static int loongson2_thermal_set(struct loongson2_thermal_data *data,
 	return 0;
 }
 
+static int loongson2_2k0300_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct loongson2_thermal_data *tdata = thermal_zone_device_priv(tz);
+	int calib_data, calib_offset, temp_mc, raw_adc;
+	u32 chip_id0, chip_id1;
+
+	raw_adc = FIELD_GET(LS2K0300_THSENS_OUT_MASK,
+			    readl(tdata->ctrl_reg + LOONGSON2_THSENS_OUT_REG));
+	chip_id0 = readl(tdata->id_reg);
+	chip_id1 = readl(tdata->id_reg + LS2K0300_CHIP_ID1);
+
+	if (chip_id0 & LS2K0300_EXTERN_ID)
+		calib_data = FIELD_GET(LS2K0300_ID1_VAL_MASK, chip_id1);
+	else
+		calib_data = FIELD_GET(LS2K0300_ID0_VAL_MASK, chip_id0);
+
+	calib_offset = FIELD_GET(LS2K0300_COMP_VAL_MASK, calib_data);
+	if (calib_data & LS2K0300_COMP_SIGN_BIT)
+		calib_offset = -calib_offset;
+
+	temp_mc = (raw_adc + calib_offset) * 570 - 394700;
+
+	/* For old fuse which can not read right thermal data */
+	if (temp_mc < LS2K0300_LOWEST_VALID_TEMP || temp_mc > LS2K0300_HIGHEST_VALID_TEMP) {
+		dev_warn_once(tdata->dev, "It's an old fuse, thermal %d is not right\n", temp_mc);
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
@@ -112,6 +163,11 @@ static int loongson2_thermal_set_trips(struct thermal_zone_device *tz, int low,
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
@@ -124,7 +180,6 @@ static const struct thermal_zone_device_ops loongson2_2k2000_of_thermal_ops = {
 
 static int loongson2_thermal_probe(struct platform_device *pdev)
 {
-	const struct thermal_zone_device_ops *thermal_ops;
 	struct device *dev = &pdev->dev;
 	struct loongson2_thermal_data *data;
 	struct thermal_zone_device *tzd;
@@ -134,6 +189,7 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	data->dev = dev;
 	data->chip_data = device_get_match_data(dev);
 
 	data->ctrl_reg = devm_platform_ioremap_resource(pdev, 0);
@@ -145,10 +201,13 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 		data->temp_reg = devm_platform_ioremap_resource(pdev, 1);
 		if (IS_ERR(data->temp_reg))
 			return PTR_ERR(data->temp_reg);
+	}
 
-		thermal_ops = &loongson2_2k2000_of_thermal_ops;
-	} else {
-		thermal_ops = &loongson2_2k1000_of_thermal_ops;
+	/* The chip id register is needed for Loongson-2K0300 */
+	if (data->chip_data->flags & LS2K0300_CHIP_ID_FLAG) {
+		data->id_reg = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(data->id_reg))
+			return PTR_ERR(data->id_reg);
 	}
 
 	irq = platform_get_irq(pdev, 0);
@@ -160,7 +219,7 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 	loongson2_thermal_set(data, 0, 0, false);
 
 	for (i = 0; i <= LOONGSON2_MAX_SENSOR_SEL_NUM; i++) {
-		tzd = devm_thermal_of_zone_register(dev, i, data, thermal_ops);
+		tzd = devm_thermal_of_zone_register(dev, i, data, data->chip_data->thermal_ops);
 
 		if (!IS_ERR(tzd))
 			break;
@@ -181,17 +240,29 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
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
+	.thermal_ops = &loongson2_2k1000_of_thermal_ops,
 };
 
 static const struct loongson2_thermal_chip_data loongson2_thermal_ls2k2000_data = {
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

