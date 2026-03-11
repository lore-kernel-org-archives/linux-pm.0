Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71703E0C58
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230201; cv=none; b=SuegMZoMlKN07lYPcsEm9hzyZhnmEEiPdDE7Gs3qEOalpKhQpLVzFuaV0QB+NGjMSlCJyV4BRyg1uk029SoQuo5QnnPGLhOFZRkQk6sYB4I/pPWI1N34MfmGKElPo7tXUAPng7yDNvewrzvO6fdNMw2ru9AHGw+q8RS/sxpVQaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230201; c=relaxed/simple;
	bh=K/K91eQQ75phcINLj4DBBQbD0ofWablCORf9BgG8obM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fKOl0R6nSh+KS4jW0s5xbQQ+kd3bWbfi+G5ouKQE4LlUbXToRVP+Fj6VfT6+g2EkZLd/V5VMI7Cw+iKYFN6Ms914Z1DhRxLklLkkEhjhdhRtBrpzNypGOwm7FluYPiNzvHDvQcLbcyh6CiC8eAOmeRNW8GNsbNa/73B0/ERm3T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=LzpP/O27; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="LzpP/O27"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48541edecf9so26776475e9.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 04:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773230198; x=1773834998; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8b97w0FIxP+iQSlY9+U8NDMrKZX5YXrCInQTxcuoNL8=;
        b=LzpP/O27YW7DukXMieulBCJYDHhyhYhnbNWoNrY6cbJdcWez9OeJQ92TMk+P9kRVRk
         I5dMws7OgQFZ9C3EjX158ubq0r2Vp0Rmz1xrYSxSBGbk1ThXbfmQESoLg5CeQQzrL6Sb
         vSf1DHso40dEjYpXzIKhC7nBaQlf0MzzDxBIER17V6aYDtARpS30eZbpPmNR67RR3F5q
         NJug1s3ZKNIdpZlFpUxXL0YtLiz6C4lurrNwwqmrpRtgbccnfxu+cTdY1Ap0CqWaovXc
         PUyj1RYyb1ccMG6g1WBA3zCOO5m+lS+SGNeDlBDcwQNcYHJTCBlqEaLkN63U5fjkY030
         nujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773230198; x=1773834998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8b97w0FIxP+iQSlY9+U8NDMrKZX5YXrCInQTxcuoNL8=;
        b=hJJx5X2ay5S6G57YEFuaKUcFQIzuDIn09PZe1wUsvuNaAJBj+1HQSlk02sv3tUeTkd
         17Z3RbJa/bYjRY47w8KnxcqbGmH8r0O3EuFhzjyy7QyXCZ/EqmlGdbkN41BkpmKvxvk7
         ubGxq5+C5VC8kdQPH4eEirbAdHjeDkepuX6azpNYbG4AnS73PfnrgPB+tH+IP+svJaeP
         v1PHr5/AxQcXYK+UlSX1FrzdVDrmaWFFrVN/DWy47nTzyCnStYAq+bQ6K4ups7/zI0JZ
         qofhEocfRcblzJ1gS57pKXidiYBRER0ZYcFoOoG+2kLunfB6l5HDSxygFc4wzwLnu6up
         lXQw==
X-Forwarded-Encrypted: i=1; AJvYcCWzXoFL7MaLb5Vs5GL9yYoyq2Jl7CApT0UPZbBszfCwyqF8NQ7O+azpWpdfXJWBja6GPglpositzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvwnZXE+7Ky9zH91KqKv8yztmykqXwi6Cke+MiQr0mCrHT5ppO
	vstMAZbpCoWuhdZ0LC4uC8dRXKNCIO28Q8420tp66lABBGEXOLoIPq/4RLt6aoTuS8s=
X-Gm-Gg: ATEYQzw9mU7AufI/djz/vNQf7eOc9i/EWRaziKoj9KwnM1azsnx3nRYplzQQvxc2vlW
	gmVB9ChUpIF5IYcvgxhcRS8k2ay06NQWgCGSXpXNSN++Cz2QTb1ORzS3nRLnr8P1BdpFu7qJ+9u
	AxD6VRtuchYf7CGlyGknOeS0+W0ioidZJwBoDSu6zzVRFF97CQjeohwv3OLQWVqMaMgOTcciyWK
	WfDsxgeVZs9Dq8AZcMe2jM9rgFtF+Frx+bq0dS5AQ28/iUHirkXYcs6Z+lG46sN+nvfZlEU2Ya5
	qbs28pnR3zD/Nj/1kAFjZfBUFJaBZei/JFS13AHZuQpiqYeB2J/1Nx8xAMVHToHWytyFF7/qoGl
	Df2kCDsWL1kmkKT4rYHXoyMDZxflC9wC2z4tdWbYds2puI+VfJk4ZRvvh+0QLvRpizRABOA/Ol3
	TqS/xxg2PT8PEUzbU8vhvrzO2hVDM+UUomjV9UqYebjYZoH1bM0uPMNst9+fKK9mkQuKDB9jZoY
	0fWi8mv6zeil+3Y
X-Received: by 2002:a05:600c:a08:b0:485:2c61:9459 with SMTP id 5b1f17b1804b1-4854b0afb48mr38299945e9.8.1773230197237;
        Wed, 11 Mar 2026 04:56:37 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854ad5416bsm39586485e9.1.2026.03.11.04.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:56:37 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 11 Mar 2026 15:56:20 +0400
