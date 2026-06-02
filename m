Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B443358B0
	for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2026 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431090; cv=none; b=saSFtEOot30bXADj1bcaqZGmGxlgECRnYHNwfBVo9tAjod/VwWELh7oELe8wF3zPgXrq+eNEXQ/Gfb9MS961co4c+q4h5LR+YmErsXk1i24VQ8Qcq/dyRrVra/vokd5wYjtTEdwR09zS2XhY/YBkXufr/wcCyxROlmSfSt04Vvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431090; c=relaxed/simple;
	bh=223od1A+Cz0XplSlrBZp0RWQ7qf9uUi6RyR8x+K5pfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GNxRtIHUzHoPOXvLoECfw5I/yeCjw0ZZxFDYFeXck7qGpoxU+Cqf7G3entxXtNf0ZsqUq0WyxvA04MJfIQLIBBoBrhlRYYVao9ocNF4chgYUI9ycT9Zypva5jMsDSDlAoEwHFc723/CjyLsYv7qKiBvZQgG9r4+ZkpOcXZp07V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=SNATBmuw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="SNATBmuw"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b4a8e28bso4136405e9.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 13:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1780431088; x=1781035888; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tao3RRa4fqWodWHn9YOVIx5KYGzNGLszmBA/8A40dM=;
        b=SNATBmuw05bjZB08ZeTPhLWM3mY9VQVIc+6n4EWCwrDTb5XkFjoK2JYz8UhKNKkT2W
         CFPAWrq6/d/s+p7EuJPs1gUzpvofqh0zPaWiDpaqLextwXt3VjRgdcO970asdV80IDIn
         y7EDK+G6jK3jCKJTIPmQlDkifCY6vwKXv7QuSTWOoDNJp2DEQ+eUgjZU4OOHt2PTAGVN
         /6wa5fRJE1nFAiOxl1cT3PBTAmDadGH1mr4mFY8jgUQCqXOX/mwkbyZins7/1kw3mCqJ
         p6wPvVxiGYG1rL/sNBVnk2JkuzNCIxHBsTYGqFWg759/aOEkwFVZreSWaihsAFOP3ocC
         kIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780431088; x=1781035888;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1tao3RRa4fqWodWHn9YOVIx5KYGzNGLszmBA/8A40dM=;
        b=SkaUgaCsdV5nyJnrIGwhATMCGG2lKlJh5oBimtF+C9IvJ/XL8/OaeJhBAD7nSJ7nLa
         deA8FOGSvf5tywcUDGGZbW6gVsLSksV78I6WMGVE8ukVQ2UzUHRhCsxJyh7cSIrxP9ch
         GbyzTUAYRQmfJS6htZMS7RTRrea+u2wkS5CkmU76qWO+02sgg5tpiNnzB0dT4OdJrGoY
         ZuLaMH/IKPyjgnTEEwd+JGcW7ZgN+biNNUjsiDB7rsdtywdxhyxK9z39FtDytD/Cm1Jb
         sdBlzVKWZJrDTXwz5HWGWG9gq6eLc4AyJE6KOIE1vLOu2RKPkMaAg0ltEo4bT/w49CLO
         QF7A==
X-Forwarded-Encrypted: i=1; AFNElJ89WqgSZCjqpHCNUK0VhbDcNfTozZ88ZtVp79R5KPXuxZ02aipkK5YmluTFLGejn83jzFqr6iBX7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOLq16p2nfcTMahMVEdjSvQhcpSkPhqjndCWDFfnaoTvTzhnyA
	QFl97ACfZPRae7jqC41WY1V9V3ycKHDsqwSINcxf2ibPiIwtNP+xQhrBECYekz9hiZ4=
X-Gm-Gg: Acq92OHWIoa95XKu0tiFHaIMLai8VdpBM5go3EGT5vA5+j4AmWFVw5I+if3uwV6WEjs
	P75ocaj2D1TuriEsE9FVX5lSL/bnPRr627CNEDoTft7XPEOEeJCAxOivKCs3cekfArnpkz7+eKO
	+d58/o7tb9kbMHsOO4wg1z2Gy3qfZYbpw/M+08zDlhIg7aNjfcK6vhKA/yBdjcZhiNC4t3jqNNl
	4wnRW05FisRaQcfRWDg2sdeAo6OBhj7m+2qNqXoQB6Sk5dHCdKnJSi2DFUpzLtvJb4GWogwR/Ao
	XseMNQlK5qy6/mzEPmN2DLWeU9PwHT8aTIeh9ywlpEmTAI0oDedjGru/L1Fecnd1376J5+ntRzJ
	SvbOit9oaBaOhFyIa4VLK8slE7zljg8ZHRJhjDvKK03qcgnSIqPNiOzh2sCTzBN87JyWJzd1LTV
	nMXxbnGUfIHPzO0klARfPcSYPIYgxKm0vJ2SiqYg7emTXCRm0Fd40=
X-Received: by 2002:a05:600c:a117:b0:490:48df:2793 with SMTP id 5b1f17b1804b1-490b5e64affmr3928395e9.26.1780431088170;
        Tue, 02 Jun 2026 13:11:28 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63e6720sm2588515e9.13.2026.06.02.13.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:11:27 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 03 Jun 2026 00:10:49 +0400
Subject: [PATCH v7 1/7] regulator: bq257xx: Drop the regulator_dev from the
 driver data
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-bq25792-v7-1-d487bed276d0@flipper.net>
References: <20260603-bq25792-v7-0-d487bed276d0@flipper.net>
In-Reply-To: <20260603-bq25792-v7-0-d487bed276d0@flipper.net>
To: Chris Morgan <macromorgan@hotmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622; i=alchark@flipper.net;
 h=from:subject:message-id; bh=223od1A+Cz0XplSlrBZp0RWQ7qf9uUi6RyR8x+K5pfQ=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTJWzzbbHGoPCH5jOhbxmauA4dYvcPNzWdpbsxhutZ5+
 7Ddv7gjHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEz1u0qGf/bsU3kDD1amPp7L9Xvvvo9/TvWuZSmsnlbiUv90YYVmby8jw0r5y/q
 a829Vre0X4Xjarx/jtnNlQoXy1hYzb5YZu3USWQE=
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
index 09c466052c04..913ca9186bf1 100644
--- a/drivers/regulator/bq257xx-regulator.c
+++ b/drivers/regulator/bq257xx-regulator.c
@@ -15,7 +15,6 @@
 #include <linux/regulator/of_regulator.h>
 
 struct bq257xx_reg_data {
-	struct regulator_dev *bq257xx_reg;
 	struct gpio_desc *otg_en_gpio;
 	struct regulator_desc desc;
 };
@@ -145,6 +144,7 @@ static int bq257xx_regulator_probe(struct platform_device *pdev)
 	struct bq257xx_reg_data *pdata;
 	struct device_node *np = dev->of_node;
 	struct regulator_config cfg = {};
+	struct regulator_dev *rdev;
 
 	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
 
@@ -164,9 +164,9 @@ static int bq257xx_regulator_probe(struct platform_device *pdev)
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
2.53.0

