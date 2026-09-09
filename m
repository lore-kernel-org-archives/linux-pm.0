Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2BA576EBA
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788968538; cv=none; b=cQI2tjo8oi076nRwR66JHGElsaDzD99ywuf3RRcH5gdhkbTz0mlqjAfabcyDJn74H0FO3v5fSq2+0s6DFSTV61Z0LoCYx/DX4keEW63qT+sOsmBNWJ6dl9wKlY44SgGhJKrgL91efYU5hFOGk++ewckcNttMinA8L7xGnh2Yaes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788968538; c=relaxed/simple;
	bh=hq4YQs4noVM+rPsJgnR/8SpC8jKglHwZ0DNfFfqjORo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SOKMUd2I5HOvp95tJTJ+bBwuIKFZmmIy33ArawE0/GLn2wVSWW1C1xRgBpVKBtZQmlaUJL8O4Y5IF4A3IxOyD+KlGAvLuESeYkvFZ2dH8psGQSQFunrsbsb9WYM6USsN314+vctgFaoNuXTIy74QR9g7SrX7SzB12p7ecO8mCW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=aoNn0W62; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="aoNn0W62"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso4733345e9.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 08:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1788968535; x=1789573335; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F0u+L+nVL9C1tUREs61N7WVbEpyXchQ6479yncGceLg=;
        b=aoNn0W62kDQ3Oe+94dtP0gJWE5L0PQ+s7Bk0hXHjxUCJ8ULldYsFsucghSkdO1H//F
         UHAOUP7Ez7NBkcLmfHXOV24YIwNWsbrs4dyFb5+XvDabeNC4N2sOzciH70Pt9uXGPHul
         slnMmVoqh/N8/WaM5ILcUlzFJShvCNhJ3PC2B/uVVozCwPRvVFurkEwPaCdrHhc69stZ
         zVzn5SUbPipMssXlZ/HLOJFxkeTetU9tiMyfk4+FasYQRutHBo6P1ZFAY2tmLSikqda+
         C9BXYE4tCn0WWpTfoOTt3xIf9DEzPDmJo2NaIi9kFkR7tTO52XI/JWCClesppj/mlyAI
         qQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788968535; x=1789573335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F0u+L+nVL9C1tUREs61N7WVbEpyXchQ6479yncGceLg=;
        b=ilkQWL6z0en9gkoLDot22Xn/4avRYE25Tjo0n03+v/aUwEyRo7o3Gee5OnOWWrW9Hc
         x3bQ5Z2Qa44wT8o6NPw3MsDCmncIeRfIQUX8MHPvrea0L/E6sEAe94fdAE+t4pLsb12Z
         WM9XJ9QWmsYdK6BKMNwqY8/DLDjVcCVOf6HySpXvgr83Z+7JcgNbYhvyaH65e9KUWrAY
         msQrPTQ8B/R0aTRR5xJeVeC3cywLwozzvVHcllMZlHcBMnag4GwhMlTF/eSdSyXONh3K
         OXXtr31emGLXL4H/qdXAlr+1q+01PehZ612NE8KTDrN9kXIvkLBgWqKkZUNtsJCEheu5
         Ss6g==
X-Forwarded-Encrypted: i=1; AKwUvBw9BUZy0TnWyp4p/6EjOtCoIIsIcr84ewzLdPSfgI4AHbNROIVAveC67z9ZC9BC8u3969UiNV3+Pw==@vger.kernel.org
X-Gm-Message-State: AFuF++lXADASTJGOp6Be13NNFCpZfy40RCAEPfZ6ExOIoPREakNmicKB
	SMqD69JLanFHHcWbuZ8VHej1lEhQKM2PM+1vzSYT+xyQz4vrbvu1dL2P3bs3wGHYyv0=
X-Gm-Gg: AYBFou35Om3guN+c9lfabwBuavixaw3Eze6rlsNEv+qG7NhIpp9GH75/6T+tHzE6DhH
	xTY+0ooLE09/GWbFe+/kxmC80C53QnLzgHZXIKBOQaFwLHoFE9C/Ee9ouIluQK++9xwin9FITDs
	vZX+sBWjRajSwEaUC4OIf+VZyzGUDYTDZEjOiGCAgFa2D8MD7v2Ot57wNLMla05GnbFZXc8s35T
	XQ+oKhGUHV+DULrHxvKG3F7LXFtziESVVSkbVYkZInsyFpEXpZJqh4dv1xiG9koPMNipO+RJzZE
	U5YWCcZpyKg1PIrWtAIF8jOAhm4+M5FU5pTuyKb6uU82hCJBM4vyugVjs+yFbCAsYv0ZxMRnrM2
	w9nxy+H1632AlZ46ETWvak+2oKRpsNWl6x8Ixmd9n7qUOfhUlZFuJcpgopd8q+S/BtsNCgeEca4
	ztGK64+zr8py6IkUc+dc8+uU1AGmIxispAPEO6tD4mOCe0akkQEtG3RtxYLe97671HF/0NWZRkB
	lPhAiCk/uFjo53e2DDUfn3GZ+3uuS9EmB1ieQwpzuP2+d+4zoc=
