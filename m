Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462943DEAED
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230188; cv=none; b=tnwnYI31Qb3huzafyvbeuZnRFs8keOQmm1Amon/VZcBn+USPGvkSuXMb1Zb0XsMhAkWFplDeKVAqYhSfkpis7mPGiFzSvxRZ8BFaIQk2TgBCEU3oIEQIMKDu8q1HeQUn+xLxC+pGZaEwsPGV3nE/YBktFb8ycQoKy/5ectS8F2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230188; c=relaxed/simple;
	bh=DcG8KW5Fnk3rc/f7uk3dyHKO5i3tnn1nAb2IeSenCzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qMNIGARAorpxfqggJVfjtxgGSsNUA4p28BxOyx/gbmJv/n1nWG4+cdap8Ek0cJOU8g4tgiOH5yY3khLygEdgzW5flB4FY0Mf2IesimSBytYwIeNFM/1diCaqONMIbf0IERFb5dICQKVWDk2inEpdhgQbVEjxdgCAWH3jh9ag+pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=Ei9hMQlq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="Ei9hMQlq"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48535a0ef86so30370015e9.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 04:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773230185; x=1773834985; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jCpuZJNVNsInRc1C9w8uAr8XhXxWVpiElBj6DPaFINQ=;
        b=Ei9hMQlq8Nf7iuEp4tS8ip3qh/DvXtJxM/OP8WSdNqjeq246T6ehXK+t4O19755PRh
         lQx8YCEQSX6AJSrzdlK6t3myvJdHkjwfbMmwxQ1t61g/2H6bC90aNhOlUTXepu1n2naD
         RTvccZU/Tdhwss60qRAviwyBSdtrCOLKWWHvkE30cI2CYDw+pZdDQ+6QTAOXQvhI8z2R
         LVNPnFuvSKsuh2Wfw83gVq93V9KGIa6YAM0J0lVJkCAlsqvj7mEpWBu4WOpm5jBXy0Jc
         kTG3rYmCbxKCxBy9bhWC7JzD0jb2RNy0xDvM6XwHkJkzueYCOZpo57JLfupkJ7zHG3Wg
         kt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773230185; x=1773834985;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jCpuZJNVNsInRc1C9w8uAr8XhXxWVpiElBj6DPaFINQ=;
        b=HkIjoVqQSZUxlYlOpqKchPXSxIosjXY1JlnDVTfAgmkrWxKrAp0QiJbrsrnb1hkt7i
         DKVbax+3dgRmVd1WjISs9an0vUmOdWg+E0Mu3c6mxS6DzHx0kWr0vJO4Iy73WNk7IYsz
         e+VQaglx8JsL65SD8Hlv6PltztkGHx05Ic9ts5NUylE7L1qTZLwprnlIQRGfX0r5ZKdg
         Ixvu/gNWvCjIcnRErm212Uq1iD59PRp8xdP4pnL06nrsekQb6QflbRklVt4xDq+5sjbW
         SIKd4sSfXynmAztDTf59nVN2nCSpORG2xd53dejlgtcD7trbIrw1ng14kb/d5Fegk1EG
         bRig==
X-Forwarded-Encrypted: i=1; AJvYcCU8NvkXM3D6C3xqMtOp7P/X1ymZ542HR/9x47L3cukHwXCr1oS80oDAHYL85McyeMWIZEfg1g8WDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc9gUkdcyebtgbVhsGAv6puldqBuogFqtgPjst/gaJSqh8QU4i
	1Ib9Auisl57cbVrmJK66dd6rNGCnpmPnth6nd6CT/3Ro9waHDnZjXcDH0zxGIGH8bps=
X-Gm-Gg: ATEYQzy/luqCE3d+ro2yBCVYyZdg4jKjyvJpjf9Ee+WH8QH27fV4pSU97pancPaMJMm
	6ph8kzAseURUme7C4Cxtxazt9tZtd3lrqr9iIcIQPvSgePFZAaZ5u+tqb4m8orAhshq6aUaPMHE
	Vcq9JGdO2hkqkebtN7YrbyEkpEGxdujQs4LowQK3RetsNzXPi4vOEgXQXeFD92Cg3O06neK4yAY
	1oH+7Kb5Z0DubLf8+vhDKTZIJ1Hd7+AP+GK7srPHI+88L+tqkO95nx30oATC2vC4RUV9gLGaWoR
	YA1lNnIvp9gXuuUklk6EOOGMkA+UxBvH1LLFxzmcmi1uP7HpQ6JCN7WAZOFXEm+LLTYHxv2tuT5
	H3TzgAE4ikbCDC73zPzjDmMpqIgQMtGUSp2dnt0rfySI+oTDO/ygn+JuUnhVpJWYEu569mA/zou
	+3xT8uz/nLdt380idSrSafvtuYOgTzo8W631huCthb9EDt3GsoJAmIX0uDjQs+tQ1+OBijixDqW
	+YIyA==
