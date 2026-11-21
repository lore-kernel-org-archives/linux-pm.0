Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.240
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795242822;
	b=eTuy/lIFsEU7YMK/olTnxkC0TO011Tk8Ruj08DU9gR8s46GI7EeNq2AdUT05dePZuYMT
	 7sUJMfBYtU9kj/ZRX47Ld83o5/j3SA9TGiBPFdmz7seiLuhv3dY/OkOaZtFFNiQKGTx0P
	 5hcA2H/uow4miNHQ2IX2ANPATwjXaCOsZFliXLHST96/dK93ACoMzADOvO2CA05GNnYKR
	 Oq5XUNsS8ucE23XtxFpAfs1yKLwSuMZEE72VptdB/vWYppw/Va3yFst4WBH9PBmn90+Tz
	 4lwFS3FX3LPvdcs+j86DUk1oX11ux8oX/yExWQleGFcVAiPLErz0jlKhN9RNbxTZ4cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795242822;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=WCE0vUfhS0MhPYOM4DRo/ve5dejGQTzGK0Aug4NmRXQ=;
	b=qFQUqvyUKOvWUVrjHvD0Jd/fe+vbZuRIJxrtdOvMSkFRAC1PHsW6xFFFvTy5ub7Zvyx7
	 o1Gmuf7G57m1LxYGrMeJa4+DWDkLDway8qBaepfOVespExWWgRXw6bqoOxR+tRIvd4bFK
	 ml0kGajVerfuEmq43KEvttMxeioAfj8T95nykWdQ1J1HOYshebO0+YWKwa0aMG1uWL7q2
	 TNusLh5fWlb8mh1yd5psntR/cC6ECdnkSTHScruHYbM/o1EKume0xT2ZUX8E/A4eO8H1c
	 DX7QbMAXlKZVp8YhV6nXH+qC36WcLxtZ47/O+wU648fZy17OBScwBg905fHdz4IrBzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="yt/wcE0V";
	arc=none smtp.remote-ip=203.205.221.240
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FB9606A33E
	for <linux-pm@vger.kernel.org>; Sat, 21 Nov 2026 06:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94FB9606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=yt/wcE0V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795242816; bh=WCE0vUfhS0MhPYOM4DRo/ve5dejGQTzGK0Aug4NmRXQ=;
	h=From:To:Cc:Subject:Date;
	b=yt/wcE0VqUe3YStJRPZ64ruksnzgz5e5T3jmDUlwhR6IWTVR/bNblcjNvVD/4p9LF
	 Ec1p/8XI7iv7oASsB+aFKC5aZmTpM9/BoJY/FdDcYfBPSvitVLI1eZve9fl88V4FdV
	 cD4AS2VuwwTwcrGnTUDUYZ/44uVDfsEmbuH3faCU=
