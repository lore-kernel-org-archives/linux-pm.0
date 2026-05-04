Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836592472A2
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 05:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777871052; cv=none; b=JfaiW/qvAWxSn+tplXa+6Ngp8a8YtyEXiE+OjW+gwxhxQMdSXNSekZtvulOlCTYYiGIiguuezp1h7bRWCiKaaY1X0r4Iy/V4a9NtT10pRmf2SzmzhlRlvurmDYNGW10xewA9LYzJGU/94NidbRHpcJKosglfUwLSap3NcVc/+2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777871052; c=relaxed/simple;
	bh=QyoUgJ2jJeKlm1ndIJvXIiS5587bYg8xTKAl4U8ecQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewe7hlvtbK7QvJ6n5uJY12wED0J1ZKM/Qk4QWO63kgb+pfTfzYsjFW+Pg7M8e14vNe7Ke6REAaZ9ubnrELMcevIi9Z/4/bDLVA7Q0I2n+mEJ/5nnxOR+VirL5pVYY4JFZIArkaXBryyopovqWMqFZ3wbfwtvbHM5p78Qf2F/4aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pfnxm9Tq; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfnxm9Tq"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-365425c98c6so357198a91.0
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 22:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777871049; x=1778475849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3+Iww+WFVs530WIpfYPC8wfiAgNCYmHbA4msVXQjbo=;
        b=pfnxm9TqFWwTMcSaDM+1yFqNXv9FPzvNhwyCtrClK1AlXeSZrtz0cSkwZzeLjrzu+v
         BUR0sScJXWEDCC6OaoOd4Z/XFu90vBzTWxPc9Ay1mb4Gox/4Rljcu6KMBEWMhmCEPBbx
         Iy1jsyjDNtd0tA9r2Cx7Ebw0Ck2f1BApXMoP776O8XgCWvICa6Op2BQLAcCUWSK0iMym
         MFBkhTfjiO6OqfknhpLiiJeuTOfgbi6FBBr40WD+rHBhD78Vx8gKtTAm7lM1n4UT6LsE
         i3//1rYxm8apthuXwdniM5rJ33RN1VD7ucRrkUsa7PYcHwXEvCFxNvL5NzGxKvsXzMk+
         46Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777871049; x=1778475849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B3+Iww+WFVs530WIpfYPC8wfiAgNCYmHbA4msVXQjbo=;
        b=hEUA/AZQlhiyNq0ErvDdhKGu0HnK/zaU3rtwgjxEuY2PJce4GD39ay0DdsJXtJ3kak
         P/xnwBDl/17yIDYSxTsHFXAHaLHBsJW5ISHQxC6PL03UyXnQyj/Wrl4qMhhs8Yrw0H6E
         C/RYRSZPib2AEdtg10nY4uFANLgL17XNUjaa6dXwmCUUSQESO/BlxEehpgUz2547MGpi
         doeaqpYlIu1QDZ+C0n1GCVdchKHtSPM2M9cpToZvDC0BQJsrRebLgSNZbNupZS8d+btU
         5ldwbAt96ZFTuNvK4oBrywAIOYicfgwgw8PXUT+btRjoE/qno7M5YWah+1xViuItCrd1
         0tcg==
X-Gm-Message-State: AOJu0Yz1kZ9Vep7paCvvN+YK/RyoUFhLG635aaCV0A/VCm7b2LgpQKfk
	wZzH9TTQ1NnP/OGw89YhWME2Co8zq2xwUn7I2j4impJhujJ/e+RVMS78
X-Gm-Gg: AeBDietIfS5RYpvYBHkop0ghhLgvgPqqWqwJAF0QFG7KuBfgz12dm1lp1wHehiOiE/I
	Ht+gwGOV102+lxkeU/Wz5g9nOE4PNZWUD8ZIvP4tsHTF+17K0oc6aW7Q9MejHmqw4b5niHhyjum
	wmNaQvr28GxR67SG6hGYg4p6XxnRM2tvAXFyy/KsQtFpm6jpnsmzxkGho64kKx3+pSIkaNNfxA/
	KR7++0RQeiOMAiNT4kIqv9/Mu9HqcdTBT7dOFG4CtCaSkB1phoeiREkm38Ja1dbYaLQvpurZUOK
	wW8qE/ISqUW6akLFGcwgA9a8o26kLBiJaIBW87Rq7QUeOtM/983KfsQ4Y4alPPFfuvoMZhGt14E
	54ngynuj6bHXs0ccmrcFOmxrJzhpLoHvovEE5AfTTDtHLzTZ0SwFQaBiVRCGW1pc6SRHn33Frxo
	BITA==
