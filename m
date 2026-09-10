Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DD748C406
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050799; cv=none; b=BUBUWqx9Eqofl0zSyDulo0j5/Wk9h2DkC8djV5JuB3+ZrvgDm2YTTpXhIo4GJngCnyZmD1InNSDEbv2lneRPEupLstf9KVPU0RIKbhrldTkr/FlBfCXraGB6EfWI+5NS6ttAd16ZVz56yLqF8OKU15JclaMweKgpGpsfUeFtIkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050799; c=relaxed/simple;
	bh=Y+EbhbTML1k5P5nFxGc2d0Dkc33XLseH6hvaVvM68bE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hIVO3hsq4nCxmzE2ReM0YlFri1dhAe71042Kqz9RPlE/Rwyjb3hAOP/4Zf5taRMPlHpDssojH8fV313Gu69L1vkIZqZwToW411rzisdFeluIa1Ey6zjtiw7GWj/85L5SuLe6bG0faTlZuIFsh5lu4OguVuYtbm/3HXxNfPvp0zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=mZO5g9iT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="mZO5g9iT"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so82247485e9.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1789050795; x=1789655595; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k4oHU8ITIzMNP9UDWWw41AJv+F3XStWFQL+oD2LuP+M=;
        b=mZO5g9iTW+MA1uvco4lo5rUq5uELPBeCg+ALkvR0OkMsSeBOukONJjzSJRWu7nSbVT
         HlK0B3KSffNdueKJipHRSSzRm5M10bah0jLx6Bpr2TFKxL282Kt+KktWUWQeZ0CFQM+f
         Yl/lW2T1A2uCWQj4LjBpGHwX+c6WxlHfHnZFFLnvXTzTaPhHlkgp/xxuibZlCw3qEohc
         lGU10npHiMLfBDbMaq1KRPHB0qr23+BIik2HlAgRjz7uCB4nANB8PPZjr+DTRFMtO7Xr
         AsyJZZuCEdITWolNDAY3Nrs7gK2sWaZYO5yHTUxKZRcymJekvbwKf0F4zWuSacxz8qsj
         tIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789050795; x=1789655595;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k4oHU8ITIzMNP9UDWWw41AJv+F3XStWFQL+oD2LuP+M=;
        b=mW1M/BCdqop3XkinB+E3HzeOVtJHRqK6hUzSP2njqtUVdh1N1ekjB7TPHzF4yk8YAx
         vE9HK0grWl1kFY6nc0VSglQsClpM1AnR67I59oh0/jdyEQ+8C+YGxWGqOJaPlP/9xW7k
         jSBJVwcUzwG0cjxlCpBpKOhpAQZYRYAXIf6IuZL3QCMPGf6xdkNepb5A4FmMs7VHrZAY
         sGc2i3QeEV0pAmUWQzFvkgMtQ93bzJ2RHA0t6W/8Dttk4WEXeF5xCJw78PqCqLI1Kx2P
         XFIxNtkIWyTPLdJ+0EYIK20naTCbzZQhILeicYJ+Ao6iMFew0dsmrhEW1inAB8r+ykeV
         FhQw==
X-Forwarded-Encrypted: i=1; AKwUvBxu566epCOBoQeV0OhCgV7MDy0jhcrRvdLJNAnoH6kdzXsY+HizG7d6afjUZC41otqUpQN1rE7EWw==@vger.kernel.org
X-Gm-Message-State: AFuF++l4rdcecJJPPVC3usj2m0ac/KxbFQi52WFQY6IM2S31bblO2m3s
	n3tC346DIr10l/P6lTHLPteMB27UGS6L5gPrnoxxjzU7Qus/HVrT9cbYtHnqFL2G8OQPO1uE8Jr
	XUR1ISAs=
X-Gm-Gg: AYBFou3R28tvJmJAH/8M5dg0Pphc4UHHNIegRZNcxlWPWmXMGn95x6kVeuQnecDo40O
	onWs7CUfgnn4OUdODw4/rC7N8mhtUJbu1vL9fDqEZ8G1YSnGFw55RMAzXSMujyaRinCd3mNFJoH
	swM+S4i3vAf0K4dICSj4PQcZogrnHxpWFW72lo8p5t0nigyiwKElGMBcvMg5h2BEIEkrOXB14fr
	0z4PtfOeAUZi99a9OMWQUrN1Tpzp4rsm9ZOkEfcIyHeitKxbv/7NcmpF7MCF1Zm2hr1byLhdsU0
	oG40fuyN+4spZz57t603JBrSqIQDqswbqXucvNI2T3rzykuSLN+WnKTmPOVNsympuPrzK5tXna0
	T3A1fOEbPaPeWFiLzAwIOphyvOGStZFOBOJMkPnCLXgkKW5MqVCdLNWIXoVNUAHLhNuJ6YCpmot
	Lw1E8MyGihYlAtbx8r5ex3sTqmZdl4xZIkzAdOLqHy4fWvjZUfgSwsLpYr0qpwu7eLCabslXu83
	Cp4mOevoZQIgerz92mqdB3r/S1kmli8LSmcjimCCJeA7qcnSBTzHyWVM9PPYo4=
