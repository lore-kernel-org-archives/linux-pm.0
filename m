Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792807235;
	b=cmiyYw3S9rGGGKmMsuPdBYzs1JaJpYhnzh4pANfxVXxoLurxUQjgdoBPTjibfIq54b0Q
	 Bq8P9fjtHSMwBHnPzno+PkbVrEnjHbD9lVwLfmSH8NsDMqiCbOpmWe6FxGwUZpH+256HO
	 vPO6BzhTu1hJwfAWQu4QEaofN9p9V8QQiNPZYkfhB5P4l/jv2poz/jIBK1/ZjoonSTTaT
	 CpuX+PISUIyEY1iHNW0oTq9ngttlfvve9/JBNHJj0QXBKZoAtsqUmF3YL+U1haAsp9aei
	 zcNiTO02p61j6usdzvXNSPUOshllJiuRo2sm9RUhd/1DqBKpco5ZzuzwI5JRxxUIhUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792807235;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=9r55CXgJzakuwiHl3DsCrmU1WyhRrQEB2+vRes1Hln8=;
	b=HdZNJ5Txqji/eSKgHmX713m9qFbrNtpPCyMaInL/Ekr/Y9CCuocJBw1TLBtdYypd4iQG
	 pVGNe4ftbEDaAq0m1+dEhBKyUjcC2acA8+HI7NqnBN9b5DEmj27tXsBui1U8hzDiq/Z8B
	 +MWWa+uM06P7jiATGoqSmjAn3crQ/2Ptk7y5E1SuGZ76NKNeYRL7Uk5+4VVySOj7Wb0+m
	 xudihLyC1zpDBlp/cjnx9JBKoL5G8HfFmd/ih1v8e150xjMreHWvzVZ+wBqfftcky+5C8
	 3awlXoLkS9tUm+tNXE1q7Lmt0qzOF8hbSJfEEMHShiv7GQdIjSI0alnSHp7RJgV9faw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="W/1X/M00";
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBF6606A31A
	for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 02:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCBF6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W/1X/M00
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5366ae57896so14410941cf.3
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 19:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792807234; x=1793412034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9r55CXgJzakuwiHl3DsCrmU1WyhRrQEB2+vRes1Hln8=;
        b=W/1X/M00yyz1dJhdQAtS8YyUN+Xgrqj9hI8rv0li0k+ePwfvOrC3kQhrBhhd93ELvx
         +XmAXY3xelHc3BCRIQvLte7UzIj9i5xvEzuA/IbshHlU7q4GxQQdBoBADu0qdKxzcqUJ
         J/fLWtFot0bBdO8MHhkOkaJ3iNFhzh0NWDCX85XYCQ5Xks2cCEboFfj3zypaOAZhZEea
         pbA6Mchn/7c9cYCJwkagRN/t4DzDeR6bWuc11rke+Wy9ZHOtwi2OBhdMeuLSDD3nZ+/u
         sX3iTejfxHE4gN5VradN0oulJTzn7fnE/muvAMrlK0o0YIKa23pHZBYjxNlDnIDk6q10
         hOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792807234; x=1793412034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9r55CXgJzakuwiHl3DsCrmU1WyhRrQEB2+vRes1Hln8=;
        b=uwP37JofgWviVzDt11GUkAMV10eFh6sdymmBorP8M0ZVv/5beKPsdqLiqBWJMVObEP
         dGv2LcxYQanQqoUjS9yWM48yaJ+cCjXKZAy3arYzZdVHioXF+ufdPL6PF6awzAsMY/Xc
         HOXpbYCEl+UTI4UC+FLlc6YUDBu1/RkodunwuQVczH0x+kcnNy7kn83BaQX9kO3yKa7P
         p5sa076yRbrFSfxG4Ax2pBP+IsRZ3WRweJNYp+puV/YQ0t1xN/BYPXh8f4ivXEF1ALMh
         v0hxA5Mp3rOHU1eueGD5ZziVec1eAzaci1aGht22xj78E5CnWI0iR66CPWqDv6WqoBqQ
         lgug==
