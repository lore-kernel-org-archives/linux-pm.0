Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9992235C1A9;
	Mon, 28 Sep 2026 04:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790570702; cv=none; b=BA/e/1crWT6ocSV+14+E90hyUxavuIhcZLSLLehod+eEItkRTHP+NtooEO0k0J+vexBpOqFcaNHQMN6FTpkD49KtT9CBRDsJlPq+M5UJqBvoJMuxvOEqKdSG8TBu340gOxqjI5FfeOasiwo8sWwIxvE21NhWu8UOTpL3GFzWWdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790570702; c=relaxed/simple;
	bh=q3zfU4q6PTqIJYlQYb+mNBG7j+aonJhq+z0g2TS9A1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRh/KYQDAboI10eHODtVUFm672pqgSqEqrzfdf5AYUAzMTGyNr6MiC666v/VWpd+kmo3bSUQWCUb/06g1vmOqGLOPuo0ccjv0tf2OboqbHFmpBmshs2kta54KAKPldCZYW5nYAE8cSmxwbwY1BsqqoffB5dgOSE3jfc6gBcdZZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.159])
	by gateway (Coremail) with SMTP id _____8BxrtLL8LlqlmEQAA--.48070S3;
	Mon, 28 Sep 2026 12:44:59 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.159])
	by front1 (Coremail) with SMTP id qMiowJDxBc3I8Llq3fElAA--.52784S2;
	Mon, 28 Sep 2026 12:44:57 +0800 (CST)
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
Subject: [PATCH v6 4/7] thermal/drivers/loongson2: Use bitfields and per-SoC thermal ops
Date: Mon, 28 Sep 2026 12:44:37 +0800
Message-ID: <16875dca6130410dbd885c7af347c161c9417511.1790561983.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJDxBc3I8Llq3fElAA--.52784S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEECGq5yvUCZgAAsE
X-Coremail-Antispam: 1Uk129KBj93XoW3WrWkKFW8Wr13Xr4DAr4UJrc_yoWfJF15p3
	47A3y5KF4DGr48uw1UAw1kXr4Yvry7tF9xZFs7Kw13Wws5t34agF97tF1FvryIkF9rJFy2
	vrWv9FZrua1DX3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
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

Replace open-coded masks and shifts with GENMASK()/FIELD_* helpers, and
define named constants for the Loongson-2K2000 temperature conversion
and trip gate calculations.

Split the temperature read and thermal zone ops into Loongson-2K1000 and
Loongson-2K2000 variants, and keep the chip-specific trip register
callback in the chip data. This prepares the driver for further SoC
support.

No functional change intended.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/thermal/loongson2_thermal.c | 123 ++++++++++++++++------------
 1 file changed, 72 insertions(+), 51 deletions(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 45fe6100134e..0660a74fd922 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
  */
 
+#include <linux/bitfield.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/minmax.h>
@@ -27,11 +28,23 @@
 #define LOONGSON2_THSENS_INT_HIGH	BIT(1)
 #define LOONGSON2_THSENS_INT_EN		(LOONGSON2_THSENS_INT_LO | \
 					 LOONGSON2_THSENS_INT_HIGH)
-#define LOONGSON2_THSENS_OUT_MASK	0xFF
+#define LOONGSON2_THSENS_CTRL_INTEN	BIT(8)
+
+#define LOONGSON2_THSENS_OUT_8B_MASK	GENMASK(7, 0)
+#define LOONGSON2_THSENS_OUT_16B_MASK	GENMASK(15, 0)
+
+#define LOONGSON2_LOWEST_VALID_TEMP     (-40000)
+#define LOONGSON2_HIGHEST_VALID_TEMP    (125000)
 
 /* Loongson-2K2000-Specific Registers */
 #define LS2K2000_THSENS_HI_GATE_HI_REG	0x18
 #define LS2K2000_THSENS_HI_GATE_LOW_REG	0x1c
