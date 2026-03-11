Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D1B3DEAED
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230190; cv=none; b=Z5539jtMi7vnCNONKimlu7zChYKTi9GPSEE8eoV3mfXMk8KVRrvrpw1Z/M6uWTTNRBigIJ9HwHNctZsUZLJQkJ2qPXgpbMeRLsDp4MkFTmBTyYldIzXmNtPtdGZfJj1OKg1A0yyqQum0xZe0MCrCEUy1K0wJackLkpj8vC9egMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230190; c=relaxed/simple;
	bh=1uAjKjH8Mriiu2XHqXVfsDGlgQSHnV96d3u/aQzpXDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=omPiAri3zrS2te2Udf4sn4p7NJGpgNjbo6iXuvp8kJGOTeaG3CA+9wH5kGiCADMVhNfX8wtZ/FFfyJ0P+cm8UKBQ3g5aJ4Xl4tvRGklSxxwiA44uowYiFKo84rTVb0HcSAYoKRIUahH8SOFqhjawxef4n8EDATZDwa0k8gLGIuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=SEYH2Pq3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="SEYH2Pq3"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so36039865e9.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 04:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773230187; x=1773834987; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=veDJydETiE9Gv6g2pRG32dl9Jb7Mpm7Du1gG7k28aTM=;
        b=SEYH2Pq3ppCgSe2YgQilj2Dk7nmgQ5YR/rZgPFxnYSBCFgdILk8nrDmQBZhHiaM5bh
         Sfk8qVwddsHsJXpfdU8/8i/f6/wP/bkHVqdoOViAyPbeosflxyFz9FyjRUpVcUMeZ6Qz
         996gv1aFo8gzsGhSlNEZg+bf2iTPCOazHoDKC3AMRRVnzq+SPHet8jVB9ak/owIZLdGR
         nU7DPivMmCBVpeJa4qRU1GZjVk135X4lZ09QUkO5DhZjy8p/7x7FXZV4LK+H8uJcbk7a
         4Ya66y6HA0FoiO0+TIBhh+WVLvno3nInqZi+BwoBp+QN6eGhNofKNj9RSdMgm3P42uQs
         tttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773230187; x=1773834987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=veDJydETiE9Gv6g2pRG32dl9Jb7Mpm7Du1gG7k28aTM=;
        b=DGcVihKkIchoTtsa9Est4+wduRSYSLKEWZzyEzoKUzCumcKYLT6kcTp7j8KYY45Mbp
         h2fJxw5xeeaG3304tNNf41qJ8Fy8taF+hqi27qiD3KOtCrWW4Xc7B8IHOXWRT8bn/7Ag
         cU6lGtVm1FQhk5kFHj6MBHrJg3vDDawOr/sMxnwiS3qXoT8BNrfV4fYB2xz10wmj3DOT
         +GVtd+zN7v42at0GbiMCox0RqA4Yl/ecTEcTut7zQfCLPTFtI7VfaYAuvOt5zY0c4HO0
         8g4jan5Jw7BRG6fH6iza4qOagfVv5eINca9ajI+qW3/wrxo6YfYoaHd6rLFXUKCX9YxO
         XNSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsqI8UF5EpMDFZBm6GtobdSDSkJecy49gV+fijf1OE1Nwivy6FtnxBCGo9+x/hB+Oke5uogQxPaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJIc7qvc4nDJu7IheBuko+jUG7mHZkLiihSXfZ5P6aZS8HEkIQ
	Vhn5zmhXKMpsdy6ffvhFdWtthTBqhgOtLifBnyPUVCaVOe3W872Jj6AEJ4y3mA40GqA=
