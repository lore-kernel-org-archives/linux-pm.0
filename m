Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF48F34B1AD
	for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2026 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431099; cv=none; b=CaMfDu3HTTMuqSbRlsYmyhpsLtEodoAXMLsnlVrB1eqIC9BNi8D3uUXItNREb6SfmDFFjBMeVbaYxyROCzTnqXf1Z3ndqlqTkwGilrxI/5upCHV7Ctfuzohw1egRe0TRivAKnKaLl3vaBbmoe3q48dAS35UvBW1jy7yd4bZ71Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431099; c=relaxed/simple;
	bh=97Sq7wlZ0moS05bCO0Jofm6Gw/WfJ7BvBaZmQBGvEdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cacS3lt9kQmPq6NqIiGKma5/Q8iuz2HxmEPuY3LWOxZ5k1egjaDV5n13HUIsmv7F74vXkW+/ASwtUlcooofrVttIMZW6R2EaqAmYIQWvakRcOrEsxyQJ+fRpcDoT8TkMdB6YZM9spwFK05ovUsCo49cwRWK08X2EDN/J/InkHcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=DdqA6CW0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="DdqA6CW0"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49068493267so69103665e9.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 13:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1780431094; x=1781035894; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LbLzHRtPnH05nnLuUM9Mpkj6zyBMwlcuhPC8O/ppmgc=;
        b=DdqA6CW0VN7f7S1Qg5gGkHcJdAJeDvV32SOdTdkCMjHfsEmcRAp4ylnby6Xci+6ZFh
         xSh+eIRweW0SDZYWIeteuL6t7jwCMZmDid74HyLGWsdz5UKTyxN4j3d43BU+jGyN2OvQ
         Y/JrEDRUFFcx7au+PXoU5c/UxPqBSt/TtSAvxiiLum5r2vNwavS780lkTb89aGECZKEw
         IOkfdW8TEJjpSIKX6gECFuib7P+h2+hHOaPkimvREN/xqE8TPTaCLAkNnPv7Inrnk6uR
         QnNe6y70LTMmcgpG9Lsw9RTEq5qAsMnxNbkwK+7xM9tOlBKZM370ph9z4eXqt/W2Ufhy
         DxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780431094; x=1781035894;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LbLzHRtPnH05nnLuUM9Mpkj6zyBMwlcuhPC8O/ppmgc=;
        b=HRh6e5niHZfQoMG5WAe3wPFiC4UmOZeK+6kuydfjkYr9nRz6HDb0pxYDjBZSCC/bLL
         OnOcTlq4NPmYmTl1CEzQbd2fCKCwsqWpxJwQgZ+C6UmxSxJOvvjOTz0RO+JfKa/fib/t
         OQ3vcVkH6nUwiOpEH+ty5DNkC9FCjSuF/w5snR5gDzqwAUy2s7642FiqXCOmBdDiRUSN
         asqcViGY7N8sz6/70Zkr5MquJvmkymI/OhpOMO9EN+KrZ5v4ILHXhVOHgJwQZPrmqJbP
         hlmVkOG1k6c8sRs1zR21IHd6LPMzDSZfxUsCeNLC+9EHA/rOMdLeqKpVK3frLmpeZTxt
         pTJA==
X-Forwarded-Encrypted: i=1; AFNElJ959l4bVEzreuz9E91XgB0yyCJAEV4qBPvZx+hzRZ5XZ6ofqeMkZo1PRBM+2TCYQBFYk4QkYHpCYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2hisx8M6hzglgBPYBQMpHa+AridL3rRz00v+Ktm83Xn5XGRbT
	CDsCmdclcFXPAeLwovf+tovX8dD6us1xW1DGv0iCiYEd134Hdmi57HoVaGccu1/thJrbTQGACXn
	YIzM7LoMJDQ==
X-Gm-Gg: Acq92OE3vBm5SaacFO5PMbgYqbDeaDElJklQhTr/4KHeNNU2UHsT1Si97xN4YrUcrON
	jfZ5J2l8Uk2MdhnuKpkjIEHpLtx6fghks1bC/g8nacyLG3gZXwZLel+lzDDGtNSsMWXk5fJMYTb
	54d10RJmIisyOS3BWQ/yGBqCaHF0Dcp5Tf4XQIlrPGLoBzpg67xQMFR3iT2q1CRgf//gJ1v00OZ
	iD8tbNE7lgaRJw7rmip4e1/SL72mq1Z7nU+3U7B/UHG+gssuDxan1Ys+Co8a7wQHDAkaMzAbIwI
	1Sn0m7bjJ56xG7bdssMhphi7PXLKlFG+7F29trl2RbcVprmkKuZ9z8wqAL1Ik5fHvnNMgJWkDHj
	E/GoTZF7IdPUDVU9coj5SGfi+D6ng5mN99VLcBDovm45BDYobbwVFBgBPLQ9NkuN8W6/dLIFybs
	zN6MAzYwNO3gvnuw14VN5ZYauwdyum/N4yLCPQCE8EfQ7xim4uXQPeQ4dd2U4LBg==
X-Received: by 2002:a05:600c:c4b8:b0:490:b591:b5a3 with SMTP id 5b1f17b1804b1-490b60e9af0mr4492655e9.32.1780431094413;
        Tue, 02 Jun 2026 13:11:34 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63e6720sm2588515e9.13.2026.06.02.13.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:11:34 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 03 Jun 2026 00:10:52 +0400
Subject: [PATCH v7 4/7] power: supply: bq257xx: Consistently use indirect
 get/set helpers
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-bq25792-v7-4-d487bed276d0@flipper.net>
References: <20260603-bq25792-v7-0-d487bed276d0@flipper.net>
In-Reply-To: <20260603-bq25792-v7-0-d487bed276d0@flipper.net>
To: Chris Morgan <macromorgan@hotmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4242; i=alchark@flipper.net;
 h=from:subject:message-id; bh=97Sq7wlZ0moS05bCO0Jofm6Gw/WfJ7BvBaZmQBGvEdQ=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTJWzyLfWB3mSu48eXt6jgX3bb11tpmF1x2Xvz36/PGi
 afLr7dP6ZjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCqXeYy/BV7ZPR3n9a8iuLnhyc9kd7wZur0d65/jZw2T3DbmfFa9+cehn/G+fX
 HJz+52lr5vPDehXe5le/DRPyqzY+6RPnOre0XCuIAAA==
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
2.53.0