X-Gm-Message-State: AFq9FYI6j9cOukKboPw+yk66xd2ib/A2fyBOXmsIqT1TraH+NncLtmGL
	Lq2eZnhNjC5rnjL8//Av2NxuudpwopfnTleBH0aMERu/6j6xFMHgkWmrSFwnBDvvUg==
X-Gm-Gg: AYBFou2OjsmBaPRzdZx8IpN6GIyWH3cmfPu8Ptt7m5xFhH1CwHjgsVTIFJSzJXe8w7B
	i7LdURsw5AgJCYCiUMyLWuYJjYDjidfls/D75E9WrwNAYmswCX9rUI5VECbvzjromXo3mva2P7U
	eFxmcWxaDPkT4yEbe2/LO8ld+jwEyZJlUmV+rzC3ca1eqRo89g6h7qE/4pUnylfWvilJry5UTEO
	JcoIiwGFBVopQgpHuRwSb36NKzo5nb0q9uqFi2uzhaQ/F6XJayfNYjPLZeu5QIZJbKKjdlE7QKa
	noAyH51j0iYrrKpQyFNxFAr4KCbxbrp/FKIw42gIdEnFPgqX+SNa6M3ezrY6jMI/XGrQqh3HK0O
	k26R9k6jD2QNILob/uGlLSoNnwojgoNJhxNZit71nALwvy6uIMrgtVpc3idxGwj2L9vHCAiiAIA
	AOw0UuAL35c4GQoQk+iqbf1EVTJVYLGa5BKA3ADpR36O9kS7T0HkJqXO+6eWudg9vomyL2nQkwL
	dwIk9Ovr8aI47Q+BygWstuOg2verbjXPHQ8pia3Xu3EUtuDyHo5iS/QG2aC1XyqIvEQhFlM92vV
	erWNRuQ+YsW+YnaoRvmgXwm1ktJRyZZHbs13Yn4PSxH+gt9X/nWPyVXg2uDnYVBEiohk+rpv2cX
	bAiBfa08Si2GthQuf
X-Received: by 2002:a05:622a:580d:b0:536:6f7d:1145 with SMTP id d75a77b69052e-5383b5ed1fcmr9506611cf.21.1792807233788;
        Fri, 23 Oct 2026 19:00:33 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394c565esm7278181cf.6.2026.10.23.19.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 19:00:18 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>,
	Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v3] power: supply: act8945a: Handle status changes in threaded IRQs
Date: Fri, 23 Oct 2026 22:00:12 -0400
Message-ID: <20261024020012.77608-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clearing init_done cannot prevent status IRQs from queueing work after
cancel_work_sync(), risking access to an unregistered power supply.

Use threaded IRQs with IRQF_ONESHOT and a shared mutex to preserve
serialized status updates. Request the LBO IRQ after power supply
registration so managed cleanup drains both IRQs before the supply is
unregistered. Remove the work item, init_done and remove callback.

This issue was identified as part of our ongoing research while
reviewing kernel code.

Fixes: a09209acd6a8 ("power: supply: act8945a_charger: Add status change update support")
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v3:
- Follow Sebastian Reichel's suggestion to handle status changes in
  threaded IRQs, removing the work item, init_done and remove callback.
- Request the LBO IRQ after power supply registration.
- Add IRQF_ONESHOT to both IRQs and preserve their trigger flags.
- Remove the now-unused platform_set_drvdata() call.
- Use a common mutex to preserve status-update serialization across both
  IRQ threads, and initialize it before requesting either IRQ.

Changes in v2:
- Remove init_done and all accesses to it.
- Initialize and disable the work before either IRQ is requested and
  enable it only after probe initialization succeeds.

Compile-tested with GCC 15, W=1 (x86_64), with OF, OF_IRQ and
GPIOLIB enabled. No runtime testing.

v1: https://lore.kernel.org/r/179211805459.3650807.8742309660995961596.G171@gmail.com/

 drivers/power/supply/act8945a_charger.c | 61 ++++++++++++---------------------
 1 file changed, 22 insertions(+), 39 deletions(-)

