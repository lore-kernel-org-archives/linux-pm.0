Received: from outbound.ci.icloud.com (ci-2001i-snip4-3.eps.apple.com [57.103.91.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D1F212FAD
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 01:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.91.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784509933; cv=none; b=i/8XjsOpZBD2e7TUlnNygxAxmptS1EO3O0J9Gl1v0JCN8QD7yBwiAyq6k+njEbC7T5uLhL4FBtys570eUitOpw1bDcmcEt+Y5yU/nxxBh/+W1VHe2mevioY5AStamYvc68yKG8x6jVGfg/U7Bu9WS8K4maYOSMDq3bvswFI3kbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784509933; c=relaxed/simple;
	bh=zYPDk0dFuqI3SWYSbwOOATjyNJP19NdKD/Zid6+2nB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rr3Oc/OTRZSvYtE3B0ZZ9b5iXDVgQToR1OXEYt2QpE9orpu3RosOXiYtMrdtSYuvWm+BLYuDC4Z2OPEwHDZUPKDgyzn3rvHWtgLtsNht22BzKYznWpvMJcyvD/AnuFTtnPbQ5QsaCDEfLNCgoEwXIyaS8Zod86SPEayGZvVvvAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=cqpDaYjv; arc=none smtp.client-ip=57.103.91.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="cqpDaYjv"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-1 (Postfix) with ESMTPS id 0D32618002CC;
	Mon, 20 Jul 2026 01:12:09 +0000 (UTC)
X-ICL-RepId: 019f7d14-9a06-7b45-aae5-f5db25592786
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPAEMGXAVeC1YBXwFLVxQEDloDVA5cBBcbXwJCH1sVSzhaDlsERxQXG1wAFw1WTVAbXwJCDxwTVhUTH1RWA0IZEFYBWFZdBU0aXBhZDxwTUFZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1QG18CQg8cE1YVEwBeDw9MC0gBWwdcAEAJSQJcA18cQQtAA18GUh9EFA5aA1QOXAQXG18CQh9bFUs4Wg5bBEcUFxtcAAlLRglJHQ4EVAddBV0=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1784509931; x=1787101931; bh=xVEkIySqC2w1VTBoBLzRmkBJvvkPdFwntWG87jLmjgU=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=cqpDaYjveEny/nal9+HhdXALvV7qV0pSegsO1UCkt8h17nAEjSZdQbAFKk95IAgMKE0vnXyT778gA0iE4iqbdYtk7LtQVU5jGtnexdOWGrXKzfvb0EkTSoln9LWxTwjNvvN/R7UKSfOIZEGlISwxI1i5sBVleiJIa0p1dTjRWTlhWB09MUaYWeq/ay6kY4yWLL7EwFzQ07HORcsf2QDBR++E2vVgSVp7skCd+p2D0wJZtBXzTSsGi1v0oDghMh64xy9Ntqec402/yxaOG461v1c+xpVUFQRUzIWokMyedtejxuinSd+ci/c3xBgXw2IIFRZrHSkeu57L1hbn9zhlBw==
Received: from bigre.localdomain (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-1 (Postfix) with ESMTPSA id 2562918000D0;
	Mon, 20 Jul 2026 01:12:09 +0000 (UTC)
From: Vincent Cloutier <vincent.cloutier@icloud.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Cloutier <vincent@cloutier.co>
Subject: [PATCH v2 3/4] power: supply: max17042_battery: Honor MAX17055 charge voltage
Date: Sun, 19 Jul 2026 21:11:39 -0400
Message-ID: <20260720011144.1280219-4-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720011144.1280219-1-vincent.cloutier@icloud.com>
References: <20260720011144.1280219-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LyABjPkAQbRT5k4bFAlS2Odj95fr4lDy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAwOSBTYWx0ZWRfXyKUSy7wT73BT
 PVkVRz+qGnKaEwveD04JO6Jxu1s1HSTwSqlZVPaJdTCUoXBKixjUb0iIdffaEzAdjVGIG5OZdDQ
 xkDNftWM0siGgnXSCTNAs38k9o4PbBoiUS1SYO9WDDuEsve92Hzxieb7rxUuQiw/D2hukGV6Zd2
 oV6mo10NIBk+Uli+QhjvM1lzf3/BaacYABZA9Pd8Xo6P/DVa8eWt90vwYacd5xHCk/Sp2lS67Ep
 Er8O0JG/h8ZdPPS9yT7+ucJwznTeWwaAXO6/RFX2Z4gyEnXxyh4z0CeCcVNrefGdvb1bpoBmRsq
 Ky+Ws2m72EsBYjytNVK
X-Proofpoint-ORIG-GUID: LyABjPkAQbRT5k4bFAlS2Odj95fr4lDy

From: Vincent Cloutier <vincent@cloutier.co>

MAX17055 ModelCfg.VChg selects the charge-voltage range used by EZ Config.
Consume voltage-max-design-microvolt from monitored-battery and set VChg
only when the value is strictly greater than 4.275 V. Reject an explicit
zero voltage and preserve the register when the property is absent.

Update only the VChg bit and verify its read-back so unrelated ModelCfg
fields remain intact. Treat a VChg-only override as an accumulator change:
read effective DesignCap and dQAcc, derive and verify the matching dPAcc,
then request model refresh. This keeps voltage-only firmware descriptions
coherent with the selected charge-voltage range.

Assisted-by: OpenCode:gpt-5.6-sol
Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
---
 drivers/power/supply/max17042_battery.c | 42 +++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index b25bf26135e0..0f6bf6d4c031 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -66,6 +66,7 @@
 #define MAX17055_DPACC_FACTOR		44138
 #define MAX17055_DPACC_VCHG_FACTOR	51200
 #define MAX17055_FSTAT_DNR_BIT		BIT(0)
+#define MAX17055_VCHG_THRESHOLD_UV	4275000
 #define MAX17055_DNR_POLL_US		10000
 #define MAX17055_DNR_TIMEOUT_US		2000000
 #define MAX17055_INIT_RETRY_DELAY_MS	10000
@@ -83,6 +84,7 @@ struct max17042_chip {
 	int    task_period;
 	bool   enable_current_sense;
 	bool   enable_por_init;
+	bool   enable_vchg_override;
 	bool   init_complete;
 	bool   hib_restore_pending;
 	u16    hib_cfg;
@@ -879,7 +881,8 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
 		max17042_override_por(map, MAX17047_V_empty, config->vempty);
 	}
 
-	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055)
+	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055 &&
+	    !chip->enable_vchg_override)
 		max17042_override_por(map, MAX17055_ModelCfg, config->model_cfg);
 }
 