X-Received: by 2002:a05:600c:1f96:b0:485:3bb0:194 with SMTP id 5b1f17b1804b1-4854b129e5dmr37492555e9.35.1773230184632;
        Wed, 11 Mar 2026 04:56:24 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854ad5416bsm39586485e9.1.2026.03.11.04.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:56:24 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 11 Mar 2026 15:56:15 +0400
Subject: [PATCH v4 02/11] regulator: bq257xx: Remove reference to the
 parent MFD's dev
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-bq25792-v4-2-7213415d9eec@flipper.net>
References: <20260311-bq25792-v4-0-7213415d9eec@flipper.net>
In-Reply-To: <20260311-bq25792-v4-0-7213415d9eec@flipper.net>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2756; i=alchark@flipper.net;
 h=from:subject:message-id; bh=DcG8KW5Fnk3rc/f7uk3dyHKO5i3tnn1nAb2IeSenCzU=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRujEgqE1l3VMZ7r6holfnSL1seO+7elP1aSGLHTfNFN
 bWTpp2b2TGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrqGOsYMXBxCsBUr25j+M3608PeLFf/6bNHZwu3mL8UuTr9T1i0wrrbk8Wki/u/W3cw/LM6MO8
 e52KFK6L5XzkPFFpZz3By7ebk/P77ltqF1D/LljECAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Drop the ->bq field from the platform data of the bq257xx regulator driver,
which was only used to get the regmap of the parent MFD device, and use the
regmap from the regulator_dev instead, slimming down the code a bit.

Acked-by: Mark Brown <broonie@kernel.org>
Tested-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/regulator/bq257xx-regulator.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/bq257xx-regulator.c b/drivers/regulator/bq257xx-regulator.c
index dab8f1ab4450..812938e565e3 100644
--- a/drivers/regulator/bq257xx-regulator.c
+++ b/drivers/regulator/bq257xx-regulator.c
@@ -15,7 +15,6 @@
 #include <linux/regulator/of_regulator.h>
 
 struct bq257xx_reg_data {
-	struct bq257xx_device *bq;
 	struct regulator_dev *bq257xx_reg;
 	struct gpio_desc *otg_en_gpio;
 	struct regulator_desc desc;
@@ -23,11 +22,11 @@ struct bq257xx_reg_data {
 
 static int bq25703_vbus_get_cur_limit(struct regulator_dev *rdev)
 {
-	struct bq257xx_reg_data *pdata = rdev_get_drvdata(rdev);
+	struct regmap *regmap = rdev_get_regmap(rdev);
 	int ret;
 	unsigned int reg;
 
-	ret = regmap_read(pdata->bq->regmap, BQ25703_OTG_CURRENT, &reg);
+	ret = regmap_read(regmap, BQ25703_OTG_CURRENT, &reg);
 	if (ret)
 		return ret;
 	return FIELD_GET(BQ25703_OTG_CUR_MASK, reg) * BQ25703_OTG_CUR_STEP_UA;
@@ -40,7 +39,7 @@ static int bq25703_vbus_get_cur_limit(struct regulator_dev *rdev)
 static int bq25703_vbus_set_cur_limit(struct regulator_dev *rdev,
 				      int min_uA, int max_uA)
 {
-	struct bq257xx_reg_data *pdata = rdev_get_drvdata(rdev);
+	struct regmap *regmap = rdev_get_regmap(rdev);
 	unsigned int reg;
 
 	if ((min_uA > BQ25703_OTG_CUR_MAX_UA) || (max_uA < 0))
@@ -52,7 +51,7 @@ static int bq25703_vbus_set_cur_limit(struct regulator_dev *rdev,
 	if ((reg * BQ25703_OTG_CUR_STEP_UA) < min_uA)
 		return -EINVAL;
 
-	return regmap_write(pdata->bq->regmap, BQ25703_OTG_CURRENT,
+	return regmap_write(regmap, BQ25703_OTG_CURRENT,
 			    FIELD_PREP(BQ25703_OTG_CUR_MASK, reg));
 }
 
@@ -137,7 +136,6 @@ static void bq257xx_reg_dt_parse_gpio(struct platform_device *pdev)
 static int bq257xx_regulator_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct bq257xx_device *bq = dev_get_drvdata(pdev->dev.parent);
 	struct bq257xx_reg_data *pdata;
 	struct device_node *np = dev->of_node;
 	struct regulator_config cfg = {};
@@ -149,7 +147,6 @@ static int bq257xx_regulator_probe(struct platform_device *pdev)
 	if (!pdata)
 		return -ENOMEM;
 
-	pdata->bq = bq;
 	pdata->desc = bq25703_vbus_desc;
 
 	platform_set_drvdata(pdev, pdata);

-- 
2.52.0

