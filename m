Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59369357D0F
	for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2026 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431105; cv=none; b=ClXqCKfrsQ/4CJX2P2NX2CRvW3nnFKlNonaCvayCthHiLQ/HjmAWDITch6+6tNmr4XrhsnazveneAGl5nqsqGxbbVU2ssOaYHasLnokB59BNJJnwuSniImRL0rsWfaAelvKWgfnQ/I6+xFeo//BQjRdi8EooTrZVPmmpy19Qw2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431105; c=relaxed/simple;
	bh=/fVBmG3pmMKGALtVvTpYeCS9ORu92oU+m2HRFoAvhO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dNvej59kGqI5w21eUKutRa2tmCDIABBkPYYB77l6VYnZxZvtllynUBGVCNxHz5L6v3DFlTp4dM6PuEkZ0Ct1VR6DDSlHwQNa0/RysWt3yQzHiJZp8yKVCsw3AgRGc5xA0n3ExUkFHsPbYH+ljwOF5NcDILSeR4KTtDx8Uro9a98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=y3MeGbCO; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="y3MeGbCO"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45eec22fab7so3084968f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 13:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1780431101; x=1781035901; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mhj/ojkVt6E05/4dVLAx3+2ix9jxvERKRunvW8ZUReg=;
        b=y3MeGbCOVY1eVEBiASiCHCNqdE5rIjPMCfs9k1cLdpLUB+rQwWmbXmSj9gKHy/C620
         8N/+l3y4/uEWDP/zrzIxG+xb4GiBWISFOYsx++0kq98aOpLbxda0NRNjlaUHPN1Uwenf
         LVsu70KqUzmsLTKxegtt7tRS2KIMioh4Wm5xrmMNWMM9EndiOJHFNW4J2fLli5n8N4VB
         yupHC3XoAW8C3GfOglplThnmhY6cVfgeBprSwg+bihz96mU3ifafWBXQKRfpuS0ywd1S
         FWIi/PR34jCZnmceRFA9no8Gi1neubgYMO9oaLLQgfSQpw2nmgbwPVAbVnsDp/YNtPA+
         fCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780431101; x=1781035901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mhj/ojkVt6E05/4dVLAx3+2ix9jxvERKRunvW8ZUReg=;
        b=AsZKw1ttXZUX9MSzI6OTys1ZzaLcGRmb9yZ5bad6LiljHCc7Esesquz2nN17o8ln8e
         nidH8PnR8V02XNTDkzR8brnof5XiqoFITIPt8SDjEYBv/3xmdvj4/iQQRA7DAR0XSQJ0
         XAgmhhh/RlE6+dsupRh5u9LIo1dXpFtuQUFKuR3a8RyesG1++g97Eg6zkCnp8lQ9Wv31
         jqvxKHzU6TpWb/xqw8mhFUsSOCYYxL4CynEU5pPPkzmYPDX++5DHKBi+FOskqBzv3mY5
         X1Uv2A28mL95Xp76Zcp3Ux2fqnWNILbNReH2//fi79QRoq1dp/Rm/Ibw9CGjDaoF9YIa
         uQfw==
X-Forwarded-Encrypted: i=1; AFNElJ9uAhwLG/NnRjh2B5F74b2qIYaoLQl2znFn0PGFxbhxFKJsBDzXeJu2kerq6NgkvUQcZPO0v81HHA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2AOv0vKASJtuv0eG6GS1+4HUzUy8q2TgyIu8R5sSBvORbC3Io
	ztQ4SpLLsnyeQwgoqGlKFesYfqOU+/+nv0ON+UisOGfD85lEbPhaR0R4qrVFPRr1uPM=