X-Gm-Gg: ATEYQzyAzTX1kAhotK2UvyAWMlxcIGr+YWO8/cj2tBkJXTZir/XaWV1TC78CwBcL2zV
	A+6XxqodD7RbSRukVe45t9O+LUqCHj3jlHRh03q24BmA3U2qeP4jvzHO7w4nLtsnWeEeWuM9LID
	H86L7rPNHPxpFeusq5VBi9SSsgJA4g1TIJkaX1TwXDXxYqo7yprsEKK0BwSvcSPmrXZQ34RBigq
	6zpp66pYG83RONmJWtO+g5Frw8fuzpYnsWH1Ga8yd/DmwBoLj/QlTOcBfJjYO6HBbT4CE3H0iCp
	p7pIUIJGmbVZIGOCqxzjfZBpQj/EukN+j833WvfoW3Ko6AfbEKjSd0+wAoSJrN/InKO26E3Gyb7
	CnHIeG662sCUqr9w2uG+54Z6J6oBkycvizCr22qbJcq5VcUTwAY+Z/+avZZLXq/ohrMIDE9lqcZ
	a8KzyM3riRNhA5BnkPo6LfHxa+fdpMz+dvUHMvmGVHp2NQzTtygRo8g3gogZ7Xuzn6uxSJkvAkx
	D1XuigSpSPRXDFQ
X-Received: by 2002:a05:600c:8b13:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-4854b100b66mr40280855e9.21.1773230187141;
        Wed, 11 Mar 2026 04:56:27 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854ad5416bsm39586485e9.1.2026.03.11.04.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:56:26 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 11 Mar 2026 15:56:16 +0400
Subject: [PATCH v4 03/11] regulator: bq257xx: Drop the regulator_dev from
 the driver data
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-bq25792-v4-3-7213415d9eec@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1643; i=alchark@flipper.net;
 h=from:subject:message-id; bh=1uAjKjH8Mriiu2XHqXVfsDGlgQSHnV96d3u/aQzpXDo=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRujEj+bmje0PRiY+9KO/vGBRtdJ58/dNP4QRT/GpPoM
 3sOH73D1TGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrqGOsYMXBxCsBU7zZhZGidk2SlnvjZKXHLl7dMX+50NHAukH2vueUdy05jhXMSK5QYGXZKFB7
 L6F4kebyK8+4XMc6SPew8r37qrOBaphF+ffYnNy4A
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

The field was not used anywhere in the driver, so just drop it. This helps
further slim down the platform data structure.

Acked-by: Mark Brown <broonie@kernel.org>
Tested-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/regulator/bq257xx-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/bq257xx-regulator.c b/drivers/regulator/bq257xx-regulator.c
index 812938e565e3..674dae6109e9 100644
--- a/drivers/regulator/bq257xx-regulator.c
+++ b/drivers/regulator/bq257xx-regulator.c
@@ -15,7 +15,6 @@
 #include <linux/regulator/of_regulator.h>
 
 struct bq257xx_reg_data {
-	struct regulator_dev *bq257xx_reg;
 	struct gpio_desc *otg_en_gpio;
 	struct regulator_desc desc;
 };
@@ -139,6 +138,7 @@ static int bq257xx_regulator_probe(struct platform_device *pdev)
 	struct bq257xx_reg_data *pdata;
 	struct device_node *np = dev->of_node;
 	struct regulator_config cfg = {};
+	struct regulator_dev *rdev;
 
 	pdev->dev.of_node = pdev->dev.parent->of_node;
 	pdev->dev.of_node_reused = true;
@@ -159,9 +159,9 @@ static int bq257xx_regulator_probe(struct platform_device *pdev)
 	if (!cfg.regmap)
 		return -ENODEV;
 
-	pdata->bq257xx_reg = devm_regulator_register(dev, &pdata->desc, &cfg);
-	if (IS_ERR(pdata->bq257xx_reg)) {
-		return dev_err_probe(&pdev->dev, PTR_ERR(pdata->bq257xx_reg),
+	rdev = devm_regulator_register(dev, &pdata->desc, &cfg);
+	if (IS_ERR(rdev)) {
+		return dev_err_probe(&pdev->dev, PTR_ERR(rdev),
 				     "error registering bq257xx regulator");
 	}
 

-- 
2.52.0

