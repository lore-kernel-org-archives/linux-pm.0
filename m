Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D0C4657F2;
	Tue, 21 Jul 2026 09:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784626609; cv=none; b=tac0x9i5+3e9fnq8epzj96zaa6NuPm8lPz9VCAYL87z+Qhk0Zy0ncdDib7RhQMAAf5jIC9Vf5SRmfCIlyz60oOP+9z90Wc2hDZiPsg/IDaUMaL79ADwCMAHSoUBkVJeyqXsNXpdKmgJC9C8Wecv43EbvgsOWd/Z0mq3GFKhg3UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784626609; c=relaxed/simple;
	bh=j2X5dwZMV4sl4tTCokUqzE+ScAYsMKJ8lYfgrAI1WxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4/xbvXy2M+eMeSVsaTgCuBrWBmgtCr/o11o2P6GYJKRCuC4TMVlbCOsbo+xA3omfiqqdMSuOH5WzZrqKVH53d0zq8IVgO0nlMCTgQMhFdR4177vKddzvt7zwh9RkAUnxfQVerpVcoG3pqLVj4Cf6R4S80H22tZUy3IgL8KunZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Fo30lcmE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Fo30lcmE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784626606;
	bh=j2X5dwZMV4sl4tTCokUqzE+ScAYsMKJ8lYfgrAI1WxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fo30lcmEabcbTjZ/3F+RDkPLcC5RAqtt/gM5pgZOUELC1r0jXdTRAX4+cbipphTeA
	 YMAqK/sJk9oM9SxK7GHff/JRq/6U9aW86R3s4VkOcSWf3S2/ZYVqVPqRXYJWNt4EDe
	 M189QPnyttfr+s4sZz9oEVWYpP55dzB2hYLmU4jQRWJn7J2O8p6iiCr1qZF/SZ1pKQ
	 pGz8RO6idOJ8aTJI2+GRvv2TjeDzqiE66Qw39doosvtPHkO0ftaRKwN4Se3gOUiYxg
	 7kioN66Z0PKcQdGsMsfBZUoCVfOS9HohmfEgP4cCYC2qf71n43uZZWdm7xatwT2ffu
	 eSh0Q3sKpu+eA==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DD6D917E0B71;
	Tue, 21 Jul 2026 11:36:44 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jic23@kernel.org,
	sboyd@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	srini@kernel.org,
	vkoul@kernel.org,
	neil.armstrong@linaro.org,
	sre@kernel.org,
	angelogioacchino.delregno@collabora.com,
	krzk@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	quic_wcheng@quicinc.com,
	melody.olvera@oss.qualcomm.com,
	quic_nsekar@quicinc.com,
	ivo.ivanov.ivanov1@gmail.com,
	abelvesa@kernel.org,
	luca.weiss@fairphone.com,
	konrad.dybcio@oss.qualcomm.com,
	mitltlatltl@gmail.com,
	krishna.kurapati@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v13 12/12] iio: adc: qcom-spmi-iadc: Remove regmap R/W wrapper functions
Date: Tue, 21 Jul 2026 11:36:26 +0200
Message-ID: <20260721093626.96264-13-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721093626.96264-1-angelogioacchino.delregno@collabora.com>
References: <20260721093626.96264-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver doesn't need to add any register base address to any
regmap call anymore since it was migrated to register as a SPMI
subdevice with its own regmap reg_base, which makes the regmap
API to automatically add such base address internally.

Since the iadc_{read,write,read_result}() functions now only do
call regmap_{read,write,bulk_read}() and nothing else, simplify
the driver by removing them and by calling regmap APIs directly.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iio/adc/qcom-spmi-iadc.c | 89 ++++++++++++--------------------
 1 file changed, 33 insertions(+), 56 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-iadc.c b/drivers/iio/adc/qcom-spmi-iadc.c
index 21e35df82193..196525ba0b4b 100644
--- a/drivers/iio/adc/qcom-spmi-iadc.c
+++ b/drivers/iio/adc/qcom-spmi-iadc.c
@@ -113,77 +113,59 @@ struct iadc_chip {
 	struct completion complete;
 };
 
