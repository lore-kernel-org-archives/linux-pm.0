Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA8B572681
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788968535; cv=none; b=MG36/PbHcAIhqb0MpAq9gdz+ap/7VTBu8m1YDVtAFFafZ49vB6wNw885/ShVojRsk2SIRS9B8ZRK7A1OevghsBfLt1z+Xthdqwi8VCpFqEyNCDu/aiKz9CdhcZ8nIosFqgFPHLITcTpIvRGqx/UrplIDC9c8yEYXLPB+dW8KJ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788968535; c=relaxed/simple;
	bh=puqbhfoUN1h0hVmNuH0sDEYWMQDzUtBnG/jCV80xhEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KE9SKjLKH0ef9/phkqLC1rVSOEMRL3kyWj9p+JmEEMxJcc3JPTs1yL414nkJoL0ILIoBR8vVQFwrWtN03sHC9UE5Zx70pHwDgZGT0bJrgecj0Nrzp2DwLpJd9s8YRrg4uGcE+pMx+MbowYSHplmL7lfQW1X05Dx21ATTG7pjal0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=cQ+wrfL/; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="cQ+wrfL/"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cc9f581c4so8594445e9.0
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 08:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1788968532; x=1789573332; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xZ2NMqgSdO9GLsjUUfKBwt+Y9+3g0pO5mWSs9o4+92M=;
        b=cQ+wrfL/2kn1Rwt8oJhk898KpHs/AVKnITX733vwmmURdGklXbf0dEEupISDzOtRyC
         XArGwPt72724nFN2UuGZ76ZDtjacEeDC8KWehRQPIxnApoG1OxAGIOj8K3TmE3mJ5OE9
         ffWwlIF6msvO170hz/ZW31zDl8I3gsVQG1BOs7LtECYrVo2Q7YBMJWyswggx0y+W7YdN
         6caXsCkMyHecTAAoCIE5R+52yiktrRV7Cak9NP3acVXW1HJjAwtZaxSzv3IO0kzqVJ87
         ySSzTkonyy17pL2+1IPfUC3Vu9LU3GVaKmyrRZdFPcUcSm1ouDDwZ4+gCF7CYu7mq6uN
         69nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788968532; x=1789573332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xZ2NMqgSdO9GLsjUUfKBwt+Y9+3g0pO5mWSs9o4+92M=;
        b=Gm9c3ig3nBFUk++1WLrNJkR/QjkQZx7EqcPPmElxIdwR391q9h4ByRNnOiA66VT+be
         fkiwa73pQdNG3zPyV2DqytmLOuUHWxE26pVCPnSd5h3cXV63z7fthRUC4fY1LlREEttk
         O+vryz2cTwmCaZkul5cN5Udvo4NUUH8QNtnEAU4lLGvxTKbGVRXoWZcyYtTHQLuLeZZ5
         CElYS5MZ6POMkqKXSS5jWchgRkB6WRLf+4/VNWw1Jh3nHwhed6TWupxW/oHHFe1Enf+i
         8ZopXwHIkShPTNnjL4+lxgNLGZhaD+S69TXITT+Lv4djh1OQybnjz/Tqx2n0leyynnOi
         vSgQ==
X-Forwarded-Encrypted: i=1; AKwUvBwKSbEjecMR0DiqZUyIp600+ty1M1gP3XT7KzI1rm6xMm16YEWpC9o4I1Ny1BaaqAPm169Hc9Oz0A==@vger.kernel.org
X-Gm-Message-State: AFuF++n9giBqZkCZL3j4hrE/CRoS175+Vf3h50GI4XUvGp07uNxDnmKu
	9qtwHCzoDv/aNUIs32yRbav7b2QjUONdM2ILqG0Rw87KF3ea7Cml0wRFLWGM4XcX7kM=
X-Gm-Gg: AYBFou1HqhRPgMejYn5nKNv/D+P13/Sxso1s3gCy556QN0PHB9sCnhEz67S6DBUJBSI
	3wsdgBryNTjRojyDs2nSnuJa6YcxNxVqkiHZCU5Wnk6BzdLIkH4tqFjEYiDKKZLqCTKaUE7wb5i
	D+sijR2nuMohfY57+DyWMcZSdqC2xSXTiUjKq9rNo3Z/dFz2hemwcz5rYuWfw9jXqwjttjYvMc3
	vA611u78mZs9E95B1OysMTHv/6Whbcx2UAoPPsGs3MTNxVE8Lpmr5oORRMAXKYBAjTUcuEYRxbV
	uSZ3Lfj1saNr/9Z8jFVJb1PkFX3mbO+UTTWSg2l50w+NTTajSlB7r6ls2Ck+IPT0mJ5cRFFzT5m
	DRM8MfHcGV3gzos0DjTV8QMaXYYdxh+k9CzQAB6aZrtyxokH1FzKh+3p/i8MFn6LfS9gjqNYJrW
	OzMwKFVv/2PG+zfHFGKj3GzlmLpj371y9M5RIADG7oeRUHasKdKA5wT+dyRVr44m118ZSPXI0mi
	gM8PKlFHTrYVD97gpKTzbBrIwEB6/OSpyyICdQ+p7+XWRGHOiE=
X-Received: by 2002:a05:600c:6216:b0:49c:799a:177b with SMTP id 5b1f17b1804b1-49d1754394emr171890905e9.2.1788968532280;
        Wed, 09 Sep 2026 08:42:12 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae. [2.51.220.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7740d44sm1042068015e9.15.2026.09.09.08.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 08:42:11 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 09 Sep 2026 19:41:46 +0400
Subject: [PATCH v2 3/4] power: supply: bq257xx: Use psy directly instead of
 driver data
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-bq257xx-init-v2-3-deb4076b1f02@flipper.net>
References: <20260909-bq257xx-init-v2-0-deb4076b1f02@flipper.net>
In-Reply-To: <20260909-bq257xx-init-v2-0-deb4076b1f02@flipper.net>
To: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
 Chris Morgan <macromorgan@hotmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213; i=alchark@flipper.net;
 h=from:subject:message-id; bh=puqbhfoUN1h0hVmNuH0sDEYWMQDzUtBnG/jCV80xhEI=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQtrHNL/Mq6LiMnM/fkt50nlaPbfCsCi5lWTbwt5ZwbN
 zfh7KGrHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEz17ySG/5XLr5durz26SHHOlbz7THMuL7k55d2VbQccd2eKsFsVdX5gZPik0nn
 krqWlkBrLLD3Nits6279w7ebdp++8/UTxPJ7FvnwA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

bq257xx_external_power_changed() is handed the power supply it is called
for, but passes pdata->charger to power_supply_am_i_supplied(). Those are
not equivalent during probe or teardown, and a supplier's changed_work can
reach power_supply_external_power_changed() when pdata->charger doesn't
point anywhere meaningful (e.g. freed memory during teardown).

Use the psy argument, which is valid whenever the callback runs.

Fixes: 1cc017b7f9c7 ("power: supply: bq257xx: Add support for BQ257XX charger")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index b735bb02a8e0..ab3519454193 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -1055,7 +1055,7 @@ static void bq257xx_external_power_changed(struct power_supply *psy)
 
 	pdata->chip->bq257xx_get_state(pdata);
 
-	pdata->supplied = power_supply_am_i_supplied(pdata->charger);
+	pdata->supplied = power_supply_am_i_supplied(psy);
 	if (pdata->supplied < 0)
 		return;
 

-- 
2.55.0

