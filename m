Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02824BC019
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494114; cv=none; b=Y2tTt4Y5+BozAHQQst1I1420DxDQBn4vdEuc1IydKPD3oDD/yYpAljkyXsmjV0wGJXLniSBZh0FZgi0ol8Ch4TmsAR5YWGB+4OCLUL5f1jzFRttd7xzoB08rg6eyLHjOJyFLxkqgcZpZaM8vuWtrfIEG38sItR0jFxVAQZJLgFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494114; c=relaxed/simple;
	bh=xHQpPZGkwnSYzPAzjFUyP0XG0WV1yIObkQuB3Uh6NO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dHL1PzHn3GVENqFuklvfrQTyGDb5iaMQIXxjIBfwrxKs9vyR/JyUuj/jmXxNkadASo6AgBc083xst8ze1+0iybVQ0A5B7DbcMomXM/M2fAhHRf9JEMzcfqV5KziesFxTsr2Gr2j5fCkGKQ+ubA4tU+dZEe5o/4MGoasz6j/zqM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2S+kkJy; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2S+kkJy"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1744eso11016e87.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 10:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789494109; x=1790098909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=arBE55z8KyRmkXgdTs2/FCieeTQlbYHFLN+eX7wLIfo=;
        b=h2S+kkJyndVUItDeT28GdWPxbA4MhZ2JkZhyPF5IPMCS2BUxX+7OheHShkNJpMLtzB
         kLI9igv1BJydEFbKHRh/Tnh3iOYsNcPoQ1HteAnVbI103ekl06sCDK0MhUBPWaiGvRVr
         iK7tVOhHIyKmOC7TeIMnVOT64aB48Vfy6/ZlgWhiBjEiUnH529nyYEsRF+C4HUb1jwYc
         fkc44FjzLhpwQzLGtPXo2n8gtG0bPQjsQOOIs7744vYuclVdll6QbMSxPrGhg54CFaOv
         X0v6FSgVBFxMV3Zq5nFMriLGSEs/gHmzBgeNnF/2Un/o3pqwGTnx5n4U52zoTDmvOiZz
         dFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494109; x=1790098909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=arBE55z8KyRmkXgdTs2/FCieeTQlbYHFLN+eX7wLIfo=;
        b=on1xhx2kYgJQisnLgJfPzsFXpzM0yIisWzAbEoOUUWXwaz5K9Ml1i5dFAKtXXj0XqE
         BarMDqF5zw7uIY+zu04Bzh1L+p8ITaHun9KMrzuzjV8bpPu1+8gymb6pXiqL1DBKT5B/
         agPKtND1qR1IL23tCQQq0t9hiEBttytAEM3hKeaRwW+FXvKS0KIfboa8v3j1cfBN/vKi
         yDo+gigPx+J9VLjWSysuwFkeVy/y/3ElGmprqTZM89hMJXIMg66A5V8UO1bF60MhPgPg
         ndOM7vWprCf9KSU0NV7ErFKPrVLPoR32RG6csH13yFI7pSXJ3ilJ5sHgFWhZeBWf5QGD
         YQEA==
X-Forwarded-Encrypted: i=1; AKwUvByahH5OTQdFNp4Q93NbkhpguBkgOnPqy4MaXm2snzUO5VyMotwn33C3M1BEMecxdn2KcqNatyYajw==@vger.kernel.org
X-Gm-Message-State: AFuF++lJSq9jZ4CMYqToaSdm9xz3BiXN8q4+PQr+scL5l+aOi5/lh5ex
	1B/u+JG0jh//d3d7XcFqWUnQ+Dd2UJnOqWNd4cjSWTrBkWr/gykOOHQ=
