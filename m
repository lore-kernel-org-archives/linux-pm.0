Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB3C18859B
	for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2026 02:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792289043; cv=none; b=DOFXHkscoes1uCrVuGmLPW8mMaPWflVywiNh5qx91sZGMf/CzNPBb0aRRxOi2Ymzdp+L1lY/HHzAiRnP8QW4fcvNmBsvFWbLlkB2Q38aPLEyP5n6DK02NUO5cLBMRxLMELeq4ugNzVxMRYzkHVJktQc49JrUB0ywoky1kUMxKZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792289043; c=relaxed/simple;
	bh=k711JYjJ7+6BTD3xUFd6EggIC11D/1ItC0j0I71VNUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RK7i8VpFJZ5Kzp/dRQX4JRHiokSn6AOVHM7Bujr5ZsYGkGRiOe/O5gfhq8KVBhkFF+LWy36jic1aMK385X4giWJ2miw7mZNs7qbuXlzv1SA6XMneSs+zdO3msfpxNNU1r6sACUfxI6Xql0IX8mYj3Vyww8q2Tl+mcnm8YvQXrMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1DQP59x; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1DQP59x"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93e63522076so78451585a.1
        for <linux-pm@vger.kernel.org>; Sat, 17 Oct 2026 19:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792289041; x=1792893841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wHi6g0wrwMF4gUfLle6SGkdX2pS0qJWckA2P3X8qxW0=;
        b=O1DQP59xSYUpzXUKB4dUT4G2oa3e3KvZiIxifCn2fkVaXgJ4vjW2xaYPnVd172cg0j
         QYkYcv7mBcpWewV3IoztPWKPdOIWOzUTLiL+WboY24wI746z9cpZJjKo1osNz+3scm7i
         ohndF+bphOyonH3st8PeTmdfvf3xvwpDv68WN6XUpxm5LXsAJmSo6OWJPrX78qEvgtBU
         oM94P5+F3FRRNxaAdxLFW3nxzHQGBtIAmuhLAlhmgq6mHtWtUuJGB5apHI4C5WXtjwPq
         Zu3B2fMGtzl9/33Nop+fHgKVIgbsqKTIes2xdjyb3Wm+FU12b2erqu3Xhr+byiqzH3zi
         qTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792289041; x=1792893841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wHi6g0wrwMF4gUfLle6SGkdX2pS0qJWckA2P3X8qxW0=;
        b=HAR4ikuvjuYmkG3ieAAl9ZcDZIV3yQfVQ7GI5kfDou6WfYTxHWZXkLwA9n93HUwwkJ
         2MayC5R+WsK1eGBjoPkjtgxcGXcGjSBPBwq2VJGaXjOZ/+9hbuOmlq9T9Q2ZwQbEgEUy
         /JGaD+gidB/EKSa1hk9Qzn6ArrJiHkgIawNVuOg42qJq+L3EZ0XLHl6Y2UnQjMEyfA5F
         tZ7p6MyTh0yTjrVdEitz3Hacviapf1UZUr66ro1IPQ9rJc2QHZAiyBGiGNuqYDjsDEr0
         9eBGleab/RhZtAEVfFv4unToMoVCT2mL+O6PmSZ7gg8Zf9n1aKHonqqorigyOWZTQY7O
         CDUQ==
X-Gm-Message-State: AFq9FYIzEXl1JEDbEmMH7NitxGP19FAia28wQnBerVYEHiezGiqEqLtY
	LEZGDXjktTaReJ6DIuVWSeDuHamC0zsMszHCxsaGXTNiIAGVioJtYKE=
X-Gm-Gg: AYBFou0QcXMNcvfu26Pl6Vf+wEUKZikVbzyavrYD3OLDv5vmdc4wr3tjbn81n3JwCMh
	GA39QW77b27w4DWBCjHp3ZUwro4wdbV1REz4lOlk7iZNl/oUsxLv4hUJVnTBNGkC5a029fPrIqj
	ols8L4DdoL2duCdy4Cs9Sqf6D26BNTUl6sFUKMNEJ772LzBUs657mmyxYPu23tZ27GQRR25XtXW
	QobOBgImXg3K8I8u3VqEedrF3elGQw9//BCg6KPu0Sk5UdJNlbXe3gGGUabsy/ZPYx5eKqxhVKV
	ErbBIKFfZCHN/J4pKWCEzkSJebrbWdadbj5tRW2sG1zUbpKHi3gYe99JWMIKek3G7nfUHVlcopo
	uZzxqvd6jhHVeO3H57FqvjZbsC/CulfX/XjDV5a+hv1bdGSApurJdC1Z3/9JtKyqtdGOchgpn9N
	AgTFccva7c66P71e2ZUE/aNrjbqwEo23V8DTRcNQkvTyw6MVTN3H7A8jOQ/AX3jmHuL924uCzWA
	65AYlUYCqjzMc6gZFD9OfYxpPDTvusGmv76B7PdjdSe8HRWt/U9jOUiDe0YJaQ65OHcEyZHLES/
	zoU4UpoOELJxO9wUzm5yPGITn8n4
