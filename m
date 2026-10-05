Received: from mail-ej2-f40.google.com (mail-ej2-f40.google.com [74.125.228.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84616313E36
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791218596; cv=none; b=Nuuh/NaOX7raHvXWTdmb68/OrXLSyGboi6qIGiglrxoliECL2zOyADMHWKv1hJVLbzMoIO1jkcXmEdF2wwcivpswIcfL8VvYrxXVAlr7Jp+CignfzEK9DjjNaO6IwzNAz+UBjcqlWNdTC/S1469BgcMwYHbdcinXKhuJoi01PrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791218596; c=relaxed/simple;
	bh=5AgDAztz8fNZkLN5QBtVGFY+DjmJen9nNpVlnXdVckk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTTuAwOdwv5fKyE17xQ4EqkKsAoGLm477Rz2ulPHaO92uEoUYaYhiMDx487wfBUAJGSuCEnGkpqHwgto0JgnYTLtuzj+aiamoA1MGEf7f3gwAs+FVN2eZhsn97dpCs0pku5JkpKO7yOlPRCRkh032Qsb87CzDAuJ3AEb+UmofDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p8Yvjq26; arc=none smtp.client-ip=74.125.228.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8Yvjq26"
Received: by mail-ej2-f40.google.com with SMTP id a640c23a62f3a-c2e417a5a81so336886266b.3
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 09:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791218592; x=1791823392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wAGEhXILcvD7hpkiY40sC0H+/SDOHnE9bL5Y2oA7gd0=;
        b=p8Yvjq26Ju6CzmSxAi7BS84me9yc/dbFrFYWcq6xbFGAQo8Dhl5tlk3KKi76iB83we
         WZOVeKDcLclRsdIqkkJO4U1djZc0sp2y7y5xX3DVoPc+nuF78Pp5abMgr30OXgK7KUWF
         GKcTM49/c9iubWvlHapOR6I65vWxl4zzJELvCsBIx4zwRD+csm+30fXQkR9zVI7y5qRc
         TDIEKu6H8JQ75C832fCfWXIWrgXpI4q90ORJFxln+/Lm2NC+pnU1K5UlNPWdw+8Uz8kX
         rFuI9j2+VOrxjO8upoTFXwsiR7l1nBTCr9a3F5NJ7UwGznNnM+5DJdlgCNjcu7SAlEbX
         Gliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791218592; x=1791823392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wAGEhXILcvD7hpkiY40sC0H+/SDOHnE9bL5Y2oA7gd0=;
        b=KPgfQaT3auobe5YQ7RY2cP04x+p9GPF2mGPwJtM52y5Ye4tkgvO9fWoppH+NWQTb9o
         E6mjgi2zc2pWQRT9o4rrtD2W7qkEk4koU6/V4A6jktES6dgxCpmOj2Xq+yK9OtTcoXrl
         RPcdzT02PLVgntpA0BMN6l74Y8jlzislWvFaq+IbgxMHdUr0fpOpk+DvFFrmp7cJNTH6
         fJM3pUlrJiMhVN9waDij75NaVkvdQAXRIAp4qjn8GqKYb4MF68oUHG4TVOV9h2OS+iZW
         KXxgKwA/gTQjyXMARvSYDy5wO/QGV4GQcxYIVTMdXCFcllqY0t5HtfHa2GvY1eUk8s8D
         V5fg==
X-Forwarded-Encrypted: i=1; AKwUvBy/uCcIJIUB1FGoU1j9ofKRHRRQG3im4oF6iyHz//nqcSoc51py15sJddGCIYkgMToXMVvatgVkJg==@vger.kernel.org
X-Gm-Message-State: AFuF++kH2h+euVQw1cnOMM+/rVAzbnp4f6naWqplsz14a/fU1CyeLNnC
	8YSBOJzWO0fgDmbdhpd/yfUsg0D8QuqOXemQE9GII8V9fdHHKP1Zi7d4
X-Gm-Gg: AYBFou21o401gYQOKwKEfDgbJkyy6tFKA/AL2BbJQrMfHdRRg4+f+/osAztFGG8Mlth
	Bw/BTDkr5SH4MobtPac44pJtvq9Oouin1/IYZJQkhqz20ruJ3Vp0PLK5DjY6nzs9Z0sbO4jyJF5
	Ay4FiTDX7EtkFqoZh407dw80y68NE2ON1zyYgP/+JKg5BV7eprVAWpklBXqAjg+AXg9SJ69CP3O
	S+BLVu48mHk/25V9c4r6vuHnsM+cKMQLmvK+4fecxmltlWvqwrKjPAryBaCAjnQv7BingbnNEAC
	PTXwk8q8YGh7uME8C+GY6OhbYXUYzv+DPv0qm4jvVd6Vogen//ZXt+bEMqaE5TEJRG9ytp6FlHN
	IqTObv+MyhXlCYgkBZEr4R1Nv1qU8M7ba+eJm9F7Dt75CJvCSyTpQmsdsbUmQIletx6yZ81PO7/
	E3Bmx98jbnAUR37djm4n6SKtM2/kGJhwnrYnK7X3sLviztCAUQo6cdNXuI379mS552i6rEWX14A
	uuIB1c5Q3SilkYM9EfAJQwOtC6LUQmFxJXCiw==
X-Received: by 2002:a17:907:3da3:b0:c2e:7fe7:288e with SMTP id a640c23a62f3a-c2e7fe736eamr529823366b.32.1791218591445;
        Mon, 05 Oct 2026 09:43:11 -0700 (PDT)
Received: from workstation.home (161-53-210-87.ftth.glasoperator.nl. [87.210.53.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6afb021af56sm3485851a12.31.2026.10.05.09.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 09:43:10 -0700 (PDT)
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
Subject: [PATCH v5 2/3] power: supply: qcom_battmgr: add Xiaomi taoyao support
Date: Mon,  5 Oct 2026 18:43:02 +0200
Message-ID: <20261005164303.1208127-3-zstaseg@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005164303.1208127-1-zstaseg@gmail.com>
References: <20261005164303.1208127-1-zstaseg@gmail.com>
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
2.55.0