X-Received: by 2002:a17:90b:2b45:b0:35d:8fdb:4f36 with SMTP id 98e67ed59e1d1-3650ce0098dmr8169319a91.18.1777871048840;
        Sun, 03 May 2026 22:04:08 -0700 (PDT)
Received: from archlinux ([2605:e440:15::152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365437b50b0sm2662908a91.0.2026.05.03.22.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 22:04:08 -0700 (PDT)
From: Mikhail Kalashnikov <iuncuim@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] thermal/drivers/sun8i: Add support for A523 THS0/1 controllers
Date: Mon,  4 May 2026 13:02:44 +0800
Message-ID: <20260504050245.646078-5-iuncuim@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504050245.646078-1-iuncuim@gmail.com>
References: <20260504050245.646078-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The A523 processor has two temperature controllers, THS0 and THS1.
THS0 has only one temperature sensor, which is located in the DRAM.
THS1 does have 3 sensors:
ths1_0 - "big" cores
ths1_1 - "little" cores
ths1_2 - gpu

The datasheet mentions a fourth sensor in the NPU, but lacks any registers
for operation other than calibration registers. The vendor code reads the
value from ths1_2, but uses separate calibration data, so we get two
different values from real one.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 133 ++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index c4aaff8f7..3b73aafab 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -59,6 +59,12 @@
 #define SUN50I_H6_THS_PC_TEMP_PERIOD(x)		((GENMASK(19, 0) & (x)) << 12)
 #define SUN50I_H6_THS_DATA_IRQ_STS(x)		BIT(x)
 
+#define SUN55I_A523_DELIMITER			0x7c8
+#define SUN55I_A523_OFFSET_ABOVE		2736
+#define SUN55I_A523_OFFSET_BELOW		2825
+#define SUN55I_A523_SCALE_ABOVE			74
+#define SUN55I_A523_SCALE_BELOW			65
+
 struct tsensor {
 	struct ths_device		*tmdev;
 	struct thermal_zone_device	*tzd;
@@ -114,6 +120,15 @@ static int sun50i_h5_calc_temp(struct ths_device *tmdev,
 		return -1590 * reg / 10 + 276000;
 }
 
+static int sun55i_a523_calc_temp(struct ths_device *tmdev,
+				 int id, int reg)
+{
+	if (reg >= SUN55I_A523_DELIMITER)
+		return SUN55I_A523_SCALE_ABOVE * (SUN55I_A523_OFFSET_ABOVE - reg);
+	else
+		return SUN55I_A523_SCALE_BELOW * (SUN55I_A523_OFFSET_BELOW - reg);
+}
+
 static int sun8i_ths_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct tsensor *s = thermal_zone_device_priv(tz);
@@ -299,6 +314,97 @@ static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
 	return 0;
 }
 
+/*
+ * The A523 nvmem calibration values. The ths1_3 is not used as it
+ * doesn't have its own sensor and doesn't have any internal switch.
+ * Instead, the value from the ths1_2 sensor is used, which gives the
+ * illusion of an independent sensor for NPU and GPU when using
+ * different calibration values.
+ *
+ * efuse layout 0x38-0x3F (caldata[0..3]):
+ *     caldata[0]      caldata[1]      caldata[2]      caldata[3]
+ * 0               16      24      32  36          48          60 64
+ * +---------------+---------------+---------------+---------------+
+ * |               |       |   temp    |  ths1_0   |  ths1_1   |   +
+ * +---------------+---------------+---------------+---------------+
+ *
+ * efuse layout 0x44-0x4B (caldata[4..7]):
+ *     caldata[4]      caldata[5]      caldata[6]      caldata[7]
+ * 0           12  16      24      32  36          48             64
+ * +---------------+---------------+---------------+---------------+
+ * |  ths1_2   |  ths1_3   |    ths0   |           |               +
+ * +---------------+---------------+---------------+---------------+
+ */
+static int sun55i_a523_ths_calibrate(struct ths_device *tmdev,
+				     u16 *caldata, int callen)
+{
+	struct device *dev = tmdev->dev;
+	int i, ft_temp;
+
+	if (!caldata[0])
+		return -EINVAL;
+
+	ft_temp = (((caldata[2] << 8) | (caldata[1] >> 8)) & FT_TEMP_MASK) * 100;
+
+	for (i = 0; i < tmdev->chip->sensor_num; i++) {
+		int sensor_reg, sensor_temp, cdata, offset;
+		/*
+		 * Chips ths0 and ths1 have common parameters for value
+		 * calibration. To separate them we can use the number of
+		 * temperature sensors on each chip.
+		 * For ths0 this value is 1.
+		 */
+		if (tmdev->chip->sensor_num == 1) {
+			sensor_reg = ((caldata[5] >> 8) | (caldata[6] << 8)) & TEMP_CALIB_MASK;
+		} else {
+			switch (i) {
+			case 0:
+				sensor_reg = (caldata[2] >> 4) & TEMP_CALIB_MASK;
+				break;
+			case 1:
+				sensor_reg = caldata[3] & TEMP_CALIB_MASK;
+				break;
+			case 2:
+				sensor_reg = caldata[4] & TEMP_CALIB_MASK;
+				break;
+			default:
+				sensor_reg = 0;
+				break;
+			}
+		}
+
+		sensor_temp = tmdev->chip->calc_temp(tmdev, i, sensor_reg);
+
+		/*
+		 * Calibration data is CALIBRATE_DEFAULT - (calculated
+		 * temperature from sensor reading at factory temperature
+		 * minus actual factory temperature) * X (scale from
+		 * temperature to register values)
+		 */
+		cdata = CALIBRATE_DEFAULT -
+			((sensor_temp - ft_temp) / SUN55I_A523_SCALE_ABOVE);
+
+		if (cdata & ~TEMP_CALIB_MASK) {
+			/*
+			 * Calibration value more than 12-bit, but calibration
+			 * register is 12-bit. In this case, ths hardware can
+			 * still work without calibration, although the data
+			 * won't be so accurate.
+			 */
+			dev_warn(dev, "sensor%d is not calibrated.\n", i);
+			continue;
+		}
+
+		offset = (i % 2) * 16;
+		regmap_update_bits(tmdev->regmap,
+				   SUN50I_H6_THS_TEMP_CALIB + (i / 2 * 4),
+				   TEMP_CALIB_MASK << offset,
+				   cdata << offset);
+	}
+
+	return 0;
+}
+
 static int sun8i_ths_calibrate(struct ths_device *tmdev)
 {
 	struct nvmem_cell *calcell = NULL;
@@ -722,6 +828,31 @@ static const struct ths_thermal_chip sun50i_h616_ths = {
 	.calc_temp = sun8i_ths_calc_temp,
 };
 
+/* The A523 has a shared reset line for both chips */
+static const struct ths_thermal_chip sun55i_a523_ths0 = {
+	.sensor_num = 1,
+	.has_bus_clk_reset = true,
+	.has_mod_clk = true,
+	.ft_deviation = 5000,
+	.temp_data_base = SUN50I_H6_THS_TEMP_DATA,
+	.calibrate = sun55i_a523_ths_calibrate,
+	.init = sun50i_h6_thermal_init,
+	.irq_ack = sun50i_h6_irq_ack,
+	.calc_temp = sun55i_a523_calc_temp,
+};
+
+static const struct ths_thermal_chip sun55i_a523_ths1 = {
+	.sensor_num = 3,
+	.has_bus_clk_reset = true,
+	.has_mod_clk = true,
+	.ft_deviation = 5000,
+	.temp_data_base = SUN50I_H6_THS_TEMP_DATA,
+	.calibrate = sun55i_a523_ths_calibrate,
+	.init = sun50i_h6_thermal_init,
+	.irq_ack = sun50i_h6_irq_ack,
+	.calc_temp = sun55i_a523_calc_temp,
+};
+
 static const struct of_device_id of_ths_match[] = {
 	{ .compatible = "allwinner,sun8i-a83t-ths", .data = &sun8i_a83t_ths },
 	{ .compatible = "allwinner,sun8i-h3-ths", .data = &sun8i_h3_ths },
@@ -732,6 +863,8 @@ static const struct of_device_id of_ths_match[] = {
 	{ .compatible = "allwinner,sun50i-h6-ths", .data = &sun50i_h6_ths },
 	{ .compatible = "allwinner,sun20i-d1-ths", .data = &sun20i_d1_ths },
 	{ .compatible = "allwinner,sun50i-h616-ths", .data = &sun50i_h616_ths },
+	{ .compatible = "allwinner,sun55i-a523-ths0", .data = &sun55i_a523_ths0 },
+	{ .compatible = "allwinner,sun55i-a523-ths1", .data = &sun55i_a523_ths1 },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, of_ths_match);
-- 
2.54.0