X-Gm-Gg: Acq92OH8nOIX218zHrWLGMwGqav/ow+RYSqATPOHphM7tx6v/76GkcmWzEgF2Ugn0Cw
	kDjNEEB26IG9K8Ak6pj3azVNE6mR6w3UJFyvzhXseFLHNFNysYMMTpKQjhH8/L2MEs+lho2+kcH
	tRDBDuUikKvewFMsuWMxk3us+q+OmYccEwARTOZlWk9OJe3wyf4hW4Ey4YjlyJnQPlafEp/KqdV
	5sdB1yzDc/yaPLs4eTVHnpSlvCU2tJTjugJOWH30Ys3QBRDj0faQOgNoFYa/rsMw9ZhL4HyAa2d
	VTy6tuE069XMlAseaPic6E0iBogQqKLOJhYn+OfSEm3W+IQ64RXyJntJF9P+TUs4J3knOstumni
	wgCQ4lvAPCOsGla7fJo1Lu6OxbV8ks0ecHh466r54XB3BrOHHyf7/RTkfOfZjhKNOrkSLjde47+
	o0Alyg+4tC1qz2086lsT7Ex2Pq99isPfI2NbTPw7AN43HRIJQ1pbGRDyUypx4VHg==
X-Received: by 2002:a05:600c:468f:b0:490:44eb:c1e5 with SMTP id 5b1f17b1804b1-490b5e8cc4cmr4607765e9.31.1780431100572;
        Tue, 02 Jun 2026 13:11:40 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63e6720sm2588515e9.13.2026.06.02.13.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:11:40 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 03 Jun 2026 00:10:55 +0400
Subject: [PATCH v7 7/7] power: supply: bq257xx: Add support for BQ25792
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-bq25792-v7-7-d487bed276d0@flipper.net>
References: <20260603-bq25792-v7-0-d487bed276d0@flipper.net>
In-Reply-To: <20260603-bq25792-v7-0-d487bed276d0@flipper.net>
To: Chris Morgan <macromorgan@hotmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=22570; i=alchark@flipper.net;
 h=from:subject:message-id; bh=/fVBmG3pmMKGALtVvTpYeCS9ORu92oU+m2HRFoAvhO0=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTJWzwPC7oR03so8fQqqx1pp770z0s9cmH/jA98V0okL
 95dpuDL0DGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBU33jPyPC/fn2w346bPPUZ1+dFW2/qL1swRTZUQ+/hu7JAY105bjtGhsdb8rr
 uPXMprT+vJvumS0dZbvrBN7JxS87e8rLjkpxykRsA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Add support for TI BQ25792 integrated battery charger and buck-boost
converter.

