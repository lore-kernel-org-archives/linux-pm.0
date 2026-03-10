Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E45F43E4BE
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134965; cv=none; b=JNtmFSZkz/F1n1MqIuC2UG/8iPHrMdpoADJdSOnwBwtWk6i+S7CyQFq1dRW7icchb+DIyN86f1QH83PIPHfd3ix94hlql7VVMbKLqviXPC3hKXF/Bim6RbPUp0OZ4g1LKso3dzTRrgg/Iv6Qgm0KX33A93MfM8hIGL+X6/B7uEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134965; c=relaxed/simple;
	bh=sw5rQKvX/kWusd9n6LHXdCUy7V/VOBCXkbjfWoaPsis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bmooJnRnF1he0LLwYdYmT6ZNc4qXLwtDHKVvShfUNlqr2zgOWIuDCbXsTs301Dho6SDq9D/CxfP6nOjSoAx+eTvTeXtYpRHiqVNX1X53AyZPZhqiW7U3DMb3IwcfEVjiNEdzVRReScdACceI857UGzVpgW44I5R0Ao0+GSMs+FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=vOUjKtG3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="vOUjKtG3"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so28735775e9.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 02:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773134963; x=1773739763; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmE6i8Plda/pdmCIIVlRHiRV9OKzbx1wU/pBBf22f9M=;
        b=vOUjKtG3KT5CfgrNcExROZczFImtw+IEH92dq+pxIXqDw2SvV6IgyPJ0wW4zloG5HG
         f5S9wIrFUpsbjiDvGd6T1sBfq/JYevqZWG+rGDY8XrN1pePNv2gSzIzK2KqSUNf0BHVk
         m9UNrwow4y7h37ISVajMqx1AIxC0/kYHQhafjMavdwcE2U//Egx0kXQZTuU21GfTX8qj
         k9c8PLMIc5gsSZ3+7gMqSAAsiS0IlUQC42/OT2b+G7hNSq+ZnMS8DV9FUFFRbOdhdHcD
         5CREXpRT4kXhMH/7AFmsi5IWY/LPr9tJTbvF2fgAzrwHC2QYXiqFZZfGOzUbSakBv8Ak
         mQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134963; x=1773739763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jmE6i8Plda/pdmCIIVlRHiRV9OKzbx1wU/pBBf22f9M=;
        b=DiPKj3giJQNl1/ZNRxN1TnxLRFmZ0exVI5iOFCjlGy/HOSTS1AdcERK+waBR2A2qPx
         ut1hNtwbCXyne0XmRCI7hbxMEL+8WMSIKrK9ZOsgjaRmPU04UIu7kYzdWvqgAnfn2wtQ
         +cxPvoTFz1+Ah7+/cWDkMDvEmjlnXxif0ZF5JzuLFmBZwSYAesw41aiFiKVviMSseirq
         Z34ZHlwrHKLymC7A8S9iI8+L1G9rD/aNl7lqww2hCFNx0JD0ZeFzbvS8suQO09xfPn7i
         z8f5V1LpinTBAd+QaPEaeF84GNa4K8QcG151BbbBk0KyLz74kfK5iiJvGrX+Pn51+j8n
         A2Lg==
X-Forwarded-Encrypted: i=1; AJvYcCVud6GMfYPAoSyvu9NSFMKtIGfalwQyZgoKH54Llx8watZ/lIQmnfbWEkb5xzuZGHHu0+nG/TpIig==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7lXLc0fXlYPNthl3pM6oF/xWRp7vpRPIZ+lrPiFcrJ0usv6b+
	sz60dX2njDJgFOQKc7PGuGLYCpzHhy7SSCA8RJfXokKVc7ht7IVoQge/FYzHJ/ECgv8=
