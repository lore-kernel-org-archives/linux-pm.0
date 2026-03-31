Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D152841B37F
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971861; cv=none; b=fVINqRQ8e6U/czpTX31mlfW9rujs5JsIBALVAPk14cxr4mS8n+hhckncldNoYFl+7fgE3oF7tDtHZkfOEO54GtTYRSo5T/IvhGHsyKjzvjseNyQ7PS4nY1I2RbSNcK72kZ1D/Fvy9IniSKkJMJwpMqPnpgEP6SuzcTCuuYHwP1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971861; c=relaxed/simple;
	bh=VW4PGKQbMprs05QZjLUFAcp7NQ6qIj6tfIjDvxiwqeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WVrbvzqEwdYkZdOTgWj4U5jlsr6c6fMIZWnKZtA6fGtZ+ygo6AxOQMyAiUtAOQIdJa0xM0DnphDQic4CTAItuPs1rrpr3ItcZGDvPjAtQlPNy4WUCktdpuLBxwH9lxgJDRKwwMoIxB1eW1ygo2rF0aWFvRORrGYQ0fYd/qF9I0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=VhLBB9WE; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="VhLBB9WE"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4887fd35e60so4196835e9.2
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 08:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1774971857; x=1775576657; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJBOPz5cenCqobIA2pP3hpiRljJx71ZTKxf/DvRJSFg=;
        b=VhLBB9WEzyBni7AnFCRNCE1beaZmO0EKVkAiJFBOlLC9pH4pTuMN6VXB37sn50y8/N
         aZc95oF9m/mS1aKsXOsnwWc7u9MTPJX2IzAbv2cK5XVxzq92oGYaKKKVzM5hTUyGCXQJ
         X9aku6RUH7YROThmsaAvS6RnQpI7MJOv7ztyxvvtc5z8y2W3w4zFG+iQ8JPFa74C1gnX
         +GA8b0rANtjUIqdzbR4X+3ylfoS74XlaKHCfsTbXbALQ3qY3OIH6aUBT0wkwWcTG6qOV
         Q726Xjqh07RnGIqSB061JfyvfYLiTJeUPKTM4J5gLstcyo11QIxw0ZUXxqzvvlcpIs7q
         0+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971857; x=1775576657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HJBOPz5cenCqobIA2pP3hpiRljJx71ZTKxf/DvRJSFg=;
        b=sj/mL2gXE6zQPE/54diGhIJSj891Wz+1ka2oYwut4Ibg9LoLWCEHNhHKShv93WAvk/
         VAlUPJo6LX2uNbzNnhHqkU6yKTjTTHdofA9sOoiFtXr8nufGUNdUkmI/T6831+gHbDgk
         sYxBUaLbxby+PUqkbUf6wEAz1kXVjToq49JDcg9eJyLCiX/nO6Y4UTHSW00lepmxltoY
         /SqYGyvHRycUQgxnRwvHOM0oQwJ0qIIeqoqk2XiWeb7M2eFNLiKaaO8IEmN5JdCA7INU
         Ed52xnFvH0rj0TMGMIxr4ML+zO5XRoWpMlNU+jBMWNIz+SSnh9mqxKNp0N+pgj2btCLK
         JCJg==
X-Forwarded-Encrypted: i=1; AJvYcCWpIXQfajEzPYLIKpcg+W8zQLvxopPRGlTKcBzyaL0aP7fCyRjDwJD6WtdRhSqpL5JPClvtyTijsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmZ7r0HE3hb17dmdiutL2CwjyuWFV9KWs7+FSSWxv5za9vThJz
	ikxmQyE74TAu/MxiapERvdOSTEFlIKbproh+wQXqlO0IpZwrgAj9x2OAIouuTql7Omo=
