Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD9841C300
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971838; cv=none; b=Y5FhV9C51nStvrvdClhwVMgIP0dWnxa+1vAFSeYqRAS7iqAnkDWeQQ6wA8slrzT/Qv2+rpCFpnJUT8hGNwB1jkfRjIkoZWgBfi/C+rkQZjGC4BPq0hh4Pq36eKfgR9I9/mKGaaii1zbH0392GFxz4UzUKIxoPV6C5GeWoR1FpjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971838; c=relaxed/simple;
	bh=1uAjKjH8Mriiu2XHqXVfsDGlgQSHnV96d3u/aQzpXDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cx3fCjc/+bQHs29FSkj6tawCCBeCkR+03TIMcx8AUXYn6b2Um6wivZ9vOiNP8ThNSK4aZywGgHewSS6fAU66HVvIK8FzV8jUkt/V2O4489lWzhxRevytQEFxqLV522sC0PYbds8X+lE/7JvRAa2e43AAUXKm+f97/zMa9Hf0RHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=qnHcMgHH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="qnHcMgHH"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-486fba7ce4cso59094665e9.3
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 08:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1774971835; x=1775576635; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=veDJydETiE9Gv6g2pRG32dl9Jb7Mpm7Du1gG7k28aTM=;
        b=qnHcMgHHjfDccj+1QAnj/lAlt5BiyHG5F+cD1TDTpQsrXKAaEnovoEcV6gqEYk7PgJ
         0ASc2pmisv+yYDLf+8YHpl18UwnFwF9PImEVYpehNlQ8nyO3zicrVh6J4KCMzJVQCTnK
         K5y6CePvSNkMlxeIEA7FQ1zrTEJ2/J7sLydwgqzpQ3JQLg90FjZ5FmqiKRdgtA11zi4Q
         YNisKgXa6NmRwVlBjuNeI/1wGeOFe4so1PzRsr/cXIT3+CPcB7GnOGXyKH5GpQOm6mpN
         77ziPdcrCpHk51E9onAZ40r+AQ9zA2WD+an2LS4qGBNfAdIj/DEZUUYdsoSQQY7XaTEu
         fagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971835; x=1775576635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=veDJydETiE9Gv6g2pRG32dl9Jb7Mpm7Du1gG7k28aTM=;
        b=R+wPrepwbtXJgpk5tL7wuO2rKxHhSNvuZhywy5voITUutNYES067Sdo+QvHJ4dw3es
         d0zOzRR8KhpnJhyPkKtz2W2qZX30QMbdT3ll5PORQEkprhwpnOWrgTNjRwsL+nH1wsQB
         28QxP0FpJ7G6U011DJqjyI1FqibzZp/tRqNNsjvEGdml0kfg7qVkEY/l+vI29/Q1xY1V
         WXFQOEvD/gS/K8KN4wOXDE93adbzJmbN8VPQz8c1gQfry0AcXKcyMzqp8N2DJY1Q2cYR
         MsKE+9ii4cT20zHeXdwMimh8WA3uyXqgiyFwI4Ok3YtqsiWRa9f2eHPwvubfyLV4o1sI
         3XJA==
X-Forwarded-Encrypted: i=1; AJvYcCWczCwqqg2bWcC+w8lldIdGCa8b3EdYWqLwS9Mik+z18Dp+4CT/qVazMEgTkqJHhC+a3PxsEZT3pg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVldFL5z7yL19v6Zfp0fVjGXcVD2fp+kPoCijHwJgnerWZ+P3R
	1FnQLDOosvMI9Ivu/9P9QUY4sSj3utp+LL6+Woio1YNW2IC8kM7/t1jg6eXlzr/ixgM=
X-Gm-Gg: ATEYQzz+cXfP0exBgFd8EvL8Tf2JS66Z0nqYt8JZtzv11xYSCGxEDoZveXS5+LLPhhG
	hqPDlGROvuAvZgnuR+M1t+TTeXXfmXareCqC34TRnUh7D6urRbrzDWZqEc4Ko8irw87OqtHUrXj
	8IXr8CDGCUwcTCi1vVAGCSReZoWEp6QUK1iBtZfivy24muU0NyHANk4VSR+X00jLBf/qOm87U3W
	xRN7KbJSASk88df4bDfNJYqLI4K3O3ZDiy28FCYxuNlJtl6gBZOB6EP5BayxRQkPUiST3BewGZ7
	jdZRSVWHktm7cK0cIxd6iKXmmZif7JQH5f0hgONxRoU5sRr0q0PA/T58kPMx+M2/mwDC/Wick4V
	dp2u7wI/fyNYS26rLanK7iydvIrIATttVoCllgam+u5yGzsbZXbpb+tlJGYM4ZmEyETTPqOeA0I
	YNWQqhJLio4Nkx6+3W3MR/ucdTWuHCYw8+FNf5re0Ao3Uu8oSZVYe5QW3EJljA6puOn5p+uJn0C
	qcgRw==
X-Received: by 2002:a05:600c:34c3:b0:485:3f65:94a1 with SMTP id 5b1f17b1804b1-48727eda72fmr294205335e9.18.1774971834917;
        Tue, 31 Mar 2026 08:43:54 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8852a5sm48412605e9.9.2026.03.31.08.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:43:54 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 31 Mar 2026 19:43:40 +0400
Subject: [PATCH v6 03/11] regulator: bq257xx: Drop the regulator_dev from
 the driver data
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-bq25792-v6-3-0278fba33eb9@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1643; i=alchark@flipper.net;
 h=from:subject:message-id; bh=1uAjKjH8Mriiu2XHqXVfsDGlgQSHnV96d3u/aQzpXDo=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSefr1+IrODV/rWs6zSx7Zo/dp8bsLnoqtLqkWFTzZ+8
 3vzu2jrro6JLAxiXAyWYoosc78tsZ1qxDdrl4fHV5g5rEwgQ6RFGhiAgIWBLzcxr9RIx0jPVNtQ
 z9BQx1jHiIGLUwCmuvIwI0PDvuoJQvujb3zOX+L27M5U4R+cMmHircIPVnktdp63aa03I8Oas90
 M8g/Ldtlq2emtYHFSXj2T7+iCqYGmy89r//CoKWcBAA==
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

