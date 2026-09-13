Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDF7331EAB
	for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 14:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311416; cv=none; b=a1WB+s3wPLFSOmsAuTxIGqLWQgghFN3mg7mMfkOnYUa57fh7B+TUPky9F3DXcjB529+Ca8XQuhRKFtNy3QglvJ13ctnLFjMzIRol2vMxOA3Jiz8YOYm18mNrPKaQskSLt9TWv6OsxLDtMjs5k15aaSv2D1RARhWqXaN6/YsdsTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311416; c=relaxed/simple;
	bh=002rqKnwYlIeVlmK+OrjXg0dmApCO+jy4dOIn8rGOwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jH70TQkDGGgZjQ/P2QoxRKOE7izCBWuz50FgY9ygnzNSVYy3q0X+KlRXBhk74mE4Wk8yNm6RmMNcCG5RAt6uBVqIe6fJfwLMSbWQd1r3mFaLwCd12RqE8svCVuuwHbBuPWZjWPpjXSLhmg+abdRj99D0MKBufF2tATCMNItAlVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axNCiK0X; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axNCiK0X"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so2180429a91.0
        for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 07:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789311411; x=1789916211; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MFmILcFARM3nbjJrUrOfoTXP5jUQVkRuUWrnpYTCEmM=;
        b=axNCiK0X16xSYIUjGMsp36VBO8SCzpYWM8SSINH0g9mtGnwz6dHHvLGBhckM76n67S
         OOYQc5yjRlUQRd7kEq4AwwyOnpC2df+CC1o4F8fDYSZjmb5qfS+faPVek8Pd699qIrhL
         Q9G0A5pZ+xObc1/KUtm2r6ciiqDuKIHIO6UoYFORmXEdjENfR5dXxTzZCLNUKcvFPnbU
         cwnumFe7MNqWkyFsbH/Y8oY4nIybovzmaW9F3AjFNxvun8uoEFVNXW6YDN0xMxUI4osQ
         3xwAg0GA/IABwucDXyq8r38gyv0nW7TZSabX3yW5C57IlcJPaajHc0zZtxxVzQQ88WJi
         bz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789311411; x=1789916211;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MFmILcFARM3nbjJrUrOfoTXP5jUQVkRuUWrnpYTCEmM=;
        b=WqbqTM88bHC7DoCGhw3+LU6L2SN1H4WHza1APkYXQGNsQ/Rklo5v3vBE9fvYaVWp2J
         ePVMhE3j2UAgMvQOSscJSBciGR/1VUOG0go9mbUxBn5Ttwo/qPwb4zCVUhVUHgF0c/3K
         7ZOdr+36pdbd98F1tR54vFGCZvfraDJZD5V/pH2iosher0y4eZFb73Hd2IWB1PAdvH4g
         vcH9JK9v1hkveXkhUdvQxaWu65I4opiuGhIpdEZHR0qsWX/JAnA4D7BxVJCeLTAOtZot
         HFPdL4my75rgQAEeCb95wmCwNeTCzcHpo34B4mzlp+RFg2dJi3f9GssSKFFN5i61yVnY
         qblg==
X-Gm-Message-State: AFuF++lghA2u4c+8TGl5yqlEd8o0NOTZkA1MKTlvyCjZQ0QTxKkTE+iw
	mM3Efz7AH3JImQVkJ1eFfGG94+vYBE1ErYTxmxkHtYh2aHR6sW8EcSCb
X-Gm-Gg: AYBFou1FOXwuQbgey90j86xaarVlVq88ZNgX1OVeD63qjeGdP+9vQRQW67cVfm1z7y6
	CruJi0V+U2mtdV2RjKjKNMVPB9aow4vcL3dBVx2LpTKlZ7qIOUUDb/Y7BPmiEh3bUI55j5B4gFT
	aXH9IKSZPMis6mXzi5bB0ZRG88Ki5OV4cJkZrgn5j+ANih3CTgrujn9a9ZDBMpq57mtzNS6xf8C
	PghWLWwPvwqsPCweQa5/py+lQtAwvBs3f0VdQX4yxIUXRKD6W8oq9kCzy6ub5g58ilGZaIJVZt3
	D/A+s+hHm9Tb7zv1gNPjb0PcruMxFeB31vE5HJQTRNLM40HVsmPHJl390ui/Czt/lk+tN0060PO
	YCseUtJHi9gGk0ZSr20R4sim1iFbkzcp6qIUly1mhvgVQp+5vwdkuHWmmcU/FPrRuz1uijwVU8x
	YUw587xRdE1WZSZuD5s3CkHoOG6r2Pcf+9Csw1bC838hKwC9oXIO/wMrmomTgnebn/
X-Received: by 2002:a17:90b:51c8:b0:38e:5b59:c2ff with SMTP id 98e67ed59e1d1-39d9bbc802bmr22552630a91.3.1789311411298;
        Sun, 13 Sep 2026 07:56:51 -0700 (PDT)