X-Gm-Gg: AYBFou0GTnUgxgwCxQ0ku0QdZWe6Ab0m7+O4Nep4iniTIxvCcVS+XlSqLACi8evnMHG
	CoaOKi3RlFrvxmRTNp8S41opIudRQ4vi+Xk+JmUIiX3gAf18XgYyRzqCZLHsvgd75xWICpstFiE
	62t8YArEM7mDDnvQQ0IHqRIpnMjbCDO0RunGVVJHjJ9Du0u/7TxhwsiaPjNCGVDcryW4fFoM0xd
	MvnxKN7ax5yda3ogTiGlQ1O84QimHdxvzSn8t/ZM2czCqgt35N9VVZJ9zn7ouypiSEb9QFlzKsa
	eoMZ4ox5V0jyFI8C/tJUKhTgT7bkdAkFYLoQKEExRhFGCdX0SLuvfRNNkAclwunDXwyHPf5SPuB
	C1QhMA91XeqYoMzIygKqzIavDZnrrsPxKmQFYfVO6imyaoCEtcX2oMhnDF9GfT4jvv+vB3X6zY1
	kAstOVeev6YEQ2AIiHktPY1e3cobW1fCqo40o0SOkyiLrnGKWj6fRw+Z2rJvpv+A==
X-Received: by 2002:a05:6512:2287:b0:5b8:b37f:164 with SMTP id 2adb3069b0e04-5b8b37f0300mr968389e87.48.1789494109295;
        Tue, 15 Sep 2026 10:41:49 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8b5789779sm123779e87.1.2026.09.15.10.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 10:41:48 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: [PATCH] thermal/drivers/airoha: Request the EN7581 IRQ after zone registration
Date: Tue, 15 Sep 2026 20:41:28 +0100
Message-ID: <20260915194128.42508-1-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The EN7581 IRQ is requested before the thermal zone is registered, and
the handler passes priv->tz to thermal_zone_device_update(). Unbind
leaves the monitor interrupt enabled, so an interrupt pending on the
next bind fires while priv->tz is NULL. On a Nokia XG-040G-MD this
oopses in thermal_zone_device_update(). On unbind, devres also frees the
zone before the IRQ.

Request the IRQ in post_probe, after zone registration.

Fixes: 42de37f40e1b ("thermal/drivers: Add support for Airoha EN7581 thermal sensor")
Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---
Independent of the AN7583 series v2:
https://lore.kernel.org/all/20260915191131.25214-1-sochnev.v.74@gmail.com/

 drivers/thermal/airoha_thermal.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index 77b3a1af271f..ea3e2649c280 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -528,7 +528,7 @@ static int en7581_thermal_probe(struct platform_device *pdev,
 	struct device_node *chip_scu_np;
 	struct device *dev = &pdev->dev;
 	void __iomem *base;
-	int i, irq, ret;
+	int i;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -567,16 +567,6 @@ static int en7581_thermal_probe(struct platform_device *pdev,
 	of_address_to_resource(chip_scu_np, 0, &priv->scu_adc_res);
 	of_node_put(chip_scu_np);
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
-	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-					en7581_thermal_irq, IRQF_ONESHOT,
-					pdev->name, priv);
-	if (ret)
-		return ret;
-
 	en7581_thermal_setup_monitor(priv);
 	en7581_thermal_setup_adc_val(dev, priv);
 
@@ -586,6 +576,18 @@ static int en7581_thermal_probe(struct platform_device *pdev,
 static int en7581_thermal_post_probe(struct platform_device *pdev)
 {
 	struct airoha_thermal_priv *priv = platform_get_drvdata(pdev);
+	int irq, ret;
+
+	/* After zone registration: the handler uses priv->tz */
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+					en7581_thermal_irq, IRQF_ONESHOT,
+					pdev->name, priv);
+	if (ret)
+		return ret;
 
 	/* Enable LOW and HIGH interrupt (if supported) */
 	regmap_write(priv->map, EN7581_TEMPMONINT,

base-commit: b115930d716defc3a7daa2bc2ae2465d864b7114
-- 
2.55.0

