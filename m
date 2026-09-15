Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000CD46F497
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462151; cv=none; b=D5/SJrl+06/xW/9X1i9LK3Rrw/is9xysJtRbBkabc3IRNgBoH97gw+Bkms3EAb/SuoIlGma58VOfRU6VOWcnJhbOHv31knsMUqaRynyRPErKtAXoYBpLojTdlEJsDKbr6gQlTaPxL2v4uvxJ/FV2NB0/6LDkBEoMvAUYbe7Z/T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462151; c=relaxed/simple;
	bh=RM4LDmfKFGK73do6/gb46bD7wd1gb1ydtCtOaLRCVj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+Dog61hmVXwWq7nFjxdf2fff/VIFo2E6oR1axFUYn7uKPP1FJGywY+sbtgo4egJFahr/6V4JEbyzlZpZ4OSLETlNf/OLwhtXlY711Hu3QqJOuTbBMPWmEmzOzFOBxCNrqml0zsykFgCQNHSNpqpMYB9kUjhPryXqZHiwoAP9Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KktpPCss; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KktpPCss"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c294af0caa8so4529666b.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 01:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789462147; x=1790066947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Okn9/8O1LREB/jJobsvVn4jcYarpZ/VFVWZ8aLiwsI=;
        b=KktpPCssJreyDDQzViiVOFxY2tZiG2nZfX/fuEO2p25pOhCtPfGfP+GQJNipKF01Cv
         zH/N83vsKqJVTaILZ/M6RQW5Sm2eYqYvk2zETQcuNSLbW4ys+Kp7x+FwmRbKUXicQyLj
         yzqICVKJ8zmlJSAXmUUu7Oe368EMyy5SJjaFXxYBz07RIZcjPOy8B/wu8N1TvPuFUwq3
         V/tHkcKVz6x6oiQjzHynLRCbLmTJ8aBXQCTT9pNdAHYgozy/xM5JXa/x+XD0EsMekaBH
         IgIfWImU2fgspjOUrR3TaJ9xFsid7Ssg9DQWAt1gd/af6/4pdOnKv6r0ufjHOE4EMYB1
         0JMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789462147; x=1790066947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Okn9/8O1LREB/jJobsvVn4jcYarpZ/VFVWZ8aLiwsI=;
        b=SLrU9aOBuFijR+Vs45aoUlVS+yxNgBLI51NzCwotMAYJFX0Qjk7xrIllZI/T3m3T7x
         U/ob1ElSKPaAwEIPXlIakkev2NW3sTC9lC1YPpCIPN/oanKwCBhTR9qfgeZwZFRHFz6p
         18jyaY7/oUNw9odgXo7ibPQENJRdzvY1r/+yRzukX44fS7D9tLeGSpGa4apBYcqdAbuu
         yUhW/i10MsLVzCwc8npLZ2YQL+alQZeon4zc5XEB5/QYUoo4pbCqYEfODbWN8MwECdL1
         zbWnBYrUmGIDPQ23Dozl63b7/GQ9BIDlGl4feCJIAn+6oHse4V+pRYQOs9h5r5eP7HlG
         7FPg==
X-Forwarded-Encrypted: i=1; AKwUvBzkwBu2szxhh20T+Z7scf8xl0rkOOmJJkmTsYQoYWgumjsRTWxDNslhFPUPbPxdcH6hKgvZKa3Mxg==@vger.kernel.org
X-Gm-Message-State: AFuF++nvoW7BkElNIURk+0UNf3RUJoQXjRK7kViRaKu1spLl5+ghEQp7
	RFAteJCYlC2Z+J2OXt5mju04QbvDO/t4da3ESFYuKLu/O5XDwEV73fbJ
X-Gm-Gg: AYBFou1peClGKCz6jOup/VL6ADkieARWi01e1nlkr4JzzXS/0uMK2uAM36wwGxuPV0x
	DYqtj5pvexs88eaxOXv3IZQi9cYH00vcG6+kkBZx5/4Nzr8fzSmuTefhjgsdEMXO397ywISqQ+P
	dV8FGdDL4navG6OCugBlFnV9K3Qrd4VXmjEZdFMBbnXaQvsw9HnZkXU8BIRe1IIph9Kv9Ui2tow
	sYRHeLDXhxmDGb2KSZJkGp17mfL4i4f8Uw4L20fjIocNOn+PEviVp7EU+c4Dq1buLHcbMkisjIy
	ONJbjODEoBZAHI3FIDktWzdzBRT1pzkSa4NfDE+cOiEUT1hjSlfO4wTPK91GYBwKCvlNJ4GxfxB
	+4UzwromAMdRJPH2jQgAefjxEPKIl5Sy6M/7xln2nZzv2LCcLlG8iB4JXQHBGPJ/JNCu2/Pdab+
	ZmKCTuO4QQJi9NHcI3y/+FtAu50CHWrQ6Y3OebEWxa4mqof5VBZ3uuT6AIqi7HI95NS5ncKvfk8
	sn2PwSTcnAGMtC8e0u/7vLHnD9DJY7seysSLB/DFDw=
