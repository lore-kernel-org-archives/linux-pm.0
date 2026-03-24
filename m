Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6FD3EAC74
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352313; cv=none; b=O+bncOafqOH9AmGjT9t9Q5elqYneaXyrnBUceJQp8FbMiJOOa/XQ38EjFmE7tW4ZsTT8Xf+ln+3sSaSO95djpbPye7uNu7cXuxSjAAV7jHCGhZz4qPikqo/PfCyfDynIn8pS0dVv5Uq/U2RDKV+QcKpQaXaduALKm70hBzMbr0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352313; c=relaxed/simple;
	bh=1uAjKjH8Mriiu2XHqXVfsDGlgQSHnV96d3u/aQzpXDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fsrpp5w1kOq976SJc0b4TcZ6n1wm5+XMC3wXV2rwa+8R8shkHJsVayKagp+KlkAHzA5ka/aLU17H35MMsdEohSm58fbMAQ8ohr9ZXAdcUBRt5990RIxOm6cO5gmzECN0RSu9mlsKO1NYedqpASXx/pjEdvvCfEoKtQScWq2whxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=LoxWdPsh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="LoxWdPsh"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48704db565eso29809225e9.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 04:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1774352310; x=1774957110; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=veDJydETiE9Gv6g2pRG32dl9Jb7Mpm7Du1gG7k28aTM=;
        b=LoxWdPsh6BjiTuvi12E25hu0JCTEt6cVS7lNv90ueKFeHmMYU2kjIowpu953fNiu8x
         ZhKDF9xDPBWxUSZopo1AB0hjHIoliPxHbjaUHq0rVPc9kZoL34CNfptTRvJzgRbw5o2A
         vZo/Bxc+ozxUMm4Ry+60CNxi8pLqiPJ+5EVJafB8SIZQyuZoht8MUu5/I+EpNj9YEJt0
         DsArQsjWNuQfgsA3FFmqwxfj1TenwEUexmgH+FKLkShE4ReUj+CrPGvSqtUdOFz3+YWa
         ovK0IBBGnD7ytEPLMy0qntNUYyifkX6qWo6QeNqcyeE/8zKT0w+olBVZEP8NC9i2ERNm
         Oi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774352310; x=1774957110;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=veDJydETiE9Gv6g2pRG32dl9Jb7Mpm7Du1gG7k28aTM=;
        b=a/3sukLE7o2/r0RKvR2Vl6qvul3+lCP+ghzm+v+z8t5R2UMj6Oz1YeqT/3PEH6Tea+
         gvZlqeNBZWJEQqQPsBxz8ff2VxOm56LnPHOw2Pb/sTwVOQjhVqUA9QpUuuIHp2W/00LT
         ZoJShiGFH2Q5WHxJ+GaCX4A46r7iBHKAl34N21QvUZIJu9aeWzRzyO8wNaDgMd2zKVd8
         DE3CSEs9NT1tFugxbkJHX+5wz4l6jDek/dRZB1Bqkaa7APS+whK8YuaDcqTOA3yhkIMz
         xrh6/lW5go8RpDuXP6oeuKCMHZeZ+8GCrQN5aA/eHL5VsWHl8fPWb/ICXObm2tL68Of9
         vfMw==
X-Forwarded-Encrypted: i=1; AJvYcCWImjgE6yoQ9hHiAZyjZ+PQbCfN/i6Wf3/Rw08H91H4rYXnTfYlFE4wEzUnC3zpKltXIsIYyjJ2SA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvJJx3rUGcB89Ur2a5tLBb2y0bXUsidGHj21X2QfU3RRRujcxu
	20GbnCYWdRSXQVILJVLP6P4myOcyn0pXYDMAk51A3KRih/kPGGaBQctUDSZFMOXJqA8=
X-Gm-Gg: ATEYQzylpoz8Wfbge5a18WkB9HFIJFq0bcSZsDEa6cYJoxd0XQHjjX5o1JLi7TVmFPN
	H/0Yg2vKNNXXhMUOwpR9OTH8kIygW/E54oT+1VtnRQWNOK48IFGwCALK7FE454qkMYGI0hnQ7ex
	XLPLiY44UMGq6EX5xGPZ3rjXTLPMDJITi1WD60i2Mv1yzdo7KL9rcbZ+3CWBt0uY0ctSYqypkWS
	H5ppE0hForXWN8xsH1SsUwtoRXKzt75kVj3dNFMIaBSN2m2zOXik4LElIyJiSukXLB+7Lz+TygN
	/cbyDSJCZofxzo4RzY84U23rXSILehvT/Odm/jENMottdhvjnLgVoYYoBHY4HtzVH/NljulY/gb
	pf72eAC28TQUTQ0ypDHWsSZGmNH3hVhru1i6O2fOEvexDxtStwibjEsF8HVAVa9z+sKSfv9N9LW
	cebCt0P+aBtPEP44uZz5E9eCbADapW/yEq8WPhpE9VdHD6OHGVzgwWpBSvLqoU3eD+Spl961e7s
	eBZRw==
X-Received: by 2002:a05:600c:8b31:b0:485:40a4:364 with SMTP id 5b1f17b1804b1-486fee1af50mr221443735e9.26.1774352310539;
        Tue, 24 Mar 2026 04:38:30 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4870f6c0fa6sm20846715e9.1.2026.03.24.04.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 04:38:30 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 24 Mar 2026 15:38:08 +0400
Subject: [PATCH v5 03/11] regulator: bq257xx: Drop the regulator_dev from
 the driver data
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-bq25792-v5-3-0a2eb58cf11d@flipper.net>
References: <20260324-bq25792-v5-0-0a2eb58cf11d@flipper.net>
In-Reply-To: <20260324-bq25792-v5-0-0a2eb58cf11d@flipper.net>
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
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQeKl8bE7h14Z3g1uhf17mkmTYxbLs9Rzhw84QMT22+Z
 qmVvM1pHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oaGOsY4RAxenAEz152cM/11dK333mmwI/bU2OpH7ESNv/vu7gTKVv6uvCOq2dCYe/szIMOXO089
 NQqcPyvffbd6ao9s1N3jKR7M+ScXOIGnfxo5PDAA=
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

