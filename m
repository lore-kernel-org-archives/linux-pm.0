Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45BD3C6A51
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 10:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049927; cv=none; b=C21lLmLqzN0/M9TbHU5ldBe9DR6a+cyeusc7oiGXWAks3wKWnBdCs7A0fZS7va+ET159BTyfcbYk26YarRF73WQ68yjiC8HMNR1UvIzwo18JOS5rox5JDgkiG/9CXtR5UnCoxVbtu4/fdV8oUqDwd8Ktid/5UA1WF2GXAe75R3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049927; c=relaxed/simple;
	bh=W9xT+mzvNTBez1lAU3xkbd8dVtQp/hVdeRLR+vfLdCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fh3l/w4eF5WKbT/5yal1FYnoEMkOs5mnQ325hCOU0CAvy2yip25sWolht7+OCH/iPBVjFVBmavVyeWF8rSVQluxwzW+1fisqXtR8syqqbJ9043Q+T/5Qo6etSsOFpugVBN42xO5/wc41CyixQywD7FEJkzuZNqpnksOFRfPuUAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=JHxBS/sG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="JHxBS/sG"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso74209945e9.3
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 03:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780049924; x=1780654724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4zSRLTrRKREVH9IqS8el7yHWyFDWA9l51ZOzDmK9sI=;
        b=JHxBS/sGBAz7c0WWghIlgA0l3RG/DH0rEfLeshMKlkhw6Y+tScIEqyDryj9cFoEhVi
         EMP6Lesja4+7J+j4YBTtc6TmD6kJ057G5jU+GR4jeymlBt7SB85xzN2NdxMrp7DHNWkH
         GwqZvGYod6Ehj7lOthlaWDQ1j/EIKBjMFFA/GLb5HNXbayOBxUrQ4zIZj0K8+pK/gs1f
         L2+5NVAIkuFdfJne/uVkmkLa8EPMR2Wi3Hl47suRCIqQ4wXITkmCqYmFe1IO/LdRmK7O
         WJtqxzbIxNWiGmcpiKGOK90d30pXuhIeRJyF4k2bmNWeFeV0KOfVLpS3vySyX3XJ1dmo
         Mycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780049924; x=1780654724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P4zSRLTrRKREVH9IqS8el7yHWyFDWA9l51ZOzDmK9sI=;
        b=Ic7Nlji/7H/GngIROUXmI52BxfU6Z9eW9QAesq2UzF155Pr5kkizCBEVABg/tZpuhA
         CfHz6eaAydr5HrCwsTBbaND4tc+zuQZk7wVqN3ofXkEEkA3BrNWAQAjfJ5FDrbokYLy/
         CKavAbE/bOOxshQFIQp5Np/Wt9UcIxGH4TsBu0RMLItITwhTIF75vJv/UKrNhDRBx3S2
         yzbIN92ng/0Z/7Xg+L/p13Y18y0+GaAfZeOwyvBQCIhCtpIMR93Lk3aCI7v3tjkcEJji
         GnXK/jJCDAgV1WiRvmtYoRg27t1LG+62t5EStEFQxJgFt/V5TthVuYD3uk0EStvy8rLC
         0J0g==
X-Forwarded-Encrypted: i=1; AFNElJ8tMZUZaJOPYDSnItadxoZbvO2JyNMqM2mWwRn9bsvBQk2GUC9+sWJy2bAKrylJvSbILWlUbx9Cpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxwuzR4vAqj6snegqK+QFQHds7bq3+YyZAFM1e9W96f0yT6+Y6
	2J70ANaKV5Qq+IRcZImrbK9PF4JK+zh0UVuunifv/T6Wnq0FWI8cELfp3TdZm6uIhnk=
