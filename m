Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF9A4A482C
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792154896; cv=none; b=pDGxjL0Ogy8xfBzkQwEus36x+W/S7DgbSlON1DAKqeB4vki1F3+Lzocjceb7wDJttqsLhAED3bRwd1EV9rL7EeSI6r3tCBLEBMUIOPAK59xvmBHUGy/MZi3AT5fIMOb+asLo2/or/AtdhZeMcZLkE0tgm3H3EzjK/+yTt3hMOMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792154896; c=relaxed/simple;
	bh=ymrDji5W9iGBhnKB17kI9XG5LABaYRXT8lJaYMJlZcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IphS7T8zKdlDWj3Mu9FehRvlD+hO9/st0VPSHDWrDYfaWnDajBhFh4XOM1Aphug2xeebbrNe7E20iuNNZ4Aj1t7hsZyOGW5aEc9ML11JWb3SQNw4sFQlKRTSCXEVMPFEJ0xqzPxpGJpZJyjhp4qrdV6iU65NDE2BfdBtaRlyx0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0xPYEbf; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0xPYEbf"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso2344765a12.0
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 05:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792154895; x=1792759695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tXKmdBCd7CWIsG/hFcl6oubp63Bnjwu+bVpaEElF5sY=;
        b=l0xPYEbfzh4ZheJiRg65u9dWRnYAtEfidN0DgbHAFZiDMMC8twvXmOzCAC6en3sJ4U
         EEED1SCRMZU4WRFT3oUTng8uVw4LtOhvCTSfb8tDNXnE2oc0PpiY2Y6n65y8fkMXry9V
         rllxqw1iovDMOuK6zULmM0KqFLqgb6uYzTYSxIfyceARhHhy7RQRW8FodycmD51y4+9d
         pMIZYVXhGlM4wX0PvNVYezGMOu3e14ms2UYo4rfF20lMhiqdisbjZngdzioBWqFIxdkW
         EM3bWEZUbGAVVIx5gI5A2YcaXiqzoTCF86+FA4g5KoXEestuknAJqkeVsf4YbJX6vt+8
         ANeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792154895; x=1792759695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tXKmdBCd7CWIsG/hFcl6oubp63Bnjwu+bVpaEElF5sY=;
        b=VSWXZZz7uLrDm4C6q+KDlHDG19HL+yhjCtSHXnhI688RuNm2m2Hg1J8nsSWiraWNiu
         IFoDCsyU1oBjIXoNvnjuUjM04SUDbVjdBlWIdle32NqYHnw2A1O9CLv0jK70vp4YDGSq
         Am2lre4zvqSLxYwYxgTXjx/WjjncXT1WHOVVA1Q6G+gNudBvoXTTwFzS6Y5I+qNkn8at
         oxpDkprXC+XwhFp/esife7m/9qqp5IxVrwVOHbvD+rRvvZ1JFnka+Hl9vcptm8nZ3P9b
         dwQ8J+DqGmMbQ+xk/CWXTrhB6Zl/ALOEjnv3U8fgaa7Y4uCB7a/X3bXKlyx7HHP3T1WA
         Wu0A==
X-Forwarded-Encrypted: i=1; AKwUvBxr49v5lYsugmZDNMVP9aPxnYYECG2gcFFt/vv10zSWyWxkjI9cIz6sPPkSlD3wPeS2kNQkhiji+Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYJqOIenlyBWw3c7xz64IHqea/YE8r8lXimguQbXTaroLcGWYu65
	FVLswPvU2tQjcWa5Ffz4qp7NiYgPVlqpjx9cqBCS/8EA2oFCMBMn62Dj
