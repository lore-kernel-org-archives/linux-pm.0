Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E781DDC35
	for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2026 00:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781396118; cv=none; b=ASvnjYljaE63TG6uZzFQAZrQg9MMOM73ZT+LVpXxxjpAQwNtI8Y90wN3/NqHOQeDEVmDhNRf4nedl0ElFagoAbS4yar9ZSbq/4qHkqRcI9IV0Dbyqff9ng4ilPh8hPX2sa0uzpy1B/OT67Z2FsPi8YVOPckLETWZfr54lmDR3NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781396118; c=relaxed/simple;
	bh=/ruWEd/vfnA9ugQfsZ4yEgYnFaThGcFjBpkXVlc3aAw=;
	h=Message-ID:From:Date:Subject:To:Cc; b=W0g2NnqBRG2qPrpa5aG1h1d8PUYuxmpqQ7ULBIAOWlrv6azzCLHaElUVcbFnY82xdG37yl4hwC1Z3C5SNC8cJScDHaQpqDTuWa+xZug/Bx6k6L8OaA9OdlF1N7zBJ54fKuDY6jxj2Zz+4sB4KWvI+jJcg+8arMx05zCABQWK5zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/0wk1+O; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/0wk1+O"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf20f6be6bso15983165ad.3
        for <linux-pm@vger.kernel.org>; Sat, 13 Jun 2026 17:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781396115; x=1782000915; darn=vger.kernel.org;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUVnT2tX7Y99O76KPHUYUD1f52zrxGJfCA6Tlu+Jsko=;
        b=s/0wk1+O/nMOgY3/ozW36pVFFewCpqeN0PFhCf2GRlnxDoALCr6Flx5bJR0w18nDEX
         66F8JWaDR7kmKZ8Y3KUg60VtE7XHOBFy4Z7rtzgMs5nQl86+jnLDG7yNYqw1gkN56CeL
         qf8lmTkFjkQoRrJDy2WSsDFgbKh6lM1oiHrNBpAkFHjZuaPvFZkPD7Lqcq9FSeSTdd6a
         yXp0IzufiDfxXMWgd4QyhJcZZ7uUmY1SKIQggtiI1C+d6EMotbxDLU3gcv4XHV8sm38s
         WoTOEwYkiooUxSK9AzzEgO+SYTjI0D62ln3PaHsI4asaTWvyjhG59LvSKV2muSLWdALY
         YPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781396115; x=1782000915;
        h=cc:to:subject:date:from:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SUVnT2tX7Y99O76KPHUYUD1f52zrxGJfCA6Tlu+Jsko=;
        b=K+elCtvQlC8S0sf1ZLXlQekUskwn1OeplP3XNgyOQ+n3o6ptLNFjBdFziOi4DR9JFC
         CPxc2U8bidIMnbzU7L+koeLzuwo/NFYjuo6XRAncibxYCB9ezlRcYCmXhePrPDGmvbLJ
         HkESJiKrnLe9vz1+/1vKpPIY23mqHRhucT8EDhNP1AtFNc8IopQdcIXBpsD++ASV4Q15
         620nav9RsTFDIqjt024HlClBpXot+xMP1mZYFhP3tyVv7MiGmlEllMkssCdP8pD9bD92
         tOQVc8AMuRqqeJWcFMcwpmDCLejxzCQfaOmRDmfKQIn5xhSKoInfIw/MPvJCx1v7gAiv
         bQaw==
X-Gm-Message-State: AOJu0YxoEVoHGZHqpp64hb71Zcfyx00Fa7pTmsaDP9VUk+fL4muBAk56
	4rgBR0Qb17cGHuIo4V3fDzJTvqu5NptgpefKZFzzJbuc+3EI+pXnqa60BIGCDjaDWlA=
X-Gm-Gg: Acq92OHVtdFcalc8N2Gsguh44ZcymzDOI09+U/h4WWWoxGSzK+jqHZIEaGFIvgI+5gB
	kcrYZe2aky789NBPO8xy53BkojgomMu1obnY6fY7jEp8fnhGAmSjG7e52R/HVSXdvm3bLkbEKDD
	FvQrc3welLBs6j3ClSvIEw7lrLXojn2pB5dQTIdENdCQ+gH/JOZBJ01rROD4BYgl+P/nfcLGI5E
	yimwpotl5/wwePuk+5eQCwmGma5DtulPaokmauZCKXjhsqZA2rUeVVL7v9T8d4ktyp9EXCeKyGw
	lC6j/v9pLxpoE67T9ehyHcBtFVOewTuhKjkFGLdXzTa9MV5rKwKGR7d1u6+QRXHw295GNTiAGUR
	eIzIhK70gsfL40NLOciY1MHyoQQIg+To/IZsUazUK/QE9t6e13UqouELmZDj2PzIyFZBKIzokoS
	asLGchEWT6NKulefHHieTdMAdP8iI=
X-Received: by 2002:a17:902:d4ca:b0:2c6:5bae:f9ab with SMTP id d9443c01a7336-2c65baefa96mr60612255ad.22.1781396115356;
        Sat, 13 Jun 2026 17:15:15 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4330782b2sm63552385ad.67.2026.06.13.17.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 17:15:15 -0700 (PDT)
Message-ID: <6a2df293.6b2684af.263065.81b4@mx.google.com>
From: "Wayen.Yan" <win847@gmail.com>
Date: Sun, 14 Jun 2026 08:14:28 +0800
Subject: [PATCH] thermal/drivers/airoha: Fix FIELD_PREP using wrong mask for
 sensor interval
To: linux-pm@vger.kernel.org
Cc: Rafael J. Wysocki <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Christian Marangi <ansuelsmth@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

In airoha_thermal_setup_monitor(), the TEMPMONCTL2 register is
programmed with:

  writel(FIELD_PREP(EN7581_FILT_INTERVAL, 1) |
         FIELD_PREP(EN7581_FILT_INTERVAL, 379), ...)

Both FIELD_PREP calls target FILT_INTERVAL (GENMASK(25,16)), so the
second one overwrites the first. The sensor interval field
SEN_INTERVAL (GENMASK(9,0)) is never written and remains zero.

The comment above states: "filt interval is 1 * 52.715us, sen interval
is 379 * 52.715us", confirming the second value should go into
SEN_INTERVAL. This matches the Mediatek auxadc_thermal.c reference
implementation which correctly writes FILTER_INTERVAL and
SENSOR_INTERVAL to their respective non-overlapping bit fields.

Actual effect: FILT=379 (should be 1), SEN=0 (should be 379).
The filter interval runs 379x too long and the sensor sampling
interval is uninitialized, causing incorrect thermal monitoring timing.

Fix by replacing the second FIELD_PREP's mask from FILT_INTERVAL to
SEN_INTERVAL.

Fixes: 42de37f40e1b ("thermal/drivers: Add support for Airoha EN7581 thermal sensor")
Signed-off-by: Wayen <win847@gmail.com>
---
 drivers/thermal/airoha_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index b9fd6bfc88..e8a33234e0 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -403,7 +403,7 @@ static void airoha_thermal_setup_monitor(struct airoha_thermal_priv *priv)
 	 * sen interval is 379 * 52.715us = 19.97ms
 	 */
 	writel(FIELD_PREP(EN7581_FILT_INTERVAL, 1) |
-	       FIELD_PREP(EN7581_FILT_INTERVAL, 379),
+	       FIELD_PREP(EN7581_SEN_INTERVAL, 379),
 	       priv->base + EN7581_TEMPMONCTL2);
 
 	/* AHB poll is set to 146 * 68.64 = 10.02us */
-- 
2.51.0


