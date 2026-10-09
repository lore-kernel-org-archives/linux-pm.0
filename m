Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBB32F25F4;
	Fri,  9 Oct 2026 02:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791514723; cv=none; b=dDcOEyoGMTjjTBxxuJEeV8FFtJOGeuDsJy/M0LekYAjvlNW7loRu8BnrdxSOROq1SAiowG7jtXbBFjowa+27rvLY1ivUelMXXbXxQY3mOclO4CmPCsUEXQPdBKP26tC4YMriomux/2M1A46iKVt8ve/ueEHd5yU3QvVKNzM8xmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791514723; c=relaxed/simple;
	bh=y2FbUxDUxBywtprkhDk2JF7x1rtj51YyaOuiZswCFg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnPt/45LIHKLB20xn1TFberPcIDKUJPndKxzsk+B2lyXPMMgiuRBBrZsQMixlrxPz8aUDw2QkQoqebMpZ4lNQLeOHbD8nF50BWBMAz8fCFMIDYG6JNC68+Z5wzbq9yhGrQZ0QnjSe9RDJUh4aljhAm9EJvIUBngec3oW2PCUHgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.159])
	by gateway (Coremail) with SMTP id _____8AxntJgWMhqfvwTAA--.58227S3;
	Fri, 09 Oct 2026 10:58:40 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.159])
	by front1 (Coremail) with SMTP id qMiowJDxRs1aWMhquUwqAA--.10860S4;
	Fri, 09 Oct 2026 10:58:39 +0800 (CST)
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
Subject: [PATCH v7 6/8] thermal/drivers/loongson2: Move per-SoC ops into chip data
Date: Fri,  9 Oct 2026 10:58:26 +0800
Message-ID: <cbe4c0195bd0fd85492810a73971fc69de93e653.1791512067.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791512067.git.zhoubinbin@loongson.cn>
References: <cover.1791512067.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxRs1aWMhquUwqAA--.10860S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEPCGrIS3YA4gAAs6
X-Coremail-Antispam: 1Uk129KBj93XoW3WFWUKry3XF45Xr1kAFWrJFc_yoW7tryDp3
	47A3y5tr4DGr4Du34UAw4kZr4Yvr9xtayfZF4xGw1fW395G34agFy8tF10vrWSkFZxJFyU
	Ars8tFZrua1DW3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWr
	XVW3AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j-b1bUUUUU=

Store the thermal_zone_device_ops pointer and the optional extended
resource initializer in struct loongson2_thermal_chip_data instead of
selecting them through flags in probe.

Rename the second mapped resource from temp_reg to extend_reg, and let
Loongson-2K2000 initialize it from its own hw_init() callback. This
makes adding new SoCs with different register layouts easier.

No functional change intended.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/thermal/loongson2_thermal.c | 66 +++++++++++++++++------------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 02f7545eaac1..dbfb03aa0833 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -45,24 +45,19 @@
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
 
@@ -114,12 +109,21 @@ static void ls2k1000_thermal_set_trips_regs(struct loongson2_thermal_data *data,
 	writew(val, data->ctrl_reg + ctrl_reg + sel * 2);
 }
 
+static int ls2k1000_thermal_hw_init(struct platform_device *pdev,
+				    struct loongson2_thermal_data *data)
+{
+	writeb(LOONGSON2_THSENS_INT_EN, data->ctrl_reg + LOONGSON2_THSENS_STATUS_REG);
+	loongson2_thermal_set_trip_temp(data, 0, 0, false);
+
+	return 0;
+}
+
 static int ls2k2000_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
 	int val;
 
-	val = FIELD_GET(LOONGSON2_THSENS_OUT_16B_MASK, readl(data->temp_reg));
+	val = FIELD_GET(LOONGSON2_THSENS_OUT_16B_MASK, readl(data->extend_reg));
 	*temp = (val * LS2K2000_TEMP_MUL / LS2K2000_TEMP_DIV - LS2K2000_TEMP_OFFSET) * KILO;
 
 	return 0;
@@ -146,6 +150,20 @@ static void ls2k2000_thermal_set_trips_regs(struct loongson2_thermal_data *data,
 	writeb(val, data->ctrl_reg + hi_reg + sel);
 }
 
+static int ls2k2000_thermal_hw_init(struct platform_device *pdev,
+				    struct loongson2_thermal_data *data)
+{
+	/* The temperature output register is separate for Loongson-2K2000 */
+	data->extend_reg = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(data->extend_reg))
+		return PTR_ERR(data->extend_reg);
+
+	writeb(LOONGSON2_THSENS_INT_EN, data->ctrl_reg + LOONGSON2_THSENS_STATUS_REG);
+	loongson2_thermal_set_trip_temp(data, 0, 0, false);
+
+	return 0;
+}
+
 static const struct thermal_zone_device_ops ls2k1000_thermal_zone_ops = {
 	.get_temp = ls2k1000_thermal_get_temp,
 	.set_trips = loongson2_thermal_set_trips,
@@ -158,14 +176,16 @@ static const struct thermal_zone_device_ops ls2k2000_thermal_zone_ops = {
 
 static const struct loongson2_thermal_chip_data ls2k1000_thermal_chip_data = {
 	.thermal_sensor_sel = 0,
-	.flags = 0,
+	.thermal_ops = &ls2k1000_thermal_zone_ops,
 	.set_trips_regs = ls2k1000_thermal_set_trips_regs,
+	.hw_init = ls2k1000_thermal_hw_init,
 };
 
 static const struct loongson2_thermal_chip_data ls2k2000_thermal_chip_data = {
 	.thermal_sensor_sel = 0,
-	.flags = LS2K2000_THSENS_OUT_FLAG,
+	.thermal_ops = &ls2k2000_thermal_zone_ops,
 	.set_trips_regs = ls2k2000_thermal_set_trips_regs,
+	.hw_init = ls2k2000_thermal_hw_init,
 };
 
 static irqreturn_t loongson2_thermal_irq_thread(int irq, void *dev)
@@ -182,9 +202,8 @@ static irqreturn_t loongson2_thermal_irq_thread(int irq, void *dev)
 
 static int loongson2_thermal_probe(struct platform_device *pdev)
 {
-	const struct thermal_zone_device_ops *thermal_ops;
-	struct device *dev = &pdev->dev;
 	struct loongson2_thermal_data *data;
+	struct device *dev = &pdev->dev;
 	struct thermal_zone_device *tzd;
 	int ret, irq;
 
@@ -193,31 +212,22 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
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
-	}
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
 
-	writeb(LOONGSON2_THSENS_INT_EN, data->ctrl_reg + LOONGSON2_THSENS_STATUS_REG);
-
-	loongson2_thermal_set_trip_temp(data, 0, 0, false);
+	ret = data->chip_data->hw_init(pdev, data);
+	if (ret)
+		return ret;
 
-	tzd = devm_thermal_of_zone_register(dev, 0, data, thermal_ops);
+	tzd = devm_thermal_of_zone_register(dev, 0, data, data->chip_data->thermal_ops);
 	if (IS_ERR(tzd))
 		return dev_err_probe(dev, PTR_ERR(tzd), "failed to register sensor");
 
-- 
2.52.0

