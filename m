Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959E144B66A
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134977; cv=none; b=KOzkGeXGDTb4UX7FXb/lSoa3gMPuKT3ewYaARPCfC2jDCR8qBMRr4PcVGaONSCa5STl68dU5IzgcvkSw4r67I+aU3k0Rc0Xn+zVJthEj3av7DjF0GsSK1MfmSWKU7SBJ9It2yAu0Xnv4hbY8prt3p7VB8ett5gBO2Ug1Ok0VpQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134977; c=relaxed/simple;
	bh=Yas/YH/+WHqmaG1+9dU+ZXDZsf5koKP+4O5pY6ZHHVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rwxX+DrYGwzScW+/E1LXjNNgBQnqxwl4JgzbKw5c3BapFbmSRVRv8V9lf0T5fkOfXqS13s3PBIRqcbXI+XLB5qEgKKHd4oebB8iOz2IhIlC0ojJLDkZZNmSBiUAPSLmMbzpLIFLl13eiqKFj6u6O0eRT1kl66U36XGS+9d9IeWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=FwTWLO4a; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="FwTWLO4a"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4853aec185aso17676695e9.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 02:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773134974; x=1773739774; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b6JAnC42FjnZsgn6Qw8KBFDtZiHpm03wSifwT634VnI=;
        b=FwTWLO4aw6ueaKTqNVpx+oRkSkIAsONBb1cBED21oQ+/u/QUZLVD9P7mupcZgMXC3f
         Y/ASAf4yPTbGEO0q4cKbRolRni1y8ftvk9k6GeRJbfvhT4CPIgMj9gG8ARSW+Nc7JewZ
         5OrqcrUKS8QCZ/oVMsNilORAWBSHnkAxxRStl9APBm8cJVIJqTu83Erm6zya5xBBSymj
         T+jbDtgLv6EGTIYI7I0yMzfb6A3BZRAKxVxKOdj58muRfPRLEaH/+IN+kZSOPDDNIqCi
         5FaJ+fDiAoOKnYUK7j6VH7cmZyZcpLXU3jlRtpQcezFneVIOq4mgx8pUujnwhkpDiUxJ
         kuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134974; x=1773739774;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b6JAnC42FjnZsgn6Qw8KBFDtZiHpm03wSifwT634VnI=;
        b=Nin2nwxGEVulu3z6V2jj1Pp//WbOPOVmdBplsXAkahLjkA7/ab77GfcE/R8kqSbYB7
         jfHTuoP3uD9d0BT2e9BKU0Ds4G4wydtUtxOvOKdylfnxZzR7SsSs1AKf1pe5fa6R39KI
         naqpK27ijEMF9yLnF64QlGFesIVG3RMN7jyYiBbZVxrIdvGYPrqoqV08/QK3fEJyj8RP
         Sggjuda8o26zR8L5EGJaE7099m5YAt/UhD8k8uWK4rZeIiku4Vh1qkXNyof5JsTexlzU
         2ZSY+gno6gWrN8CqubwoPLGR2Gpx87d4kdrT6q0oT9JJKA6RD5K6ODZQuaRDD4+kMKWP
         doEw==
X-Forwarded-Encrypted: i=1; AJvYcCVx0OAjPiMqsU55N0kvPBx0MN45Zr95MJN8LBM4rbUaQJzQ/lSEv8Q0rdTBswCFLoCg914BgzNePg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSBRj+mzww1AkgI7UFQ6nhL/PIOSGVmnUuIBaCnURq97wgoXlv
	pF64Wyj4PG0x0zEWKGByl/nrn7f+xaUDirLXBhURMOigrTBf/yD7k7KVYzSiUWffO5c=