+#define LS2K2000_GATE0_VAL_MASK		GENMASK(7, 0)
+#define LS2K2000_THSENS_SEL_MASK	GENMASK(11, 10)
+
+#define LS2K2000_TEMP_MUL		(820)
+#define LS2K2000_TEMP_DIV		(0x4000)
+#define LS2K2000_TEMP_OFFSET		(311)
 
 /*
  * This flag is used to indicate the temperature reading
@@ -64,71 +77,101 @@ static void loongson2_thermal_set_trip_temp(struct loongson2_thermal_data *data,
 	data->chip_data->set_trips_regs(data, high, false, enable);
 }
 
-static int loongson2_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
+static int loognson2_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
 	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
 
-	low = clamp(low, -40000, 125000);
-	high = clamp(high, -40000, 125000);
+	low = clamp(low, LOONGSON2_LOWEST_VALID_TEMP, LOONGSON2_HIGHEST_VALID_TEMP);
+	high = clamp(high, LOONGSON2_LOWEST_VALID_TEMP, LOONGSON2_HIGHEST_VALID_TEMP);
 
 	loongson2_thermal_set_trip_temp(data, low / MILLI, high / MILLI, true);
 
 	return 0;
 }
 
-static void loongson2_2k1000_set_trips_regs(struct loongson2_thermal_data *data,
+static int ls2k1000_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
+	int val;
+
+	val = FIELD_GET(LOONGSON2_THSENS_OUT_8B_MASK,
+			readl(data->ctrl_reg + LOONGSON2_THSENS_OUT_REG));
+	*temp = (val - HECTO) * KILO;
+
+	return 0;
+}
+
+static void ls2k1000_thermal_set_trips_regs(struct loongson2_thermal_data *data,
 					    int temp, bool low, bool enable)
 {
-	int reg_ctrl = 0;
-	int reg_off  = data->chip_data->thermal_sensor_sel * 2;
 	int ctrl_reg = low ? LOONGSON2_THSENS_CTRL_LOW_REG : LOONGSON2_THSENS_CTRL_HI_REG;
+	int reg_off  = data->chip_data->thermal_sensor_sel * 2;
+	int reg_ctrl = 0;
 
 	reg_ctrl = temp + HECTO;
-	reg_ctrl |= enable ? 0x100 : 0;
+	if (enable)
+		reg_ctrl |= LOONGSON2_THSENS_CTRL_INTEN;
+
 	writew(reg_ctrl, data->ctrl_reg + ctrl_reg + reg_off);
 }
 
-static int loongson2_2k1000_get_temp(struct thermal_zone_device *tz, int *temp)
+static int ls2k2000_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	int val;
 	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
+	int val;
 
-	val = readl(data->ctrl_reg + LOONGSON2_THSENS_OUT_REG);
-	*temp = ((val & LOONGSON2_THSENS_OUT_MASK) - HECTO) * KILO;
+	val = FIELD_GET(LOONGSON2_THSENS_OUT_16B_MASK, readl(data->temp_reg));
+	*temp = (val * LS2K2000_TEMP_MUL / LS2K2000_TEMP_DIV - LS2K2000_TEMP_OFFSET) * KILO;
 
 	return 0;
 }
 
-static void loongson2_2k2000_set_trips_regs(struct loongson2_thermal_data *data,
+static void ls2k2000_thermal_set_trips_regs(struct loongson2_thermal_data *data,
 					    int temp, bool low, bool enable)
 {
 	int hi_reg, ctrl_reg;
 	int val = 0, gate;
 
 	ctrl_reg = low ? LOONGSON2_THSENS_CTRL_LOW_REG : LOONGSON2_THSENS_CTRL_HI_REG;
-	gate = (temp + 311) * 0x4000 / 820;
+	gate = (temp + LS2K2000_TEMP_OFFSET) * LS2K2000_TEMP_DIV / LS2K2000_TEMP_MUL;
+
+	val = FIELD_PREP(LS2K2000_GATE0_VAL_MASK, FIELD_GET(GENMASK(7, 0), gate)) |
+	      FIELD_PREP(LS2K2000_THSENS_SEL_MASK, 0);
+	if (enable)
+		val |= LOONGSON2_THSENS_CTRL_INTEN;
 
-	val = gate & 0xff;
-	val |= enable ? 0x100 : 0;
 	writel(val, data->ctrl_reg + ctrl_reg);
 
 	hi_reg = low ? LS2K2000_THSENS_HI_GATE_LOW_REG : LS2K2000_THSENS_HI_GATE_HI_REG;
 
 	val = readl(data->ctrl_reg + hi_reg);
-	val = (val & ~0xff) | ((gate >> 8) & 0xff);
+	val &= ~LS2K2000_GATE0_VAL_MASK;
+	val |= FIELD_PREP(LS2K2000_GATE0_VAL_MASK, FIELD_GET(GENMASK(15, 8), gate));
+
 	writel(val, data->ctrl_reg + hi_reg);
 }
 
-static int loongson2_2k2000_get_temp(struct thermal_zone_device *tz, int *temp)
-{
-	int val;
-	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
+static const struct thermal_zone_device_ops ls2k1000_thermal_zone_ops = {
+	.get_temp = ls2k1000_thermal_get_temp,
+	.set_trips = loognson2_thermal_set_trips,
+};
 
-	val = readl(data->temp_reg);
-	*temp = ((val & 0xffff) * 820 / 0x4000 - 311) * KILO;
+static const struct thermal_zone_device_ops ls2k2000_thermal_zone_ops = {
+	.get_temp = ls2k2000_thermal_get_temp,
+	.set_trips = loognson2_thermal_set_trips,
+};
 
-	return 0;
-}
+static const struct loongson2_thermal_chip_data ls2k1000_thermal_chip_data = {
+	.thermal_sensor_sel = 0,
+	.flags = 0,
+	.set_trips_regs = ls2k1000_thermal_set_trips_regs,
+};
+
+static const struct loongson2_thermal_chip_data ls2k2000_thermal_chip_data = {
+	.thermal_sensor_sel = 0,
+	.flags = LS2K2000_THSENS_OUT_FLAG,
+	.set_trips_regs = ls2k2000_thermal_set_trips_regs,
+};
 
 static irqreturn_t loongson2_thermal_irq_thread(int irq, void *dev)
 {
@@ -142,16 +185,6 @@ static irqreturn_t loongson2_thermal_irq_thread(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static const struct thermal_zone_device_ops loongson2_2k1000_of_thermal_ops = {
-	.get_temp = loongson2_2k1000_get_temp,
-	.set_trips = loongson2_thermal_set_trips,
-};
-
-static const struct thermal_zone_device_ops loongson2_2k2000_of_thermal_ops = {
-	.get_temp = loongson2_2k2000_get_temp,
-	.set_trips = loongson2_thermal_set_trips,
-};
-
 static int loongson2_thermal_probe(struct platform_device *pdev)
 {
 	const struct thermal_zone_device_ops *thermal_ops;
@@ -176,9 +209,9 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 		if (IS_ERR(data->temp_reg))
 			return PTR_ERR(data->temp_reg);
 
-		thermal_ops = &loongson2_2k2000_of_thermal_ops;
+		thermal_ops = &ls2k2000_thermal_zone_ops;
 	} else {
-		thermal_ops = &loongson2_2k1000_of_thermal_ops;
+		thermal_ops = &ls2k1000_thermal_zone_ops;
 	}
 
 	irq = platform_get_irq(pdev, 0);
@@ -213,26 +246,14 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
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

