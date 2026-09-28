Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3641736492D;
	Mon, 28 Sep 2026 04:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790570705; cv=none; b=NxWZBAECIgWy9wWyQL56zdlcV0fI6E1tHE+gBE0dtWuBU2CPkOnDqOn7PQO5gTJJdQInS5+TWTRri43RwEoaYNmN3T54RPrepg046Va57aUkINCH4pzMqx0s5glZEESrD0KLl9emz7E7lZoJZBASJsL2aIXNoBkWZfnGsaSRcEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790570705; c=relaxed/simple;
	bh=UiLqD3bQ54q3Kp5KqDITW+bog8jer8Qudy0qwgKrUPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRnVfhAmP6pr/ILWmVlFpmBuAOFvux7BOEfQDoXZC9+jYbyiL0Fb1gKChwbyrRES96WZAtk07S4mpDmm8O+dAbxSMSemEBozIcAFv+wNNajOzCy7OuTPN/7eZ1tzhjZQFJpufDNMFD59wfIIGj8dn5o2YBr9GSJcs8QJ5RIIggk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.159])
	by gateway (Coremail) with SMTP id _____8AxdvDN8LlqrWEQAA--.47932S3;
	Mon, 28 Sep 2026 12:45:01 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.159])
	by front1 (Coremail) with SMTP id qMiowJDxBc3I8Llq3fElAA--.52784S5;
	Mon, 28 Sep 2026 12:45:01 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v6 7/7] thermal/drivers/loongson2: Add Loongson-2K0300 support
Date: Mon, 28 Sep 2026 12:44:40 +0800
Message-ID: <549b204c1621341edc5b4aa4f81e164ec5ce7fed.1790561983.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1790561983.git.zhoubinbin@loongson.cn>
References: <cover.1790561983.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxBc3I8Llq3fElAA--.52784S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEECGq5yvUCagAAsI
X-Coremail-Antispam: 1Uk129KBj93XoW3JFW7Wr4fGF15GF1fKF1rAFc_yoW3WrWUpa
	yUAFy5trWkGr48Ww4Iyw4DZr4YgrnFyFyavFZ7Kw1rZws3t34aqFyktFyYvryrGFWUJFyU
	Zr4qqrW7CayDX3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6rWY6Fy7McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280
	aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jxvtAUUUUU=

The Loongson-2K0300 sensor provides an 11-bit output and requires
calibration data from the CHIP ID registers. Read the calibration offset
throughthe `loongson,chipid` syscon phandle, initialize the sensor
configuration register, and calculate the temperature with the
calibrated slope and offset.

Early Loongson-2K0300 fuse revisions may provide unusable calibration
data. If the calibrated formula reports a temperature outside the valid
sensor range, fall back to the old-fuse slope with a zero calibration
offset.

The set_trips callback of Loongson-2K0300 will be added in the future.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/thermal/loongson2_thermal.c | 136 ++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 17aa1d80a2e6..a53d70b824f3 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -8,10 +8,12 @@
 #include <linux/bitfield.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/regmap.h>
 #include <linux/thermal.h>
 #include <linux/units.h>
 
@@ -31,11 +33,37 @@
 #define LOONGSON2_THSENS_CTRL_INTEN	BIT(8)
 
 #define LOONGSON2_THSENS_OUT_8B_MASK	GENMASK(7, 0)
+#define LOONGSON2_THSENS_OUT_11B_MASK	GENMASK(10, 0)
 #define LOONGSON2_THSENS_OUT_16B_MASK	GENMASK(15, 0)
 
 #define LOONGSON2_LOWEST_VALID_TEMP     (-40000)
 #define LOONGSON2_HIGHEST_VALID_TEMP    (125000)
 
+/* Loongson-2K0300-Specific Registers */
+#define LS2K0300_CHIP_ID0		0x10
+#define LS2K0300_CHIP_ID1		0x14
+
+#define LS2K0300_THSENS_CFG_REG		0x18
+#define LS2K0300_THSENS_INIT_MASK	0xff03
+
+#define LS2K0300_EXTERN_ID		BIT(4)
+#define LS2K0300_ID0_VAL_MASK		GENMASK(31, 20)
+#define LS2K0300_ID1_VAL_MASK		GENMASK(15, 0)
+
+#define LS2K0300_COMP_VAL_MASK		GENMASK(14, 0)
+#define LS2K0300_COMP_SIGN_BIT		BIT(15)
+
+#define LS2K0300_TEMP_SLOPE		(570)	/* m°C/LSB, calibrated */
+#define LS2K0300_TEMP_SLOPE_OLD		(569)	/* m°C/LSB, old fuse */
+#define LS2K0300_TEMP_OFFSET		(394700) /* m°C */
+
+/*
+ * Set when the on-chip calibration data is unusable (early 2K0300
+ * fuse revision). The driver then uses LS2K0300_TEMP_SLOPE_OLD with
+ * calib_offset = 0 instead of the calibrated formula.
+ */
+#define LS2K0300_OLD_FUSE_FLAG		BIT(0)
+
 /* Loongson-2K2000-Specific Registers */
 #define LS2K2000_THSENS_HI_GATE_HI_REG	0x18
 #define LS2K2000_THSENS_HI_GATE_LOW_REG	0x1c
