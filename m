Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690730;
	b=nLJ3LcExNc89YAzkXvObguca+ZcWO9IWf/HE3L3yNRCsXs6/DRA0ySLg5PCm3neD5xgZ
	 sv3PniOatdMYN7sPszG6L3Eex91sRc5u/BXn9W3DC/ZAH5uDufwRC3cuzkZba8x/pLq5l
	 qpifLjdFc0jZCc9Cdk9FNWHaE1Optx1gF9p05DOufeqiw2S024HGwNKl9fbIcwIk1mNb/
	 cecUhq7y6S1DDPp8vzb/4pZSlpaQ9yW9bHCAXVr+StZ2r+hZwVWiUa1kZsJrLmjZaPain
	 0HYjFNuhoPbPv37PpVjCUrnR0a7bqpKlb4S+Ut37tXpUdIz/cqL/LVBNQVtRRTAw1Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690730;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=bkxuqO+yIqukudz41+gWfZew/CsLom1cOAo3HBlAl7M=;
	b=Q/c/I4Ud+KZyRJwHaDBkHRxGoKvsnMISDQNdxzjjOtnGDXAcz2vDObLGReDoEkm45zAP
	 HFjkjvoaz0BgzYFZkWtYgdCnHSEcdXk/CwYiI9ulnxD1Rz64S0Lj7EcPOkjOq++rKOLVl
	 izN3p1Lb0RgaNTmg8ljuX8SruxctBusF0XQDzqRvfsLkiQgiRL5nsT5OlyqpxSQrd2oCS
	 6IHLZNLl9Tpe5GQkF+NZGD10dZ70ecHHZlh/VSgOu/Zqv7oVUoFkKzfXl5tPx+bUwu0Hi
	 YQ4cQwmmmcYQqW43e7HmNkU/7pdOHYsXxnjO1AoYxCeAES2sEa9fhqrSQD1rfdinMKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E632606A32F;
	Tue,  3 Nov 2026 07:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E632606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8Cx_9JmjOlqJt4bAA--.15273S3;
	Tue, 03 Nov 2026 15:25:26 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJBx5cxijOlq7xUyAA--.10875S3;
	Tue, 03 Nov 2026 15:25:24 +0800 (CST)
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
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v8 5/7] thermal/drivers/loongson2: Move per-SoC ops and init into chip data
Date: Tue,  3 Nov 2026 15:25:14 +0800
Message-ID: <a48aa6ef46ea4ebae3a95c5d6004808952890af8.1793690276.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1793690276.git.zhoubinbin@loongson.cn>
References: <cover.1793690276.git.zhoubinbin@loongson.cn>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx5cxijOlq7xUyAA--.10875S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEACGrpUP0D1gAAsw
X-Coremail-Antispam: 1Uk129KBj93XoWfGr1fuw1rZw1rWF15WF4fCrX_yoWDXFWrp3
	47A3y5tFWDXr4Du34UAw4kZr4Yyry3tasxZF4xGw1fW395G34agFy8tFy0vFWSkFy5JFyU
	ZrZ5tFW7ua1DW3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Wrv_ZF1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUIYhFUUUUU

Instead of using a flags field to select the thermal_zone_device_ops in
probe and handling the Loongson-2K2000 extended register mapping inline,
store the ops pointer and an optional hw_init() callback in struct
loongson2_thermal_chip_data. Each SoC now provides its own hw_init()
that performs the common initialization and, for Loongson-2K2000, maps
the extended temperature register.

Rename the second mapped resource from temp_reg to extend_reg to better
reflect its purpose. Also rename the per-SoC functions with consistent
ls2k1000/ls2k2000 prefixes and introduce a common set_trips callback.

This makes adding support for new SoCs with different register layouts
easier.

