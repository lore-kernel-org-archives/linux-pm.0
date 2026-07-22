Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5143E16B9
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 21:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784754081; cv=none; b=EwhDQm8FEQ+cfKBjupkZMXxYYhxH6dDvi3KHte99gvE7Xn5A2L8W5G9b0TLidOeZhG4tDWkPfbOiAvCtsd1ir+iL2tXf5RHZjmUSUgdyeamxf5beoPtgMVGIGE1kkjbfxRYKa8lNOf8Wk0boAWj9ddmduJtqUmcgoHbNQZmQZxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784754081; c=relaxed/simple;
	bh=QfEiZ1MBoePzf0Zzf6Vklru7ufE2oWiROW1QfAEBbtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bpVdVpD7sFhZRhzyEKz8CByrrgoDJUm/qdKCLdqKgv3PAVq5M8VJHaZLMK7IYb1M2650JgciL939R+cLtY/dJwKVZbqDv05q5nYuwfrbNvcyf9P91U9xHDri60pDY6H7R+jest471pEKx/BetpLM+Ws6RwAsbMo5yBnCReW6bQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnNjb+AW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnNjb+AW"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f84023916so1608259f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 14:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784754077; x=1785358877; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B4bcrjfjaOxCTjFJ1nEuge+dwYCIOai8f6MdCth28oQ=;
        b=MnNjb+AWcvBIhjG1V0zsmHK8/x6xkLNeT0SVIfTZinXgl57a32M601pzurqkb7znDk
         gSeBXD/p6Ibv1O3kSMVSPvCo7QpDv3lj2URKkjymuqv4DPr2unfRf63GotsKXBchSxGp
         Xo2f/BEGVICKFsvcqQbI+aj7UxgQKbJAe40wTBBluZymjyyDV1lYGKaR+50kqBA6skzG
         ydXse6/bFZUNTqMN5R4J6arzjTWee0Lf0Ayx10QNcpLz+zAG9iNO/y1gvi6zNoXYf64r
         o60jbAlnBhDd+eFzS/pexHOjhHRMXYqi2XKoPL9e6P6CML1HDLatmJNkV6xZ3zDIDBvK
         rLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784754077; x=1785358877;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B4bcrjfjaOxCTjFJ1nEuge+dwYCIOai8f6MdCth28oQ=;
        b=Bs1fulTqrnzNLNZNdxPu+QeRQrLgZUQXK/crdJoRxI0Az7go9mbhWSMilQ+9CRdgm7
         GuUVqT+7SUIxyYJ2084N/XJFaw612wJDKMwuYqB15WfgHstE+mgN19lbzzND2KdSO55e
         /hrggl/hAkWVRkBLW5veI0elkPbopGagt5qKrTmA+V4VropCSZGIcp/Xf0HWasS6ozbS
         d68dj9XDBjsqa+t/Dk3FtQ+JpWFF9u5Wmv8oEKPGPOnk/uoFNCT88Kc4OUtlGupmLgtz
         yBg15TsC3Etg2JRevAeKl4yfEDC66isA1Tnza5K4nSUD0an3usnUEgLB0IyIBAQgyLs0
         veig==
X-Gm-Message-State: AOJu0Yz1OH3iDpgsmlFfwIyGNFSXlrX5Ih2N32XhM+Z98ttW+X3mU4Am
	rY2LPtIY2Bxmu+6H9U/Rl1o5oarYjFL4DqvyGTMC5ylgCT/QdWHbtWjdcxXwmjIEXbTLeQ==
X-Gm-Gg: AR+sD10nICaLqK6jB7USXZQCiJPnJhZXO51hlEmVvoMhYri9xqknNi56KQL0VHPwgDh
	jcxnEr/4xSFkrFdVwJ9C7q/63UFR0NUiw3tQs23JGt69kAOiAVRVEee0BfkqQKZiWkEIs6ysQVn
	WFwy7QuJIPjEIZV7DI1INR1KGWZkLo6fkxpwguBMc++8llo50tEuRy3dpOQrZBgOmZfgD4K+STf
	D9Ayls8ah2OTiilsbxGDvZ4woZReWU06Ej7I48H4IUVHxTS8a7HLu22g3Ebb7+bAYHH9+/K4vKi
	h2N9DAclc8aWFg3qZteTEZPJpQaSuR8wKlw+JnTlmbIDpURuGTMjxgufhkIJCXz0ZRri9eAacCY
	RFqD8q/Iw59ISfIQ/g+UESDMo1i6r3QKfysJ8w89WqkxbRpwdtJeB5aztL2aWG1JikA9QEctGJE
	9Rd4pCKAmGBPftH62F3VSAmDJr