Received: from jerry-PC.lan ([2408:8249:5f:7101:71a:8713:56b4:5043])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 86136C4F; Sat, 21 Nov 2026 14:33:33 +0800
X-QQ-mid: xmsmtpt1795242813t2sx48k49
Message-ID: <tencent_5995CC7B942E7CD204E49AE7AE32164BAB09@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjSJ9wQXs34T/QCnXRQN1WHKrDU0AzKxo+oPpQOEt6oaKnTYBun0
	 dhvk7l0VVzmWluLRZUV2IobXFwWimg3+dCrdNAqANIm/ZlYYeyrpFvHKeJduD/9yS8OtbK72EPhs
	 jN73tWTYZUQNQCAv725uvIGjmsbZJUx0puQF9D6RX65exj+s2nlJZYVXMIeoQQVNZ8Ev1Hufw0/C
	 qZ0aUcDa/Z1FE+ZolIkZNHBBJ0moqEpnYor+6xbq2CfU9WI6DVicRtZBVAkOFd4vPdr/aWfc1IOp
	 NkIdWmIAi5CJ6Ychu651fWd80ykyDJLPOG0ge51CjvV//mZ8zKMeq479QVb3UqOenMFGEEc/AZ8V
	 SISR7e/JwYnKxD4oTzptfHDFs6t1iYKB771+wmLZHYagFndpNvFJ9l+XNmy2Ob6nAfdEryvXRPVi
	 uVwqhZzsUMgq5W2VXZkymaKt4RwUfR9qGzKRf1CecRNvxvh52KiC7ofapyscIvxLaGY0JJyr3tYF
	 D3/mn4iO6lA9qV0X9P+lk2TAr3LmUlvJLaljktBDjkJ6z+QsEfFzBrCO9U8u0hD+VcrXzQKPsPi5
	 iQwt7xWU81zcsk9E48Vwe1HlhoN3NLHfXAQtFXaoueB3vrtPA/bQXGVZYcFlrVM7rk6u1VYKptbi
	 Wb7MtiJbtW1z4n7gYxLXbjl1GWJZCpYB74i03GRNf4NEImzYexSrRYCQK+940Xil6BiWBtRfzLKx
	 CzGyGp8NLSVAk8vBfXFs/IRfq9gZVPUA+aoVHyX50AIfQgB2WsHSPdJzeZHjeWNh4Qv2dQ98yv5G
	 LofJFsdTT2ULQzuJB64nqLbW8SgnSfbtPrA2t3sFm2vJIN7u3TRNwXT7CtQ9WS4V9yKE0M6G7BcL
	 3UdcYngiz8FLby2LpJfy2EpMfPL6QysM+dvF/1b06CcNxX02fIzwHy6xRF9LVei8UojHx5sIEgCM
	 MY1jRwGcLMTNx6OCmorD4aaGe0NXnMIZFbG81F1oetvmm3ODNEGyC97g+sdMp7ov/bhEG7sUD12G
	 wSqj0WOeWiSS3RHrZHADNtyoBwOPYeDeeRrGFgEdx2cuMaXulRASi144AeL9EWXMWYrvAFOf0LBw
	 ul5hI8IEyjGdMvDr7xktyeeLjshe6jLbkyIIxMGLG95gUEobFAyb+oxqIkqDGiX6RS7KMkl++8l2
	 05qfSB0I4pXA81Hw==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: ZhuXiangyu <1194781887@qq.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ZhuXiangyu <1194781887@qq.com>
Subject: [PATCH 1/2] thermal: rockchip: add RK3506 TSADC support
Date: Sat, 21 Nov 2026 14:33:29 +0800
X-OQ-MSGID: <20261121063330.1094548-1-1194781887@qq.com>
X-Mailer: git-send-email 2.47.3
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

The RK3506 TSADC is based on the TSADCV13 register layout and provides
a single CPU sensor channel. Its analog front-end is enabled through
the GRF and the controller needs the TSEN clock for the sensor analog
supply.

Add the chip data, the conversion table, the initialization sequence
and a suspend callback that turns the analog front-end off while the
SoC is suspended. Also grab the optional TSEN clock so that it is not
disabled as unused.

Tested on an RK3506B EVB: the thermal zone registers successfully and
reports the on-chip temperature correctly.

