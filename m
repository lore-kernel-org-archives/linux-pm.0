Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1447C47CA8D
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 12:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315841; cv=none; b=Hx7uGdTEw8Tog1NAVhAFGgFQcqZtiw9yMU30oRKedA7DRQPflv6xpkc3pIQcA3voagLuckLrsIYDBDa07pksRu52jo6SM0bLw/RagscGLPh4EY2yxE4rKY3UXjF5PFWB1HByafUiYcDXMu9UL96hjOSy/JZ2g4CoQrxjw3StA4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315841; c=relaxed/simple;
	bh=am7gVdhKCETDKBm4r5rOwz5dtIGpAOkyIKqQhn8Cy8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOlBscvVFYrq2Gh7qxFmNtaoxMjWmGsmQ3KMGbQ71R1Txyeo+jBd/ZWA4pUoPlWUVS9XpfiZzfPHJjG8ZglouyFGpdcUKmHtKA9YRrvumcaWfWKd1MStrXCDF63JQh/bb+lpl7xc6eCaEBc2ueQ1sgtnWeNLTRp6KIqU9zz16W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pRShtK+6; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRShtK+6"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c214e625259so133167166b.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 05:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787315837; x=1787920637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=93Xla+7s9FbydTHq6rHQfZ+XpNLmw5w7sZgFpRSWwzA=;
        b=pRShtK+6J/z7PCGs6J9K0pKgq2j8jw9fyT85YnODkLxsAIOGXw8SGIVP4XnkriNOVk
         O0WY15X2auwWozLHUVGp4OKrNhbB3dm8UeT8LBeLoJ9pCi/i/awKvS7Wj8N6LCvqL/GV
         z8AJItywKesvAqZcZbdN56w+M4E0cusNauj5OuqrQ25Ykw+gKTWuuKXqBwltHilvymon
         2eXVUXjTekXl7mu0V5Q2rClOSsA4Anlvc0GIsxzDa9mX3wZBawpJLuXcUhKZqHj2Eh58
         P0qfxdpf5ZW5g8xhmFM5dIEfvVlx4UeTCZg3jR20peYI3V1sOVaRwspLsa7mavDPUqZl
         2RVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787315837; x=1787920637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=93Xla+7s9FbydTHq6rHQfZ+XpNLmw5w7sZgFpRSWwzA=;
        b=Ohl+1YZth/lD0+cnhygHbKYXAbZ0tjSioR7QSq21qRuMZ61PVBpBLTBXVfazIsMsWR
         FzqYtcK0N4HIWBaUV7f3h69jB92QQMN81tFkUIV30StWp9aAtl8PlBk3e/ePEnIPM7Bk
         wVZhQAHbGwJBh7xzvoI+kDhkVYDAm3qvuLdXnDxNKBCfjx5m377fsLfQcepFmRjowQwb
         n7ocY8XbreENWwU5F8xbZ8OjvVD7K3zVf1G3jlYyJFzSjIqhKYHJDWgFMxPHuo0YYlUS
         1onawv7NDT1dGBvpRLDdaAlNxbcTF5g+BpJAeCZTpPSVGPzkps9/V+4FbGCVJt3FCHWJ
         L6AA==
X-Forwarded-Encrypted: i=1; AHgh+Ro8NOSzJ5rZ2tQR5o6KAssN0GferN9PclBxbqciTylI2FXalD9aUxI/518uwfGLyoOqlxToRZjTBg==@vger.kernel.org
X-Gm-Message-State: AFuF++nDHup53MIZeDLA55cUHNOcbvQyXTHSSutd+w9HbLvw1NY+hGQf
	V+T8pDUZuXYi0sYZlUyL8GdqE0D94Sy9z9Dxm9dlKvR8kMBcB/y0sRdM
X-Gm-Gg: AR+sD13uAZPbulKPKPSeVZwuxLaWD32bagpCg9F86OrnpEFZXwX+cSYIjZnu8Luilku
	xsE4uVJC9b/QdJQZSLe6jCH0lztIrQd9rQHW48gHbU8rrWCr4RPGtQl1/VUH25KtWHuOhVwNyaa
	AG0hdGvmR4qllcRI+J8LhBmIC9MxitfwgfeZDvbhaYzZ4W45WUuN76SnLOZn1zS9YghZMocm7Qk
	HglSWtKfJEQWUnLa5ZBfip69QK6U+/BhQRz0u4jeujgRDOP0QjYg+kwTu/EJk7DWpqjwI241Z4w
	wAnkw/SzzIdJRqGHGJKv/NVGl82OziXqoCoynswIgUEdRpajoQl3vRfiOFOfglRRBlrNLDkmbOi
	UDVqQEriA7AWjAxj1dakxg+ZAqIGzAl6ciLAUduqUV2IO9R/1wl8nbDWSmIFZ4VlFMEX9Pvr7kT
	pv1p/dcm8M5f+W7rEAq08F/+yM7BIZ3bhDU0ZjHK/mPoi8U/5oIX+9xxDPFkoEXpOioLK8oPs0u
	2hWWwVlW2DfZ4dOCpjc6A==
X-Received: by 2002:a17:907:1b0b:b0:c12:e178:9e68 with SMTP id a640c23a62f3a-c246a63071emr586903066b.19.1787315836590;
        Fri, 21 Aug 2026 05:37:16 -0700 (PDT)
Received: from workstation (161-53-210-87.ftth.glasoperator.nl. [87.210.53.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24591e0397sm451194666b.53.2026.08.21.05.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 05:37:16 -0700 (PDT)
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
Subject: [RFC PATCH v3 2/3] power: supply: qcom_battmgr: add Xiaomi taoyao support
Date: Fri, 21 Aug 2026 14:37:10 +0200
Message-ID: <20260821123711.1579539-3-zstaseg@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821123711.1579539-1-zstaseg@gmail.com>
References: <20260821123711.1579539-1-zstaseg@gmail.com>
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