X-Received: by 2002:a05:600c:1d9a:b0:498:943:ccc0 with SMTP id 5b1f17b1804b1-49d258ef83amr41366425e9.6.1788968534764;
        Wed, 09 Sep 2026 08:42:14 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae. [2.51.220.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7740d44sm1042068015e9.15.2026.09.09.08.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 08:42:14 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 09 Sep 2026 19:41:47 +0400
Subject: [PATCH v2 4/4] power: supply: bq257xx: Parse battery info before
 registering power supply
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-bq257xx-init-v2-4-deb4076b1f02@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4653; i=alchark@flipper.net;
 h=from:subject:message-id; bh=hq4YQs4noVM+rPsJgnR/8SpC8jKglHwZ0DNfFfqjORo=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQtrHOz+rDvXhzv1arCxV0XFa5tYXQqZOt78n2u0Ib8Z
 PVNl7iWd0xkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDV6yUZGZ5/7D/apLJm1x1H72xWjzC2uh0prbvPHg8LOhbot2eehzTDH26WJ+Z
 8BtMEBJTKljQc973nIGu18uBhw++XEv58mvqxhwMA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Switch to a dev-based battery get/put interface to parse battery info
before registering the power supply, so that nobody tries to access the
power supply until we finish programming the device parameters.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 50 ++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index ab3519454193..a02d293c7395 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -1163,38 +1163,38 @@ static const struct bq257xx_chip_info bq25792_chip_info = {
 /**
  * bq257xx_parse_dt() - Parse the device tree for required properties
  * @pdata: driver platform data
- * @psy_cfg: power supply config data
  * @dev: device struct
  *
  * Read the device tree to identify the minimum system voltage, the
  * maximum charge current, the maximum charge voltage, and the maximum
- * input current.
+ * input current. Deliberately keyed off @dev rather than the charger power
+ * supply, so that it can run before the supply is registered.
  *
  * Return: Returns 0 on success or error code on error.
  */
-static int bq257xx_parse_dt(struct bq257xx_chg *pdata,
-		struct power_supply_config *psy_cfg, struct device *dev)
+static int bq257xx_parse_dt(struct bq257xx_chg *pdata, struct device *dev)
 {
 	struct power_supply_battery_info *bat_info;
 	int ret;
 
-	ret = power_supply_get_battery_info(pdata->charger,
-					    &bat_info);
+	ret = power_supply_get_battery_info_from_dev(dev, &bat_info);
 	if (ret)
 		return dev_err_probe(dev, ret,
 				     "Unable to get battery info\n");
 
 	if ((bat_info->voltage_min_design_uv <= 0) ||
 	    (bat_info->constant_charge_voltage_max_uv <= 0) ||
-	    (bat_info->constant_charge_current_max_ua <= 0))
+	    (bat_info->constant_charge_current_max_ua <= 0)) {
+		power_supply_put_battery_info_from_dev(dev, bat_info);
 		return dev_err_probe(dev, -EINVAL,
 				     "Required bat info missing or invalid\n");
+	}
 
 	pdata->vsys_min = bat_info->voltage_min_design_uv;
 	pdata->vbat_max = bat_info->constant_charge_voltage_max_uv;
 	pdata->ichg_max = bat_info->constant_charge_current_max_ua;
 
-	power_supply_put_battery_info(pdata->charger, bat_info);
+	power_supply_put_battery_info_from_dev(dev, bat_info);
 
 	ret = device_property_read_u32(dev,
 				       "input-current-limit-microamp",
@@ -1210,9 +1210,14 @@ static int bq257xx_parse_dt(struct bq257xx_chg *pdata,
  * @pdev: platform device
  *
  * Probe the charger device, allocate driver data structure, select the
- * appropriate chip-specific function pointers, register the power supply,
- * parse device tree properties for battery limits, initialize hardware,
- * and set up the interrupt handler if available.
+ * appropriate chip-specific function pointers, parse device tree properties
+ * for battery limits, initialize hardware, register the power supply, and set
+ * up the interrupt handler if available.
+ *
+ * The power supply is registered only once the hardware is up, because
+ * registering it lets the core call ->external_power_changed() at any time. A
+ * probe failure after that point would have devres free @pdata while such a
+ * callback is still running on it.
  *
  * Return: Returns 0 on success or error code on failure.
  */
@@ -1245,6 +1250,14 @@ static int bq257xx_charger_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pdata);
 
+	ret = bq257xx_parse_dt(pdata, dev);
+	if (ret)
+		return ret;
+
+	ret = pdata->chip->bq257xx_hw_init(pdata);
+	if (ret)
+		return dev_err_probe(dev, ret, "Cannot initialize the charger\n");
+
 	psy_cfg.drv_data = pdata;
 	psy_cfg.fwnode = dev_fwnode(dev);
 
@@ -1255,16 +1268,11 @@ static int bq257xx_charger_probe(struct platform_device *pdev)
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
+	/*
+	 * Requested after the supply is registered so that devres tears it down
+	 * first, quiescing the interrupt before the supply it reports on goes
+	 * away.
+	 */
 	if (bq->client->irq) {
 		ret = devm_request_threaded_irq(dev, bq->client->irq, NULL,
 						bq257xx_irq_handler_thread,

-- 
2.55.0

