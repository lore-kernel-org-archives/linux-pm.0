Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AA035F164;
	Mon, 28 Sep 2026 04:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790570702; cv=none; b=Ap67z1rpFi3CwIPwCNGKqPha2WHHa6WZRrlISVm4mtW8YbqWwpWz3C/s+24UhThabCI3kqbBHD5HtvSW5u/87MOoORKWBFvinQBpXkMxwHfAC00d6nZ6Pn0qn28avaHG6Xp0EQNv/K2W0QV2rjh7LRQPnDtBs1fJjKzeZi6lOnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790570702; c=relaxed/simple;
	bh=W3GsE6QEZVkcbAMZdJNi1RQSdLlHDeBuQT/teQf5N9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlmInnigU8nvI+R7fJ4txJ5vqe9Dlrifc+pWkHVDRYX2X+qyeohMoHaH2tcZoL+Rn5wRh2rjEcf1iqFbUp9SmDQ0CNdAG6y8mzgtFjg386N+Gcpprt7n0upqtUndJWdYEUOGDQokWWvFNP/G80ExcYuSp0eSOI6uUIaNss4jEjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.159])
	by gateway (Coremail) with SMTP id _____8DxjdLL8LlqnWEQAA--.47726S3;
	Mon, 28 Sep 2026 12:44:59 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.159])
	by front1 (Coremail) with SMTP id qMiowJDxBc3I8Llq3fElAA--.52784S3;
	Mon, 28 Sep 2026 12:44:58 +0800 (CST)
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
Subject: [PATCH v6 5/7] thermal/drivers/loongson2: Move per-SoC ops into chip data
Date: Mon, 28 Sep 2026 12:44:38 +0800
Message-ID: <4868a63c96793c45f48d921e7b7890bfdf628789.1790561983.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1790561983.git.zhoubinbin@loongson.cn>
References: <cover.1790561983.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxBc3I8Llq3fElAA--.52784S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEECGq5yvUCZwAAsF
X-Coremail-Antispam: 1Uk129KBj93XoW3WFWUKry3XF45Xr18tw4UWrX_yoW7WFyfp3
	y7Cw45Kr4kGr4Du34UAw4kZr4Yyry7tayfXr4xGw1fX395G34agFyUtr1FvFWSkFy8JFyU
	Ars8tFWDuayDJ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWr
	XVW3AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j6hFcUUUUU=

Store the thermal_zone_device_ops pointer and the optional extended
resource initializer in struct loongson2_thermal_chip_data instead of
selecting them through flags in probe.

Rename the second mapped resource from temp_reg to extend_reg, and let
Loongson-2K2000 initialize it from its own init_extend_resource()
callback. This makes adding new SoCs with different register layouts
easier.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/thermal/loongson2_thermal.c | 50 ++++++++++++++++-------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 0660a74fd922..17aa1d80a2e6 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -46,24 +46,20 @@
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
+	int (*init_extend_resource)(struct platform_device *pdev,
+				    struct loongson2_thermal_data *data);
 };
 
 struct loongson2_thermal_data {
 	void __iomem *ctrl_reg;
-	void __iomem *temp_reg;
+	void __iomem *extend_reg;
 	const struct loongson2_thermal_chip_data *chip_data;
 };
 
@@ -120,7 +116,7 @@ static int ls2k2000_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
 	int val;
 
-	val = FIELD_GET(LOONGSON2_THSENS_OUT_16B_MASK, readl(data->temp_reg));
+	val = FIELD_GET(LOONGSON2_THSENS_OUT_16B_MASK, readl(data->extend_reg));
 	*temp = (val * LS2K2000_TEMP_MUL / LS2K2000_TEMP_DIV - LS2K2000_TEMP_OFFSET) * KILO;
 
 	return 0;
@@ -151,6 +147,17 @@ static void ls2k2000_thermal_set_trips_regs(struct loongson2_thermal_data *data,
 	writel(val, data->ctrl_reg + hi_reg);
 }
 
+static int ls2k2000_thermal_init_extend_resource(struct platform_device *pdev,
+						 struct loongson2_thermal_data *data)
+{
+	/* The temperature output register is separate for Loongson-2K2000 */
+	data->extend_reg = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(data->extend_reg))
+		return PTR_ERR(data->extend_reg);
+
+	return 0;
+}
+
 static const struct thermal_zone_device_ops ls2k1000_thermal_zone_ops = {
 	.get_temp = ls2k1000_thermal_get_temp,
 	.set_trips = loognson2_thermal_set_trips,
@@ -163,14 +170,15 @@ static const struct thermal_zone_device_ops ls2k2000_thermal_zone_ops = {
 
 static const struct loongson2_thermal_chip_data ls2k1000_thermal_chip_data = {
 	.thermal_sensor_sel = 0,
-	.flags = 0,
+	.thermal_ops = &ls2k1000_thermal_zone_ops,
 	.set_trips_regs = ls2k1000_thermal_set_trips_regs,
 };
 
 static const struct loongson2_thermal_chip_data ls2k2000_thermal_chip_data = {
 	.thermal_sensor_sel = 0,
-	.flags = LS2K2000_THSENS_OUT_FLAG,
+	.thermal_ops = &ls2k2000_thermal_zone_ops,
 	.set_trips_regs = ls2k2000_thermal_set_trips_regs,
+	.init_extend_resource = ls2k2000_thermal_init_extend_resource,
 };
 
 static irqreturn_t loongson2_thermal_irq_thread(int irq, void *dev)
@@ -187,9 +195,8 @@ static irqreturn_t loongson2_thermal_irq_thread(int irq, void *dev)
 
 static int loongson2_thermal_probe(struct platform_device *pdev)
 {
-	const struct thermal_zone_device_ops *thermal_ops;
-	struct device *dev = &pdev->dev;
 	struct loongson2_thermal_data *data;
+	struct device *dev = &pdev->dev;
 	struct thermal_zone_device *tzd;
 	int ret, irq, i;
 
@@ -198,20 +205,17 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
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
-		thermal_ops = &ls2k2000_thermal_zone_ops;
-	} else {
-		thermal_ops = &ls2k1000_thermal_zone_ops;
+	if (data->chip_data->init_extend_resource) {
+		ret = data->chip_data->init_extend_resource(pdev, data);
+		if (ret)
+			return ret;
 	}
 
 	irq = platform_get_irq(pdev, 0);
@@ -223,7 +227,7 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 	loongson2_thermal_set_trip_temp(data, 0, 0, false);
 
 	for (i = 0; i <= LOONGSON2_MAX_SENSOR_SEL_NUM; i++) {
-		tzd = devm_thermal_of_zone_register(dev, i, data, thermal_ops);
+		tzd = devm_thermal_of_zone_register(dev, i, data, data->chip_data->thermal_ops);
 		if (!IS_ERR(tzd))
 			break;
 
-- 
2.52.0