Tested-by: ZhuXiangyu <1194781887@qq.com>
Signed-off-by: ZhuXiangyu <1194781887@qq.com>
---
 drivers/thermal/rockchip_thermal.c | 101 +++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 5e327039..fbfd78a6 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -104,6 +104,7 @@ struct rockchip_tsadc_chip {
 	/* Chip-wide methods */
 	void (*initialize)(struct regmap *grf,
 			   void __iomem *reg, enum tshut_polarity p);
+	void (*suspend)(struct regmap *grf, void __iomem *reg);
 	void (*irq_ack)(void __iomem *reg);
 	void (*control)(void __iomem *reg, bool on);
 
@@ -146,6 +147,7 @@ struct rockchip_thermal_sensor {
  * @sensors: array of thermal sensors
  * @clk: the controller clock is divided by the exteral 24MHz
  * @pclk: the advanced peripherals bus clock
+ * @tsen: the sensor analog clock, optional
  * @grf: the general register file will be used to do static set by software
  * @regs: the base address of tsadc controller
  * @trim_base: major component of sensor trim value, in Celsius
@@ -165,6 +167,7 @@ struct rockchip_thermal_data {
 
 	struct clk *clk;
 	struct clk *pclk;
+	struct clk *tsen;
 
 	struct regmap *grf;
 	void __iomem *regs;
@@ -210,6 +213,7 @@ struct rockchip_thermal_data {
 #define TSADCV2_AUTO_PERIOD_HT			0x6c
 #define TSADCV3_AUTO_PERIOD			0x154
 #define TSADCV3_AUTO_PERIOD_HT			0x158
+#define TSADCV9_Q_MAX				0x210
 
 #define TSADCV2_AUTO_EN				BIT(0)
 #define TSADCV2_AUTO_EN_MASK			BIT(16)
@@ -220,6 +224,7 @@ struct rockchip_thermal_data {
 #define TSADCV2_AUTO_TSHUT_POLARITY_MASK	BIT(24)
 
 #define TSADCV3_AUTO_Q_SEL_EN			BIT(1)
+#define TSADCV3_AUTO_Q_SEL_EN_MASK		BIT(17)
 
 #define TSADCV2_INT_SRC_EN(chn)			BIT(chn)
 #define TSADCV2_INT_SRC_EN_MASK(chn)		BIT(16 + (chn))
@@ -246,6 +251,10 @@ struct rockchip_thermal_data {
 #define TSADCV6_AUTO_PERIOD_TIME		5000 /* 2.5ms */
 #define TSADCV6_AUTO_PERIOD_HT_TIME		5000 /* 2.5ms */
 
+#define TSADCV13_AUTO_PERIOD_TIME		2500 /* 2.5ms */
+#define TSADCV13_AUTO_PERIOD_HT_TIME		2500 /* 2.5ms */
+#define TSADCV13_Q_MAX_VAL			0x3ff /* 10bit 1023 */
+
 #define TSADCV2_USER_INTER_PD_SOC		0x340 /* 13 clocks */
 #define TSADCV5_USER_INTER_PD_SOC		0xfc0 /* 97us, at least 90us */
 
@@ -255,6 +264,10 @@ struct rockchip_thermal_data {
 
 #define PX30_GRF_SOC_CON2			0x0408
 
+#define RK3506_GRF_TSADC_CON			0x0010
+#define RK3506_GRF_TSADC_TSEN			(0x10001 << 8)
+#define RK3506_GRF_TSADC_ANA			(0xff0007 << 0)
+
 #define RK3568_GRF_TSADC_CON			0x0600
 #define RK3568_GRF_TSADC_ANA_REG0		(0x10001 << 0)
 #define RK3568_GRF_TSADC_ANA_REG1		(0x10001 << 1)
@@ -526,6 +539,17 @@ static const struct tsadc_table rk3399_code_table[] = {
 	{TSADCV3_DATA_MASK, 125000},
 };
 
+static const struct tsadc_table rk3506_code_table[] = {
+	{0, -60000},
+	{362, -60000},
+	{395, -40000},
+	{503, 25000},
+	{604, 85000},
+	{672, 125000},
+	{757, 180000},
+	{TSADCV3_DATA_MASK, 180000},
+};
+
 static const struct tsadc_table rk3568_code_table[] = {
 	{0, -40000},
 	{1584, -40000},
@@ -863,6 +887,40 @@ static void rk_tsadcv8_initialize(struct regmap *grf, void __iomem *regs,
 			       regs + TSADCV2_AUTO_CON);
 }
 
+static void rk_tsadcv13_initialize(struct regmap *grf, void __iomem *regs,
+				   enum tshut_polarity tshut_polarity)
+{
+	regmap_write(grf, RK3506_GRF_TSADC_CON, RK3506_GRF_TSADC_TSEN);
+	usleep_range(10, 20);
+	regmap_write(grf, RK3506_GRF_TSADC_CON, RK3506_GRF_TSADC_ANA);
+	usleep_range(100, 200);
+
+	writel_relaxed(TSADCV13_AUTO_PERIOD_TIME, regs + TSADCV3_AUTO_PERIOD);
+	writel_relaxed(TSADCV13_AUTO_PERIOD_TIME,
+		       regs + TSADCV3_AUTO_PERIOD_HT);
+	writel_relaxed(TSADCV2_HIGHT_INT_DEBOUNCE_COUNT,
+		       regs + TSADCV3_HIGHT_INT_DEBOUNCE);
+	writel_relaxed(TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT,
+		       regs + TSADCV3_HIGHT_TSHUT_DEBOUNCE);
+	writel_relaxed(TSADCV13_Q_MAX_VAL, regs + TSADCV9_Q_MAX);
+	if (tshut_polarity == TSHUT_HIGH_ACTIVE)
+		writel_relaxed(TSADCV2_AUTO_TSHUT_POLARITY_HIGH |
+			       TSADCV2_AUTO_TSHUT_POLARITY_MASK,
+			       regs + TSADCV2_AUTO_CON);
+	else
+		writel_relaxed(TSADCV2_AUTO_TSHUT_POLARITY_MASK,
+			       regs + TSADCV2_AUTO_CON);
+	writel_relaxed(TSADCV3_AUTO_Q_SEL_EN | TSADCV3_AUTO_Q_SEL_EN_MASK,
+		       regs + TSADCV2_AUTO_CON);
+}
+
+static void rk3506_tsadc_suspend(struct regmap *grf, void __iomem *regs)
+{
+	/* Disable the analog front-end while the SoC is suspended. */
+	regmap_write(grf, RK3506_GRF_TSADC_CON,
+		     RK3506_GRF_TSADC_TSEN & 0xffff0000);
+}
+
 static void rk_tsadcv2_irq_ack(void __iomem *regs)
 {
 	u32 val;
@@ -1280,6 +1338,29 @@ static const struct rockchip_tsadc_chip rk3399_tsadc_data = {
 	},
 };
 
+static const struct rockchip_tsadc_chip rk3506_tsadc_data = {
+	.chn_offset = 0, /* cpu sensor is channel 0 */
+	.chn_num = 1, /* one channel for tsadc */
+	.grf_required = true,
+	.tshut_mode = TSHUT_MODE_CRU, /* default TSHUT via CRU */
+	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
+	.tshut_temp = 95000,
+	.initialize = rk_tsadcv13_initialize,
+	.suspend = rk3506_tsadc_suspend,
+	.irq_ack = rk_tsadcv4_irq_ack,
+	.control = rk_tsadcv4_control,
+	.get_temp = rk_tsadcv4_get_temp,
+	.set_alarm_temp = rk_tsadcv3_alarm_temp,
+	.set_tshut_temp = rk_tsadcv3_tshut_temp,
+	.set_tshut_mode = rk_tsadcv4_tshut_mode,
+	.table = {
+		.id = rk3506_code_table,
+		.length = ARRAY_SIZE(rk3506_code_table),
+		.data_mask = TSADCV3_DATA_MASK,
+		.mode = ADC_INCREMENT,
+	},
+};
+
 static const struct rockchip_tsadc_chip rk3568_tsadc_data = {
 	/* cpu, gpu */
 	.chn_offset = 0,
@@ -1383,6 +1464,10 @@ static const struct of_device_id of_rockchip_thermal_match[] = {
 		.compatible = "rockchip,rk3399-tsadc",
 		.data = (void *)&rk3399_tsadc_data,
 	},
+	{
+		.compatible = "rockchip,rk3506-tsadc",
+		.data = (void *)&rk3506_tsadc_data,
+	},
 	{
 		.compatible = "rockchip,rk3568-tsadc",
 		.data = (void *)&rk3568_tsadc_data,
@@ -1736,6 +1821,11 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(thermal->pclk),
 				     "failed to get apb_pclk clock.\n");
 
+	thermal->tsen = devm_clk_get_optional_enabled(&pdev->dev, "tsen");
+	if (IS_ERR(thermal->tsen))
+		return dev_err_probe(&pdev->dev, PTR_ERR(thermal->tsen),
+				     "failed to get tsen clock.\n");
+
 	rockchip_thermal_reset_controller(thermal->reset);
 
 	error = rockchip_configure_from_dt(&pdev->dev, np, thermal);
@@ -1815,6 +1905,10 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
 
 	thermal->chip->control(thermal->regs, false);
 
+	if (thermal->chip->suspend)
+		thermal->chip->suspend(thermal->grf, thermal->regs);
+
+	clk_disable(thermal->tsen);
 	clk_disable(thermal->pclk);
 	clk_disable(thermal->clk);
 
@@ -1842,6 +1936,13 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
 		return error;
 	}
 
+	error = clk_enable(thermal->tsen);
+	if (error) {
+		clk_disable(thermal->pclk);
+		clk_disable(thermal->clk);
+		return error;
+	}
+
 	rockchip_thermal_reset_controller(thermal->reset);
 
 	tsadc->initialize(thermal->grf, thermal->regs, thermal->tshut_polarity);
-- 
2.47.3

