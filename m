Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF2843C046
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784752444; cv=none; b=bFptDSfwnStpOF4sMhmRPkXzLV9QKYxdzA5HZxPjJpWySxIabR5IpilwVx00av92tOVqjUELa3qqBBpq4Ea2jUB2f36mD7eA/SjdbtaIp6JO3Tjt5AJTzunxnuNweKLI+ck1MpuEBxh9wlFsO1XJfbS+P1MxncLiMAARIhv0iOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784752444; c=relaxed/simple;
	bh=XJPPHxvlhX7+yckB+Oxkh/O6RdSQleix8ttfdkXWMwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hHWJyjieaRFd+6XWizSPl5LPfow4wd2iQWWTrpLMA4CDdNj5+2vTEe+uokWCOkR+zFFOQPzZTrBDvPtboW+j3rfqKYJ5ghoHvv9NJWn4tUqLsb7KiFrOQg4FhsXHX+nWzT53F/tKsX3qjj5JJn5E+7bRt2FPAYuOMDQXwxl4LpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGUxlMVA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGUxlMVA"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so23676045e9.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 13:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784752440; x=1785357240; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r+zTFoTWUUJ+4b3U4GZ5sdW+uFxLxmihuq+hef+CKeU=;
        b=DGUxlMVAnnJZ9rujuxNRxJPd16nqdrvFLzRrTTsuqvIYeX2m7BkYC2mg5w6KjsEwPz
         7dgdBaUt8Xqyde/dDoRJqg2ffquelpTOA50SJfgPHdtYOBdugD6zY0acZJRkgt0gaxG1
         b4Hrf7ksToho1rAkEy+sxCcFo90x10zWoHUvs6pC8rkQp8CduYrOYme75XaQEl49RSWD
         gxGdEyDOcz3SR986nFT/P5SOSXfpDU876wbla7dqF4E0TVqv2aR5dNROecIYLj60CxBg
         /YqmIxUUXqNe1ak6u23JIA1OHjlUOB2yQ2hnzirJ2sduz2nuDReK228Wa700AKX+BWkP
         1CPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784752440; x=1785357240;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r+zTFoTWUUJ+4b3U4GZ5sdW+uFxLxmihuq+hef+CKeU=;
        b=HgTkG4I0i7GETUSLmnzPdFc34c5qxlSCpdpvdNvvIJKs5UeUKkh0X/ipY0B7uqVXVj
         0hV2iZqmzrEEO0cFAxQcR+672O62S6Om96wIvhLUaZdzCrJRObV3maAQAAOw7IviXNxJ
         OYNOE5DRSWbunZvuE6lOt/m7QSYRu6TPHHRFVqlKiGSwVr2PqLGohIpgZSaxV+QSvS43
         Srqe7BjPmvI9pWcgrwnX2mk1g/WuHogfag7AxCJ700N/oyNd6SqwUYTYw8BuwSB9nfSb
         hLwIuWvJO4Dqn+EaN9O4tSdVGc9JgJua341ylr40N7DnHHVWfdBzjvsN5AP19sGQFV5F
         bgTA==
X-Gm-Message-State: AOJu0YySQh8qJZHi3MGiDmM/jgv+Md1fWoq5gH0E89GQZlhzew50P0mt
	BZkjUNGtL9kS+fM7E23nt7axlW2qF73BaHvbvvPtcLzyiOVH20b1nbbDgkHwDfafmM5RMA==
X-Gm-Gg: AR+sD12Uo1bddO86Hx6nNU2NVUW4wGmIPfgAYu8EuV3qZm9JNk395fxrqY6TYU9Pg5D
	qgifLntKV+ZMjH7uGbmW5FXGcYellttGf9eMm4HkTYFV1/soUPVBp6e/N6D9354fMgLfpEIGDqg
	UTd4uDVDpvaq2HpFhgG9f+Yp0DNxp2qA66l67DYoFiphpk0ApgtPP/NL8sLbL5/NGHktwy5BkAv
	wAXrdxHFx3808UY5wXb1bYfoywz7FVbZRXymvS1qc8GaJ7WjlBa36A4snD9ApZaZe6foSbwyvuX
	FFmYhP+tEvrMuUorX4hfEDQqh28yUnRizmELxI7eoT22j2oheAXKsbT6N3NLW6Lhs5OenhSpyWf
	kHnZTkffTDCY6nVZL2ZPJMijYjjac0pBT4ruVXBERBs9r+NjdS5tj9gTr6tLZN3MM+VkH/sJIG+
	4/si7C8jLZprhNt2UC3+jyXnhYPTZB62z2vZ8=
