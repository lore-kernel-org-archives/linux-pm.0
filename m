Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDE543DA5B
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134955; cv=none; b=JerkVOPJyhb/2A9R1Rfes1lN7mqHGJuPaHPYMGLug7NKIig0qat0VpV31vUqb90V92dx/yyxsjnbq439Z1DK8WyG3OD5CrN8I7Oekmrl0AJFDCprUaLt8jjlsBNLT2j6qaNEZifio+oaU2iPtSwHBx/Q01ILtTuwtvaxmW4/zvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134955; c=relaxed/simple;
	bh=DcG8KW5Fnk3rc/f7uk3dyHKO5i3tnn1nAb2IeSenCzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SDfKX5Ic2quNE15A0gbTDrqMkCNuXb/W1lMGoeTqVnDI+RShpwBGrFvgUkfi2j/GHvYYgFOZxq3r6bwCG1cIfHLi2RxG0g/Sm1gvmLuhlRc7yr1LpzLzguH4N91Eg+TsxiHT6oKoWO4vpDrVGlvKS/SXh58D/F4qXs1sFc0VBoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=52rmwWQ+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="52rmwWQ+"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4853510b4f3so34089095e9.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 02:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773134953; x=1773739753; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jCpuZJNVNsInRc1C9w8uAr8XhXxWVpiElBj6DPaFINQ=;
        b=52rmwWQ+5lSExH5NtxqrZ1Urfxwa33hp20t5KO3bH4tydKGukbT+MSzLGrWnpg8ImT
         O5PasIZsGor2CQ77z7tI/cL/VBfCyEKlKLdQkVanZkc01FC8cPIVvcC9sYhZxAqx0zLO
         VZSAD0S6q0L+PLnrtEFjZXK9/sl4/pA0XL2S2B8mkY/IeeGRfOGxTT2z969KSQRlm94n
         ZMu35iA+iFjSOR2++CQZlbkX5rgHhnIGtKtxgjuVCwy73Xrw4+RPnmK6m3ozbA4j0ukr
         nDBCk1AcHzmE9TdoON5CexlJA4GE03Hwf1AQhSds9Hw10BdvdYolW8bSyDbtyM4ryH2A
         YluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134953; x=1773739753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jCpuZJNVNsInRc1C9w8uAr8XhXxWVpiElBj6DPaFINQ=;
        b=jXbk/jXlOG+xsoCcX1Ny13+vc369Dp0afaHQktbPT4lTyv3wbmX0CD3h3uSlL9lK2Y
         tGW1oRhOzHO/27PfIBCONmQznpj6B+c9t7vP0TtbeH0d4aIY/7tdFARC8Hn/z2ipExVc
         u5dS8jjKqQvIdMCxI3kdfg+iw9STXgbD6uIOWw9RIFGwx1orPxcBAhU1+7VbFas3bM0H
         wmdpWyi/8ktjTjYWXbUg98zD6OctFblYFgfGDH/jg3cAqICR8gfBK3mbz+8LIsk6fyn8
         RYDZ+wccJDNhgUAwRYPJ5OjCm5WDz64bkg4eUP8pUij3Kq0O4iLVvZ1Qwh0Y2P3iBDSm
         rufQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCplWXnYuaT9i71s2Uuqyq4543n0YCs/A8XnhlMx36JEj7X/Dc5RK6ETDSgq3cCjPQZK8YkRrONg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3eEhz7zJgCB4b1Zkpd9BA7mcDq7wy8cCuxYGiq9dQ9OBzHJVy
	rfDmSl/WB0TSncqh5WvkWc+xf47FhmqPr1FwP0KUkaa7AKngu+bBoVeu02OKDGmGEiY=
X-Gm-Gg: ATEYQzwQB66Ww1Gfu2rZjxjafhhdNyBoGVfJQPK4xG4hgAFHahyDacLBt7GwUgOAkKz
	doOyMgI0uIOR84Bf2yKxsGK9VBgGwgyRXS3l+SqBk7CUlOEo91iEvAHhIhy1LJkp+H7vgHssb46
	NM5eDpcuzu8xjl/xiWVGiBRUNHav6wuYDzkdWQd5tBZPhCgNEBQI4n31vXUs4R51xtXl+ZPVWXv
	hJ/BdyrTYamP/EmB3t8fu1Av3wO2Dvx3v+WPZsUsHOWUU3CgZ62zxxUJr/VbzRU9koeBqZaXJQu
	lS/cHDQPxHGIzzE8CA+cbHQ3O+WJQBJzC1uDuTxXn+Lk5aDckIV/VukwvxKnVory2mCS1oe/71J
	Jd6N9TTJLIfThkq8AUW++AH9xT0Ots/TTz8gxGDhFi8wj7b6F0G3nFbov6U6NoTJ/fzwTmdZ0Bb
	c57dah4YnNd7UoKN0HUJ+SuI2ueXChzwDzm5B2MId8iaQA27SRyTOrRuthJkh6L/Fctk50Jhldq
	Ux77A==
X-Received: by 2002:a05:600c:1e2a:b0:47e:e57d:404 with SMTP id 5b1f17b1804b1-485269582efmr227608515e9.16.1773134952539;
        Tue, 10 Mar 2026 02:29:12 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48529f019a4sm104214285e9.12.2026.03.10.02.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:29:12 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 10 Mar 2026 13:28:26 +0400
Subject: [PATCH v3 02/11] regulator: bq257xx: Remove reference to the
 parent MFD's dev
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-bq25792-v3-2-02f8e232d63b@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2756; i=alchark@flipper.net;
 h=from:subject:message-id; bh=DcG8KW5Fnk3rc/f7uk3dyHKO5i3tnn1nAb2IeSenCzU=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSuf5KomuzgzdwTos704jv/tblFLzseLf7LNcNJwGSB8
 2/DbYXKHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oaGOsY4RAxenAEy1ZCfD/4rL8mblacUJkm1X0n14Vp+rvR2gu9F08bQNeccUvxgkFzAyLE5maJN
 Tcn2lqlvveZSX/9erNRueXrO/k9snFhsqWGbHAQA=
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