X-Gm-Gg: AYBFou1BITVGj2mQl6hMqMKrlmiUDp6Auowc8gbCWTFpn1cINxiJNn03SGU5eYPWl8T
	i8ih/ld6135PLHU9ET/+Bg6cHMxqHWolUalM7mN6GR22tPPDg16CGMPATKVOY+Q7sF//iHLYkd/
	LJwPMBZ2W76jTSi1CG3JSF6GFqjJx63rRBrDF/x/eYFAUls38NlLllUqdG3/ZXuCtJH2N+pAx50
	lBHrf9F1b0l7SmTbJH76pInpi1sbKPZ5nXf2OqlSoAZMaw7c3qpTUIbkOO8nxQjqSPaInwIoFO3
	W9OJrZltH5m/LAS/TsOnRVXp1QrYYYTv66IEHKRrly9EfOi+1w3iTMd0Uv1H42VE2Nu8xGXQ+HV
	UR7lB+tTLiW+ddIL5UbCPqS7VD0iZVciDfcB4zdpnuXKyJbSk88VPK79k/DaV6VqF439D6gUCnp
	HPndm3/xZGPsbOVL91aXk03/gv/FP4/XRUhxUX5E0sRJ86rgPs+mYHvovOut8qTGtSgG69yKQrt
	ItRiqRgaDBg2w==
X-Received: by 2002:a17:903:3d10:b0:2e9:7e90:8a3 with SMTP id d9443c01a7336-2e97e900abcmr24506075ad.39.1792154894479;
        Fri, 16 Oct 2026 05:48:14 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e834ef9sm9833775ad.42.2026.10.16.05.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 05:48:13 -0700 (PDT)
From: Joonhoe Kim <26rote@gmail.com>
To: sre@kernel.org
Cc: konrad.dybcio@oss.qualcomm.com,
	kamal.wadhwa@oss.qualcomm.com,
	anjelique.melendez@oss.qualcomm.com,
	dhruvin.rajpura@oss.qualcomm.com,
	andersson@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] power: supply: qcom_battmgr: expose the charge current limit
Date: Fri, 16 Oct 2026 21:48:06 +0900
Message-ID: <20261016124806.1789-2-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261016124806.1789-1-26rote@gmail.com>
References: <20261016124806.1789-1-26rote@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The battery manager firmware takes a charge current limit in uA
(BATT_CHG_CTRL_LIM) and reports the highest value it accepts
(BATT_CHG_CTRL_LIM_MAX). Expose them on SM8550 class batteries as
charge_control_limit and charge_control_limit_max, clamping writes to
the maximum.

Also handle the BATTMGR_BAT_PROPERTY_SET response, which was logged as
an unknown message, and return its result.

On a Lenovo Legion Tab Y700 Gen 5 with a 45 W PD charger, limits of
500 mA and 100 mA give about 480 mA and 90 mA of charge current while
the PD contract stays at 9 V. A limit of 0 stops charging, and this
firmware does not resume when the limit is raised again until the end
threshold is moved below the capacity and back.

Signed-off-by: Joonhoe Kim <26rote@gmail.com>
---
The downstream qti_battery_charger driver also writes this property in
uA. The thermal mitigation series [1] used it as a level index, and
Konrad noted that the ABI defines charge_control_limit in uA; this
follows the ABI. Only tested on Kaanapali.

