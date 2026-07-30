Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C2B3FBB7D
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404112; cv=none; b=PxINV2wQjo1P/izFQWRjAzbLnBJmhewtBie8ibSvOENLMvL2RenVEB1viwQc38y8JvD/2k75CpDSfMIDmA1B4CMzpkl27XHBJ61/exC2P4RjIjdsvZRbXhG6yVClxb+b3vwAQyUfcBiJkFK1X0usBhu3gYwWesewuF6moXCXJQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404112; c=relaxed/simple;
	bh=vkSeZ8X4pQE4BuTo9oUM7Hmz29LHol+s3w3lzRuGVuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prVs/1Q8GMrsoICp0mIil5dsx7WF64NgIhPH7aFN+sZGChJHIPvhN8udfPl9ItNhtory8MuuPGpTnEhqk4ASq2fbAlUoblkK29sNza1vCivhUevwpLdvhd09izV+9mdJyfSpksZFguc7WoM0CW22Zk/7VqlEJE0qombPcxUiQNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2akxTef; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2akxTef"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15c42a45adso89892966b.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 02:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785404107; x=1786008907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VmAhfMCIo5qNxQmn+Z0q3zV1cg+1dJz7+jBwbd3a33c=;
        b=e2akxTefSdUsR532kyLVsIahDJoFfMRzE9A9ZqI6JIhTbxjgJIbvih5K0u5ly/RqoQ
         b+/LqsAtfYGjzyYSSET6FNsghOnoxFMloOLn7JSmQgeJN9NyntQY+GvVdzcLRDtBk7jr
         ETj1KHtdPw8lkWq96EryOgl031aLBvqJaHQffd62i9bHrejMfyYir3yUSacSOxFV3pp2
         ds/CZcZTL5gSY0O+ewSYlL5zuhPovnAJ281CTdFi1vNb4UAo7WTN8iloc4wOQSXjc8VH
         RCnRGKUMkfhifKnUipbqCR7sFjoOzszvvQxN6U6NjtyViHSeK6I3QKq4MPv7i0UpluRc
         tRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785404107; x=1786008907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VmAhfMCIo5qNxQmn+Z0q3zV1cg+1dJz7+jBwbd3a33c=;
        b=n9mrYwFIo4bdgHDzVaWBx4Qsi7BCzllaingedWqQxP4+CrjNMc0ZAyXqHAmR+5IU/W
         LW5Kd5V9n8SRtxtxFafVmgcSTXDxjCNvOA6A+I6+Y1/kTlnRjpVmaxI+9uKNKNHMJEua
         Pyk0MyWN5Or2Rprib9AxB1sQNzcvPMxW22SDFVEgE94PQVxSttfforXMPXMUQktCmZtM
         s+l4tFakIPLacq6O93tds50JW9IoR9oLRlahmZ2zwAlJMazmW/M3WRPKtsXygA/3IlnK
         Aqs8QW2ZOe1Q7K9xGR15wGoO0W3rigNRKUWJ7O8oDxCPFq/KN+/8Mk5NfzPWHSnNIhRx
         ENIw==
X-Forwarded-Encrypted: i=1; AHgh+RpSjn6O53Bg6cxH3YYMcrWvsekZbSH7KbmUIydJ9r9+4YIONIgL3s4LcUQGPXiw2dxJhSg9+fDD/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXqtbRTG1CzLb5lZppL3gtnSFCwcx58lKpRZWGjfOKzA41MlLg
	KtMJQLVEFHXFACFVy1X6NPvTfWQPkZu9Wan90x+QNQPtIyp1shZccUWl
X-Gm-Gg: AR+sD1066OVl5SeTvauRFPggwEvANqQdlARKjADyrbZVVK9hU8oms8IdJIAm+TCKn21
	pgugjhkmpMkCOiOysJXtJORSqcmIzIcBPz48QfGe9Ep8kxcu6Nnqunvxsyiz45WYuKD4kjyRrQ3
	BiZlBaNsxme8o8x4ROqlsCdW/Ld/I4DvcDOmcZUI+jQ2k1HCakQJf5StB3cfSodv9GzXyhKd+1F
	mvhlcCuBtiVkKs5u2JW/LzdRgwSJM6tz3IbcyPGWV9iJuMkaHX1XGZtfhleZRg+zVLf0xDjNkNW
	MLzMp7kLPppFuSIvaec4sic57rgEBSBalEC6JOGDqZ+zQLxaS+Neg4ev+FyQJuM73wfWBQplBxj
	+ciBpyniQKTMWBlqrQwlZoMLYzG+liHHHK2999SLpj76FJ/9WF3W9NaGEMTfITrB1R2Y+bE7kNX
	vf2FBgvcaAcCiOvhUu2VdDmSVNbzvU/3GByrb3jDLKAbsfPog6oHO1rrel3ixgMiR5/uoTWtAxJ
	xfqnhpkOPQcib4vcaUp8HJyBOCkreGw
X-Received: by 2002:a17:907:a60b:b0:c1f:e5f:4d2d with SMTP id a640c23a62f3a-c1fad038c03mr73551466b.19.1785404107470;
        Thu, 30 Jul 2026 02:35:07 -0700 (PDT)
Received: from workstation (161-53-210-87.ftth.glasoperator.nl. [87.210.53.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8577e78sm46733066b.20.2026.07.30.02.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:35:07 -0700 (PDT)
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
	Stanislav Zaikin <zstaseg@gmail.com>
Subject: [RFC PATCH 2/3] power: supply: qcom_battmgr: add Xiaomi taoyao support
Date: Thu, 30 Jul 2026 11:35:01 +0200
Message-ID: <20260730093502.689505-3-zstaseg@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730093502.689505-1-zstaseg@gmail.com>
References: <20260730093502.689505-1-zstaseg@gmail.com>
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
---
 drivers/power/supply/qcom_battmgr.c | 86 +++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 490137a23d00..390d7c75e36f 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -24,6 +24,7 @@ enum qcom_battmgr_variant {
 	QCOM_BATTMGR_SM8350,
 	QCOM_BATTMGR_SM8550,
 	QCOM_BATTMGR_X1E80100,
+	QCOM_BATTMGR_TAOYAO,
 };
 
 #define BATTMGR_BAT_STATUS		0x1
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