X-Gm-Gg: ATEYQzymExAR6iQkLlgWNAfOfl6md8MTj2EUxz/v4laiyfr4/wsRKgAOKWRaasZuJNm
	8nhvHhmihfUrjBHjacxpGGj5kNApn2seZMkcPFw9NUfnegNWTbduPfpv4YY/zELOX4+Gv+2giFI
	8bHcC/cy2V6IqV9DRHkJPjhAkkjy8SwWDX7G2DWUwiO00cOcYiJhVFBCNmVjFqaCIZD4/y2vvsa
	tJ2v1hHcss5qJKMmuvnApPeWFz5e+QrwCTUSv8ONwpajF9K0+qQjYDvtjQnZwcTZwAV51VYympu
	C/cFZZXyfN7knn6M02Z9x1mUpa44vsSepXAlbAvhgpRa9qrE7X958ygozXo3HuoR7EcXUabRL3e
	K/Og6Db6A4f1MF4u387Tb0Vm03V1z9M10pHeP2QMvcaFS+z2wMCtxQXv3p5Mx2zDMVtJj3yW4qF
	5PuWAZ4yQAgQ5J2lTlUeBjRPmf19P/ryLPxP12NZzw9tAFuHjwZjQTJlX53hQPXzLAaJVHCpZ2t
	4Gpuw==
X-Received: by 2002:a05:600d:8450:20b0:485:40c6:f526 with SMTP id 5b1f17b1804b1-48540c6f6b0mr46904115e9.26.1773134963152;
        Tue, 10 Mar 2026 02:29:23 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48529f019a4sm104214285e9.12.2026.03.10.02.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:29:22 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 10 Mar 2026 13:28:30 +0400
Subject: [PATCH v3 06/11] power: supply: bq257xx: Make the default current
 limit a per-chip attribute
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-bq25792-v3-6-02f8e232d63b@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1666; i=alchark@flipper.net;
 h=from:subject:message-id; bh=sw5rQKvX/kWusd9n6LHXdCUy7V/VOBCXkbjfWoaPsis=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSuf5LI91X9g6CVhNWfrl31XKcYVKtPCd9kL+hrmmee3
 3iQo7y2YyILgxgXg6WYIsvcb0tspxrxzdrl4fEVZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNQx1jFi4OIUgKmukmJkmPTmrOzJKaFLW2q43SVUV1hd7pnYGHs7210irTeN9dwiV0aG0xYvJD+
 8Tti7Y4aT6CudPUaq7/as9dF57nhvoZL9H2ZFJgA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Add a field for the default current limit to the bq257xx_info structure and
use it instead of the hardcoded value in the probe function.

This prepares the driver for allowing different electrical constraints for
different chip variants.

Tested-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index 7ca4ae610902..e14dd16f9d08 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -26,6 +26,7 @@ struct bq257xx_chg;
  * @bq257xx_set_iindpm: set maximum input current (in uA)
  */
 struct bq257xx_chip_info {
+	int default_iindpm_uA;
 	int (*bq257xx_hw_init)(struct bq257xx_chg *pdata);
 	void (*bq257xx_hw_shutdown)(struct bq257xx_chg *pdata);
 	int (*bq257xx_get_state)(struct bq257xx_chg *pdata);
@@ -627,6 +628,7 @@ static const struct power_supply_desc bq257xx_power_supply_desc = {
 };
 
 static const struct bq257xx_chip_info bq25703_chip_info = {
+		.default_iindpm_uA = BQ25703_IINDPM_DEFAULT_UA,
 		.bq257xx_hw_init = &bq25703_hw_init,
 		.bq257xx_hw_shutdown = &bq25703_hw_shutdown,
 		.bq257xx_get_state = &bq25703_get_state,
@@ -675,7 +677,7 @@ static int bq257xx_parse_dt(struct bq257xx_chg *pdata,
 				       "input-current-limit-microamp",
 				       &pdata->iindpm_max);
 	if (ret)
-		pdata->iindpm_max = BQ25703_IINDPM_DEFAULT_UA;
+		pdata->iindpm_max = pdata->chip->default_iindpm_uA;
 
 	return 0;
 }

-- 
2.52.0