@@ -914,7 +917,19 @@ static int max17055_override_battery_values(struct max17042_chip *chip)
 			return ret;
 	}
 
-	if (!config->design_cap && !config->dqacc)
+	if (chip->enable_vchg_override) {
+		ret = regmap_update_bits(map, MAX17055_ModelCfg,
+					 MAX17055_MODELCFG_VCHG_BIT,
+					 config->model_cfg &
+					 MAX17055_MODELCFG_VCHG_BIT);
+		if (ret)
+			return ret;
+
+		usleep_range(1000, 2000);
+	}
+
+	if (!config->design_cap && !config->dqacc &&
+	    !chip->enable_vchg_override)
 		return 0;
 
 	ret = regmap_read(map, MAX17042_DesignCap, &design_cap);
@@ -928,6 +943,10 @@ static int max17055_override_battery_values(struct max17042_chip *chip)
 	ret = regmap_read(map, MAX17055_ModelCfg, &model_cfg);
 	if (ret)
 		return ret;
+	if (chip->enable_vchg_override &&
+	    (model_cfg & MAX17055_MODELCFG_VCHG_BIT) !=
+	    (config->model_cfg & MAX17055_MODELCFG_VCHG_BIT))
+		return -EIO;
 
 	if (!design_cap || !dqacc)
 		return -ERANGE;
@@ -1248,9 +1267,11 @@ static int max17042_apply_battery_properties(struct max17042_chip *chip,
 	struct device *dev = chip->dev;
 	bool have_design_cap;
 	bool have_ichgt_term;
+	bool have_vchg;
 	u16 design_cap = 0;
 	u16 ichgt_term = 0;
 	u16 dqacc = 0;
+	u16 model_cfg = 0;
 	u64 data64;
 
 	if (!info || chip->chip_type != MAXIM_DEVICE_TYPE_MAX17055)
@@ -1260,7 +1281,8 @@ static int max17042_apply_battery_properties(struct max17042_chip *chip,
 		info->charge_full_design_uah >= 0;
 	have_ichgt_term = chip->enable_current_sense &&
 		info->charge_term_current_ua >= 0;
-	if (!have_design_cap && !have_ichgt_term)
+	have_vchg = info->voltage_max_design_uv >= 0;
+	if (!have_design_cap && !have_ichgt_term && !have_vchg)
 		return 0;
 
 	if (have_design_cap) {
@@ -1301,6 +1323,15 @@ static int max17042_apply_battery_properties(struct max17042_chip *chip,
 		ichgt_term = (u16)data64;
 	}
 
+	if (have_vchg) {
+		if (!info->voltage_max_design_uv)
+			return dev_err_probe(dev, -EINVAL,
+					     "battery design voltage must be positive\n");
+
+		if (info->voltage_max_design_uv > MAX17055_VCHG_THRESHOLD_UV)
+			model_cfg = MAX17055_MODELCFG_VCHG_BIT;
+	}
+
 	config = chip->config_data;
 	if (!config) {
 		config = devm_kzalloc(dev, sizeof(*config), GFP_KERNEL);
@@ -1314,6 +1345,11 @@ static int max17042_apply_battery_properties(struct max17042_chip *chip,
 	}
 	if (have_ichgt_term)
 		config->ichgt_term = ichgt_term;
+	if (have_vchg) {
+		config->model_cfg &= ~MAX17055_MODELCFG_VCHG_BIT;
+		config->model_cfg |= model_cfg;
+		chip->enable_vchg_override = true;
+	}
 
 	chip->config_data = config;
 	chip->enable_por_init = true;
-- 
2.55.0