X-Received: by 2002:a17:907:3e29:b0:c29:583a:c291 with SMTP id a640c23a62f3a-c29d77ed37cmr13864166b.21.1789462147034;
        Tue, 15 Sep 2026 01:49:07 -0700 (PDT)
Received: from workstation (161-53-210-87.ftth.glasoperator.nl. [87.210.53.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2966067101sm552702966b.35.2026.09.15.01.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:49:06 -0700 (PDT)
From: Stanislav Zaikin <zstaseg@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Stanislav Zaikin <zstaseg@gmail.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v4 2/3] power: supply: qcom_battmgr: add Xiaomi taoyao support
Date: Tue, 15 Sep 2026 10:49:00 +0200
Message-ID: <20260915084901.56622-3-zstaseg@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915084901.56622-1-zstaseg@gmail.com>
References: <20260915084901.56622-1-zstaseg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Xiaomi taoyao firmware defines an additional BATT_CONSTANT_CURRENT
property (ID 12) between BATT_CHG_CTRL_LIM_MAX and BATT_TEMP, shifting
all higher battery property IDs by one.

Signed-off-by: Stanislav Zaikin <zstaseg@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/power/supply/qcom_battmgr.c | 86 +++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 490137a23d00..1ff079750807 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -23,6 +23,7 @@ enum qcom_battmgr_variant {
 	QCOM_BATTMGR_SC8280XP,
 	QCOM_BATTMGR_SM8350,
 	QCOM_BATTMGR_SM8550,
+	QCOM_BATTMGR_TAOYAO,
 	QCOM_BATTMGR_X1E80100,
 };
 
@@ -451,16 +452,87 @@ static const u8 sm8350_bat_prop_map[] = {
 	[POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD] = BATT_CHG_CTRL_END_THR,
 };
 
+/*
+ * Xiaomi Taoyao firmware has BATT_CONSTANT_CURRENT (ID 12) inserted
+ * between BATT_CHG_CTRL_LIM_MAX and BATT_TEMP, shifting all subsequent
+ * IDs by one.
+ */
+static const u8 taoyao_bat_prop_map[] = {
+	[POWER_SUPPLY_PROP_STATUS] = BATT_STATUS,
+	[POWER_SUPPLY_PROP_HEALTH] = BATT_HEALTH,
+	[POWER_SUPPLY_PROP_PRESENT] = BATT_PRESENT,
+	[POWER_SUPPLY_PROP_CHARGE_TYPE] = BATT_CHG_TYPE,
+	[POWER_SUPPLY_PROP_CAPACITY] = BATT_CAPACITY,
+	[POWER_SUPPLY_PROP_VOLTAGE_OCV] = BATT_VOLT_OCV,
+	[POWER_SUPPLY_PROP_VOLTAGE_NOW] = BATT_VOLT_NOW,
+	[POWER_SUPPLY_PROP_VOLTAGE_MAX] = BATT_VOLT_MAX,
+	[POWER_SUPPLY_PROP_CURRENT_NOW] = BATT_CURR_NOW,
+	[POWER_SUPPLY_PROP_TEMP] = BATT_TEMP + 1,
+	[POWER_SUPPLY_PROP_TECHNOLOGY] = BATT_TECHNOLOGY + 1,
+	[POWER_SUPPLY_PROP_CHARGE_COUNTER] = BATT_CHG_COUNTER + 1,
+	[POWER_SUPPLY_PROP_CYCLE_COUNT] = BATT_CYCLE_COUNT + 1,
+	[POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN] = BATT_CHG_FULL_DESIGN + 1,
+	[POWER_SUPPLY_PROP_CHARGE_FULL] = BATT_CHG_FULL + 1,
+	[POWER_SUPPLY_PROP_MODEL_NAME] = BATT_MODEL_NAME + 1,
+	[POWER_SUPPLY_PROP_TIME_TO_FULL_AVG] = BATT_TTF_AVG + 1,
+	[POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG] = BATT_TTE_AVG + 1,
+	[POWER_SUPPLY_PROP_INTERNAL_RESISTANCE] = BATT_RESISTANCE + 1,
+	[POWER_SUPPLY_PROP_STATE_OF_HEALTH] = BATT_SOH,
+	[POWER_SUPPLY_PROP_POWER_NOW] = BATT_POWER_NOW + 1,
+	[POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD] = BATT_CHG_CTRL_START_THR + 1,
+	[POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD] = BATT_CHG_CTRL_END_THR + 1,
+};
+
+/*
+ * Reverse mapping from Xiaomi Taoyao firmware property IDs to canonical
+ * kernel property IDs.
+ */
+static const u8 taoyao_to_canonical[] = {
+	[BATT_STATUS] = BATT_STATUS,
+	[BATT_HEALTH] = BATT_HEALTH,
+	[BATT_PRESENT] = BATT_PRESENT,
+	[BATT_CHG_TYPE] = BATT_CHG_TYPE,
+	[BATT_CAPACITY] = BATT_CAPACITY,
+	[BATT_SOH] = BATT_SOH,
+	[BATT_VOLT_OCV] = BATT_VOLT_OCV,
+	[BATT_VOLT_NOW] = BATT_VOLT_NOW,
+	[BATT_VOLT_MAX] = BATT_VOLT_MAX,
+	[BATT_CURR_NOW] = BATT_CURR_NOW,
+	[BATT_CHG_CTRL_LIM] = BATT_CHG_CTRL_LIM,
+	[BATT_CHG_CTRL_LIM_MAX] = BATT_CHG_CTRL_LIM_MAX,
+	[BATT_CHG_CTRL_LIM_MAX + 1] = 0xff,	/* BATT_CONSTANT_CURRENT - never requested */
+	[BATT_TEMP + 1] = BATT_TEMP,
+	[BATT_TECHNOLOGY + 1] = BATT_TECHNOLOGY,
+	[BATT_CHG_COUNTER + 1] = BATT_CHG_COUNTER,
+	[BATT_CYCLE_COUNT + 1] = BATT_CYCLE_COUNT,
+	[BATT_CHG_FULL_DESIGN + 1] = BATT_CHG_FULL_DESIGN,
+	[BATT_CHG_FULL + 1] = BATT_CHG_FULL,
+	[BATT_MODEL_NAME + 1] = BATT_MODEL_NAME,
+	[BATT_TTF_AVG + 1] = BATT_TTF_AVG,
+	[BATT_TTE_AVG + 1] = BATT_TTE_AVG,
+	[BATT_RESISTANCE + 1] = BATT_RESISTANCE,
+	[BATT_POWER_NOW + 1] = BATT_POWER_NOW,
+	[BATT_POWER_AVG + 1] = BATT_POWER_AVG,
+	[BATT_CHG_CTRL_EN + 1] = BATT_CHG_CTRL_EN,
+	[BATT_CHG_CTRL_START_THR + 1] = BATT_CHG_CTRL_START_THR,
+	[BATT_CHG_CTRL_END_THR + 1] = BATT_CHG_CTRL_END_THR,
+};
+
 static int qcom_battmgr_bat_sm8350_update(struct qcom_battmgr *battmgr,
 					  enum power_supply_property psp)
 {
 	unsigned int prop;
 	int ret;
 
-	if (psp >= ARRAY_SIZE(sm8350_bat_prop_map))
-		return -EINVAL;
-
-	prop = sm8350_bat_prop_map[psp];
+	if (battmgr->variant == QCOM_BATTMGR_TAOYAO) {
+		if (psp >= ARRAY_SIZE(taoyao_bat_prop_map))
+			return -EINVAL;
+		prop = taoyao_bat_prop_map[psp];
+	} else {
+		if (psp >= ARRAY_SIZE(sm8350_bat_prop_map))
+			return -EINVAL;
+		prop = sm8350_bat_prop_map[psp];
+	}
 
 	mutex_lock(&battmgr->lock);
 	ret = qcom_battmgr_request_property(battmgr, BATTMGR_BAT_PROPERTY_GET, prop, 0);
@@ -1381,6 +1453,11 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
 	switch (opcode) {
 	case BATTMGR_BAT_PROPERTY_GET:
 		property = le32_to_cpu(resp->intval.property);
+
+		if (battmgr->variant == QCOM_BATTMGR_TAOYAO &&
+		    property < ARRAY_SIZE(taoyao_to_canonical))
+			property = taoyao_to_canonical[property];
+
 		if (property == BATT_MODEL_NAME) {
 			if (payload_len != sizeof(resp->strval)) {
 				dev_warn(battmgr->dev,
@@ -1617,6 +1694,7 @@ static const struct of_device_id qcom_battmgr_of_variants[] = {
 	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
 	{ .compatible = "qcom,sm8550-pmic-glink", .data = (void *)QCOM_BATTMGR_SM8550 },
 	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_X1E80100 },
+	{ .compatible = "xiaomi,taoyao-pmic-glink", .data = (void *)QCOM_BATTMGR_TAOYAO },
 	/* Unmatched devices falls back to QCOM_BATTMGR_SM8350 */
 	{}
 };
-- 
2.53.0