X-Gm-Gg: ATEYQzyFg6wPjdH0AtPwIv3ikIQbwKHHNijaLnVcjPbULI/spUUWoOBdZA4sFEIK5d+
	hWERXdA16qfdj5vPiE+BfqAB2SBVulU4pjZf3oa3VuAaTpCr3QLsbnkhiAeHRwWyzZlXTHy9jjz
	LBenBx3CywAAmDBFHkikKe5AlOIAAnlss0JJPAkaPsGCRDiuRMH5bKukBJFStR+DjQZhCpNv9ul
	+329joOi9T1SOlJYROs52oMUjCh6OTBdTxyllGWqh43sBfjNnFV1qirHv++p9HvvEjC6HqvdWFL
	d4hv1F7QiPVWU6P3ZzHWwwvXVOqST6fdB6cfor9rFuCHMn1GbcuvXdARF+FqbqdLq6jAJPso4ys
	oE5I4CXkji+CGOsVAIm1f2lixAiPtaPBiFgEl0t4rkhPCmMiD3EQXIRiYrwPO/HFPdTAUJG9atO
	WWY1p/vUf42ikeGRAIPLvuWspUDVx8FIxArnbBgTjiV4KZGFThOwiYlOstT6rED8BnWQ0PvBaM9
	VKzvw==
X-Received: by 2002:a05:600c:8215:b0:485:3baa:af14 with SMTP id 5b1f17b1804b1-48727f5f985mr265707625e9.18.1774971856859;
        Tue, 31 Mar 2026 08:44:16 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8852a5sm48412605e9.9.2026.03.31.08.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:44:16 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 31 Mar 2026 19:43:48 +0400
Subject: [PATCH v6 11/11] power: supply: bq257xx: Add support for BQ25792
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-bq25792-v6-11-0278fba33eb9@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=20378; i=alchark@flipper.net;
 h=from:subject:message-id; bh=VW4PGKQbMprs05QZjLUFAcp7NQ6qIj6tfIjDvxiwqeE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSefr3hAc9He6P7a7vSu7vT+NW+CFpLu9tGvPWVUfp0b
 D33nL4NHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oaGOsY4RAxenAEy16AOGfxaM6fNbfC8paKjnLDZPq268a8oRcN/22HrVhYuca3n97BgZroslMZQ
 G1U6YXFZ7pyjPrsr7xZtXU7teRnjyXDw1JVuBHQA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Add support for TI BQ25792 integrated battery charger and buck-boost
converter.

It shares high-level logic of operation with the already supported
BQ25703A, but has a different register map, bit definitions and some of
the lower-level hardware states.

Tested-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 482 ++++++++++++++++++++++++++++++++-
 1 file changed, 481 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index 9c082865e745..b9a41fe6f00e 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/byteorder/generic.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/bq257xx.h>
@@ -88,6 +89,53 @@ struct bq257xx_chg {
 	u32 vsys_min;
 };
 
