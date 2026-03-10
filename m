Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07C144BC91
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 09:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134980; cv=none; b=STL5UuXCK0qN0CQ0Hj4K09tWZgmYg0wm42oby7J3kd7JdkqEidThoUBDRIsEXQXh6tlaiML/jhv7PAjS6Qv2Ogm0dWJ+MZZV4utECY1F32Meah43uYkGeHmdV/9m+PN5aYoh1exJ1nzO4/Ox3kXOQfwZqmepsK48/UY+O2WNLRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134980; c=relaxed/simple;
	bh=FwG9A84SLXtf/UKZlp7MYYLSt2H9Jv4dNseNtGkkscI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LaAyd1ezGNaZiL8nfIME26mBe8YuYgGB16y4shuvLvpf4yDCtPoP6u82UOcGz/5IjhqL1/yGaHk9HQMqrwVl3peKRkeIIa/29qSXnntv5DzWSwh/O171sjTN1tqNa7paTwftUkYuyqsA/3KrhuumLC8unfzxBDHAtGZy/FuLwD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=o9JXEvwf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="o9JXEvwf"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852fdb36a8so33425775e9.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 02:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773134977; x=1773739777; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYcWbBThtSnaMdWV6+Ti7cq+NwatFUoWBz0VjirVfYk=;
        b=o9JXEvwfNKyvTAJhilYdgnHQzN4leWHvwNmsVd7A3zBy+PY4GZ89y5FLwloYddcF6E
         mpLupe3+AGTMEElxDtkicAJ4utGN7qgxIa3/r30NHa8dlnCjN3tMzh41ndB9qCt6u1K0
         GuOFQykaaEyodsrqrxVWUkClhw2OcWfJkXv/t9MgGQmSaA+xlBD5knwuOaPR2u75TLkc
         /1tcbZA/2FYkahizBGPgAYF4fBf7inmHpMHOSzlCRbUz++Dl8BnxIaAdwgLggwZrSl9q
         dEan+mdiQ+SdwVMrtzFiQC0r95kdFZlWiOlctzP2lNqJ2+4x3DjiyPosFd582Ew1XNiU
         HdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134977; x=1773739777;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AYcWbBThtSnaMdWV6+Ti7cq+NwatFUoWBz0VjirVfYk=;
        b=TcCsW6V1pXeqSuOt4Dm7NyIHJXxG7eEqhZOoQ5mHuo6oD7SqTZ2MzRZwRvQuYaoOl0
         hArTLWSUPaoVhm0wWPNgzpDg3ale2xT6MCR/5Pw1WfqGpH38sjOQN/vOCpRx0dLInOLb
         f7Cssieq7XYAt3I7UBvYh2JlpZktyENh0SeCxR1Cj+7BLVRKoveNzoFVsunyhQPUJs4a
         8/AC4Pdd6Xsj8meNQVS7Zc2CbzuT2Z/QQRxQGXNgfaLAsRAAZNmLILM4QznGvIiBhNZI
         U4hAs2WDAhZwxnIIelG/UibRrWQhXa8wRm2m8hKSoCLIEVqQcgwesHc33JjaD5n6Urxc
         Gi/A==
X-Forwarded-Encrypted: i=1; AJvYcCUXlhmPFyIW1q5xXpGb9zyLbJwAgoK+LkrAN0wGVuVwxsdgRllP271cEM+slwLvUlvcdtwk36iSrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYCxsGWI7kwe3qRo3W8c+Xzr8wvpRj67t+OXGqpND9t7ItZstQ
	raUcXhu5LQ3JJPcoH+fRh7r0//Rn+E+YEORiFjw4I0tq5owkC2iMg1UAclp6Wk4/KX8=
