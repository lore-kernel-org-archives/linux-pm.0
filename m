Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D701519B4;
	Thu, 30 Jul 2026 01:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785374250; cv=none; b=LvBgjqGS/HTlUHV8Lk20CmxnXI74Ib3LTGNQVq9F6E+JZF0++9/q/lr802d49/2RPGYaD2B8mhnBZ6Wc326oCk1dzjtyli6FLKRKsKhGK6n1RK2hrWAQ4epeYm3RHt2DQ0D8E+4j/Gg83syTQ/HpSLGnTqMKUMC9nPATNvgPbOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785374250; c=relaxed/simple;
	bh=IkMLIhviuMtpOFqlPOuHbj02DmV0lSyjUNOp0xKqwiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nV15FaNZEJ+WbRXXeE/j38dAycYxxpFm6Uc0604dZe1liM1Zvshs8FBIL7ktFRpKKmkVt73GTae4sPDp2qY/abPnuUkkHJ+NtIhaY2pebK5/WJ71J0lLXbPtLPrS3HxamRRLDbarDcOI5Eup83nUhj61qmsabVAX0V8IT/5WXQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6a2013168bb411f1aa26b74ffac11d73-20260730
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:32c8c64c-11f4-4745-867d-fdfdd2f8606c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:1eee9fb96518b78592d144031840dade,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6a2013168bb411f1aa26b74ffac11d73-20260730
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 207998015; Thu, 30 Jul 2026 09:17:21 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Sebastian Reichel <sre@kernel.org>
Cc: Waqar Hameed <waqar.hameed@axis.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH v3 1/2] power: supply: bq25630: Scope battery information to bq25630_setup()
Date: Thu, 30 Jul 2026 09:17:12 +0800
Message-Id: <20260730011713.3332913-2-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260730011713.3332913-1-lilinmao@kylinos.cn>
References: <20260730011713.3332913-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

data->batinfo is only used by bq25630_setup() to program the initial
charge limits, but power_supply_get_battery_info() allocates it on
psy->dev, so it stays around for the lifetime of the device. Nothing
else in the driver uses it.

