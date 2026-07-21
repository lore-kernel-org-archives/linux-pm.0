Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86C5446847;
	Tue, 21 Jul 2026 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784626605; cv=none; b=YgL6pMpD0o85gPg4Fia51D7WPSTI6VPkoQospRMX/s3L4jB19OLmbbpJ3afeErWhGzl1rOihnCq0CJl4XrOU1ZHbWV+yydrHay7xm/mnGl/IYrsOe1Cjtqu4x2s8RGkIyuis+LiB6SSzup4lC3/jeYrsHSzDChsc85wmtql1v3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784626605; c=relaxed/simple;
	bh=enDIhVLctEZZCNGenoTWwC3xY076j1epPWpsHW+gzYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0gw5xDivNJpXF6SkVjaLdvW6vmgwZ1ZJll5hn0JD9qZ3EM7Qt0bJNzJ6KN3AFH+5CV1LrD/4bKiS2MwvyhDU6Vbz9Xsd/hsxaI+ei/FzeYEnFYzZ8xU3d5EU0m0ASiCrTx8KbR57YH0Rdb8N/6YxFMR6IDBHkV301npd84V4Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mAjji0eP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mAjji0eP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784626602;
	bh=enDIhVLctEZZCNGenoTWwC3xY076j1epPWpsHW+gzYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mAjji0eP5kmmOgaIGjYtTwdF0e7ihktfNiNR1oN1UHFlqlzaleSE0I09S/tZiHvIG
	 79X4RhNM+0BNjjyRizs9Yo2OTq1ByaOeaNYJyPkRZyMYFRW8H10ZP9NEgKbwonMFIc
	 JayBl0onI+dYM3zdMpL0iQrguv5AwgHKcDxWjdovCEURrSEynPQU6aJaHDw5eejWSL
	 F+IA85wMhoweoglqbF+tPPqBUiOzB7HvSW3icnSN/pulysIn6CcGeMitSWkHjKhgow
	 UwJNi6rot5FsPHCE2sKARzk4GrdD3DbjrOMUU6cwdcv/5MkqYR7Mj7pZBYJxKoom2Y
	 +MQ3ZsgsdyLMA==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 39E5517E0FA2;
	Tue, 21 Jul 2026 11:36:41 +0200 (CEST)
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
	Abel Vesa <abel.vesa@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v13 09/12] phy: qualcomm: eusb2-repeater: Migrate to devm_spmi_subdevice_alloc_and_add()
Date: Tue, 21 Jul 2026 11:36:23 +0200
Message-ID: <20260721093626.96264-10-angelogioacchino.delregno@collabora.com>
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

Some Qualcomm PMICs integrate an USB Repeater device, used to
convert between eUSB2 and USB 2.0 signaling levels, reachable
in a specific address range over SPMI.

Instead of using the parent SPMI device (the main PMIC) as a kind
of syscon in this driver, register a new SPMI sub-device for EUSB2
and initialize its own regmap with this sub-device's specific base
address, retrieved from the devicetree.

This allows to stop manually adding the register base address to
every R/W call in this driver, as this can be, and is now, handled
by the regmap API instead.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Acked-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/phy/qualcomm/Kconfig                  |  2 +
 .../phy/qualcomm/phy-qcom-eusb2-repeater.c    | 52 ++++++++++++-------
 2 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
index 60a0ead127fa..902a788f35f1 100644
--- a/drivers/phy/qualcomm/Kconfig
+++ b/drivers/phy/qualcomm/Kconfig
@@ -128,7 +128,9 @@ config PHY_QCOM_QUSB2
 config PHY_QCOM_EUSB2_REPEATER
 	tristate "Qualcomm PMIC eUSB2 Repeater Driver"
 	depends on OF && (ARCH_QCOM || COMPILE_TEST)
+	depends on SPMI
 	select GENERIC_PHY
+	select REGMAP_SPMI
 	help
 	  Enable support for the USB high-speed eUSB2 repeater on Qualcomm
 	  PMICs. The repeater is paired with a Synopsys or M31 eUSB2 Phy
diff --git a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
index efeec4709a15..89bc1c89fc85 100644
--- a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
+++ b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
@@ -9,6 +9,7 @@
 #include <linux/regmap.h>
 #include <linux/of.h>
 #include <linux/phy/phy.h>
+#include <linux/spmi.h>
 
 /* eUSB2 status registers */
 #define EUSB2_RPTR_STATUS		0x08
@@ -66,7 +67,6 @@ struct eusb2_repeater {
 	struct phy *phy;
 	struct regulator_bulk_data *vregs;
 	const struct eusb2_repeater_cfg *cfg;
-	u32 base;
 	enum phy_mode mode;
 };
 
@@ -143,7 +143,6 @@ static int eusb2_repeater_init(struct phy *phy)
 	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
 	struct device_node *np = rptr->dev->of_node;
 	struct regmap *regmap = rptr->regmap;
-	u32 base = rptr->base;
 	u32 poll_val;
 	s32 dt_val;
 	int ret;
@@ -154,37 +153,37 @@ static int eusb2_repeater_init(struct phy *phy)
 	if (ret)
 		return ret;
 
-	regmap_write(regmap, base + EUSB2_EN_CTL1, EUSB2_RPTR_EN);
+	regmap_write(regmap, EUSB2_EN_CTL1, EUSB2_RPTR_EN);
 
 	/* Write registers from init table */
 	for (int i = 0; i < rptr->cfg->init_tbl_num; i++)
