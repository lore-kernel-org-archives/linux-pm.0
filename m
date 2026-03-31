Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF84423149
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971848; cv=none; b=JjkagNlcMN897VzTMhfgfhDWmsflppFevwFWLYO32EYVv7uvd7p+lnX8xMB42bt5bzopSnFw9j4bVnpiPDT6mnHQH8AgKR8/E10TK1h5W0MxkJK9k/a/Ww8FGs7T+V3CJjJdlCO93w3A9XwWp4w8sVFn4Tdiw8JIcFaB8VGaPIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971848; c=relaxed/simple;
	bh=K/K91eQQ75phcINLj4DBBQbD0ofWablCORf9BgG8obM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SJ3mQ11lvmIa21hg5WXI0cpZrFPKR8J2BJrKO0ueX2OeyAJVQDnBxoT+3GkTNCDeEwlgTgzbs017ldp/f/sktTLDzzfOwRPSfR3nbb/HpMevysIEHgyVM52J0ihrR5Nwkx/jh0g5I3JsRoPmHI5SQFCPFPhXjQHk4ijiQBrrZ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=cABwwynB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="cABwwynB"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486ff3a0fc1so53672385e9.2
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 08:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1774971845; x=1775576645; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8b97w0FIxP+iQSlY9+U8NDMrKZX5YXrCInQTxcuoNL8=;
        b=cABwwynBtz91HQQXT/PqabNqB0tswzybZM5KooRH9z1AxGGpZHl8q1fodnGBhoDQJ3
         zk4uMZ33EPZLLB7q9yPK5bGTSvh9M5IyeltMwCUrRAyhT/qGzCkBX0z+vx+sIzP/xx0l
         asyOx/ywrHqOKgu4Z5EPad0qSjEqOgtu6biVFicz6VdF5ti4Vla+4WDKnLZAvjJQYO9R
         WHmowSwsck+ehm5QrrnZyTW0fZIRG398JC3HSaLlDPddrnSLfsLdADIuA3oY63OopW/m
         4SBhO47MBKzseDp+VXVaiMhbBFJr9g+2IA6CK2fixrqj70WPHf6SPduDNTFZ3qQ6m+8A
         eQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971845; x=1775576645;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8b97w0FIxP+iQSlY9+U8NDMrKZX5YXrCInQTxcuoNL8=;
        b=AnZX07V8iuUnepQJzB5evnrauf9mQNib5LxLGN1GPcp87nN6p0T18LiFYXiP6F+a+9
         vDtK1/PoE4txYTxUzaGB3M2rVI7KrP2e025ZRpqDfkk/YNdeWt/UQDCHjWso6bA/hULL
         oAt/Xn9CkD6rlrB8S0zWOCKXgk/lYzKdxgsUUc8gWKMrTkAfeyIZ3u/SLuGaRi25WuLw
         0v/BGoV8qb08TKJT3DojAeXZD94ckbPUdCydUQ1JesXgrE0KC+BLf6BTPWNrsm1BkaVH
         GbYAfmqxXJZCbDHt86fEivvNjIZAEFrPKHd5JhKgr/1Ho6kXcQkaW5t6pWLqQnL8wxnz
         QGfA==
X-Forwarded-Encrypted: i=1; AJvYcCWk6rLhulrIqw447el33Z184Zyu2+v1yAZbUVZo7UlXZZjypaWfU56PQoR2q7I7792T1q5olJ0Wqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFqN7+C3RBCp6vRfDITYxPKD42L0n7R3ZJ+ZMz922GhqotCUOy
	hs7b0Z8GbGBK5UPPl7K99Www9diQgpBUx1dzKZHPUMkSf0zNu6nFkBYI6cHbB8i7Qlo=
X-Gm-Gg: ATEYQzw6H3GXl4sKB611f1B3EoJm69Hz83uARmea9DsurGqF8EBqXL9Dri/Q1J/SB51
	JYnuptD0qE05yp+0NWbiqdimBOBuuFiyImS5AGboIMUr3wNaImcifMf5iEY0YFliT8n1BC9N3uj
	/ec5HPYwJcNs/7W8GX3lJLZaSiB1xb/CLVT4ePio7Dq3HRRt2pHg5dZ9vw5LjV+OydModobcdsA
	loZA4l71C/KrF5O+vWs95lv7CHZ5PBUxghJTCM23mbYPlgNb0GxbDyy8xvFTPZFy3l6YX7RlL3w
	mVVC55OYVjlsx76DT2UyBMmvFYvmigJ/431HQNPCZFxzZjztxSLeTDj5zEdWrayqfb2N7IeW1ZW
	Ye7a8OoZMCho97QLSgWsq60DCTYQYN+rf8zwHpQY3yTzhWFs/yCOUE8iC23bHLaiZcQzPTJmoOe
	Q0yO5BS2RdI6phNf20dw+Zu8Qv6c2qwLdivD9bdunXm73cgZ2DkRz0fLEnkP+Y0GMr2XXUQjRc7
	2Tkqg==
X-Received: by 2002:a05:600c:4f53:b0:485:3692:e8f7 with SMTP id 5b1f17b1804b1-48727ede47amr285030835e9.25.1774971845478;
        Tue, 31 Mar 2026 08:44:05 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8852a5sm48412605e9.9.2026.03.31.08.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:44:05 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 31 Mar 2026 19:43:44 +0400
Subject: [PATCH v6 07/11] power: supply: bq257xx: Consistently use indirect
 get/set helpers
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-bq25792-v6-7-0278fba33eb9@flipper.net>
References: <20260331-bq25792-v6-0-0278fba33eb9@flipper.net>
In-Reply-To: <20260331-bq25792-v6-0-0278fba33eb9@flipper.net>
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
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSefr1+UozjGbdn6i0TNpbc3npbND99gm+lRDTzgcszY
 j9X9x+Q7pjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DA11jHWMGLg4BWCqOecx/GZ5eHLud+NqkwvXFk6dtfPAzH1LGR0WMhQfzZq9R11l9vIdjAynPe4
 smT1xtX6F8eq1k6MnVKwM3qArO/U/f63lsS4Jj3+8AA==
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