@@ -60,12 +88,18 @@ struct loongson2_thermal_chip_data {
 struct loongson2_thermal_data {
 	void __iomem *ctrl_reg;
 	void __iomem *extend_reg;
+	struct regmap *regmap_cfg;
+	unsigned int flags;
+	int calib_offset;
 	const struct loongson2_thermal_chip_data *chip_data;
 };
 
 static void loongson2_thermal_set_trip_temp(struct loongson2_thermal_data *data,
 					    int low, int high, bool enable)
 {
+	if (!data->chip_data->set_trips_regs)
+		return;
+
 	/* Set low temperature threshold */
 	data->chip_data->set_trips_regs(data, low, true, enable);
 
@@ -85,6 +119,94 @@ static int loognson2_thermal_set_trips(struct thermal_zone_device *tz, int low,
 	return 0;
 }
 
+static int ls2k0300_adc_to_temp_mc(struct loongson2_thermal_data *data, int slope)
+{
+	int raw_adc;
+
+	raw_adc = FIELD_GET(LOONGSON2_THSENS_OUT_11B_MASK,
+			    readl(data->ctrl_reg + LOONGSON2_THSENS_OUT_REG));
+
+	return (raw_adc + data->calib_offset) * slope - LS2K0300_TEMP_OFFSET;
+}
+
+static int ls2k0300_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
+	int slope = LS2K0300_TEMP_SLOPE;
+
+	if (data->flags & LS2K0300_OLD_FUSE_FLAG)
+		slope = LS2K0300_TEMP_SLOPE_OLD;
+
+	*temp = ls2k0300_adc_to_temp_mc(data, slope);
+
+	return 0;
+}
+
+static void ls2k0300_thermal_detect_old_fuse(struct device *dev,
+					     struct loongson2_thermal_data *data)
+{
+	int temp;
+
+	temp = ls2k0300_adc_to_temp_mc(data, LS2K0300_TEMP_SLOPE);
+
+	if (temp < LOONGSON2_LOWEST_VALID_TEMP ||
+	    temp > LOONGSON2_HIGHEST_VALID_TEMP) {
+		dev_warn(dev, "calibrated temperature %d m°C out of range [%d, %d], using old fuse formula\n",
+			 temp, LOONGSON2_LOWEST_VALID_TEMP, LOONGSON2_HIGHEST_VALID_TEMP);
+		data->flags = LS2K0300_OLD_FUSE_FLAG;
+		data->calib_offset = 0;
+	}
+}
+
+static int ls2k0300_thermal_read_calib(struct loongson2_thermal_data *data)
+{
+	u32 chip_id0, chip_id1;
+	int calib_data, calib_offset, ret;
+
+	ret = regmap_read(data->regmap_cfg, LS2K0300_CHIP_ID0, &chip_id0);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap_cfg, LS2K0300_CHIP_ID1, &chip_id1);
+	if (ret)
+		return ret;
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
+	data->calib_offset = calib_offset;
+	return 0;
+}
+
+static int ls2k0300_thermal_init_extend_resource(struct platform_device *pdev,
+						 struct loongson2_thermal_data *data)
+{
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	data->regmap_cfg =
+		syscon_regmap_lookup_by_phandle(dev->of_node, "loongson,chipid");
+	if (IS_ERR(data->regmap_cfg))
+		return PTR_ERR(data->regmap_cfg);
+
+	ret = ls2k0300_thermal_read_calib(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to read calibration data\n");
+
+	writel(LS2K0300_THSENS_INIT_MASK, data->ctrl_reg + LS2K0300_THSENS_CFG_REG);
+
+	ls2k0300_thermal_detect_old_fuse(dev, data);
+
+	return 0;
+}
+
 static int ls2k1000_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
@@ -158,6 +280,10 @@ static int ls2k2000_thermal_init_extend_resource(struct platform_device *pdev,
 	return 0;
 }
 
+static const struct thermal_zone_device_ops ls2k0300_thermal_zone_ops = {
+	.get_temp = ls2k0300_thermal_get_temp,
+};
+
 static const struct thermal_zone_device_ops ls2k1000_thermal_zone_ops = {
 	.get_temp = ls2k1000_thermal_get_temp,
 	.set_trips = loognson2_thermal_set_trips,
@@ -168,6 +294,12 @@ static const struct thermal_zone_device_ops ls2k2000_thermal_zone_ops = {
 	.set_trips = loognson2_thermal_set_trips,
 };
 
+static const struct loongson2_thermal_chip_data ls2k0300_thermal_chip_data = {
+	.thermal_sensor_sel = 0,
+	.thermal_ops = &ls2k0300_thermal_zone_ops,
+	.init_extend_resource = ls2k0300_thermal_init_extend_resource,
+};
+
 static const struct loongson2_thermal_chip_data ls2k1000_thermal_chip_data = {
 	.thermal_sensor_sel = 0,
 	.thermal_ops = &ls2k1000_thermal_zone_ops,
@@ -251,6 +383,10 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id of_loongson2_thermal_match[] = {
+	{
+		.compatible = "loongson,ls2k0300-thermal",
+		.data = &ls2k0300_thermal_chip_data,
+	},
 	{
 		.compatible = "loongson,ls2k1000-thermal",
 		.data = &ls2k1000_thermal_chip_data,
-- 
2.52.0