Received: from archlinux ([207.90.239.231])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba7a9bb56sm21467366eec.31.2026.09.13.07.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 07:56:50 -0700 (PDT)
From: Mikhail Kalashnikov <iuncuim@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	=?UTF-8?q?Juan=20Manuel=20L=C3=B3pez=20Carrillo?= <juanmanuellopezcarrillo@gmail.com>,
	Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v6 4/5] thermal/drivers/sun8i: Add support for A523 THS0/1 controllers
Date: Sun, 13 Sep 2026 22:55:26 +0800
Message-ID: <20260913145527.18148-5-iuncuim@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913145527.18148-1-iuncuim@gmail.com>
References: <20260913145527.18148-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

The A523 processor has two temperature controllers, THS0 and THS1.
THS0 has only one temperature sensor, which is located in the DRAM
controller. THS1 does have 4 sensors:
ths1_0 - "big" cores
ths1_1 - "little" cores
ths1_2 - gpu
ths1_3 - npu

The user manual for the T527 processor describes 4 sensors, whereas
the one for the A523 describes only 3. As additional information, the BSP
driver was used, in which the value SUN55IW3_CAL_COM(5000) is used as
the calibration value in the formula; in the mainline driver it is
treated as the ft_deviation value. Also, in the BSP driver the NPU sensor
is used for both the GPU and the NPU — its actual purpose is unclear;
both sensors are functional and show temperature changes depending on
load.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 147 ++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 360654880..4a81486f8 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -59,6 +59,12 @@
 #define SUN50I_H6_THS_PC_TEMP_PERIOD(x)		((GENMASK(19, 0) & (x)) << 12)
 #define SUN50I_H6_THS_DATA_IRQ_STS(x)		BIT(x)
 
+#define SUN55I_A523_DELIMITER			0x7c8
+#define SUN55I_A523_OFFSET_BELOW		2736
+#define SUN55I_A523_OFFSET_ABOVE		2825
+#define SUN55I_A523_SCALE_BELOW			74
+#define SUN55I_A523_SCALE_ABOVE			65
+
 struct tsensor {
 	struct ths_device		*tmdev;
 	struct thermal_zone_device	*tzd;
@@ -114,6 +120,21 @@ static int sun50i_h5_calc_temp(struct ths_device *tmdev,
 		return -1590 * reg / 10 + 276000;
 }
 
+/*
+ * The constant names were chosen in accordance with the BSP driver;
+ * they indicate whether the value corresponds to a high or low
+ * temperature (relative to a value of ~55 °C), rather than the reg value
+ * that was read.
+ */
+static int sun55i_a523_calc_temp(struct ths_device *tmdev,
+				 int id, int reg)
+{
+	if (reg >= SUN55I_A523_DELIMITER)
+		return SUN55I_A523_SCALE_BELOW * (SUN55I_A523_OFFSET_BELOW - reg);
+	else
+		return SUN55I_A523_SCALE_ABOVE * (SUN55I_A523_OFFSET_ABOVE - reg);
+}
+
 static int sun8i_ths_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct tsensor *s = thermal_zone_device_priv(tz);
@@ -298,6 +319,105 @@ static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
 	return 0;
 }
 
+/*
+ * The A523 calibration data is stored in the eFuse, split across two
+ * nvmem cells. THS1 has four sensors, including ths1_3 which is used
+ * for the NPU, each with its own calibration value. The fields are
+ * packed as shown in the layouts below.
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
+	if (!caldata[1])
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
+			sensor_reg = ((caldata[5] >> 8) |
+				      (caldata[6] << 8)) & TEMP_CALIB_MASK;
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
+			case 3:
+				sensor_reg = ((caldata[4] >> 12) |
+					      (caldata[5] << 4)) & TEMP_CALIB_MASK;
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
+		 * temperature to register values).
+		 *
+		 * The BSP's SUN55IW3_CAL_COM(5000) is applied as ft_deviation
+		 * in sun8i_ths_get_temp(), after calc_temp(), and therefore
+		 * intentionally not repeated here.
+		 */
+		cdata = CALIBRATE_DEFAULT -
+			((sensor_temp - ft_temp) / SUN55I_A523_SCALE_BELOW);
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
@@ -719,6 +839,31 @@ static const struct ths_thermal_chip sun50i_h616_ths = {
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
+	.sensor_num = 4,
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
@@ -729,6 +874,8 @@ static const struct of_device_id of_ths_match[] = {
 	{ .compatible = "allwinner,sun50i-h6-ths", .data = &sun50i_h6_ths },
 	{ .compatible = "allwinner,sun20i-d1-ths", .data = &sun20i_d1_ths },
 	{ .compatible = "allwinner,sun50i-h616-ths", .data = &sun50i_h616_ths },
+	{ .compatible = "allwinner,sun55i-a523-ths0", .data = &sun55i_a523_ths0 },
+	{ .compatible = "allwinner,sun55i-a523-ths1", .data = &sun55i_a523_ths1 },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, of_ths_match);
-- 
2.55.0