+/**
+ * bq25792_read16() - Read a 16-bit value from device register
+ * @pdata: driver platform data
+ * @reg: register address to read from
+ * @val: pointer to store the register value
+ *
+ * Read a 16-bit big-endian value from the BQ25792 device via regmap
+ * and convert to CPU byte order.
+ *
+ * Return: Returns 0 on success or error on failure to read.
+ */
+static int bq25792_read16(struct bq257xx_chg *pdata, unsigned int reg, u16 *val)
+{
+	__be16 regval;
+	int ret;
+
+	ret = regmap_raw_read(pdata->bq->regmap, reg, &regval, sizeof(regval));
+	if (ret)
+		return ret;
+
+	*val = be16_to_cpu(regval);
+	return 0;
+}
+
+/**
+ * bq25792_write16() - Write a 16-bit value to device register
+ * @pdata: driver platform data
+ * @reg: register address to write to
+ * @val: 16-bit value to write in CPU byte order
+ *
+ * Convert the value to big-endian and write a 16-bit value to the
+ * BQ25792 device via regmap.
+ *
+ * Return: Returns 0 on success or error on failure to write.
+ */
+static int bq25792_write16(struct bq257xx_chg *pdata, unsigned int reg, u16 val)
+{
+	__be16 regval = cpu_to_be16(val);
+	int ret;
+
+	ret = regmap_raw_write(pdata->bq->regmap, reg, &regval, sizeof(regval));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 /**
  * bq25703_get_state() - Get the current state of the device
  * @pdata: driver platform data
@@ -119,6 +167,43 @@ static int bq25703_get_state(struct bq257xx_chg *pdata)
 	return 0;
 }
 
+/**
+ * bq25792_get_state() - Get the current state of the device
+ * @pdata: driver platform data
+ *
+ * Get the current state of the BQ25792 charger by reading status
+ * registers. Updates the online, charging, overvoltage, and fault
+ * status fields in the driver data structure.
+ *
+ * Return: Returns 0 on success or error on failure to read device.
+ */
+static int bq25792_get_state(struct bq257xx_chg *pdata)
+{
+	unsigned int reg;
+	int ret;
+
+	ret = regmap_read(pdata->bq->regmap, BQ25792_REG1B_CHARGER_STATUS_0, &reg);
+	if (ret)
+		return ret;
+
+	pdata->online = reg & BQ25792_REG1B_PG_STAT;
+
+	ret = regmap_read(pdata->bq->regmap, BQ25792_REG1C_CHARGER_STATUS_1, &reg);
+	if (ret)
+		return ret;
+
+	pdata->charging = reg & BQ25792_REG1C_CHG_STAT_MASK;
+
+	ret = regmap_read(pdata->bq->regmap, BQ25792_REG20_FAULT_STATUS_0, &reg);
+	if (ret)
+		return ret;
+
+	pdata->overvoltage = reg & BQ25792_REG20_OVERVOLTAGE_MASK;
+	pdata->oc_fault = reg & BQ25792_REG20_OVERCURRENT_MASK;
+
+	return 0;
+}
+
 /**
  * bq25703_get_min_vsys() - Get the minimum system voltage
  * @pdata: driver platform data
@@ -142,6 +227,31 @@ static int bq25703_get_min_vsys(struct bq257xx_chg *pdata, int *intval)
 	return ret;
 }
 
+/**
+ * bq25792_get_min_vsys() - Get the minimum system voltage
+ * @pdata: driver platform data
+ * @intval: pointer to store the minimum voltage value
+ *
+ * Read the current minimum system voltage setting from the device
+ * and return it in microvolts.
+ *
+ * Return: Returns 0 on success or error on failure to read.
+ */
+static int bq25792_get_min_vsys(struct bq257xx_chg *pdata, int *intval)
+{
+	unsigned int reg;
+	int ret;
+
+	ret = regmap_read(pdata->bq->regmap, BQ25792_REG00_MIN_SYS_VOLTAGE, &reg);
+	if (ret)
+		return ret;
+
+	reg = FIELD_GET(BQ25792_REG00_VSYSMIN_MASK, reg);
+	*intval = (reg * BQ25792_MINVSYS_STEP_UV) + BQ25792_MINVSYS_MIN_UV;
+
+	return ret;
+}
+
 /**
  * bq25703_set_min_vsys() - Set the minimum system voltage
  * @pdata: driver platform data
@@ -166,6 +276,29 @@ static int bq25703_set_min_vsys(struct bq257xx_chg *pdata, int vsys)
 			    reg);
 }
 
+/**
+ * bq25792_set_min_vsys() - Set the minimum system voltage
+ * @pdata: driver platform data
+ * @vsys: voltage value to set in uV
+ *
+ * Set the minimum system voltage by clamping the requested value
+ * between device limits and writing to the appropriate register.
+ *
+ * Return: Returns 0 on success or error on failure to write.
+ */
+static int bq25792_set_min_vsys(struct bq257xx_chg *pdata, int vsys)
+{
+	unsigned int reg;
+	int vsys_min = pdata->vsys_min;
+
+	vsys = clamp(vsys, vsys_min, BQ25792_MINVSYS_MAX_UV);
+	reg = ((vsys - BQ25792_MINVSYS_MIN_UV) / BQ25792_MINVSYS_STEP_UV);
+	reg = FIELD_PREP(BQ25792_REG00_VSYSMIN_MASK, reg);
+
+	return regmap_write(pdata->bq->regmap,
+			    BQ25792_REG00_MIN_SYS_VOLTAGE, reg);
+}
+
 /**
  * bq25703_get_cur() - Get the reported current from the battery
  * @pdata: driver platform data
@@ -195,6 +328,30 @@ static int bq25703_get_cur(struct bq257xx_chg *pdata, int *intval)
 	return ret;
 }
 
+/**
+ * bq25792_get_cur() - Get the reported current from the battery
+ * @pdata: driver platform data
+ * @intval: pointer to store the battery current value
+ *
+ * Read the current ADC value from the device representing the battery
+ * charge or discharge current and return it in microamps.
+ *
+ * Return: Returns 0 on success or error on failure to read.
+ */
+static int bq25792_get_cur(struct bq257xx_chg *pdata, int *intval)
+{
+	u16 reg;
+	int ret;
+
+	ret = bq25792_read16(pdata, BQ25792_REG33_IBAT_ADC, &reg);
+	if (ret < 0)
+		return ret;
+
+	*intval = (s16)reg * BQ25792_ADCIBAT_STEP_UA;
+
+	return ret;
+}
+
 /**
  * bq25703_get_ichg_cur() - Get the maximum reported charge current
  * @pdata: driver platform data
@@ -218,6 +375,30 @@ static int bq25703_get_ichg_cur(struct bq257xx_chg *pdata, int *intval)
 	return ret;
 }
 
+/**
+ * bq25792_get_ichg_cur() - Get the maximum reported charge current
+ * @pdata: driver platform data
+ * @intval: pointer to store the maximum charge current value
+ *
+ * Read the programmed maximum charge current limit from the device.
+ *
+ * Return: Returns 0 on success or error on failure to read value.
+ */
+static int bq25792_get_ichg_cur(struct bq257xx_chg *pdata, int *intval)
+{
+	u16 reg;
+	int ret;
+
+	ret = bq25792_read16(pdata, BQ25792_REG03_CHARGE_CURRENT_LIMIT, &reg);
+	if (ret)
+		return ret;
+
+	*intval = FIELD_GET(BQ25792_REG03_ICHG_MASK, reg) *
+		  BQ25792_ICHG_STEP_UA;
+
+	return ret;
+}
+
 /**
  * bq25703_set_ichg_cur() - Set the maximum charge current
  * @pdata: driver platform data
@@ -242,6 +423,28 @@ static int bq25703_set_ichg_cur(struct bq257xx_chg *pdata, int ichg)
 			    reg);
 }
 
+/**
+ * bq25792_set_ichg_cur() - Set the maximum charge current
+ * @pdata: driver platform data
+ * @ichg: current value to set in uA
+ *
+ * Set the maximum charge current by clamping the requested value
+ * between device limits and writing to the appropriate register.
+ *
+ * Return: Returns 0 on success or error on failure to write.
+ */
+static int bq25792_set_ichg_cur(struct bq257xx_chg *pdata, int ichg)
+{
+	int ichg_max = pdata->ichg_max;
+	u16 reg;
+
+	ichg = clamp(ichg, BQ25792_ICHG_MIN_UA, ichg_max);
+	reg = FIELD_PREP(BQ25792_REG03_ICHG_MASK,
+			 (ichg / BQ25792_ICHG_STEP_UA));
+
+	return bq25792_write16(pdata, BQ25792_REG03_CHARGE_CURRENT_LIMIT, reg);
+}
+
 /**
  * bq25703_get_chrg_volt() - Get the maximum set charge voltage
  * @pdata: driver platform data
@@ -265,6 +468,30 @@ static int bq25703_get_chrg_volt(struct bq257xx_chg *pdata, int *intval)
 	return ret;
 }
 
+/**
+ * bq25792_get_chrg_volt() - Get the maximum set charge voltage
+ * @pdata: driver platform data
+ * @intval: pointer to store the maximum charge voltage value
+ *
+ * Read the current charge voltage limit from the device.
+ *
+ * Return: Returns 0 on success or error on failure to read value.
+ */
+static int bq25792_get_chrg_volt(struct bq257xx_chg *pdata, int *intval)
+{
+	u16 reg;
+	int ret;
+
+	ret = bq25792_read16(pdata, BQ25792_REG01_CHARGE_VOLTAGE_LIMIT, &reg);
+	if (ret)
+		return ret;
+
+	*intval = FIELD_GET(BQ25792_REG01_VREG_MASK, reg) *
+		  BQ25792_VBATREG_STEP_UV;
+
+	return ret;
+}
+
 /**
  * bq25703_set_chrg_volt() - Set the maximum charge voltage
  * @pdata: driver platform data
@@ -291,6 +518,29 @@ static int bq25703_set_chrg_volt(struct bq257xx_chg *pdata, int vbat)
 			    reg);
 }
 
+/**
+ * bq25792_set_chrg_volt() - Set the maximum charge voltage
+ * @pdata: driver platform data
+ * @vbat: voltage value to set in uV
+ *
+ * Set the maximum charge voltage by clamping the requested value
+ * between device limits and writing to the appropriate register.
+ *
+ * Return: Returns 0 on success or error on failure to write.
+ */
+static int bq25792_set_chrg_volt(struct bq257xx_chg *pdata, int vbat)
+{
+	int vbat_max = pdata->vbat_max;
+	u16 reg;
+
+	vbat = clamp(vbat, BQ25792_VBATREG_MIN_UV, vbat_max);
+
+	reg = FIELD_PREP(BQ25792_REG01_VREG_MASK,
+			 (vbat / BQ25792_VBATREG_STEP_UV));
+
+	return bq25792_write16(pdata, BQ25792_REG01_CHARGE_VOLTAGE_LIMIT, reg);
+}
+
 /**
  * bq25703_get_iindpm() - Get the maximum set input current
  * @pdata: driver platform data
@@ -319,6 +569,30 @@ static int bq25703_get_iindpm(struct bq257xx_chg *pdata, int *intval)
 	return ret;
 }
 
+/**
+ * bq25792_get_iindpm() - Get the maximum set input current
+ * @pdata: driver platform data
+ * @intval: pointer to store the maximum input current value
+ *
+ * Read the current input current limit from the device.
+ *
+ * Return: Returns 0 on success or error on failure to read value.
+ */
+static int bq25792_get_iindpm(struct bq257xx_chg *pdata, int *intval)
+{
+	u16 reg;
+	int ret;
+
+	ret = bq25792_read16(pdata, BQ25792_REG06_INPUT_CURRENT_LIMIT, &reg);
+	if (ret)
+		return ret;
+
+	reg = FIELD_GET(BQ25792_REG06_IINDPM_MASK, reg);
+	*intval = reg * BQ25792_IINDPM_STEP_UA;
+
+	return ret;
+}
+
 /**
  * bq25703_set_iindpm() - Set the maximum input current
  * @pdata: driver platform data
@@ -344,6 +618,29 @@ static int bq25703_set_iindpm(struct bq257xx_chg *pdata, int iindpm)
 			    FIELD_PREP(BQ25703_IINDPM_MASK, reg));
 }
 
+/**
+ * bq25792_set_iindpm() - Set the maximum input current
+ * @pdata: driver platform data
+ * @iindpm: current value in uA
+ *
+ * Set the maximum input current by clamping the requested value
+ * between device limits and writing to the appropriate register.
+ *
+ * Return: Returns 0 on success or error on failure to write.
+ */
+static int bq25792_set_iindpm(struct bq257xx_chg *pdata, int iindpm)
+{
+	u16 reg;
+	int iindpm_max = pdata->iindpm_max;
+
+	iindpm = clamp(iindpm, BQ25792_IINDPM_MIN_UA, iindpm_max);
+
+	reg = iindpm / BQ25792_IINDPM_STEP_UA;
+
+	return bq25792_write16(pdata, BQ25792_REG06_INPUT_CURRENT_LIMIT,
+			       FIELD_PREP(BQ25792_REG06_IINDPM_MASK, reg));
+}
+
 /**
  * bq25703_get_vbat() - Get the reported voltage from the battery
  * @pdata: driver platform data
@@ -368,6 +665,30 @@ static int bq25703_get_vbat(struct bq257xx_chg *pdata, int *intval)
 	return ret;
 }
 
+/**
+ * bq25792_get_vbat() - Get the reported voltage from the battery
+ * @pdata: driver platform data
+ * @intval: pointer to store the battery voltage value
+ *
+ * Read the current ADC value representing the battery voltage
+ * and return it in microvolts.
+ *
+ * Return: Returns 0 on success or error on failure to read value.
+ */
+static int bq25792_get_vbat(struct bq257xx_chg *pdata, int *intval)
+{
+	u16 reg;
+	int ret;
+
+	ret = bq25792_read16(pdata, BQ25792_REG3B_VBAT_ADC, &reg);
+	if (ret)
+		return ret;
+
+	*intval = reg * BQ25792_ADCVSYSVBAT_STEP_UV;
+
+	return ret;
+}
+
 /**
  * bq25703_hw_init() - Set all the required registers to init the charger
  * @pdata: driver platform data
@@ -434,6 +755,62 @@ static int bq25703_hw_init(struct bq257xx_chg *pdata)
 	return ret;
 }
 
+/**
+ * bq25792_hw_init() - Initialize BQ25792 hardware
+ * @pdata: driver platform data
+ *
+ * Initialize the BQ25792 by disabling the watchdog, enabling discharge
+ * current sensing with 5A limit, and configuring input current regulation.
+ * Set the charge current, charge voltage, minimum system voltage, and
+ * input current limit from platform data. Enable and configure the ADC
+ * to measure all available channels.
+ *
+ * Return: Returns 0 on success or error code on error.
+ */
+static int bq25792_hw_init(struct bq257xx_chg *pdata)
+{
+	struct regmap *regmap = pdata->bq->regmap;
+	int ret = 0;
+
+	/* Disable watchdog (TODO: make it work instead) */
+	regmap_write(regmap, BQ25792_REG10_CHARGER_CONTROL_1, 0);
+
+	/*
+	 * Enable battery discharge current sensing, 5A discharge current
+	 * limit, input current regulation and ship FET functions
+	 */
+	regmap_write(regmap, BQ25792_REG14_CHARGER_CONTROL_5,
+		     BQ25792_REG14_SFET_PRESENT |
+		     BQ25792_REG14_EN_IBAT |
+		     BQ25792_IBAT_5A |
+		     BQ25792_REG14_EN_IINDPM);
+
+	ret = pdata->chip->bq257xx_set_ichg(pdata, pdata->ichg_max);
+	if (ret)
+		return ret;
+
+	ret = pdata->chip->bq257xx_set_vbatreg(pdata, pdata->vbat_max);
+	if (ret)
+		return ret;
+
+	ret = bq25792_set_min_vsys(pdata, pdata->vsys_min);
+	if (ret)
+		return ret;
+
+	ret = pdata->chip->bq257xx_set_iindpm(pdata, pdata->iindpm_max);
+	if (ret)
+		return ret;
+
+	/* Enable the ADC. */
+	regmap_write(regmap, BQ25792_REG2E_ADC_CONTROL, BQ25792_REG2E_ADC_EN);
+
+	/* Clear per-channel ADC disable bits - enable all channels */
+	regmap_write(regmap, BQ25792_REG2F_ADC_FUNCTION_DISABLE_0, 0);
+	regmap_write(regmap, BQ25792_REG30_ADC_FUNCTION_DISABLE_1, 0);
+
+	return ret;
+}
+
 /**
  * bq25703_hw_shutdown() - Set registers for shutdown
  * @pdata: driver platform data
@@ -446,6 +823,30 @@ static void bq25703_hw_shutdown(struct bq257xx_chg *pdata)
 			   BQ25703_EN_LWPWR, BQ25703_EN_LWPWR);
 }
 
+/**
+ * bq25792_hw_shutdown() - Shutdown BQ25792 hardware
+ * @pdata: driver platform data
+ *
+ * Perform hardware shutdown for the BQ25792. Currently a no-op
+ * as the device does not require special shutdown configuration.
+ */
+static void bq25792_hw_shutdown(struct bq257xx_chg *pdata)
+{
+	/* Nothing to do here */
+}
+
+/**
+ * bq257xx_set_charger_property() - Set a power supply property
+ * @psy: power supply device
+ * @prop: power supply property to set
+ * @val: value to set for the property
+ *
+ * Handle requests to set power supply properties such as input current
+ * limit, constant charge voltage, and constant charge current. Routes
+ * the request to the chip-specific implementation.
+ *
+ * Return: Returns 0 on success or -EINVAL if property is not supported.
+ */
 static int bq257xx_set_charger_property(struct power_supply *psy,
 		enum power_supply_property prop,
 		const union power_supply_propval *val)
@@ -469,6 +870,19 @@ static int bq257xx_set_charger_property(struct power_supply *psy,
 	return -EINVAL;
 }
 
+/**
+ * bq257xx_get_charger_property() - Get a power supply property
+ * @psy: power supply device
+ * @psp: power supply property to get
+ * @val: pointer to store the property value
+ *
+ * Handle requests to get power supply properties, including status,
+ * health, manufacturer, online state, and various voltage/current
+ * measurements. Reads current device state and routes chip-specific
+ * property requests to appropriate handlers.
+ *
+ * Return: Returns 0 on success or -EINVAL if property is not supported.
+ */
 static int bq257xx_get_charger_property(struct power_supply *psy,
 				enum power_supply_property psp,
 				union power_supply_propval *val)
@@ -550,6 +964,17 @@ static enum power_supply_property bq257xx_power_supply_props[] = {
 	POWER_SUPPLY_PROP_USB_TYPE,
 };
 
+/**
+ * bq257xx_property_is_writeable() - Check if a property is writeable
+ * @psy: power supply device
+ * @prop: power supply property to check
+ *
+ * Determines which power supply properties can be written to. Only
+ * charge current limit, charge voltage limit, and input current
+ * limit are writeable.
+ *
+ * Return: Returns 1 if property is writeable, 0 otherwise.
+ */
 static int bq257xx_property_is_writeable(struct power_supply *psy,
 					 enum power_supply_property prop)
 {
@@ -622,6 +1047,17 @@ static void bq257xx_external_power_changed(struct power_supply *psy)
 	power_supply_changed(psy);
 }
 
+/**
+ * bq257xx_irq_handler_thread() - Handle charger interrupt
+ * @irq: interrupt number
+ * @private: pointer to driver private data
+ *
+ * Thread handler for charger interrupts. Triggers re-evaluation of
+ * external power status and updates power supply state in response
+ * to charger events.
+ *
+ * Return: Returns IRQ_HANDLED if interrupt was processed.
+ */
 static irqreturn_t bq257xx_irq_handler_thread(int irq, void *private)
 {
 	struct bq257xx_chg *pdata = private;
@@ -662,6 +1098,22 @@ static const struct bq257xx_chip_info bq25703_chip_info = {
 		.bq257xx_get_min_vsys = &bq25703_get_min_vsys,
 };
 
+static const struct bq257xx_chip_info bq25792_chip_info = {
+		.default_iindpm_uA = BQ25792_IINDPM_DEFAULT_UA,
+		.bq257xx_hw_init = &bq25792_hw_init,
+		.bq257xx_hw_shutdown = &bq25792_hw_shutdown,
+		.bq257xx_get_state = &bq25792_get_state,
+		.bq257xx_get_ichg = &bq25792_get_ichg_cur,
+		.bq257xx_set_ichg = &bq25792_set_ichg_cur,
+		.bq257xx_get_vbatreg = &bq25792_get_chrg_volt,
+		.bq257xx_set_vbatreg = &bq25792_set_chrg_volt,
+		.bq257xx_get_iindpm = &bq25792_get_iindpm,
+		.bq257xx_set_iindpm = &bq25792_set_iindpm,
+		.bq257xx_get_cur = &bq25792_get_cur,
+		.bq257xx_get_vbat = &bq25792_get_vbat,
+		.bq257xx_get_min_vsys = &bq25792_get_min_vsys,
+};
+
 /**
  * bq257xx_parse_dt() - Parse the device tree for required properties
  * @pdata: driver platform data
@@ -707,6 +1159,17 @@ static int bq257xx_parse_dt(struct bq257xx_chg *pdata,
 	return 0;
 }
 
+/**
+ * bq257xx_charger_probe() - Probe routine for charger platform device
+ * @pdev: platform device
+ *
+ * Probe the charger device, allocate driver data structure, select the
+ * appropriate chip-specific function pointers, register the power supply,
+ * parse device tree properties for battery limits, initialize hardware,
+ * and set up the interrupt handler if available.
+ *
+ * Return: Returns 0 on success or error code on failure.
+ */
 static int bq257xx_charger_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -722,7 +1185,17 @@ static int bq257xx_charger_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pdata->bq = bq;
-	pdata->chip = &bq25703_chip_info;
+
+	switch (bq->type) {
+	case BQ25703A:
+		pdata->chip = &bq25703_chip_info;
+		break;
+	case BQ25792:
+		pdata->chip = &bq25792_chip_info;
+		break;
+	default:
+		return dev_err_probe(dev, -EINVAL, "Unknown chip type\n");
+	}
 
 	platform_set_drvdata(pdev, pdata);
 
@@ -760,6 +1233,13 @@ static int bq257xx_charger_probe(struct platform_device *pdev)
 	return ret;
 }
 
+/**
+ * bq257xx_charger_shutdown() - Shutdown routine for charger platform device
+ * @pdev: platform device
+ *
+ * Called during system shutdown to perform charger cleanup, including
+ * disabling watchdog timers or other chip-specific shutdown procedures.
+ */
 static void bq257xx_charger_shutdown(struct platform_device *pdev)
 {
 	struct bq257xx_chg *pdata = platform_get_drvdata(pdev);

-- 
2.52.0

