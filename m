Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FA244102A
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134968; cv=none; b=vDqcjPmbdtkBNSBHuoC3H/EuNY9KKZ+jtPy7SDOLnOh2Ux9lpodRVZfRbI9eCfl7sAgG2JSOG4/FjcSX8f72Y0ypd5E1aTddzWhGKWZLxEzffKSpxFdqnVKXRBZulOxYRujJMeOwul95zxW3y3RC+yVFlhvZCMd7vfRWUZ0X1hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134968; c=relaxed/simple;
	bh=uhoOBLTkCt9koWbQVb9qbShLeGalrFZRwZECwHGWC0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pxEOLA0fVup4bi7ZiBJyj8UmdbCah32hiIbbHPM9PcQcuenKBgQiAlHeOQhAmPH0yapdRC5iN51p1RjH3V4A6B/MpwStHqqWJDtQnwIdCuyGvE3ztTBSUAEqBtPAP9aIvRIv8mNYkKeY16gd+n3AMF+9d8/YFwdDbl4lbzYH5ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=8IoaQdpn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="8IoaQdpn"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so31512295e9.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 02:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773134966; x=1773739766; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XCPvyofErjhorjvOzgcNlfIsVmqLN0uhP/f3Z0DZct8=;
        b=8IoaQdpniGTg3J6DKnb32KHRH0sycNRGaeTUw4PxH8cUHaxx/FSnxd+KDMbeCOZod3
         t+Ja3fvXVkUS9tUPX01B46aE6qMa8xnuBP6s0pCJqRZQ8ggpsjDU0zSntnfErnPSk1JL
         O6OfPMmgeyWOs16+QWiYPUFx674BsT9lIjTkwDrPuTCrQyShLKe6TgjetroMJi9am/GD
         U7OHpjxRjyo+TCaAft8CP5DDKcFa6KKjXfqaIyCSRtEUZX585kr6iFLwnqQYcUa9aPBd
         PJTpnB3ChwVWuhIwtBdhClKA5Jxq8lrorsszwwlIe3BsRZCmZUJtRmXeUoZvmzpTcD5c
         NADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134966; x=1773739766;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XCPvyofErjhorjvOzgcNlfIsVmqLN0uhP/f3Z0DZct8=;
        b=W6g73hrqsk/niriShKNxYaeba4scDOUN2HHy5MrR0XhEMsD/JN/sWOBVHpUOz13Yxu
         YfjRHYu4H09i3VclRG4M52TdQiNP6vgcOIOOks5VOv8+VM+B6YJX8dOAtfsORFk2RAlg
         +skAPevzzNRuq9vGuY/1Jz41SbISUSzI9O4KfCTjcR5S/5eTjI9vYZ+dleMPuNVJBC8K
         /NFX0/IiH9lmVxZwseoUAwqUnjSO+gW7CN7Lf/nwF1sT0TqDtEk9oVIHnwLGsk/8miZ+
         wwfJKgQvYb9jj/PlOOTmeXzlx1OOf/+aaYrM67GlzivTp7TheGX6HXtZHt0ziJDZlq2/
         miBw==
X-Forwarded-Encrypted: i=1; AJvYcCUoYuYo1plUtJfYl4KDC5BWcQMdEUGlbBL5eBGJeKvz6FCQiBw4HswiOjTAszlSqFCcJ04SrZRsKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqZnQ5FIgQZ+YvFKhaPE7NHTqqMulkO4T9ISLrmaBQmnXi6g7x
	31WCSVHr8KI+UYcTnswLugiCOuAY6kQsarinYwe/koP4qfst9UiBMXH2wl117cudckc=
X-Gm-Gg: ATEYQzwG5Www9VYXgZ678YX6h6SCOBQQSVDNoyufqXgIpzUkAIC86wNIUoFt+35bGms
	k/gYmICfy2GIrM5uHZSxsoaLoNl9dTm0WheXK+6Obuy1ffGbscw0iR8Tzf9AIxtyw2c5j7r3zXD
	Vd7t/WRmObwkzgPNr7R4PIfagPrWx2k4iunfiawl6E++nOJbRG71RVdgRxVwYVxT2qsrvDfXwmh
	WpF4Fw2DFTBzmBPRks8sOGPb5rVpzPefL2R7v2FXrcecQKasgr1iQk2N1NmOLKmN25smLqlVUKk
	h5bsJKYSrIjjqeQuixfeTMlN3oeFK/rwFCmEwkIMwOh0kx87K+tQmJvus+DaDe2jpW9g5H6cWTj
	+0AkjMyHwBu7+C/Z0Pba42KcQAN2EzN9Ciq3zRx4iCi+K9n4ahjLym1P5v7nOnMj8GSflTWAT2h
	Xm9doxkeOSchhGApGm0Ab2ypJ5ssa/GfY89r2ZmLpaW1bOFDSp3G3XK3C7E+NFrJfz0xxA8uJEy
	d1AVw==
X-Received: by 2002:a05:600c:350e:b0:477:9b35:3e49 with SMTP id 5b1f17b1804b1-48526916bafmr216148855e9.3.1773134965857;
        Tue, 10 Mar 2026 02:29:25 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48529f019a4sm104214285e9.12.2026.03.10.02.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:29:25 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 10 Mar 2026 13:28:31 +0400
Subject: [PATCH v3 07/11] power: supply: bq257xx: Consistently use indirect
 get/set helpers
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-bq25792-v3-7-02f8e232d63b@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3415; i=alchark@flipper.net;
 h=from:subject:message-id; bh=uhoOBLTkCt9koWbQVb9qbShLeGalrFZRwZECwHGWC0Y=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSuf5L4NvKH67LLO18+Sn5RxHPNdrv3nO0LruRGXQj+0
 /20df1fvo6JLAxiXAyWYoosc78tsZ1qxDdrl4fHV5g5rEwgQ6RFGhiAgIWBLzcxr9RIx0jPVNtQ
 z9BQx1jHiIGLUwCm2t+WkWHS7M0t5hLsDYsOPvvOY/LJnP2eQPVPZp/GQ1tXs3l0pp1j+M3CuXN
 qTVjBB8fv3MybHe4Vyxkde/t8/bKv0YLzZ66W1uQAAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Move the remaining get/set helper functions to indirect calls via the
per-chip bq257xx_chip_info struct.

This improves the consistency of the code and prepares the driver to
support multiple chip variants with different register layouts and bit
definitions.

Tested-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index e14dd16f9d08..deb60a9bd222 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -30,9 +30,15 @@ struct bq257xx_chip_info {
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
@@ -489,22 +495,22 @@ static int bq257xx_get_charger_property(struct power_supply *psy,
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
@@ -632,9 +638,15 @@ static const struct bq257xx_chip_info bq25703_chip_info = {
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