-		regmap_write(regmap, base + rptr->cfg->init_tbl[i].reg,
+		regmap_write(regmap, rptr->cfg->init_tbl[i].reg,
 			     rptr->cfg->init_tbl[i].value);
 
 	/* Override registers from devicetree values */
 	if (!of_property_read_u8(np, "qcom,tune-usb2-preem", &val))
-		regmap_write(regmap, base + EUSB2_TUNE_USB2_PREEM, val);
+		regmap_write(regmap, EUSB2_TUNE_USB2_PREEM, val);
 
 	if (!of_property_read_u8(np, "qcom,tune-usb2-disc-thres", &val))
-		regmap_write(regmap, base + EUSB2_TUNE_HSDISC, val);
+		regmap_write(regmap, EUSB2_TUNE_HSDISC, val);
 
 	if (!of_property_read_u8(np, "qcom,tune-usb2-amplitude", &val))
-		regmap_write(regmap, base + EUSB2_TUNE_IUSB2, val);
+		regmap_write(regmap, EUSB2_TUNE_IUSB2, val);
 
 	if (!of_property_read_u8(np, "qcom,tune-res-fsdif", &val))
-		regmap_write(regmap, base + EUSB2_TUNE_RES_FSDIF, val);
+		regmap_write(regmap, EUSB2_TUNE_RES_FSDIF, val);
 
 	if (!of_property_read_s32(np, "qcom,squelch-detector-bp", &dt_val)) {
 		for (i = 0; i < ARRAY_SIZE(squelch_detector); i++) {
 			if (squelch_detector[i] == dt_val) {
-				regmap_write(regmap, base + EUSB2_TUNE_SQUELCH_U, i);
+				regmap_write(regmap, EUSB2_TUNE_SQUELCH_U, i);
 				break;
 			}
 		}
 	}
 
 	/* Wait for status OK */
-	ret = regmap_read_poll_timeout(regmap, base + EUSB2_RPTR_STATUS, poll_val,
+	ret = regmap_read_poll_timeout(regmap, EUSB2_RPTR_STATUS, poll_val,
 				       poll_val & RPTR_OK, 10, 5);
 	if (ret)
 		dev_err(rptr->dev, "initialization timed-out\n");
@@ -197,7 +196,6 @@ static int eusb2_repeater_set_mode(struct phy *phy,
 {
 	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
 	struct regmap *regmap = rptr->regmap;
-	u32 base = rptr->base;
 
 	switch (mode) {
 	case PHY_MODE_USB_HOST:
@@ -206,8 +204,8 @@ static int eusb2_repeater_set_mode(struct phy *phy,
 		 * per eUSB 1.2 Spec. Below implement software workaround until
 		 * PHY and controller is fixing seen observation.
 		 */
-		regmap_write(regmap, base + EUSB2_FORCE_EN_5, F_CLK_19P2M_EN);
-		regmap_write(regmap, base + EUSB2_FORCE_VAL_5, V_CLK_19P2M_EN);
+		regmap_write(regmap, EUSB2_FORCE_EN_5, F_CLK_19P2M_EN);
+		regmap_write(regmap, EUSB2_FORCE_VAL_5, V_CLK_19P2M_EN);
 		break;
 	case PHY_MODE_USB_DEVICE:
 		/*
@@ -216,8 +214,8 @@ static int eusb2_repeater_set_mode(struct phy *phy,
 		 * repeater doesn't clear previous value due to shared
 		 * regulators (say host <-> device mode switch).
 		 */
-		regmap_write(regmap, base + EUSB2_FORCE_EN_5, 0);
-		regmap_write(regmap, base + EUSB2_FORCE_VAL_5, 0);
+		regmap_write(regmap, EUSB2_FORCE_EN_5, 0);
+		regmap_write(regmap, EUSB2_FORCE_VAL_5, 0);
 		break;
 	default:
 		return -EINVAL;
@@ -242,11 +240,18 @@ static const struct phy_ops eusb2_repeater_ops = {
 
 static int eusb2_repeater_probe(struct platform_device *pdev)
 {
+	struct regmap_config eusb2_regmap_config = {
+		.reg_bits = 16,
+		.val_bits = 8,
+		.max_register = 0xff,
+		.fast_io = true,
+	};
+	struct spmi_device *sparent;
 	struct eusb2_repeater *rptr;
+	struct spmi_subdevice *sub_sdev;
 	struct device *dev = &pdev->dev;
 	struct phy_provider *phy_provider;
 	struct device_node *np = dev->of_node;
-	u32 res;
 	int ret;
 
 	rptr = devm_kzalloc(dev, sizeof(*rptr), GFP_KERNEL);
@@ -260,15 +265,21 @@ static int eusb2_repeater_probe(struct platform_device *pdev)
 	if (!rptr->cfg)
 		return -EINVAL;
 
-	rptr->regmap = dev_get_regmap(dev->parent, NULL);
-	if (!rptr->regmap)
+	sparent = spmi_get_parent_spmi_device(dev);
+	if (!sparent)
 		return -ENODEV;
 
-	ret = of_property_read_u32(np, "reg", &res);
+	sub_sdev = devm_spmi_subdevice_alloc_and_add(dev, sparent);
+	if (IS_ERR(sub_sdev))
+		return PTR_ERR(sub_sdev);
+
+	ret = device_property_read_u32(dev, "reg", &eusb2_regmap_config.reg_base);
 	if (ret < 0)
 		return ret;
 
-	rptr->base = res;
+	rptr->regmap = devm_regmap_init_spmi_ext(&sub_sdev->sdev, &eusb2_regmap_config);
+	if (IS_ERR(rptr->regmap))
+		return PTR_ERR(rptr->regmap);
 
 	ret = eusb2_repeater_init_vregs(rptr);
 	if (ret < 0) {
@@ -335,3 +346,4 @@ module_platform_driver(eusb2_repeater_driver);
 
 MODULE_DESCRIPTION("Qualcomm PMIC eUSB2 Repeater driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("SPMI");
-- 
2.55.0