X-Gm-Gg: Acq92OEmO3PzPFJ0J19HNn1Sks5E0HIXs9ZTCMFnYyuPdUtqc3vm9ka/gIdByb8fyhc
	AHimQIcYblbbCfQalxgvNvGWWHEruXZt6zgEX8BlYKf3sJLjJ1Pr3OAoXn04o7uHcAdic5J9IBm
	Hp3pipauZfg99g+nT21UvoF/xCu0eUcGT0LPQpUOS0wXcQItWtUiVMepIKlV+FtVxq0O59fknvC
	RzCOnZ+aRXptOIyq4qYmVgl/IBZb/YkvJzt3eFX+zf/WcTuQhUzqdprxPvzcB9RyY+0ITyZ5zl4
	xeww8wD4OMg4iHGopCvy+EBLPT7A7F0T0/3wtZppZCcyCrHFF/T1pcC5XfgrtgtnA3lfJZG5KME
	s6gIZjWOVeHckIVUSTsg4AFlmgWslKYpYP74irrF2Utg4e8LnaKpidd8leam7G2FoTgh1jbsiY8
	LqYZagkGNTlghCaBKd8N0i7eaYDZ6L9UcUojPSKK8qb9Hbz2oFzOTpZUdCz4fQf4q58TCM+Esh4
	MKxcY9Hh46NTJMFsHo/3lyVBg==
X-Received: by 2002:a05:600c:58ce:b0:490:44eb:c1ea with SMTP id 5b1f17b1804b1-4909c0b546cmr30191565e9.24.1780049924381;
        Fri, 29 May 2026 03:18:44 -0700 (PDT)