Subject: [PATCH v4 07/11] power: supply: bq257xx: Consistently use indirect
 get/set helpers
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-bq25792-v4-7-7213415d9eec@flipper.net>
References: <20260311-bq25792-v4-0-7213415d9eec@flipper.net>
In-Reply-To: <20260311-bq25792-v4-0-7213415d9eec@flipper.net>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4242; i=alchark@flipper.net;
 h=from:subject:message-id; bh=K/K91eQQ75phcINLj4DBBQbD0ofWablCORf9BgG8obM=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRujEg+9Kgp+p7OmthNUvZb1s1ysl8VH2wpuUKVnaHf7
 sH+HrPUjoksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0FDHWMeIgYtTAKbaOZiR4SCHVptEYfyd7hW+9QcfCh/isdK4/G2O0Oq1yZfS05j2XWBk2GpwTFS
 pVzKUnfVS0tQl/3/nPFglo+Bu0h7iWL3fP9KRBwA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Move the remaining get/set helper functions to indirect calls via the
per-chip bq257xx_chip_info struct.

This improves the consistency of the code and prepares the driver to
support multiple chip variants with different register layouts and bit
definitions.

Tested-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index 39718223c3f9..0765673728e4 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -22,18 +22,30 @@ struct bq257xx_chg;
  * @bq257xx_hw_init: init function for hw
  * @bq257xx_hw_shutdown: shutdown function for hw
  * @bq257xx_get_state: get and update state of hardware
+ * @bq257xx_get_ichg: get maximum charge current (in uA)
  * @bq257xx_set_ichg: set maximum charge current (in uA)
+ * @bq257xx_get_vbatreg: get maximum charge voltage (in uV)
  * @bq257xx_set_vbatreg: set maximum charge voltage (in uV)
+ * @bq257xx_get_iindpm: get maximum input current (in uA)
  * @bq257xx_set_iindpm: set maximum input current (in uA)
+ * @bq257xx_get_cur: get battery current from ADC (in uA)
+ * @bq257xx_get_vbat: get battery voltage from ADC (in uV)
+ * @bq257xx_get_min_vsys: get minimum system voltage (in uV)
  */
 struct bq257xx_chip_info {
 	int default_iindpm_uA;
 	int (*bq257xx_hw_init)(struct bq257xx_chg *pdata);
 	void (*bq257xx_hw_shutdown)(struct bq257xx_chg *pdata);
 	int (*bq257xx_get_state)(struct bq257xx_chg *pdata);
+	int (*bq257xx_get_ichg)(struct bq257xx_chg *pdata, int *intval);
 	int (*bq257xx_set_ichg)(struct bq257xx_chg *pdata, int ichg);
+	int (*bq257xx_get_vbatreg)(struct bq257xx_chg *pdata, int *intval);
 	int (*bq257xx_set_vbatreg)(struct bq257xx_chg *pdata, int vbatreg);
+	int (*bq257xx_get_iindpm)(struct bq257xx_chg *pdata, int *intval);
 	int (*bq257xx_set_iindpm)(struct bq257xx_chg *pdata, int iindpm);
+	int (*bq257xx_get_cur)(struct bq257xx_chg *pdata, int *intval);
+	int (*bq257xx_get_vbat)(struct bq257xx_chg *pdata, int *intval);
+	int (*bq257xx_get_min_vsys)(struct bq257xx_chg *pdata, int *intval);
 };
 
 /**
@@ -490,22 +502,22 @@ static int bq257xx_get_charger_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
-		return bq25703_get_iindpm(pdata, &val->intval);
+		return pdata->chip->bq257xx_get_iindpm(pdata, &val->intval);
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
-		return bq25703_get_chrg_volt(pdata, &val->intval);
+		return pdata->chip->bq257xx_get_vbatreg(pdata, &val->intval);
 
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		return bq25703_get_cur(pdata, &val->intval);
+		return pdata->chip->bq257xx_get_cur(pdata, &val->intval);
 
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		return bq25703_get_vbat(pdata, &val->intval);
+		return pdata->chip->bq257xx_get_vbat(pdata, &val->intval);
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
-		return bq25703_get_ichg_cur(pdata, &val->intval);
+		return pdata->chip->bq257xx_get_ichg(pdata, &val->intval);
 
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
-		return bq25703_get_min_vsys(pdata, &val->intval);
+		return pdata->chip->bq257xx_get_min_vsys(pdata, &val->intval);
 
 	case POWER_SUPPLY_PROP_USB_TYPE:
 		val->intval = pdata->usb_type;
@@ -633,9 +645,15 @@ static const struct bq257xx_chip_info bq25703_chip_info = {
 		.bq257xx_hw_init = &bq25703_hw_init,
 		.bq257xx_hw_shutdown = &bq25703_hw_shutdown,
 		.bq257xx_get_state = &bq25703_get_state,
+		.bq257xx_get_ichg = &bq25703_get_ichg_cur,
 		.bq257xx_set_ichg = &bq25703_set_ichg_cur,
+		.bq257xx_get_vbatreg = &bq25703_get_chrg_volt,
 		.bq257xx_set_vbatreg = &bq25703_set_chrg_volt,
+		.bq257xx_get_iindpm = &bq25703_get_iindpm,
 		.bq257xx_set_iindpm = &bq25703_set_iindpm,
+		.bq257xx_get_cur = &bq25703_get_cur,
+		.bq257xx_get_vbat = &bq25703_get_vbat,
+		.bq257xx_get_min_vsys = &bq25703_get_min_vsys,
 };
 
 /**

-- 
2.52.0