diff --git a/drivers/power/supply/act8945a_charger.c b/drivers/power/supply/act8945a_charger.c
index 7e4b087f7679..9411e1f049aa 100644
--- a/drivers/power/supply/act8945a_charger.c
+++ b/drivers/power/supply/act8945a_charger.c
@@ -8,6 +8,7 @@
  */
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
@@ -76,9 +77,9 @@ struct act8945a_charger {
 	struct power_supply *psy;
 	struct power_supply_desc desc;
 	struct regmap *regmap;
-	struct work_struct work;
+	/* Serialize status updates from both IRQ threads. */
+	struct mutex status_lock;
 
-	bool init_done;
 	struct gpio_desc *lbo_gpio;
 	struct gpio_desc *chglev_gpio;
 };
@@ -430,22 +431,14 @@ static unsigned int act8945a_set_supply_type(struct act8945a_charger *charger,
 	return 0;
 }
 
-static void act8945a_work(struct work_struct *work)
-{
-	struct act8945a_charger *charger =
-			container_of(work, struct act8945a_charger, work);
-
-	act8945a_set_supply_type(charger, &charger->desc.type);
-
-	power_supply_changed(charger->psy);
-}
-
 static irqreturn_t act8945a_status_changed(int irq, void *dev_id)
 {
 	struct act8945a_charger *charger = dev_id;
 
-	if (charger->init_done)
-		schedule_work(&charger->work);
+	mutex_lock(&charger->status_lock);
+	act8945a_set_supply_type(charger, &charger->desc.type);
+	power_supply_changed(charger->psy);
+	mutex_unlock(&charger->status_lock);
 
 	return IRQ_HANDLED;
 }
@@ -490,13 +483,6 @@ static int act8945a_charger_config(struct device *dev,
 		return err;
 	}
 
-	ret = devm_request_irq(dev, gpiod_to_irq(charger->lbo_gpio),
-			       act8945a_status_changed,
-			       (IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING),
-			       "act8945a_lbo_detect", charger);
-	if (ret)
-		dev_info(dev, "failed to request gpio \"lbo\" IRQ\n");
-
 	charger->chglev_gpio = devm_gpiod_get_optional(dev,
 						       "active-semi,chglev",
 						       GPIOD_IN);
@@ -581,6 +567,8 @@ static int act8945a_charger_probe(struct platform_device *pdev)
 	if (!charger)
 		return -ENOMEM;
 
+	mutex_init(&charger->status_lock);
+
 	charger->regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!charger->regmap) {
 		dev_err(&pdev->dev, "Parent did not provide regmap\n");
@@ -617,39 +605,34 @@ static int act8945a_charger_probe(struct platform_device *pdev)
 		return PTR_ERR(charger->psy);
 	}
 
-	ret = devm_request_irq(&pdev->dev, irq, act8945a_status_changed,
-			       IRQF_TRIGGER_FALLING, "act8945a_interrupt",
-			       charger);
+	ret = devm_request_threaded_irq(&pdev->dev,
+					gpiod_to_irq(charger->lbo_gpio), NULL,
+					act8945a_status_changed,
+					IRQF_TRIGGER_FALLING |
+					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					"act8945a_lbo_detect", charger);
 	if (ret)
-		return ret;
-
-	platform_set_drvdata(pdev, charger);
+		dev_info(&pdev->dev, "failed to request gpio \"lbo\" IRQ\n");
 
-	INIT_WORK(&charger->work, act8945a_work);
+	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+					act8945a_status_changed,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					"act8945a_interrupt", charger);
+	if (ret)
+		return ret;
 
 	ret = act8945a_enable_interrupt(charger);
 	if (ret)
 		return -EIO;
 
-	charger->init_done = true;
-
 	return 0;
 }
 
-static void act8945a_charger_remove(struct platform_device *pdev)
-{
-	struct act8945a_charger *charger = platform_get_drvdata(pdev);
-
-	charger->init_done = false;
-	cancel_work_sync(&charger->work);
-}
-
 static struct platform_driver act8945a_charger_driver = {
 	.driver	= {
 		.name = "act8945a-charger",
 	},
 	.probe	= act8945a_charger_probe,
-	.remove	= act8945a_charger_remove,
 };
 module_platform_driver(act8945a_charger_driver);
 

base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
-- 
2.53.0