X-Gm-Gg: ATEYQzzhNtB3ZAnQDS0YYB+Xb65WH7Lo+f8gi+K6AESOgNH3QzHwALJQKJnU2sC5fUS
	gtIvQ/tRyaaiwxCSgmVa/dgJxVyu3hT85OlsDcnj9cqbkMexJ39Q0WcYAncWKW3UF8QRWTC04WZ
	j2JOrzMPvEC5HAsOdnr9QVWP22ljC/OIJASxDqWNR+s9BxW1DYwpDYgyQ2+DOr2BzBDQl3Ylqo3
	6ESWdqga7E72kh3ioteJujs/07iklEIBJFUjs4VHJoTgiIn5Met+jTskzw/bezOot3o+aS2HqPn
	6UJdZQub7mGSUND3sp3dorK6C+Pb9Iwy8VEK0pB3zntYwnuqWDZptcCb9rjDOQi2so9+4klyOAR
	AvbQ1r1NOR1+rkUf84qBFNWrMBJBIfWWhaVDalYJjQ/i5NCGzrWPa2i6xTg8iBdmx9cjMee2qlV
	MWPddsywTCa0BpxEYvt1IX+xl74JnXfsFl7wB8KFPvyx4vvjlhZi6uhAD+VH2QaBauWD52fD9tV
	J4irg==
X-Received: by 2002:a05:600c:3b89:b0:485:3f1c:d8a4 with SMTP id 5b1f17b1804b1-4853f1cda4cmr79633425e9.9.1773134976888;
        Tue, 10 Mar 2026 02:29:36 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48529f019a4sm104214285e9.12.2026.03.10.02.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:29:36 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 10 Mar 2026 13:28:35 +0400
Subject: [PATCH v3 11/11] power: supply: bq257xx: Add support for BQ25792
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-bq25792-v3-11-02f8e232d63b@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=22912; i=alchark@flipper.net;
 h=from:subject:message-id; bh=FwG9A84SLXtf/UKZlp7MYYLSt2H9Jv4dNseNtGkkscI=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSuf5J0Wv/Iz+vGnsUHdarjA7bbTHt/Z88Rhu0fj+/cO
 CldJeDw/I6JLAxiXAyWYoosc78tsZ1qxDdrl4fHV5g5rEwgQ6RFGhiAgIWBLzcxr9RIx0jPVNtQ
 z9BQx1jHiIGLUwCmOuclI8PtO/KLV9XMO/bizsGoYw4RmkazlC9Fr+S5ELd80aUSnwtXGP7nd/7
 3r5D9Pf9nxRf1q1Ouat7tYY5aLtP8oc/n7eyH5z8zAAA=
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
 drivers/power/supply/bq257xx_charger.c | 492 ++++++++++++++++++++++++++++++++-
 include/linux/mfd/bq257xx.h            |   6 +-
 2 files changed, 493 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index 951abd035fc5..0bbb0a8b5f55 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/byteorder/generic.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/bq257xx.h>