X-Received: by 2002:a7b:cb86:0:b0:493:bc4b:b8c with SMTP id 5b1f17b1804b1-49573cf1557mr1519575e9.38.1784752440278;
        Wed, 22 Jul 2026 13:34:00 -0700 (PDT)
Received: from coolemuke.fritz.box ([2a00:6020:b320:1a00:c256:1463:a40b:d8c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956ab2f0a2sm63134945e9.1.2026.07.22.13.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 13:33:59 -0700 (PDT)
From: "=?UTF-8?q?S=C3=B6ren=20Hantel?=" <fugininsane@gmail.com>
X-Google-Original-From: =?UTF-8?q?S=C3=B6ren=20Hantel?= <fugininsane@googlemail.com>
To: linux-pm@vger.kernel.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Rossak <embed3d@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?S=C3=B6ren=20Hantel?= <fugininsane@googlemail.com>,
	Claude Fable 5 <noreply@anthropic.com>
Subject: [PATCH 2/3] thermal/drivers/sun8i: Add support for the A80 THS
Date: Wed, 22 Jul 2026 22:33:40 +0200
Message-ID: <20260722203341.2917852-3-fugininsane@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722203341.2917852-1-fugininsane@googlemail.com>
References: <20260722203341.2917852-1-fugininsane@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Allwinner A80 thermal sensor is an early relative of the THS found
in the A83T and later SoCs. It shares its register block, bus gate,
4 MHz module clock and reset line with the GPADC; the THS registers
live at offset 0x40 of the shared block, with four data registers for
the four sensors (0: big cluster, 1: DRAM, 2: GPU, 3: little cluster).

Register layout, initialization values and the temperature formula
(T = 190 - raw * 1000 / 14543, i.e. offset 190000 / scale 688 in this
driver's convention) are taken from the vendor BSP kernel. The init
sequence also programs the hardware alarm (~90 degC) and emergency
shutdown (~105 degC) thresholds the BSP uses, since their reset
defaults are undefined.

Unlike on later SoCs the data-ready interrupt fires at the conversion
rate (tens of kHz), so it is left disabled and the thermal core polls
the sensors; the interrupt line only serves the alarm and shutdown
events, matching the vendor BSP behaviour.

The A80 SID is not yet supported by the sunxi nvmem driver, so
calibration data is currently unavailable and the driver falls back to
the defaults, which yield plausible results (idle temperatures around
40 degC, full-load peaks in the mid 50s on a Cubieboard4).

Tested on a Cubietech Cubieboard4: all four zones report load-reactive
temperatures via polling.

Co-authored-by: Claude Fable 5 <noreply@anthropic.com>
Signed-off-by: Sören Hantel <fugininsane@googlemail.com>
---
 drivers/thermal/sun8i_thermal.c | 93 ++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 2267479..3e7bfda 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -65,8 +65,27 @@ struct tsensor {
 	int				id;
 };
 
+/*
+ * The A80 thermal sensor shares its register block with the GPADC.
+ * The THS registers start at offset 0x40 within that block.
+ */
+#define SUN9I_THS_CTRL				0x40
+#define SUN9I_THS_IC				0x44
+#define SUN9I_THS_IS				0x48
+#define SUN9I_THS_ALARM_TH(x)			(0x50 + (x) * 0x4)
+#define SUN9I_THS_SHUT_TH(x)			(0x60 + (x) * 0x4)
+#define SUN9I_THS_MFC				0x70
+#define SUN9I_THS_TEMP_DATA			0x80
+#define SUN9I_THS_CTRL_ACQ(x)			((x) << 16)
+#define SUN9I_THS_CTRL_SENSOR_EN		GENMASK(3, 0)
+#define SUN9I_THS_ALARM_IRQ_EN			GENMASK(3, 0)
+#define SUN9I_THS_SHUT_IRQ_EN			GENMASK(7, 4)
+#define SUN9I_THS_ALARM_IRQ_STS(x)		BIT(x)
+#define SUN9I_THS_SHUT_IRQ_STS(x)		BIT(4 + (x))
+
 struct ths_thermal_chip {
 	bool            has_mod_clk;
+	unsigned long	mod_clk_rate;
 	bool            has_bus_clk_reset;
 	bool		needs_sram;
 	int		sensor_num;
@@ -413,7 +432,8 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
 			return PTR_ERR(tmdev->mod_clk);
 	}
 
-	ret = clk_set_rate(tmdev->mod_clk, 24000000);
+	ret = clk_set_rate(tmdev->mod_clk, tmdev->chip->mod_clk_rate ?:
+			   24000000);
 	if (ret)
 		return ret;
 
@@ -596,6 +616,76 @@ static int sun8i_ths_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int sun9i_a80_thermal_init(struct ths_device *tmdev)
+{
+	int i;
+
+	/* clear any pending interrupt status */
+	regmap_write(tmdev->regmap, SUN9I_THS_IS, 0xfff);
+	/* set up the median filter, average over 8 samples */
+	regmap_write(tmdev->regmap, SUN9I_THS_MFC, 0x5);
+
+	/*
+	 * Program the protection thresholds with the values the vendor
+	 * BSP uses (thresholds are in raw sensor units, which decrease
+	 * with rising temperature): an alarm interrupt at ~90 degC and
+	 * an emergency hardware shutdown at ~105 degC.
+	 */
+	for (i = 0; i < tmdev->chip->sensor_num; i++) {
+		regmap_write(tmdev->regmap, SUN9I_THS_ALARM_TH(i),
+			     (1454 << 16) | 0xfff);
+		regmap_write(tmdev->regmap, SUN9I_THS_SHUT_TH(i),
+			     (1231 << 16) | 0xfff);
+	}
+
+	/*
+	 * Unlike on later SoCs, the data-ready interrupt fires at the
+	 * conversion rate (tens of kHz), so leave it disabled and let the
+	 * thermal core poll the data registers; the interrupt line only
+	 * serves the alarm and shutdown events, like in the vendor BSP.
+	 */
+	regmap_write(tmdev->regmap, SUN9I_THS_IC,
+		     SUN9I_THS_ALARM_IRQ_EN | SUN9I_THS_SHUT_IRQ_EN);
+	/* acquire time 0x2f, enable all four sensors */
+	regmap_write(tmdev->regmap, SUN9I_THS_CTRL,
+		     SUN9I_THS_CTRL_ACQ(0x2f) | SUN9I_THS_CTRL_SENSOR_EN);
+
+	return 0;
+}
+
+static unsigned long sun9i_a80_irq_ack(struct ths_device *tmdev)
+{
+	unsigned long irq_bitmap = 0;
+	int i, state;
+
+	regmap_read(tmdev->regmap, SUN9I_THS_IS, &state);
+
+	for (i = 0; i < MAX_SENSOR_NUM; i++) {
+		if (state & (SUN9I_THS_ALARM_IRQ_STS(i) |
+			     SUN9I_THS_SHUT_IRQ_STS(i))) {
+			regmap_write(tmdev->regmap, SUN9I_THS_IS,
+				     state & (SUN9I_THS_ALARM_IRQ_STS(i) |
+					      SUN9I_THS_SHUT_IRQ_STS(i)));
+			set_bit(i, &irq_bitmap);
+		}
+	}
+
+	return irq_bitmap;
+}
+
+static const struct ths_thermal_chip sun9i_a80_ths = {
+	.sensor_num = 4,
+	.has_mod_clk = true,
+	.mod_clk_rate = 4000000,
+	.has_bus_clk_reset = true,
+	.scale = 688,
+	.offset = 190000,
+	.temp_data_base = SUN9I_THS_TEMP_DATA,
+	.init = sun9i_a80_thermal_init,
+	.irq_ack = sun9i_a80_irq_ack,
+	.calc_temp = sun8i_ths_calc_temp,
+};
+
 static const struct ths_thermal_chip sun8i_a83t_ths = {
 	.sensor_num = 3,
 	.scale = 705,
@@ -711,6 +801,7 @@ static const struct ths_thermal_chip sun50i_h616_ths = {
 
 static const struct of_device_id of_ths_match[] = {
 	{ .compatible = "allwinner,sun8i-a83t-ths", .data = &sun8i_a83t_ths },
+	{ .compatible = "allwinner,sun9i-a80-ths", .data = &sun9i_a80_ths },
 	{ .compatible = "allwinner,sun8i-h3-ths", .data = &sun8i_h3_ths },
 	{ .compatible = "allwinner,sun8i-r40-ths", .data = &sun8i_r40_ths },
 	{ .compatible = "allwinner,sun50i-a64-ths", .data = &sun50i_a64_ths },
-- 
2.43.0