It shares high-level logic of operation with the already supported
BQ25703A, but has a different register map, bit definitions and some of
the lower-level hardware states.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 528 ++++++++++++++++++++++++++++++++-
 include/linux/mfd/bq257xx.h            |  14 +
 2 files changed, 541 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index 9c082865e745..7d02169248b1 100644
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
@@ -434,6 +755,108 @@ static int bq25703_hw_init(struct bq257xx_chg *pdata)
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
+	u8 reg;
+
+	/* Disable watchdog (TODO: make it work instead) */
+	ret = regmap_write(regmap, BQ25792_REG10_CHARGER_CONTROL_1, 0);
+	if (ret)
+		return ret;
+
+	/*
+	 * Enable battery discharge current sensing, 5A discharge current
+	 * limit, input current regulation and ship FET functions
+	 */
+	ret = regmap_write(regmap, BQ25792_REG14_CHARGER_CONTROL_5,
+			   BQ25792_REG14_SFET_PRESENT |
+			   BQ25792_REG14_EN_IBAT |
+			   BQ25792_IBAT_5A |
+			   BQ25792_REG14_EN_IINDPM);
+	if (ret)
+		return ret;
+
+	if (pdata->vbat_max < 5000000) {
+		/* 1S batteries */
+		reg = FIELD_PREP(BQ25792_REG0A_CELL_MASK, BQ25792_CELL_1S);
+	} else if (pdata->vbat_max < 10000000) {
+		/* 2S batteries */
+		reg = FIELD_PREP(BQ25792_REG0A_CELL_MASK, BQ25792_CELL_2S);
+	} else if (pdata->vbat_max < 14000000) {
+		/* 3S batteries */
+		reg = FIELD_PREP(BQ25792_REG0A_CELL_MASK, BQ25792_CELL_3S);
+	} else {
+		/* 4S batteries */
+		reg = FIELD_PREP(BQ25792_REG0A_CELL_MASK, BQ25792_CELL_4S);
+	}
+
+	/* Recharge voltage detection deglitch time (default 1024ms) */
+	reg |= FIELD_PREP(BQ25792_REG0A_TRECHG_MASK, BQ25792_TRECHG_1024MS);
+
+	/* Recharge voltage offset: 5% of the set charge voltage */
+	reg |= FIELD_PREP(BQ25792_REG0A_VRECHG_MASK,
+			  (pdata->vbat_max / 20 - BQ25792_VRECHG_MIN_UV) / BQ25792_VRECHG_STEP_UV);
+
+	ret = regmap_write(regmap, BQ25792_REG0A_RECHARGE_CONTROL, reg);
+	if (ret)
+		return ret;
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
+	/* Enable the Input Current Optimizer (the rest is at POR value) */
+	ret = regmap_write(regmap, BQ25792_REG0F_CHARGER_CONTROL_0,
+			   BQ25792_REG0F_EN_AUTO_IBATDIS |
+			   BQ25792_REG0F_EN_CHG |
+			   BQ25792_REG0F_EN_ICO |
+			   BQ25792_REG0F_EN_TERM);
+	if (ret)
+		return ret;
+
+	/* Enable the ADC. */
+	ret = regmap_write(regmap, BQ25792_REG2E_ADC_CONTROL, BQ25792_REG2E_ADC_EN);
+	if (ret)
+		return ret;
+
+	/* Clear per-channel ADC disable bits - enable all channels */
+	ret = regmap_write(regmap, BQ25792_REG2F_ADC_FUNCTION_DISABLE_0, 0);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(regmap, BQ25792_REG30_ADC_FUNCTION_DISABLE_1, 0);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
 /**
  * bq25703_hw_shutdown() - Set registers for shutdown
  * @pdata: driver platform data
@@ -446,6 +869,30 @@ static void bq25703_hw_shutdown(struct bq257xx_chg *pdata)
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
@@ -469,6 +916,19 @@ static int bq257xx_set_charger_property(struct power_supply *psy,
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
@@ -550,6 +1010,17 @@ static enum power_supply_property bq257xx_power_supply_props[] = {
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
@@ -622,6 +1093,17 @@ static void bq257xx_external_power_changed(struct power_supply *psy)
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
@@ -662,6 +1144,22 @@ static const struct bq257xx_chip_info bq25703_chip_info = {
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
@@ -707,6 +1205,17 @@ static int bq257xx_parse_dt(struct bq257xx_chg *pdata,
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
@@ -722,7 +1231,17 @@ static int bq257xx_charger_probe(struct platform_device *pdev)
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
 
@@ -760,6 +1279,13 @@ static int bq257xx_charger_probe(struct platform_device *pdev)
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
diff --git a/include/linux/mfd/bq257xx.h b/include/linux/mfd/bq257xx.h
index 4ec72eb920f2..379ef4ee8291 100644
--- a/include/linux/mfd/bq257xx.h
+++ b/include/linux/mfd/bq257xx.h
@@ -200,6 +200,20 @@
 #define BQ25792_REG0A_TRECHG_MASK		GENMASK(5, 4)
 #define BQ25792_REG0A_VRECHG_MASK		GENMASK(3, 0)
 
+#define BQ25792_CELL_1S				0
+#define BQ25792_CELL_2S				1
+#define BQ25792_CELL_3S				2
+#define BQ25792_CELL_4S				3
+
+#define BQ25792_TRECHG_64MS			0
+#define BQ25792_TRECHG_256MS			1
+#define BQ25792_TRECHG_1024MS			2
+#define BQ25792_TRECHG_2048MS			3
+
+#define BQ25792_VRECHG_MIN_UV			50000
+#define BQ25792_VRECHG_STEP_UV			50000
+#define BQ25792_VRECHG_MAX_UV			800000
+
 /* VOTG regulation */
 #define BQ25792_REG0B_VOTG_MASK			GENMASK(10, 0)
 

-- 
2.53.0

