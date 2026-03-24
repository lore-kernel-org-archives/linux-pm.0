Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD203EE1F6
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 11:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352325; cv=none; b=Du7NhImNM02opAsoOVaQ+PbaMm0j9Hoz0a2JC3NgOIHdJ5dkuogl2838cK8u4Bi6ohcS7ghCqMJZRJq3BAkpeHTayQwBfIRoS08AZymrsHNsLwA5PrzZHSQr13JgtC4LE+Y55VmgWpCmOHD2sVJg3dLTzO9RzMpPutmn53G31KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352325; c=relaxed/simple;
	bh=K/K91eQQ75phcINLj4DBBQbD0ofWablCORf9BgG8obM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rTFif45yBd4OFzZpqMHD8HqaDFaCQbocPsE/8qV9c88a8tfSWrsAJLleFSvtc/V2PMu0OVysjVCsOHD/hMlsetET5H48NnQskmwkc/kMzRZlO6+IZA5Rq/CBJAEvD0gwsrYX8MPaFduMWSJRPuu6rjldC1XhdTjQd3ZOEq8uwfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=s6qpf/bl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="s6qpf/bl"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486507134e4so14303055e9.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 04:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1774352322; x=1774957122; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8b97w0FIxP+iQSlY9+U8NDMrKZX5YXrCInQTxcuoNL8=;
        b=s6qpf/bli7kxnqYpBCJHYvWsRf0FCHKjGYc5tyw8/2+/ArvH5ctKWE0nspfQ+UWWFa
         ZplGI8NnZmlExIe5l6vkZjCYfDMQLnui4YZgNrREZDXetdYQq1lV75Hs9irLXxWHOpjI
         jK3gL0qAT+VEugK340xuck76HDlNjXOvH5sW4nZ7c1QWXE2G0dhgTAyIFkJk2z/Psd2S
         uffl2nClbMY0ikTe1gf10SP6sAurjZU3m3PSgPTsGkzktLdiirf8qmSws+J5hQ2GDMYY
         gjJJ6DcvQVyjtQnX9D+LSBhiww5u9tnI7RzBt/qPFzzEalUtXZBRCbhJ6x1NwchHqbZf
         hrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774352322; x=1774957122;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8b97w0FIxP+iQSlY9+U8NDMrKZX5YXrCInQTxcuoNL8=;
        b=HRJ47PueBxBNRQMZb5PnMsN2Dnicf4PS7TJwQSL5cri45GHhGHbPi0zR7jFGNqbVWy
         SCgH7izxBTU0TmTvqk8j2nGyW0SvAn0r9CbOzXMpWDBeSZnirSRDBgnk7sKcGtVG4XaO
         yDfkcDsgu9uaxJ1/hrqnnoRolcMpCjbNDnFj0Qo5/w8+UZwJkiZUdBlmFuawxRcA2gFp
         ZpA46RImdwO8fRykfm6KR413cnqWXthM2RoaC+bSxN6R/w5PDQ220KiHQcXL8B/uJWFg
         vHVuupSjn78JdPVaNYb4J2c3snMJsoy6I49SnCbs96XFaaGKu0tCAd/wDJAEKeP1aV2i
         9kag==
X-Forwarded-Encrypted: i=1; AJvYcCUFC0BDlCoe/DKt6cS6Lw4T1BBiO5YqqtVMgpRuGgnI/S8oAMJd/5DWalrI319QAoRO6sKfa42iDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwI2wxNag5mRmDXcFNpxYzW6582yFNK+VZEp0C8G+WWVGqAUm13
	hF2eLXkKdogFZ1yebx0Qju1Xcp76hEB9SqlC9tf3FfYCQsg/dnhH3AD5lIrVxgMRXXU=
X-Gm-Gg: ATEYQzxuE0NZ+mzFqE2UnPle99vDQkcgRzRhHaPfcaVTCqXUxE5Eqzx8XRbzkFiDzGq
	krE85R7Z1Mmhh7OWC605BG/OBa05N3lNlf7+uEbGZ36VynLKK5DpbLOc9MqMzn+J24zU6q3Vv17
	n3umi9rGaPX0hfpoqrSf4Fmk8t99cTpBtidBIKj4LtN0CMRbd5GMYhvOyjtgaMla/fm/J1Vd3I5
	4//b6TvOmcTupzGYBBo+zVmfbQxIRUuYIRv+WsdSOI8hWznOsG5dQY8YrzzKqcoPnBBCfJBojPn
	gYeyzV4d5VMfUOmdB0Li5XAhx8EqkPMJpclNzKcw1cMRfELXNJN0W8k4GGW4KRLrb3UyuJruVke
	i3SFzp5Z1jJWTXnRgPypUcWf06XVAazVX2nj4RYf4PDW/5PnmMcO2mybmiuV6+aUrIMUETpM4aG
	2N9Rm/QnLL3H2MU/t2ZJZwLSeAemG+hiqc6c7lZyf8HQ+tST9h0kNhHEXzkl3s4p5Iz9Phf2Bfe
	+QMcw==
X-Received: by 2002:a05:600c:3e8d:b0:485:3a03:ceca with SMTP id 5b1f17b1804b1-486fee26501mr204972165e9.23.1774352322085;
        Tue, 24 Mar 2026 04:38:42 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4870f6c0fa6sm20846715e9.1.2026.03.24.04.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 04:38:41 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 24 Mar 2026 15:38:12 +0400
Subject: [PATCH v5 07/11] power: supply: bq257xx: Consistently use indirect
 get/set helpers
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-bq25792-v5-7-0a2eb58cf11d@flipper.net>
References: <20260324-bq25792-v5-0-0a2eb58cf11d@flipper.net>
In-Reply-To: <20260324-bq25792-v5-0-0a2eb58cf11d@flipper.net>
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
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQeKl97wX577jHP7rKNP51nyfjunKR07ofdXDaheA7Xu
 FnCU/mudkxkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hoY6xjpGDFycAjDV3KsY/srqfJ05k7WmRvDWow98zzUORx5f9s/rHSfnnHTm1dwsETcZGRYJue5
 8vy38kot39/Q3gt82x3K/vKq0x8RHk1dF+NaU/7wA
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

