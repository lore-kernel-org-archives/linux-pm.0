Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E79411627
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 15:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971836; cv=none; b=rvxdtHMkan6sUJu29VjroaWImGnxolQv/+z00Vu9/r1ZPB+fWpC6v1Atr/MvLKCEs5pppGLwWJJk9cT0OpM84HKkYtKJvzVuMcU8ECjlO6glUVK+JcCctObY3JBUwCgpw1JqjjeJ0ouny0MFzdGSTTRiKlSYxt0kkH7q2voO17o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971836; c=relaxed/simple;
	bh=DcG8KW5Fnk3rc/f7uk3dyHKO5i3tnn1nAb2IeSenCzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=msNjU9jKIpQRHIiu0uD44VbuoifBt74JPpx1avL/rr3V6UgOED6Tpsm7Hzt+E1teMl0TbPwH68M5J6ZxIsjm/JYdDch7bPD63G9+z7EN7Fyx87eZfCaZmXhapvDPF0y4avcQhQO5maRn9ieKcWQ2NQc+J3miqXiyH81R7aSn7vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=CKE+UWzQ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="CKE+UWzQ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4888244e9f9so1931295e9.0
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 08:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1774971832; x=1775576632; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jCpuZJNVNsInRc1C9w8uAr8XhXxWVpiElBj6DPaFINQ=;
        b=CKE+UWzQ99gN5vRJddsxigmoPegNBzL9eS3NZ0nRxxt4pPYgBvWtnXFL95th3A9PWr
         PbQRQPL0IfOHx2vOtdM8LjzKwq9nW3JRBVMG61j3D2XAXEHo3dj4nAX1YHInuMTbdUQ4
         e79vjb0TB4n1Q3HFEJWHePMVzwcV17EaWMrduCWkBJc0rNSdnKlPEkM/JGkiJ5lOTVOt
         +JDxydXRCYy29ekpOUKZC2g15lvA1d8hYEey1W2peveJkJb0XEV1ibBt/UFBAe5ll9EG
         bVJ813YOQrplb14tFOTmBmb9SGC7qcfufiSxbdvfPGnyshNScdu4be1418TV97wA5f0+
         fTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971832; x=1775576632;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jCpuZJNVNsInRc1C9w8uAr8XhXxWVpiElBj6DPaFINQ=;
        b=jHbWfKIajAwyNuPvEWs8c3jHj0mORv+O9xoafmxV1wmfI6+eJFBBPwm129R6i2ahmZ
         quFL1MAdre5RKEc44z3tnzqcPVH0lRGCf5scxQvyIYBpI6mXdMGt34UupguFKeUDeIrd
         zgJr6I8mIKOKXAIk/tPMER9vbryqWBiX/t1haKrHeCmJUgx3HV7afprl6ZzsE7JT8cWz
         qAoI/ZpUvgzu0bZEQAdWZ1JLuWBDh0gi013wkIyPWlvur7RbplPKT6Z6Kscm5qDERK3X
         ttZbblrefk1+mXjOa9e+UQmyx2ILrCafBeNpQAkFr4+jmRaleKXAqxTcdfo/v5wXzMXa
         vY1g==
X-Forwarded-Encrypted: i=1; AJvYcCVs7DM3+0vViexSzf+hxNmjUykE3Nt7RTDclrvyPiiNPW9UsijUJL+RIYjqO22mXwAp//FtJAVWZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyntMNdEkIxjnKQr8IWyeL2nYOT7TI20DKQuGJtfHnf783l6b2P
	imf0LD6L2Kwq4knEi9SXBvM5+DVLo3JYjcoNtko6bCwxHkpeuQOjj9j2E1eTqsOiG3o=
X-Gm-Gg: ATEYQzyvN3p4Wlc+RO0SoCppXOgiz4e98mKA7OAkiwxClJ0yO5UPduuwaaRCiMRvwvL
	tFYYe/MhYgDRWM94cMYEJJHL8YQRX2WvJY+Ky9zhyWG2ardu7lqzDEmS/klSgthyQ1SzUNFXblQ
	3khQupx/cmh3D+QZAUWMEIj2ZJmXT425grfR8rfQM7mGkTkpJRUI83E67KuCMTJdCrUJJwBIVf7
	RiLLsHHwl2yCp2aQ+xn+pufWlIE07I6Nxu5lTDQaowgOjhRzDXRpSyRzemvFG9mSPhfZm2AWEFZ
	4wRSibX7sjrXhTgwTs0zUiBFIfMhFCQjm0US/s7/kxA//vCGyHiTRPi5AmTr8xuYlWg9lZfEZPl
	o0sqafV/g84xbTmi6KteG3k6649NczxztISQzrMoENci6eryeNTvx6+4aFx3BrvZAXzbJd39GUV
	W0Pjs6F4iUFd3s4EYOWEZOo8RTyjciNwHQOCHa6eIrBqKTpAAEU8p1t1104VtJ7JmcpRt3t9x4R
	MekqQ==
X-Received: by 2002:a05:600c:8b03:b0:486:fdca:ea8d with SMTP id 5b1f17b1804b1-48727ef5550mr313707345e9.25.1774971832370;
        Tue, 31 Mar 2026 08:43:52 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8852a5sm48412605e9.9.2026.03.31.08.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:43:52 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 31 Mar 2026 19:43:39 +0400
Subject: [PATCH v6 02/11] regulator: bq257xx: Remove reference to the
 parent MFD's dev
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-bq25792-v6-2-0278fba33eb9@flipper.net>
References: <20260331-bq25792-v6-0-0278fba33eb9@flipper.net>
In-Reply-To: <20260331-bq25792-v6-0-0278fba33eb9@flipper.net>
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
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSefr3eoZmnxr1uHUfSjQOZkxNdw5t49PYXfFsTlvop7
 ppd4i3zjoksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0FDHWMeIgYtTAKb68zKGv5I59o+fSuka2CT/vcLMMWnipG3bujcdWPVUrGX758ucZ1QZGZ7MyvQ
 5f+lS9kKhJu2/GT0WK5rutN+8IPd+6+w3GhPcZ/IAAA==
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