X-Gm-Gg: ATEYQzy5eCBBZ9aE7yBPhR9eqenX7iRaDGwIasdiwrziVWKaoKSGTsM6Osoad1oJyS6
	hYHw6i1GOvh4uMXvXP5nnoOpLFTQuwV9vyJCrj6C3/K7VyqdcB5AejTu8daihOKNjUfzXSmt5ln
	YA48tuoEhjZnv6fdJGWdLyLGhVUWybEbro6A7pZLsrr2JFjApAns0BdPTV/kONzf7Ff2rAxBU3Z
	LA0iSISOEXZFA0Jqxh4EMgTvb7DC3gA1rR/84HDs8eMwwunJSboTQvqovDrKApeC+gLFo5rWcAD
	8ORZH6Flaqr68JHWqhg9itpLJ4FIaHSF8jyZzUOwrG/yDDuhU1/pvQIfxzE8YKQnNzJ6G5vIfTm
	gVVJmDdsx2mQtiFM3KLypcfYF3yQ8LMtVZ7FK5U/Zfl077hI4sKXnY1h6xoSiU2TrGhk7onH5YG
	dWUSsUXCedZ0owx0JMopQ9dEi00gmlpELNkRxMDb2W4AF/vrjDkOA1kk5u+nmk3A8Awt2megsO9
	c8PKw==
X-Received: by 2002:a05:600c:4445:b0:483:a27e:6706 with SMTP id 5b1f17b1804b1-48526922533mr256104605e9.9.1773134973989;
        Tue, 10 Mar 2026 02:29:33 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48529f019a4sm104214285e9.12.2026.03.10.02.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:29:33 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 10 Mar 2026 13:28:34 +0400
Subject: [PATCH v3 10/11] regulator: bq257xx: Add support for BQ25792
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-bq25792-v3-10-02f8e232d63b@flipper.net>
References: <20260310-bq25792-v3-0-02f8e232d63b@flipper.net>
In-Reply-To: <20260310-bq25792-v3-0-02f8e232d63b@flipper.net>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5084; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Yas/YH/+WHqmaG1+9dU+ZXDZsf5koKP+4O5pY6ZHHVo=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSuf5LUcM/2idZDNp71kkv/7AxRl4vQ23+X74pO2RLOR
 a91Xjru7ZjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DA11jHWMGLg4BWCqD61n+Cvfx+d/+i9P/1uJ7zHXZvGeWNNnKcOj0Vfaw6Sdlr7/QSwjw9uw7Ia
 IbdpPDkw4t32XYPixNSZamlyzN28V2/jqQVnlUU4A
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Add support for TI BQ25792, an integrated battery charger and buck/boost
regulator. This enables VBUS output from the charger's boost converter
for use in USB OTG applications, supporting 2.8-22V output at up to 3.32A
with 10mV and 40mA resolution.

Acked-by: Mark Brown <broonie@kernel.org>
Tested-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/regulator/bq257xx-regulator.c | 98 ++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/bq257xx-regulator.c b/drivers/regulator/bq257xx-regulator.c
index 0bb58ab4b8d4..61911ac8613a 100644
--- a/drivers/regulator/bq257xx-regulator.c
+++ b/drivers/regulator/bq257xx-regulator.c
@@ -31,6 +31,32 @@ static int bq25703_vbus_get_cur_limit(struct regulator_dev *rdev)
 	return FIELD_GET(BQ25703_OTG_CUR_MASK, reg) * BQ25703_OTG_CUR_STEP_UA;
 }
 