-static int iadc_read(struct iadc_chip *iadc, u16 offset, u8 *data)
-{
-	unsigned int val;
-	int ret;
-
-	ret = regmap_read(iadc->regmap, offset, &val);
-	if (ret < 0)
-		return ret;
-
-	*data = val;
-	return 0;
-}
-
-static int iadc_write(struct iadc_chip *iadc, u16 offset, u8 data)
-{
-	return regmap_write(iadc->regmap, offset, data);
-}
-
 static int iadc_reset(struct iadc_chip *iadc)
 {
-	u8 data;
+	u32 data;
 	int ret;
 
-	ret = iadc_write(iadc, IADC_SEC_ACCESS, IADC_SEC_ACCESS_DATA);
+	ret = regmap_write(iadc->regmap, IADC_SEC_ACCESS, IADC_SEC_ACCESS_DATA);
 	if (ret < 0)
 		return ret;
 
-	ret = iadc_read(iadc, IADC_PERH_RESET_CTL3, &data);
+	ret = regmap_read(iadc->regmap, IADC_PERH_RESET_CTL3, &data);
 	if (ret < 0)
 		return ret;
 
-	ret = iadc_write(iadc, IADC_SEC_ACCESS, IADC_SEC_ACCESS_DATA);
+	ret = regmap_write(iadc->regmap, IADC_SEC_ACCESS, IADC_SEC_ACCESS_DATA);
 	if (ret < 0)
 		return ret;
 
 	data |= IADC_FOLLOW_WARM_RB;
 
-	return iadc_write(iadc, IADC_PERH_RESET_CTL3, data);
+	return regmap_write(iadc->regmap, IADC_PERH_RESET_CTL3, data);
 }
 
 static int iadc_set_state(struct iadc_chip *iadc, bool state)
 {
-	return iadc_write(iadc, IADC_EN_CTL1, state ? IADC_EN_CTL1_SET : 0);
+	return regmap_write(iadc->regmap, IADC_EN_CTL1, state ? IADC_EN_CTL1_SET : 0);
 }
 
 static void iadc_status_show(struct iadc_chip *iadc)
 {
-	u8 mode, sta1, chan, dig, en, req;
+	u32 mode, sta1, chan, dig, en, req;
 	int ret;
 
-	ret = iadc_read(iadc, IADC_MODE_CTL, &mode);
+	ret = regmap_read(iadc->regmap, IADC_MODE_CTL, &mode);
 	if (ret < 0)
 		return;
 
-	ret = iadc_read(iadc, IADC_DIG_PARAM, &dig);
+	ret = regmap_read(iadc->regmap, IADC_DIG_PARAM, &dig);
 	if (ret < 0)
 		return;
 
-	ret = iadc_read(iadc, IADC_CH_SEL_CTL, &chan);
+	ret = regmap_read(iadc->regmap, IADC_CH_SEL_CTL, &chan);
 	if (ret < 0)
 		return;
 
-	ret = iadc_read(iadc, IADC_CONV_REQ, &req);
+	ret = regmap_read(iadc->regmap, IADC_CONV_REQ, &req);
 	if (ret < 0)
 		return;
 
-	ret = iadc_read(iadc, IADC_STATUS1, &sta1);
+	ret = regmap_read(iadc->regmap, IADC_STATUS1, &sta1);
 	if (ret < 0)
 		return;
 
-	ret = iadc_read(iadc, IADC_EN_CTL1, &en);
+	ret = regmap_read(iadc->regmap, IADC_EN_CTL1, &en);
 	if (ret < 0)
 		return;
 
@@ -199,34 +181,34 @@ static int iadc_configure(struct iadc_chip *iadc, int channel)
 
 	/* Mode selection */
 	mode = (IADC_OP_MODE_NORMAL << IADC_OP_MODE_SHIFT) | IADC_TRIM_EN;
-	ret = iadc_write(iadc, IADC_MODE_CTL, mode);
+	ret = regmap_write(iadc->regmap, IADC_MODE_CTL, mode);
 	if (ret < 0)
 		return ret;
 
 	/* Channel selection */
-	ret = iadc_write(iadc, IADC_CH_SEL_CTL, channel);
+	ret = regmap_write(iadc->regmap, IADC_CH_SEL_CTL, channel);
 	if (ret < 0)
 		return ret;
 
 	/* Digital parameter setup */
 	decim = IADC_DEF_DECIMATION << IADC_DIG_DEC_RATIO_SEL_SHIFT;
-	ret = iadc_write(iadc, IADC_DIG_PARAM, decim);
+	ret = regmap_write(iadc->regmap, IADC_DIG_PARAM, decim);
 	if (ret < 0)
 		return ret;
 
 	/* HW settle time delay */
-	ret = iadc_write(iadc, IADC_HW_SETTLE_DELAY, IADC_DEF_HW_SETTLE_TIME);
+	ret = regmap_write(iadc->regmap, IADC_HW_SETTLE_DELAY, IADC_DEF_HW_SETTLE_TIME);
 	if (ret < 0)
 		return ret;
 
-	ret = iadc_write(iadc, IADC_FAST_AVG_CTL, IADC_DEF_AVG_SAMPLES);
+	ret = regmap_write(iadc->regmap, IADC_FAST_AVG_CTL, IADC_DEF_AVG_SAMPLES);
 	if (ret < 0)
 		return ret;
 
 	if (IADC_DEF_AVG_SAMPLES)
-		ret = iadc_write(iadc, IADC_FAST_AVG_EN, IADC_FAST_AVG_EN_SET);
+		ret = regmap_write(iadc->regmap, IADC_FAST_AVG_EN, IADC_FAST_AVG_EN_SET);
 	else
-		ret = iadc_write(iadc, IADC_FAST_AVG_EN, 0);
+		ret = regmap_write(iadc->regmap, IADC_FAST_AVG_EN, 0);
 
 	if (ret < 0)
 		return ret;
@@ -239,19 +221,19 @@ static int iadc_configure(struct iadc_chip *iadc, int channel)
 		return ret;
 
 	/* Request conversion */
-	return iadc_write(iadc, IADC_CONV_REQ, IADC_CONV_REQ_SET);
+	return regmap_write(iadc->regmap, IADC_CONV_REQ, IADC_CONV_REQ_SET);
 }
 
 static int iadc_poll_wait_eoc(struct iadc_chip *iadc, unsigned int interval_us)
 {
 	unsigned int count, retry;
+	u32 sta1;
 	int ret;
-	u8 sta1;
 
 	retry = interval_us / IADC_CONV_TIME_MIN_US;
 
 	for (count = 0; count < retry; count++) {
-		ret = iadc_read(iadc, IADC_STATUS1, &sta1);
+		ret = regmap_read(iadc->regmap, IADC_STATUS1, &sta1);
 		if (ret < 0)
 			return ret;
 
@@ -267,11 +249,6 @@ static int iadc_poll_wait_eoc(struct iadc_chip *iadc, unsigned int interval_us)
 	return -ETIMEDOUT;
 }
 
-static int iadc_read_result(struct iadc_chip *iadc, u16 *data)
-{
-	return regmap_bulk_read(iadc->regmap, IADC_DATA, data, 2);
-}
-
 static int iadc_do_conversion(struct iadc_chip *iadc, int chan, u16 *data)
 {
 	unsigned int wait;
@@ -296,7 +273,7 @@ static int iadc_do_conversion(struct iadc_chip *iadc, int chan, u16 *data)
 	}
 
 	if (!ret)
-		ret = iadc_read_result(iadc, data);
+		ret = regmap_bulk_read(iadc->regmap, IADC_DATA, data, sizeof(*data));
 exit:
 	iadc_set_state(iadc, false);
 	if (ret < 0)
@@ -392,33 +369,33 @@ static int iadc_update_offset(struct iadc_chip *iadc)
 
 static int iadc_version_check(struct iadc_chip *iadc)
 {
-	u8 val;
+	u32 val;
 	int ret;
 
-	ret = iadc_read(iadc, IADC_PERPH_TYPE, &val);
+	ret = regmap_read(iadc->regmap, IADC_PERPH_TYPE, &val);
 	if (ret < 0)
 		return ret;
 
 	if (val < IADC_PERPH_TYPE_ADC) {
-		dev_err(iadc->dev, "%d is not ADC\n", val);
+		dev_err(iadc->dev, "%u is not ADC\n", val);
 		return -EINVAL;
 	}
 
-	ret = iadc_read(iadc, IADC_PERPH_SUBTYPE, &val);
+	ret = regmap_read(iadc->regmap, IADC_PERPH_SUBTYPE, &val);
 	if (ret < 0)
 		return ret;
 
 	if (val < IADC_PERPH_SUBTYPE_IADC) {
-		dev_err(iadc->dev, "%d is not IADC\n", val);
+		dev_err(iadc->dev, "%u is not IADC\n", val);
 		return -EINVAL;
 	}
 
-	ret = iadc_read(iadc, IADC_REVISION2, &val);
+	ret = regmap_read(iadc->regmap, IADC_REVISION2, &val);
 	if (ret < 0)
 		return ret;
 
 	if (val < IADC_REVISION2_SUPPORTED_IADC) {
-		dev_err(iadc->dev, "revision %d not supported\n", val);
+		dev_err(iadc->dev, "revision %u not supported\n", val);
 		return -EINVAL;
 	}
 
@@ -428,7 +405,7 @@ static int iadc_version_check(struct iadc_chip *iadc)
 static int iadc_rsense_read(struct iadc_chip *iadc, struct device_node *node)
 {
 	int ret, sign, int_sense;
-	u8 deviation;
+	u32 deviation;
 
 	ret = of_property_read_u32(node, "qcom,external-resistor-micro-ohms",
 				   &iadc->rsense[IADC_EXT_RSENSE]);
@@ -440,7 +417,7 @@ static int iadc_rsense_read(struct iadc_chip *iadc, struct device_node *node)
 		return -EINVAL;
 	}
 
-	ret = iadc_read(iadc, IADC_NOMINAL_RSENSE, &deviation);
+	ret = regmap_read(iadc->regmap, IADC_NOMINAL_RSENSE, &deviation);
 	if (ret < 0)
 		return ret;
 
-- 
2.55.0

