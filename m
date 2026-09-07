Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24F34FECD6
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793328; cv=none; b=CS+r36sF5vyA2A6ShcqnLNOTHQdxotaaDC8+Q7TWNzXvPeiWtkEiOuHreK124QdrHmxY/iHiyc2AhjcuCE2JLv9x1SUs2ElNHRIsvKKTHfABEiKr35emKlfrQbsK2R/OcqQPDo6vufBG0btB+Yua2gqOQh8MlZGEdkuDenwt1BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793328; c=relaxed/simple;
	bh=lE4DoCX54IzHb9OGuqjtUGY0/Idn5+TuMdUQxkrjXI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s5GmSpMa+Bu/pEHJ/8TiGqZG7YR1YsJ8I81Oiw3JykU3lqD+DT0ulHpeNYPxUFWDs9LbwrDMq8eAwqV8KV7zrcvv1CAX58ezS0Wky0k0clCa5KPTbTIgo4Kq7v3mU+5iklFSuw8iRr+9E1vvMUi3PtyZd+0o3QSrk1djs6iGNo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=u6C40K/A; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="u6C40K/A"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-495590dde14so52688955e9.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 08:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1788793322; x=1789398122; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9RcLvsK/2UZ/1TkMot9jvTvWpZC1OV1SBC2asu5tlgE=;
        b=u6C40K/AoJfOc0UJKHfKdH4eNeTn/xYZw7rKMR8ohuLczdIwf8/HWgY0tQ4OM0+nbt
         6tgSns0EyX4evNav474AplIHNVMa12gNt8gUK7EXKHQ379kDbjqJ1RUO4dsDfDawWzFc
         MUitEE3l8nWzEMxA3wniYEFRIu62GR2L6XJhHFL68x2ves+2LA9Aid94ezf4zPsLYeYT
         /gnngSbNNurWHhq0uHMpE1afjMtuWcUVQMkcWqkgTt5sL5E8gkT5m0ZdQQf67fx6+WTP
         sESsA3ir//DP5P7uFDIF7DR4Y2PaqA8wk/wTxiaIkZR2jZTgYvG+5/S47G6B+O/tS2z5
         okhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788793322; x=1789398122;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9RcLvsK/2UZ/1TkMot9jvTvWpZC1OV1SBC2asu5tlgE=;
        b=bDNWERj68lEYmqZZYl7E1axtgEBk3J4EWc+1H6gjecSYCfy+mpoPY+IKcc99ns3wpK
         RAdgjPVoXzq3lxEW8yXEgYfPcsMFjC6UKM/0aBkmfXtJ0Qo2Wj8UaoVAMi8jj1WtL8+Z
         1M7hxvfJRSda354Dze4HsHJ4DQ21t4E+/Ttf+vF0Xw81slbOOlkU5VNhcj7ErQJu95jB
         uoBR0EQjcSfRsJLhGH8wsPYSQQDQLx7lrDbZEu1C8WVJDx/Rwm0tevnTxDw/ELXSqShj
         JsOqsipJGC5xAZyBzYFo+IHjY312vKXU7KtE7puND/04j7AX/VR5plzyJ3QczjGW6rB8
         10ng==
X-Forwarded-Encrypted: i=1; AKwUvBymtqJmyKFNt/2P/D/KZXtpNYLzuvCs7tOg9xRxU9BP0DN/0akxnzlSS+NV9nZM+cmUB3VWNdAcoQ==@vger.kernel.org
X-Gm-Message-State: AFuF++k5exZCwJHDDmQaz4kTeH/j8CDVpBeFZw4Wj1RRyz7XEGmL20Pb
	+fxS/Kf8/DMP/4DvRq0HmJJ5PFO0PdTz8tM9/9+CHDtpO2s77RSUFpBbCJLKPiZruc4=
X-Gm-Gg: AYBFou19w/vPLRk61/XO0amYR1eCWL7fgidWY+LyLykUOCDFdzUfZ4No8kLOSJS5UQs
	GnTnf4ADrwQZlotOurZYrEOgHnc4KnxDjbTrI5HIpZYHHxvTQb6ulvBRBvmFPlCh8CBqyZM4P07
	BQC5Z1AG5IoJdGVmIVSBk1Bh75jXPDsdOpYZREvtJBWCNxQ1dIFERPntoAID+U2Bdy/bYTu7fU1
	gONf1Bp98sxDCRrB7ggVNJD15rQzv5aq5CLn5/aVg0PaxQhCjO9H5Szp58HpPdbO3nFTg0spMtE
	u7+U/EJp+NQtycdOZ5O68OTpmnbCclFTCh2q/NOlUVvaoGyn3DRpnTh9KJqJR/PwRj7VBKauawY
	B3or9p0H7icbqsS85aSFLck2rD5iKGN/MQ6OZyxSztCraCxU0Aalua0gpn1uv+xW4h/FvnG0abf
	YHYmKeCqFHSasArsEabKfacqd6jsOqLEJpD4E1h8EBOGIRXdbhu4xv+fMZMMn6/CWhhKK/9354H
	apSCG8TM4OfdjnfdaYEGkiVg13/wjVCUpyEj/l/
X-Received: by 2002:a05:600c:4e51:b0:49c:ff8d:b548 with SMTP id 5b1f17b1804b1-49cff8db5demr394817815e9.11.1788793322389;
        Mon, 07 Sep 2026 08:02:02 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae. [2.51.220.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cff8195ffsm262992705e9.14.2026.09.07.08.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:02:02 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 07 Sep 2026 19:01:45 +0400
Subject: [PATCH 5/5] power: supply: bq257xx: Parse battery info before
 registering power supply
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bq257xx-init-v1-5-1a08b29e1a68@flipper.net>
References: <20260907-bq257xx-init-v1-0-1a08b29e1a68@flipper.net>
In-Reply-To: <20260907-bq257xx-init-v1-0-1a08b29e1a68@flipper.net>
To: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
 Chris Morgan <macromorgan@hotmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4653; i=alchark@flipper.net;
 h=from:subject:message-id; bh=lE4DoCX54IzHb9OGuqjtUGY0/Idn5+TuMdUQxkrjXI0=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTNu3gn5r68dXzYz7dcrQITrplMiVg29dl/wfTKzSwtY
 a0yWSeOdExkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDV9yMYGa4m7EnwXfSQq3K6bMVdyU7XHeFN10wvfTmxsrNquZDC4fMMfwWvPb3
 6wsfCrjO85+IUrm0fzvP9fMXtWOow9ZNlhIloMzsA
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
index 8a645859460b..6faa1055b3ee 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -1165,38 +1165,38 @@ static const struct bq257xx_chip_info bq25792_chip_info = {
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
@@ -1212,9 +1212,14 @@ static int bq257xx_parse_dt(struct bq257xx_chg *pdata,
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
@@ -1247,6 +1252,14 @@ static int bq257xx_charger_probe(struct platform_device *pdev)
 
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
 
@@ -1257,16 +1270,11 @@ static int bq257xx_charger_probe(struct platform_device *pdev)
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
2.54.0