X-Received: by 2002:a05:6000:4903:b0:46f:a0f1:c33f with SMTP id ffacd0b85a97d-47f8d7565a2mr481160f8f.32.1784754076687;
        Wed, 22 Jul 2026 14:01:16 -0700 (PDT)
Received: from coolemuke.fritz.box ([2a00:6020:b320:1a00:c256:1463:a40b:d8c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c63678sm8610812f8f.29.2026.07.22.14.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 14:01:16 -0700 (PDT)
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
Subject: [PATCH v2 2/3] thermal/drivers/sun8i: Add support for the A80 THS
Date: Wed, 22 Jul 2026 23:00:45 +0200
Message-ID: <20260722210046.2932498-3-fugininsane@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722210046.2932498-1-fugininsane@googlemail.com>
References: <20260722203341.2917852-1-fugininsane@googlemail.com>
 <20260722210046.2932498-1-fugininsane@googlemail.com>
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
rate (tens of kHz), and the level triggered alarm interrupt would
retrigger for as long as an over-temperature condition persists, so
both stay disabled and the thermal core polls the sensors; only the
emergency shutdown event keeps its interrupt enabled.

Since the A80 chip description has no calibrate callback, guard the
callback invocation in sun8i_ths_calibrate(); the A80 SID is not yet
supported by the sunxi nvmem driver anyway, so calibration data is
currently unavailable and the driver falls back to the defaults,
which yield plausible results (idle temperatures around 40 degC,
full-load peaks in the mid 50s on a Cubieboard4).

Tested on a Cubietech Cubieboard4: all four zones report load-reactive
temperatures via polling.

Co-authored-by: Claude Fable 5 <noreply@anthropic.com>
Signed-off-by: Sören Hantel <fugininsane@googlemail.com>
---
 drivers/thermal/sun8i_thermal.c | 98 ++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 2267479..c906dea 100644
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
@@ -307,6 +326,9 @@ static int sun8i_ths_calibrate(struct ths_device *tmdev)
 	size_t callen;
 	int ret = 0;
 
+	if (!tmdev->chip->calibrate)
+		return 0;
+
 	calcell = nvmem_cell_get(dev, "calibration");
 	if (IS_ERR(calcell)) {
 		if (PTR_ERR(calcell) == -EPROBE_DEFER)
@@ -413,7 +435,8 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
 			return PTR_ERR(tmdev->mod_clk);
 	}
 
-	ret = clk_set_rate(tmdev->mod_clk, 24000000);
+	ret = clk_set_rate(tmdev->mod_clk, tmdev->chip->mod_clk_rate ?:
+			   24000000);
 	if (ret)
 		return ret;
 
@@ -596,6 +619,78 @@ static int sun8i_ths_probe(struct platform_device *pdev)
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
+	 * conversion rate (tens of kHz), and the level triggered alarm
+	 * interrupt would retrigger for as long as the over-temperature
+	 * condition persists. Leave both disabled and let the thermal
+	 * core poll the data registers; only the emergency shutdown
+	 * interrupt stays enabled, as by the time it fires the hardware
+	 * is powering off anyway.
+	 */
+	regmap_write(tmdev->regmap, SUN9I_THS_IC, SUN9I_THS_SHUT_IRQ_EN);
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
@@ -711,6 +806,7 @@ static const struct ths_thermal_chip sun50i_h616_ths = {
 
 static const struct of_device_id of_ths_match[] = {
 	{ .compatible = "allwinner,sun8i-a83t-ths", .data = &sun8i_a83t_ths },
+	{ .compatible = "allwinner,sun9i-a80-ths", .data = &sun9i_a80_ths },
 	{ .compatible = "allwinner,sun8i-h3-ths", .data = &sun8i_h3_ths },
 	{ .compatible = "allwinner,sun8i-r40-ths", .data = &sun8i_r40_ths },
 	{ .compatible = "allwinner,sun50i-a64-ths", .data = &sun50i_a64_ths },
-- 
2.43.0