Received: from localhost (p200300f65f47db043f932d8b97293bf6.dip0.t-ipconnect.de. [2003:f6:5f47:db04:3f93:2d8b:9729:3bf6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4909c0ad269sm11855695e9.11.2026.05.29.03.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:18:43 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Yixun Lan <dlan@kernel.org>,
	Andreas Kemnade <andreas@kemnade.info>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Amit Sunil Dhamne <amitsd@google.com>,
	Samuel Kayode <samkay014@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v1 4/6] power: Use named initializers for platform_device_id arrays
Date: Fri, 29 May 2026 12:18:19 +0200
Message-ID:  <1ceacf4f9c3f827bcad85b378aa04cdca1c04635.1780048925.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780048925.git.u.kleine-koenig@baylibre.com>
References: <cover.1780048925.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5348; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=W9xT+mzvNTBez1lAU3xkbd8dVtQp/hVdeRLR+vfLdCE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqGWfy0bX/m5kq8Arlyt5XE8Z+Ge+pZiRLveebn 4cklmt0zVmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahln8gAKCRCPgPtYfRL+ Tgj4CACZl/QxMesCrrIl4aNkVxWwxHLc2F2zJNbXP7mUNUZy6iSAQRmCPv/wrBPSa2TyyvCYd7T zCUw3L9LezGtcTAcu4AT6betYFrT3vdx2aMXWqk/lunJew9bTfAOihdCMJcA3jLt0SHECHUBYCt 8ibifSKnMpS9cmgT1+nXA/3x0Zp26IE6mNdFJai3hgNrNtpW+8MKMX2tBk/3VT6uv4nv3bzs5JR DZ9/1h8ng6iT+z6mSE3NjM83dSCzN+fkhK6EXTAZ8k0GaxqyY4TdqZSyZdPCeFum1xeDSRiVunl YedBpxql0w3n64ysMOen1PE+PCNSTxrCd0ATCblCqdxOqrhO
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Named initializers are better readable and more robust to changes of the
struct definition. This robustness is relevant for a planned change to
struct platform_device_id replacing .driver_data by an anonymous union.

While touching these arrays unify spacing and usage of commas.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/power/reset/spacemit-p1-reboot.c | 4 ++--
 drivers/power/reset/tps65086-restart.c   | 2 +-
 drivers/power/supply/bd71828-power.c     | 8 ++++----
 drivers/power/supply/macsmc-power.c      | 2 +-
 drivers/power/supply/max77759_charger.c  | 2 +-
 drivers/power/supply/max8998_charger.c   | 2 +-
 drivers/power/supply/pf1550-charger.c    | 2 +-
 drivers/power/supply/rt5033_charger.c    | 2 +-
 8 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/power/reset/spacemit-p1-reboot.c b/drivers/power/reset/spacemit-p1-reboot.c
index 9ec3d1fff8f3..84026b042ea2 100644
--- a/drivers/power/reset/spacemit-p1-reboot.c
+++ b/drivers/power/reset/spacemit-p1-reboot.c
@@ -70,8 +70,8 @@ static int spacemit_p1_reboot_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id spacemit_p1_reboot_id_table[] = {
-	{ "spacemit-p1-reboot", },
-	{ /* sentinel */ },
+	{ .name = "spacemit-p1-reboot" },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(platform, spacemit_p1_reboot_id_table);
 
diff --git a/drivers/power/reset/tps65086-restart.c b/drivers/power/reset/tps65086-restart.c
index 6976dbcac74f..37d248a9df17 100644
--- a/drivers/power/reset/tps65086-restart.c
+++ b/drivers/power/reset/tps65086-restart.c
@@ -41,7 +41,7 @@ static int tps65086_restart_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id tps65086_restart_id_table[] = {
-	{ "tps65086-reset", },
+	{ .name = "tps65086-reset" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(platform, tps65086_restart_id_table);
diff --git a/drivers/power/supply/bd71828-power.c b/drivers/power/supply/bd71828-power.c
index 5e78faa0a4aa..5ab514ff5c65 100644
--- a/drivers/power/supply/bd71828-power.c
+++ b/drivers/power/supply/bd71828-power.c
@@ -1184,10 +1184,10 @@ static int bd71828_power_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id bd71828_charger_id[] = {
-	{ "bd71815-power", ROHM_CHIP_TYPE_BD71815 },
-	{ "bd71828-power", ROHM_CHIP_TYPE_BD71828 },
-	{ "bd72720-power", ROHM_CHIP_TYPE_BD72720 },
-	{ },
+	{ .name = "bd71815-power", .driver_data = ROHM_CHIP_TYPE_BD71815 },
+	{ .name = "bd71828-power", .driver_data = ROHM_CHIP_TYPE_BD71828 },
+	{ .name = "bd72720-power", .driver_data = ROHM_CHIP_TYPE_BD72720 },
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, bd71828_charger_id);
 
diff --git a/drivers/power/supply/macsmc-power.c b/drivers/power/supply/macsmc-power.c
index 33ca07460f3a..ced07f71e0a8 100644
--- a/drivers/power/supply/macsmc-power.c
+++ b/drivers/power/supply/macsmc-power.c
@@ -834,7 +834,7 @@ static void macsmc_power_remove(struct platform_device *pdev)
 }
 
 static const struct platform_device_id macsmc_power_id[] = {
-	{ "macsmc-power" },
+	{ .name = "macsmc-power" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(platform, macsmc_power_id);
diff --git a/drivers/power/supply/max77759_charger.c b/drivers/power/supply/max77759_charger.c
index 9bb414599f16..c606d7bafcb8 100644
--- a/drivers/power/supply/max77759_charger.c
+++ b/drivers/power/supply/max77759_charger.c
@@ -754,7 +754,7 @@ static int max77759_charger_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id max77759_charger_id[] = {
-	{ .name = "max77759-charger", },
+	{ .name = "max77759-charger" },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, max77759_charger_id);
diff --git a/drivers/power/supply/max8998_charger.c b/drivers/power/supply/max8998_charger.c
index 418b882b163d..b0eda2b51e7f 100644
--- a/drivers/power/supply/max8998_charger.c
+++ b/drivers/power/supply/max8998_charger.c
@@ -188,7 +188,7 @@ static int max8998_battery_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id max8998_battery_id[] = {
-	{ "max8998-battery", TYPE_MAX8998 },
+	{ .name = "max8998-battery" },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, max8998_battery_id);
diff --git a/drivers/power/supply/pf1550-charger.c b/drivers/power/supply/pf1550-charger.c
index a457862ef461..41036f4cb64a 100644
--- a/drivers/power/supply/pf1550-charger.c
+++ b/drivers/power/supply/pf1550-charger.c
@@ -622,7 +622,7 @@ static int pf1550_charger_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id pf1550_charger_id[] = {
-	{ "pf1550-charger", },
+	{ .name = "pf1550-charger" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(platform, pf1550_charger_id);
diff --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/supply/rt5033_charger.c
index de724f23e453..536ab29b657d 100644
--- a/drivers/power/supply/rt5033_charger.c
+++ b/drivers/power/supply/rt5033_charger.c
@@ -727,7 +727,7 @@ static int rt5033_charger_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id rt5033_charger_id[] = {
-	{ "rt5033-charger", },
+	{ .name = "rt5033-charger" },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, rt5033_charger_id);
-- 
2.47.3