No functional change intended.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/thermal/loongson2_thermal.c | 138 +++++++++++++++-------------
 1 file changed, 74 insertions(+), 64 deletions(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 19e3f9246cc0..d83aaa588c48 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -45,29 +45,24 @@
 #define LS2K2000_TEMP_DIV		(0x4000)
 #define LS2K2000_TEMP_OFFSET		(311)
 
-/*
- * This flag is used to indicate the temperature reading
- * method of the Loongson-2K2000
- */
-#define LS2K2000_THSENS_OUT_FLAG	BIT(0)
-
 struct loongson2_thermal_data;
 
 struct loongson2_thermal_chip_data {
 	unsigned int thermal_sensor_sel;
-	unsigned int flags;
+	const struct thermal_zone_device_ops *thermal_ops;
 	void (*set_trips_regs)(struct loongson2_thermal_data *data,
 			       int temp, bool low, bool enable);
+	int (*hw_init)(struct platform_device *pdev, struct loongson2_thermal_data *data);
 };
 
 struct loongson2_thermal_data {
 	void __iomem *ctrl_reg;
-	void __iomem *temp_reg;
+	void __iomem *extend_reg;
 	const struct loongson2_thermal_chip_data *chip_data;
 };
 
-static void loongson2_thermal_set(struct loongson2_thermal_data *data,
-				  int low, int high, bool enable)
+static void loongson2_thermal_set_trip_temp(struct loongson2_thermal_data *data,
+					    int low, int high, bool enable)
 {
 	low = clamp(low, LOONGSON2_LOWEST_VALID_TEMP, LOONGSON2_HIGHEST_VALID_TEMP);
 	high = clamp(high, LOONGSON2_LOWEST_VALID_TEMP, LOONGSON2_HIGHEST_VALID_TEMP);
@@ -79,7 +74,16 @@ static void loongson2_thermal_set(struct loongson2_thermal_data *data,
 	data->chip_data->set_trips_regs(data, high / MILLIDEGREE_PER_DEGREE, false, enable);
 }
 
-static int loongson2_2k1000_get_temp(struct thermal_zone_device *tz, int *temp)
+static int loongson2_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
+{
+	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
+
+	loongson2_thermal_set_trip_temp(data, low, high, true);
+
+	return 0;
+}
+
+static int ls2k1000_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
 	int val;
@@ -91,7 +95,7 @@ static int loongson2_2k1000_get_temp(struct thermal_zone_device *tz, int *temp)
 	return 0;
 }
 
-static void loongson2_2k1000_set_trips_regs(struct loongson2_thermal_data *data,
+static void ls2k1000_thermal_set_trips_regs(struct loongson2_thermal_data *data,
 					    int temp, bool low, bool enable)
 {
 	u32 sel = data->chip_data->thermal_sensor_sel;
@@ -105,18 +109,27 @@ static void loongson2_2k1000_set_trips_regs(struct loongson2_thermal_data *data,
 	writew(val, data->ctrl_reg + ctrl_reg + sel * 2);
 }
 
-static int loongson2_2k2000_get_temp(struct thermal_zone_device *tz, int *temp)
+static int ls2k1000_thermal_hw_init(struct platform_device *pdev,
+				    struct loongson2_thermal_data *data)
+{
+	writeb(LOONGSON2_THSENS_INT_EN, data->ctrl_reg + LOONGSON2_THSENS_STATUS_REG);
+	loongson2_thermal_set_trip_temp(data, 0, 0, false);
+
+	return 0;
+}
+
+static int ls2k2000_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
 	int val;
 
-	val = FIELD_GET(LOONGSON2_THSENS_OUT_16B_MASK, readl(data->temp_reg));
+	val = FIELD_GET(LOONGSON2_THSENS_OUT_16B_MASK, readl(data->extend_reg));
 	*temp = (val * LS2K2000_TEMP_MUL / LS2K2000_TEMP_DIV - LS2K2000_TEMP_OFFSET) * KILO;
 
 	return 0;
 }
 
-static void loongson2_2k2000_set_trips_regs(struct loongson2_thermal_data *data,
+static void ls2k2000_thermal_set_trips_regs(struct loongson2_thermal_data *data,
 					    int temp, bool low, bool enable)
 {
 	unsigned int sel = data->chip_data->thermal_sensor_sel;
@@ -137,42 +150,60 @@ static void loongson2_2k2000_set_trips_regs(struct loongson2_thermal_data *data,
 	writeb(val, data->ctrl_reg + hi_reg + sel);
 }
 
-static irqreturn_t loongson2_thermal_irq_thread(int irq, void *dev)
+static int ls2k2000_thermal_hw_init(struct platform_device *pdev,
+				    struct loongson2_thermal_data *data)
 {
-	struct thermal_zone_device *tzd = dev;
-	struct loongson2_thermal_data *data = thermal_zone_device_priv(tzd);
+	/* The temperature output register is separate for Loongson-2K2000 */
+	data->extend_reg = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(data->extend_reg))
+		return PTR_ERR(data->extend_reg);
 
 	writeb(LOONGSON2_THSENS_INT_EN, data->ctrl_reg + LOONGSON2_THSENS_STATUS_REG);
-
-	thermal_zone_device_update(tzd, THERMAL_EVENT_UNSPECIFIED);
-
-	return IRQ_HANDLED;
-}
-
-static int loongson2_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
-{
-	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
-
-	loongson2_thermal_set(data, low, high, true);
+	loongson2_thermal_set_trip_temp(data, 0, 0, false);
 
 	return 0;
 }
 
-static const struct thermal_zone_device_ops loongson2_2k1000_of_thermal_ops = {
-	.get_temp = loongson2_2k1000_get_temp,
+static const struct thermal_zone_device_ops ls2k1000_thermal_zone_ops = {
+	.get_temp = ls2k1000_thermal_get_temp,
 	.set_trips = loongson2_thermal_set_trips,
 };
 
-static const struct thermal_zone_device_ops loongson2_2k2000_of_thermal_ops = {
-	.get_temp = loongson2_2k2000_get_temp,
+static const struct thermal_zone_device_ops ls2k2000_thermal_zone_ops = {
+	.get_temp = ls2k2000_thermal_get_temp,
 	.set_trips = loongson2_thermal_set_trips,
 };
 
+static const struct loongson2_thermal_chip_data ls2k1000_thermal_chip_data = {
+	.thermal_sensor_sel = 0,
+	.thermal_ops = &ls2k1000_thermal_zone_ops,
+	.set_trips_regs = ls2k1000_thermal_set_trips_regs,
+	.hw_init = ls2k1000_thermal_hw_init,
+};
+
+static const struct loongson2_thermal_chip_data ls2k2000_thermal_chip_data = {
+	.thermal_sensor_sel = 0,
+	.thermal_ops = &ls2k2000_thermal_zone_ops,
+	.set_trips_regs = ls2k2000_thermal_set_trips_regs,
+	.hw_init = ls2k2000_thermal_hw_init,
+};
+
+static irqreturn_t loongson2_thermal_irq_thread(int irq, void *dev)
+{
+	struct thermal_zone_device *tzd = dev;
+	struct loongson2_thermal_data *data = thermal_zone_device_priv(tzd);
+
+	writeb(LOONGSON2_THSENS_INT_EN, data->ctrl_reg + LOONGSON2_THSENS_STATUS_REG);
+
+	thermal_zone_device_update(tzd, THERMAL_EVENT_UNSPECIFIED);
+
+	return IRQ_HANDLED;
+}
+
 static int loongson2_thermal_probe(struct platform_device *pdev)
 {
-	const struct thermal_zone_device_ops *thermal_ops;
-	struct device *dev = &pdev->dev;
 	struct loongson2_thermal_data *data;
+	struct device *dev = &pdev->dev;
 	struct thermal_zone_device *tzd;
 	int ret, irq;
 
@@ -181,31 +212,22 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	data->chip_data = device_get_match_data(dev);
+	if (!data->chip_data)
+		return -EINVAL;
 
 	data->ctrl_reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->ctrl_reg))
 		return PTR_ERR(data->ctrl_reg);
 
-	/* The temperature output register is separate for Loongson-2K2000 */
-	if (data->chip_data->flags & LS2K2000_THSENS_OUT_FLAG) {
-		data->temp_reg = devm_platform_ioremap_resource(pdev, 1);
-		if (IS_ERR(data->temp_reg))
-			return PTR_ERR(data->temp_reg);
-
-		thermal_ops = &loongson2_2k2000_of_thermal_ops;
-	} else {
-		thermal_ops = &loongson2_2k1000_of_thermal_ops;
-	}
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
 
-	writeb(LOONGSON2_THSENS_INT_EN, data->ctrl_reg + LOONGSON2_THSENS_STATUS_REG);
-
-	loongson2_thermal_set(data, 0, 0, false);
+	ret = data->chip_data->hw_init(pdev, data);
+	if (ret)
+		return ret;
 
-	tzd = devm_thermal_of_zone_register(dev, 0, data, thermal_ops);
+	tzd = devm_thermal_of_zone_register(dev, 0, data, data->chip_data->thermal_ops);
 	if (IS_ERR(tzd))
 		return dev_err_probe(dev, PTR_ERR(tzd), "failed to register sensor");
 
@@ -219,26 +241,14 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct loongson2_thermal_chip_data loongson2_thermal_ls2k1000_data = {
-	.thermal_sensor_sel = 0,
-	.flags = 0,
-	.set_trips_regs = loongson2_2k1000_set_trips_regs,
-};
-
-static const struct loongson2_thermal_chip_data loongson2_thermal_ls2k2000_data = {
-	.thermal_sensor_sel = 0,
-	.flags = LS2K2000_THSENS_OUT_FLAG,
-	.set_trips_regs = loongson2_2k2000_set_trips_regs,
-};
-
 static const struct of_device_id of_loongson2_thermal_match[] = {
 	{
 		.compatible = "loongson,ls2k1000-thermal",
-		.data = &loongson2_thermal_ls2k1000_data,
+		.data = &ls2k1000_thermal_chip_data,
 	},
 	{
 		.compatible = "loongson,ls2k2000-thermal",
-		.data = &loongson2_thermal_ls2k2000_data,
+		.data = &ls2k2000_thermal_chip_data,
 	},
 	{ /* end */ }
 };
-- 
2.52.0

