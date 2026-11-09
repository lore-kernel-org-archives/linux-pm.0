Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211759;
	b=ooZP1rgAxRlE1CuK5bMs7Y+/itV+N76nDOZb2QlRABJDOaidj7IpEmOer8hTUOgVpIQ4
	 QZMD6c8zuQnnsweO/B8LF4EkOVpM+PRlebMuNMdmIXnVFrfUibStR9br4js+Gf434UVD2
	 uhCIRCAVEz325G+zPpxK6oH3iudHHrLaKTkJfvI2/UuH2AJqDgTwly3Jov1sCSJsyXQLT
	 sKNsW8t4il8jO8yDURsCtXSSgNw0xFsVPka2kbkZ2qJ213cGxwwW/y/EiUENuWHF1PFkW
	 UV53v3wGvZr3lrcXSbOtkgw5FeFKN7vcgTIuUzmriu+gyZy8Aaxis0XsGF5Ksqj8MoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211759;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=YZ2XkImT/gn3zzYWu859LjlWgZxII3SFdLxIM0C4uH8=;
	b=H1bJdKSSW4IuVeKHLHK9fS26noX78X/n2ePxeCfmuJgwygTcjXGc0O3wQYOGq9EAJBgQ
	 HFZomVJmJPM7C/0T1o7wLE8jmbrBUkA0FK8ckrm3gt0xV/JCFiJrZz3tocxPMAZ3d+8YP
	 iTxLzX4hP9aMmgPzsJGbVuzbFh0MAO18gMNGL/ZSkN4CfPvTj4/l/IDT+BIM0o/XxZ8jQ
	 WDXuOtg8AJZT/YU7rFS2OteqguXd9f4DDnPKDRVOc8LaYbN6BTKhFCpPAxI6rSXHXDctK
	 waMZ3RLO3QUIWg21V142HAf3pJcsp999GcBNU3dEvjIh2LQc6jMA2bDq9eJySjxZClQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50131606A335;
	Mon,  9 Nov 2026 08:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50131606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8Axj9Gsf_Fqtb8dAA--.20551S3;
	Mon, 09 Nov 2026 16:09:16 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJAxmM2lf_FqdCQzAA--.37921S4;
	Mon, 09 Nov 2026 16:09:15 +0800 (CST)
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
Subject: [PATCH v9 5/7] thermal/drivers/loongson2: Move per-SoC ops and init into chip data
Date: Mon,  9 Nov 2026 16:09:01 +0800
Message-ID: <77c58f3456e9a0969e99a621f8d2c452de776fb0.1794211535.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1794211535.git.zhoubinbin@loongson.cn>
References: <cover.1794211535.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJAxmM2lf_FqdCQzAA--.37921S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEGCGrxKfoFZgAAsl
X-Coremail-Antispam: 1Uk129KBj93XoWfGr1DCF15WF13WFyxCry5KFX_yoWDWrW3p3
	47A3y5tFWDJr4Du34UAw4kZr4Yyry3tasxZF4xGw1fW395G34agFy8tFy0vFWSkFy5JFyU
	ZrZ5tFW7ua1DW3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUVF4EDUUUU

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

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/thermal/loongson2_thermal.c | 138 +++++++++++++++-------------
 1 file changed, 74 insertions(+), 64 deletions(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 18f6ae70288e..4ce162dfb122 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -49,29 +49,24 @@
 #define LS2K2000_GATE_LO_MASK		GENMASK(7, 0)
 #define LS2K2000_GATE_HI_MASK		GENMASK(15, 8)
 
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
@@ -83,7 +78,16 @@ static void loongson2_thermal_set(struct loongson2_thermal_data *data,
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
@@ -95,7 +99,7 @@ static int loongson2_2k1000_get_temp(struct thermal_zone_device *tz, int *temp)
 	return 0;
 }
 
-static void loongson2_2k1000_set_trips_regs(struct loongson2_thermal_data *data,
+static void ls2k1000_thermal_set_trips_regs(struct loongson2_thermal_data *data,
 					    int temp, bool low, bool enable)
 {
 	u32 sel = data->chip_data->thermal_sensor_sel;
@@ -109,18 +113,27 @@ static void loongson2_2k1000_set_trips_regs(struct loongson2_thermal_data *data,
 	writew(val, data->ctrl_reg + ctrl_reg + sel * 2);
 }
 
-static int loongson2_2k2000_get_temp(struct thermal_zone_device *tz, int *temp)
+static int ls2k1000_thermal_hw_init(struct platform_device *pdev,
+				    struct loongson2_thermal_data *data)
+{
+	writeb(LOONGSON2_THSENS_INT_CLR, data->ctrl_reg + LOONGSON2_THSENS_STATUS_REG);
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
 	u32 sel = data->chip_data->thermal_sensor_sel;
@@ -151,42 +164,60 @@ static void loongson2_2k2000_set_trips_regs(struct loongson2_thermal_data *data,
 	writew(val, data->ctrl_reg + ctrl_reg + sel * 2);
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
 
 	writeb(LOONGSON2_THSENS_INT_CLR, data->ctrl_reg + LOONGSON2_THSENS_STATUS_REG);
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
+	writeb(LOONGSON2_THSENS_INT_CLR, data->ctrl_reg + LOONGSON2_THSENS_STATUS_REG);
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
 
@@ -195,31 +226,22 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
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
 
-	writeb(LOONGSON2_THSENS_INT_CLR, data->ctrl_reg + LOONGSON2_THSENS_STATUS_REG);
-
-	loongson2_thermal_set(data, 0, 0, false);
+	ret = data->chip_data->hw_init(pdev, data);
+	if (ret)
+		return ret;
 
-	tzd = devm_thermal_of_zone_register(dev, 0, data, thermal_ops);
+	tzd = devm_thermal_of_zone_register(dev, 0, data, data->chip_data->thermal_ops);
 	if (IS_ERR(tzd))
 		return dev_err_probe(dev, PTR_ERR(tzd), "failed to register sensor");
 
@@ -233,26 +255,14 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
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