@@ -18,12 +19,19 @@ struct bq257xx_chg;
 
 /**
  * struct bq257xx_chip_info - chip specific routines
+ * @default_iindpm_uA: default input current limit in microamps
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
@@ -47,8 +55,10 @@ struct bq257xx_chip_info {
  * @bq: parent MFD device
  * @charger: power supply device
  * @online: charger input is present
+ * @charging: charger is actively charging the battery
  * @fast_charge: charger is in fast charge mode
  * @pre_charge: charger is in pre-charge mode
+ * @overvoltage: overvoltage fault detected
  * @ov_fault: charger reports over voltage fault
  * @batoc_fault: charger reports battery over current fault
  * @oc_fault: charger reports over current fault
@@ -79,6 +89,53 @@ struct bq257xx_chg {
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
@@ -110,6 +167,43 @@ static int bq25703_get_state(struct bq257xx_chg *pdata)
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
@@ -133,6 +227,31 @@ static int bq25703_get_min_vsys(struct bq257xx_chg *pdata, int *intval)
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
@@ -157,6 +276,29 @@ static int bq25703_set_min_vsys(struct bq257xx_chg *pdata, int vsys)
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
@@ -186,6 +328,30 @@ static int bq25703_get_cur(struct bq257xx_chg *pdata, int *intval)
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
@@ -209,6 +375,30 @@ static int bq25703_get_ichg_cur(struct bq257xx_chg *pdata, int *intval)
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
@@ -233,6 +423,28 @@ static int bq25703_set_ichg_cur(struct bq257xx_chg *pdata, int ichg)
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
@@ -256,6 +468,30 @@ static int bq25703_get_chrg_volt(struct bq257xx_chg *pdata, int *intval)
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
@@ -282,6 +518,29 @@ static int bq25703_set_chrg_volt(struct bq257xx_chg *pdata, int vbat)
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
@@ -310,6 +569,30 @@ static int bq25703_get_iindpm(struct bq257xx_chg *pdata, int *intval)
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
@@ -335,6 +618,29 @@ static int bq25703_set_iindpm(struct bq257xx_chg *pdata, int iindpm)
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
@@ -359,6 +665,30 @@ static int bq25703_get_vbat(struct bq257xx_chg *pdata, int *intval)
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
@@ -425,6 +755,62 @@ static int bq25703_hw_init(struct bq257xx_chg *pdata)
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
@@ -437,6 +823,30 @@ static void bq25703_hw_shutdown(struct bq257xx_chg *pdata)
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
@@ -460,6 +870,19 @@ static int bq257xx_set_charger_property(struct power_supply *psy,
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
@@ -541,6 +964,17 @@ static enum power_supply_property bq257xx_power_supply_props[] = {
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
@@ -613,6 +1047,17 @@ static void bq257xx_external_power_changed(struct power_supply *psy)
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
@@ -653,6 +1098,22 @@ static const struct bq257xx_chip_info bq25703_chip_info = {
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
@@ -698,10 +1159,22 @@ static int bq257xx_parse_dt(struct bq257xx_chg *pdata,
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
 	struct bq257xx_device *bq = dev_get_drvdata(pdev->dev.parent);
+	struct bq257xx_plat *plat = dev_get_platdata(dev);
 	struct bq257xx_chg *pdata;
 	struct power_supply_config psy_cfg = { };
 	int ret;
@@ -713,7 +1186,17 @@ static int bq257xx_charger_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pdata->bq = bq;
-	pdata->chip = &bq25703_chip_info;
+
+	switch (plat->type) {
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
 
@@ -751,6 +1234,13 @@ static int bq257xx_charger_probe(struct platform_device *pdev)
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
index b2e38a4a4738..0d568e8b1835 100644
--- a/include/linux/mfd/bq257xx.h
+++ b/include/linux/mfd/bq257xx.h
@@ -353,12 +353,10 @@
 #define BQ25792_REG20_VAC2_OVP_STAT		BIT(1)
 #define BQ25792_REG20_VAC1_OVP_STAT		BIT(0)
 
-#define BQ25792_REG20_OVERVOLTAGE_MASK		(BQ25792_REG20_VBUS_OVP_STAT | \
-						 BQ25792_REG20_VBAT_OVP_STAT | \
+#define BQ25792_REG20_OVERVOLTAGE_MASK		(BQ25792_REG20_VBAT_OVP_STAT | \
 						 BQ25792_REG20_VAC2_OVP_STAT | \
 						 BQ25792_REG20_VAC1_OVP_STAT)
-#define BQ25792_REG20_OVERCURRENT_MASK		(BQ25792_REG20_IBUS_OCP_STAT | \
-						 BQ25792_REG20_IBAT_OCP_STAT | \
+#define BQ25792_REG20_OVERCURRENT_MASK		(BQ25792_REG20_IBAT_OCP_STAT | \
 						 BQ25792_REG20_CONV_OCP_STAT)
 
 /* FAULT Status 1 */

-- 
2.52.0