X-Received: by 2002:a05:620a:2552:b0:93f:953:9a1d with SMTP id af79cd13be357-93f29db4fc0mr716733685a.67.1792289041164;
        Sat, 17 Oct 2026 19:04:01 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1fb55fdcsm505611385a.39.2026.10.17.19.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 19:04:00 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v2] power: supply: act8945a: Disable status work on removal
Date: Sat, 17 Oct 2026 22:03:57 -0400
Message-ID: <20261018020357.3845586-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clearing init_done does not synchronize with either status interrupt. A
handler can observe init_done set, be delayed, and schedule the status
work after cancel_work_sync() has returned. The work can then access the
power supply after its managed cleanup.

Use disable_work_sync() to reject subsequent queueing and drain any
existing execution. The charger allocation remains valid until both
managed IRQs have been released, so a late handler can safely attempt to
queue the disabled work.

Replace init_done with the work item's disable state. Initialize and
disable the work before act8945a_charger_config(), which registers the
LBO interrupt, and enable it only after probe initialization succeeds.
This keeps both status IRQs from queueing work before the power supply
is ready, including on probe failure.

This issue was identified as part of our ongoing research while
reviewing kernel code.

Fixes: a09209acd6a8 ("power: supply: act8945a_charger: Add status change update support")
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Remove init_done and all accesses to it, as requested by Sebastian
  Reichel.
- Initialize the work before either IRQ is requested and keep it disabled
  until probe initialization succeeds, preserving the probe-time gate.

Compile-tested with GCC 15, W=1 (x86_64), with OF, OF_IRQ and
GPIOLIB enabled. No runtime testing.

v1: https://lore.kernel.org/r/179211805459.3650807.8742309660995961596.G171@gmail.com/
Review: https://lore.kernel.org/r/atPtc_jKLo8RhAMU@venus/

 drivers/power/supply/act8945a_charger.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/act8945a_charger.c b/drivers/power/supply/act8945a_charger.c
index 7e4b087..7d47052 100644
--- a/drivers/power/supply/act8945a_charger.c
+++ b/drivers/power/supply/act8945a_charger.c
@@ -14,6 +14,7 @@
 #include <linux/power_supply.h>
 #include <linux/regmap.h>
 #include <linux/gpio/consumer.h>
+#include <linux/workqueue.h>
 
 static const char *act8945a_charger_model = "ACT8945A";
 static const char *act8945a_charger_manufacturer = "Active-semi";
@@ -78,7 +79,6 @@ struct act8945a_charger {
 	struct regmap *regmap;
 	struct work_struct work;
 
-	bool init_done;
 	struct gpio_desc *lbo_gpio;
 	struct gpio_desc *chglev_gpio;
 };
@@ -444,8 +444,7 @@ static irqreturn_t act8945a_status_changed(int irq, void *dev_id)
 {
 	struct act8945a_charger *charger = dev_id;
 
-	if (charger->init_done)
-		schedule_work(&charger->work);
+	schedule_work(&charger->work);
 
 	return IRQ_HANDLED;
 }
@@ -587,6 +586,10 @@ static int act8945a_charger_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	/* Keep status IRQs from queueing work until probe has completed. */
+	INIT_WORK(&charger->work, act8945a_work);
+	disable_work(&charger->work);
+
 	ret = act8945a_charger_config(&pdev->dev, charger);
 	if (ret)
 		return ret;
@@ -625,13 +628,11 @@ static int act8945a_charger_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, charger);
 
-	INIT_WORK(&charger->work, act8945a_work);
-
 	ret = act8945a_enable_interrupt(charger);
 	if (ret)
 		return -EIO;
 
-	charger->init_done = true;
+	enable_work(&charger->work);
 
 	return 0;
 }
@@ -640,8 +641,7 @@ static void act8945a_charger_remove(struct platform_device *pdev)
 {
 	struct act8945a_charger *charger = platform_get_drvdata(pdev);
 
-	charger->init_done = false;
-	cancel_work_sync(&charger->work);
+	disable_work_sync(&charger->work);
 }
 
 static struct platform_driver act8945a_charger_driver = {

base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
-- 
2.53.0