[1] https://lore.kernel.org/all/20260609-cooling_device_reg-v1-2-e15bddcb0086@qti.qualcomm.com/

 drivers/power/supply/qcom_battmgr.c | 52 +++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 0d55458b2881..69931827bc08 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -260,6 +260,8 @@ struct qcom_battmgr_info {
 	unsigned int charge_count;
 	unsigned int charge_ctrl_start;
 	unsigned int charge_ctrl_end;
+	unsigned int charge_ctrl_limit;
+	unsigned int charge_ctrl_limit_max;
 	char model_number[BATTMGR_STRING_LEN];
 	char serial_number[BATTMGR_STRING_LEN];
 	char oem_info[BATTMGR_STRING_LEN];
@@ -451,6 +453,8 @@ static const u8 sm8350_bat_prop_map[] = {
 	[POWER_SUPPLY_PROP_POWER_NOW] = BATT_POWER_NOW,
 	[POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD] = BATT_CHG_CTRL_START_THR,
 	[POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD] = BATT_CHG_CTRL_END_THR,
+	[POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT] = BATT_CHG_CTRL_LIM,
+	[POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX] = BATT_CHG_CTRL_LIM_MAX,
 };
 
 static int qcom_battmgr_bat_sm8350_update(struct qcom_battmgr *battmgr,
@@ -635,6 +639,12 @@ static int qcom_battmgr_bat_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
 		val->intval = battmgr->info.charge_ctrl_end;
 		break;
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+		val->intval = battmgr->info.charge_ctrl_limit;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX:
+		val->intval = battmgr->info.charge_ctrl_limit_max;
+		break;
 	case POWER_SUPPLY_PROP_MANUFACTURE_YEAR:
 		val->intval = battmgr->info.year;
 		break;
@@ -729,6 +739,26 @@ static int qcom_battmgr_set_charge_end_threshold(struct qcom_battmgr *battmgr, i
 	return 0;
 }
 
+static int qcom_battmgr_set_charge_control_limit(struct qcom_battmgr *battmgr, int limit)
+{
+	int ret;
+
+	if (limit < 0)
+		return -EINVAL;
+
+	mutex_lock(&battmgr->lock);
+	ret = qcom_battmgr_request_property(battmgr, BATTMGR_BAT_PROPERTY_GET,
+					    BATT_CHG_CTRL_LIM_MAX, 0);
+	if (!ret) {
+		limit = min_t(u32, limit, battmgr->info.charge_ctrl_limit_max);
+		ret = qcom_battmgr_request_property(battmgr, BATTMGR_BAT_PROPERTY_SET,
+						    BATT_CHG_CTRL_LIM, limit);
+	}
+	mutex_unlock(&battmgr->lock);
+
+	return ret;
+}
+
 static int qcom_battmgr_charge_control_thresholds_init(struct qcom_battmgr *battmgr)
 {
 	int ret;
@@ -764,6 +794,7 @@ static int qcom_battmgr_bat_is_writeable(struct power_supply *psy,
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
 	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
 		return 1;
 	default:
 		return 0;
@@ -786,6 +817,8 @@ static int qcom_battmgr_bat_set_property(struct power_supply *psy,
 		return qcom_battmgr_set_charge_start_threshold(battmgr, pval->intval);
 	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
 		return qcom_battmgr_set_charge_end_threshold(battmgr, pval->intval);
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+		return qcom_battmgr_set_charge_control_limit(battmgr, pval->intval);
 	default:
 		return -EINVAL;
 	}
@@ -921,6 +954,8 @@ static const enum power_supply_property sm8550_bat_props[] = {
 	POWER_SUPPLY_PROP_POWER_NOW,
 	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD,
 	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
 };
 
 static const struct power_supply_desc sm8550_bat_psy_desc = {
@@ -1479,11 +1514,28 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
 		case BATT_CHG_CTRL_END_THR:
 			battmgr->info.charge_ctrl_end = le32_to_cpu(resp->intval.value);
 			break;
+		case BATT_CHG_CTRL_LIM:
+			battmgr->info.charge_ctrl_limit = le32_to_cpu(resp->intval.value);
+			break;
+		case BATT_CHG_CTRL_LIM_MAX:
+			battmgr->info.charge_ctrl_limit_max = le32_to_cpu(resp->intval.value);
+			break;
 		default:
 			dev_warn(battmgr->dev, "unknown property %#x\n", property);
 			break;
 		}
 		break;
+	case BATTMGR_BAT_PROPERTY_SET:
+		if (payload_len != sizeof(resp->intval)) {
+			dev_warn(battmgr->dev,
+				 "invalid payload length for battery property set: %zd\n",
+				 payload_len);
+			battmgr->error = -ENODATA;
+			return;
+		}
+
+		battmgr->error = le32_to_cpu(resp->intval.result) ? -EIO : 0;
+		break;
 	case BATTMGR_USB_PROPERTY_GET:
 		property = le32_to_cpu(resp->intval.property);
 		if (payload_len != sizeof(resp->intval)) {
-- 
2.43.0