Get the battery information in bq25630_setup(), just before it is read,
and release it on every path out of that function. The driver data no
longer has to carry the pointer.

Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 drivers/power/supply/bq25630_charger.c | 48 ++++++++++++++------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/power/supply/bq25630_charger.c b/drivers/power/supply/bq25630_charger.c
index 165f8c67b489..54c62b7d6514 100644
--- a/drivers/power/supply/bq25630_charger.c
+++ b/drivers/power/supply/bq25630_charger.c
@@ -356,7 +356,6 @@ struct bq25630_data {
 	struct regmap_field *regfields[BQ25630_REGF_MAX];
 
 	struct power_supply *psy;
-	struct power_supply_battery_info *batinfo;
 
 	/* State status from IRQs. */
 	u8 statregs[BQ25630_NR_STAT_REGS];
@@ -668,6 +667,7 @@ static int bq25630_reset(struct bq25630_data *data)
 
 static int bq25630_setup(struct bq25630_data *data)
 {
+	struct power_supply_battery_info *batinfo;
 	int ret;
 
 	ret = bq25630_reset(data);
@@ -684,69 +684,78 @@ static int bq25630_setup(struct bq25630_data *data)
 		return ret;
 	}
 
+	ret = power_supply_get_battery_info(data->psy, &batinfo);
+	if (ret) {
+		dev_err(data->dev, "Could not get battery info (%d)\n", ret);
+		return ret;
+	}
+
 	/*
 	 * Set values according to battery info. Warn on missing "dangerous"
 	 * properties.
 	 */
-	if (data->batinfo->voltage_min_design_uv >= 0) {
+	if (batinfo->voltage_min_design_uv >= 0) {
 		ret = bq25630_write_limit(data, BQ25630_REGF_VSYSMIN,
 					  BQ25630_VSYSMIN_MIN,
 					  BQ25630_VSYSMIN_MAX,
 					  BQ25630_VSYSMIN_STEP,
 					  BQ25630_VSYSMIN_MIN_REGVAL,
-					  data->batinfo->voltage_min_design_uv);
+					  batinfo->voltage_min_design_uv);
 		if (ret)
-			return ret;
+			goto out_put_batinfo;
 	} else
 		dev_warn(data->dev,
 			 "Using default value for minimum voltage\n");
 
-	if (data->batinfo->constant_charge_voltage_max_uv >= 0) {
+	if (batinfo->constant_charge_voltage_max_uv >= 0) {
 		ret = bq25630_write_limit(
 			data, BQ25630_REGF_VREG, BQ25630_VREG_MIN,
 			BQ25630_VREG_MAX, BQ25630_VREG_STEP,
 			BQ25630_VREG_MIN_REGVAL,
-			data->batinfo->constant_charge_voltage_max_uv);
+			batinfo->constant_charge_voltage_max_uv);
 		if (ret)
-			return ret;
+			goto out_put_batinfo;
 	} else
 		dev_warn(data->dev,
 			 "Using default value for maximum constant charge voltage\n");
 
-	if (data->batinfo->constant_charge_current_max_ua >= 0) {
+	if (batinfo->constant_charge_current_max_ua >= 0) {
 		ret = bq25630_write_limit(
 			data, BQ25630_REGF_ICHG, BQ25630_ICHG_MIN,
 			BQ25630_ICHG_MAX, BQ25630_ICHG_STEP,
 			BQ25630_ICHG_MIN_REGVAL,
-			data->batinfo->constant_charge_current_max_ua);
+			batinfo->constant_charge_current_max_ua);
 		if (ret)
-			return ret;
+			goto out_put_batinfo;
 	} else
 		dev_warn(data->dev,
 			 "Using default value for maximum constant charge current\n");
 
-	if (data->batinfo->charge_term_current_ua >= 0) {
+	if (batinfo->charge_term_current_ua >= 0) {
 		ret = bq25630_write_limit(
 			data, BQ25630_REGF_ITERM, BQ25630_ITERM_MIN,
 			BQ25630_ITERM_MAX, BQ25630_ITERM_STEP,
 			BQ25630_ITERM_MIN_REGVAL,
-			data->batinfo->charge_term_current_ua);
+			batinfo->charge_term_current_ua);
 		if (ret)
-			return ret;
+			goto out_put_batinfo;
 	}
 
-	if (data->batinfo->precharge_current_ua >= 0) {
+	if (batinfo->precharge_current_ua >= 0) {
 		ret = bq25630_write_limit(data, BQ25630_REGF_IPRECHG,
 					  BQ25630_IPRECHG_MIN,
 					  BQ25630_IPRECHG_MAX,
 					  BQ25630_IPRECHG_STEP,
 					  BQ25630_IPRECHG_MIN_REGVAL,
-					  data->batinfo->precharge_current_ua);
+					  batinfo->precharge_current_ua);
 		if (ret)
-			return ret;
+			goto out_put_batinfo;
 	}
 
-	return 0;
+out_put_batinfo:
+	power_supply_put_battery_info(data->psy, batinfo);
+
+	return ret;
 }
 
 static int bq25630_charger_get_property(struct power_supply *psy,
@@ -1024,11 +1033,6 @@ static int bq25630_probe(struct i2c_client *client)
 		return dev_err_probe(data->dev, PTR_ERR(data->psy),
 			      "Could not register power supply\n");
 
-	ret = power_supply_get_battery_info(data->psy, &data->batinfo);
-	if (ret)
-		return dev_err_probe(data->dev, ret,
-				     "Could not get battery info\n");
-
 	/*
 	 * Device sends active low 256 µs pulse to report status and fault.
 	 *
-- 
2.25.1