+static int bq25792_vbus_get_cur_limit(struct regulator_dev *rdev)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	int ret;
+	unsigned int reg;
+
+	ret = regmap_read(regmap, BQ25792_REG0D_IOTG_REGULATION, &reg);
+	if (ret)
+		return ret;
+	return FIELD_GET(BQ25792_REG0D_IOTG_MASK, reg) * BQ25792_OTG_CUR_STEP_UA;
+}
+
+static int bq25792_vbus_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	__be16 reg;
+	int ret;
+
+	ret = regmap_raw_read(regmap, BQ25792_REG0B_VOTG_REGULATION,
+			      &reg, sizeof(reg));
+	if (ret)
+		return ret;
+
+	return FIELD_GET(BQ25792_REG0B_VOTG_MASK, be16_to_cpu(reg));
+}
+
 /*
  * Check if the minimum current and maximum current requested are
  * sane values, then set the register accordingly.
@@ -54,6 +80,37 @@ static int bq25703_vbus_set_cur_limit(struct regulator_dev *rdev,
 			    FIELD_PREP(BQ25703_OTG_CUR_MASK, reg));
 }
 
+static int bq25792_vbus_set_cur_limit(struct regulator_dev *rdev,
+				      int min_uA, int max_uA)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	unsigned int reg;
+
+	if ((min_uA > BQ25792_OTG_CUR_MAX_UA) ||
+	    (max_uA < BQ25792_OTG_CUR_MIN_UA))
+		return -EINVAL;
+
+	reg = (max_uA / BQ25792_OTG_CUR_STEP_UA);
+
+	/* Catch rounding errors since our step is 40000uA. */
+	if ((reg * BQ25792_OTG_CUR_STEP_UA) < min_uA)
+		return -EINVAL;
+
+	return regmap_write(regmap, BQ25792_REG0D_IOTG_REGULATION,
+			    FIELD_PREP(BQ25792_REG0D_IOTG_MASK, reg));
+}
+
+static int bq25792_vbus_set_voltage_sel(struct regulator_dev *rdev,
+					unsigned int sel)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	__be16 reg;
+
+	reg = cpu_to_be16(FIELD_PREP(BQ25792_REG0B_VOTG_MASK, sel));
+	return regmap_raw_write(regmap, BQ25792_REG0B_VOTG_REGULATION,
+				&reg, sizeof(reg));
+}
+
 static int bq25703_vbus_enable(struct regulator_dev *rdev)
 {
 	struct bq257xx_reg_data *pdata = rdev_get_drvdata(rdev);
@@ -101,6 +158,34 @@ static const struct regulator_desc bq25703_vbus_desc = {
 	.vsel_mask = BQ25703_OTG_VOLT_MASK,
 };
 
+static const struct regulator_ops bq25792_vbus_ops = {
+	/* No GPIO for enabling the OTG regulator */
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear,
+	.get_voltage_sel = bq25792_vbus_get_voltage_sel,
+	.set_voltage_sel = bq25792_vbus_set_voltage_sel,
+	.get_current_limit = bq25792_vbus_get_cur_limit,
+	.set_current_limit = bq25792_vbus_set_cur_limit,
+};
+
+static const struct regulator_desc bq25792_vbus_desc = {
+	.name = "vbus",
+	.of_match = of_match_ptr("vbus"),
+	.regulators_node = of_match_ptr("regulators"),
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+	.ops = &bq25792_vbus_ops,
+	.min_uV = BQ25792_OTG_VOLT_MIN_UV,
+	.uV_step = BQ25792_OTG_VOLT_STEP_UV,
+	.n_voltages = BQ25792_OTG_VOLT_NUM_VOLT,
+	.enable_mask = BQ25792_REG12_EN_OTG,
+	.enable_reg = BQ25792_REG12_CHARGER_CONTROL_3,
+	.enable_val = BQ25792_REG12_EN_OTG,
+	.disable_val = 0,
+};
+
 /* Get optional GPIO for OTG regulator enable. */
 static void bq257xx_reg_dt_parse_gpio(struct platform_device *pdev)
 {
@@ -141,6 +226,7 @@ static void bq257xx_reg_dt_parse_gpio(struct platform_device *pdev)
 static int bq257xx_regulator_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct bq257xx_plat *plat = dev_get_platdata(dev);
 	struct bq257xx_reg_data *pdata;
 	struct device_node *np = dev->of_node;
 	struct regulator_config cfg = {};
@@ -153,7 +239,17 @@ static int bq257xx_regulator_probe(struct platform_device *pdev)
 	if (!pdata)
 		return -ENOMEM;
 
-	pdata->desc = bq25703_vbus_desc;
+	switch (plat->type) {
+	case BQ25703A:
+		pdata->desc = bq25703_vbus_desc;
+		break;
+	case BQ25792:
+		pdata->desc = bq25792_vbus_desc;
+		break;
+	default:
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "Unsupported device type\n");
+	}
 
 	platform_set_drvdata(pdev, pdata);
 	bq257xx_reg_dt_parse_gpio(pdev);

-- 
2.52.0