X-Received: by 2002:a05:600c:c173:b0:49c:cedc:3c36 with SMTP id 5b1f17b1804b1-49cf82a514cmr441914795e9.16.1789050794823;
        Thu, 10 Sep 2026 07:33:14 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae. [2.51.220.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e5fbda49asm12537135e9.3.2026.09.10.07.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:33:14 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 10 Sep 2026 18:33:00 +0400
Subject: [PATCH v3 3/3] power: supply: bq257xx: Convert parameters setup to
 the new .init callback
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-bq257xx-init-v3-3-4e219a1a04a5@flipper.net>
References: <20260910-bq257xx-init-v3-0-4e219a1a04a5@flipper.net>
In-Reply-To: <20260910-bq257xx-init-v3-0-4e219a1a04a5@flipper.net>
To: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
 Chris Morgan <macromorgan@hotmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6721; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Y+EbhbTML1k5P5nFxGc2d0Dkc33XLseH6hvaVvM68bE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQt2j9Hse5PRvrq3bf3JKw/JvM2smPJqdBQkxD7j16n4
 39KPGWZ0TGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBU77BgZJjVzSOV3WlgIzdx8WQ1fftV0XPizV3bl93cMu3GQf15qn8ZGXprnJ+
 fjbpt465d/sGa7fK28kLrBP01DxYobVI1zg9sYwQA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Switch the battery parsing and hardware initialization from happening
inside the probe routine (after the power supply is registered) to the new
.init callback which gets run during the registration, thus avoiding the
exposure of a not-yet-fully-configured power supply to the rest of the
system.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 122 ++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 64 deletions(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index ab3519454193..2177cee29a4f 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -73,6 +73,7 @@ struct bq257xx_chg {
 	const struct bq257xx_chip_info *chip;
 	struct bq257xx_device *bq;
 	struct power_supply *charger;
+	struct device *dev;
 	bool online;
 	bool charging;
 	bool fast_charge;
@@ -1112,6 +1113,54 @@ static irqreturn_t bq257xx_irq_handler_thread(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+/**
+ * bq257xx_charger_init() - Initialization for charger power supply device
+ * @psy: power supply device
+ *
+ * Set device parameters during registration, before the power supply becomes
+ * accessible to the broader system.
+ *
+ * Return: Returns 0 on success or error code on failure.
+ */
+static int bq257xx_charger_init(struct power_supply *psy)
+{
+	struct bq257xx_chg *pdata = power_supply_get_drvdata(psy);
+	struct power_supply_battery_info *bat_info;
+	struct device *dev = pdata->dev;
+	int ret;
+
+	ret = power_supply_get_battery_info(psy, &bat_info);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Unable to get battery info\n");
+
+	if ((bat_info->voltage_min_design_uv <= 0) ||
+	    (bat_info->constant_charge_voltage_max_uv <= 0) ||
+	    (bat_info->constant_charge_current_max_ua <= 0)) {
+		power_supply_put_battery_info(psy, bat_info);
+		return dev_err_probe(dev, -EINVAL,
+				     "Required bat info missing or invalid\n");
+	}
+
+	pdata->vsys_min = bat_info->voltage_min_design_uv;
+	pdata->vbat_max = bat_info->constant_charge_voltage_max_uv;
+	pdata->ichg_max = bat_info->constant_charge_current_max_ua;
+
+	power_supply_put_battery_info(psy, bat_info);
+
+	ret = device_property_read_u32(dev,
+				       "input-current-limit-microamp",
+				       &pdata->iindpm_max);
+	if (ret)
+		pdata->iindpm_max = pdata->chip->default_iindpm_uA;
+
+	ret = pdata->chip->bq257xx_hw_init(pdata);
+	if (ret)
+		return dev_err_probe(dev, ret, "Cannot initialize the charger\n");
+
+	return 0;
+}
+
 static const struct power_supply_desc bq257xx_power_supply_desc = {
 	.name = "bq257xx-charger",
 	.type = POWER_SUPPLY_TYPE_USB,
@@ -1126,6 +1175,7 @@ static const struct power_supply_desc bq257xx_power_supply_desc = {
 	.set_property = bq257xx_set_charger_property,
 	.property_is_writeable = bq257xx_property_is_writeable,
 	.external_power_changed = bq257xx_external_power_changed,
+	.init = bq257xx_charger_init,
 };
 
 static const struct bq257xx_chip_info bq25703_chip_info = {
@@ -1160,58 +1210,12 @@ static const struct bq257xx_chip_info bq25792_chip_info = {
 		.bq257xx_get_min_vsys = &bq25792_get_min_vsys,
 };
 
-/**
- * bq257xx_parse_dt() - Parse the device tree for required properties
- * @pdata: driver platform data
- * @psy_cfg: power supply config data
- * @dev: device struct
- *
- * Read the device tree to identify the minimum system voltage, the
- * maximum charge current, the maximum charge voltage, and the maximum
- * input current.
- *
- * Return: Returns 0 on success or error code on error.
- */
-static int bq257xx_parse_dt(struct bq257xx_chg *pdata,
-		struct power_supply_config *psy_cfg, struct device *dev)
-{
-	struct power_supply_battery_info *bat_info;
-	int ret;
-
-	ret = power_supply_get_battery_info(pdata->charger,
-					    &bat_info);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Unable to get battery info\n");
-
-	if ((bat_info->voltage_min_design_uv <= 0) ||
-	    (bat_info->constant_charge_voltage_max_uv <= 0) ||
-	    (bat_info->constant_charge_current_max_ua <= 0))
-		return dev_err_probe(dev, -EINVAL,
-				     "Required bat info missing or invalid\n");
-
-	pdata->vsys_min = bat_info->voltage_min_design_uv;
-	pdata->vbat_max = bat_info->constant_charge_voltage_max_uv;
-	pdata->ichg_max = bat_info->constant_charge_current_max_ua;
-
-	power_supply_put_battery_info(pdata->charger, bat_info);
-
-	ret = device_property_read_u32(dev,
-				       "input-current-limit-microamp",
-				       &pdata->iindpm_max);
-	if (ret)
-		pdata->iindpm_max = pdata->chip->default_iindpm_uA;
-
-	return 0;
-}
-
 /**
  * bq257xx_charger_probe() - Probe routine for charger platform device
  * @pdev: platform device
  *
  * Probe the charger device, allocate driver data structure, select the
  * appropriate chip-specific function pointers, register the power supply,
- * parse device tree properties for battery limits, initialize hardware,
  * and set up the interrupt handler if available.
  *
  * Return: Returns 0 on success or error code on failure.
@@ -1222,7 +1226,6 @@ static int bq257xx_charger_probe(struct platform_device *pdev)
 	struct bq257xx_device *bq = dev_get_drvdata(pdev->dev.parent);
 	struct bq257xx_chg *pdata;
 	struct power_supply_config psy_cfg = { };
-	int ret;
 
 	device_set_of_node_from_dev(dev, pdev->dev.parent);
 
@@ -1231,6 +1234,7 @@ static int bq257xx_charger_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pdata->bq = bq;
+	pdata->dev = dev;
 
 	switch (bq->type) {
 	case BQ25703A:
@@ -1255,26 +1259,16 @@ static int bq257xx_charger_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(pdata->charger),
 				     "Power supply register charger failed\n");
 
-	ret = bq257xx_parse_dt(pdata, &psy_cfg, dev);
-	if (ret)
-		return ret;
-
-	ret = pdata->chip->bq257xx_hw_init(pdata);
-	if (ret)
-		return dev_err_probe(dev, ret, "Cannot initialize the charger\n");
-
-	platform_set_drvdata(pdev, pdata);
-
 	if (bq->client->irq) {
-		ret = devm_request_threaded_irq(dev, bq->client->irq, NULL,
-						bq257xx_irq_handler_thread,
-						IRQF_TRIGGER_RISING |
-						IRQF_TRIGGER_FALLING |
-						IRQF_ONESHOT,
-						dev_name(&bq->client->dev), pdata);
+		return devm_request_threaded_irq(dev, bq->client->irq, NULL,
+						 bq257xx_irq_handler_thread,
+						 IRQF_TRIGGER_RISING |
+						 IRQF_TRIGGER_FALLING |
+						 IRQF_ONESHOT,
+						 dev_name(&bq->client->dev), pdata);
 	}
 
-	return ret;
+	return 0;
 }
 
 /**

-- 
2.55.0

