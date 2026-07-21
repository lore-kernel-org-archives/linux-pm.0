Received: from outbound.qs.icloud.com (qs-2002c-snip4-3.eps.apple.com [57.103.87.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E997446EF6A
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.87.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660383; cv=none; b=aVTpRPcg1NwVvi8rdE8wDZq/VcAu8DdODwVtrIsN02Pp+iNKH1J0AUczrzHJsUf6piuoT9+XURZ8QcYGLiUE4JgatuZQzc39OmqtBR0bDIo0vFWd/+1NrGamDWvUeWup+dUBL0y1ct2G2mYpv1XlWCfdtJY4oWse/q3OnUnarig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660383; c=relaxed/simple;
	bh=zYPDk0dFuqI3SWYSbwOOATjyNJP19NdKD/Zid6+2nB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYMhtHwnn98yZcot2aPkOtGC/vtPwe70ofIJUUbCVSAMll+GfqewzMJ+O7qdht33rFso0UfRiDF2+mP15zwwx2le8XFkpQ6t8Y7sN6fd0vJCZA1J2nuSacCoFIGTRggpnKRKkDSXuM/Bm2/vUoTdYyBFbZWjacbvGMln2d8DFHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=s8NvcgRV; arc=none smtp.client-ip=57.103.87.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="s8NvcgRV"
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-3 (Postfix) with ESMTPS id 7799618004D8;
	Tue, 21 Jul 2026 18:59:36 +0000 (UTC)
X-ICL-RepId: 019f860c-3b17-7494-9120-83c21685520b
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPAEMGXAVeC1YBXwFLVxQEDloDVA5cBBcbXwJCH1sVSzhaDlsERxQXG1wAFw1WTVAbXwJCDxwTVhUTH1RWA0IZEFYBWFZdBU0aXBhZDxwBSlZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1QG18CQg8cE1YVEwBeDw9MC0gBWwdcAEEIQAZUB18cRAlPBlsaXx8GUBZQCFkfHBNVF0YZXg5AMFAbXwJCDxwTVhUNTUMSQhUEEVABWB5W
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1784660380; x=1787252380; bh=xVEkIySqC2w1VTBoBLzRmkBJvvkPdFwntWG87jLmjgU=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=s8NvcgRVaH4oWAxO2ECYrcTt0vNoNYMheub05EhlPaCH7EkCpsrKMc7vJY9KBC0uttNBxJcL2ujJG+uSUW4kQ62yubESUzLItfsL4Roy2EAiCcquibFQBTO5t5ZxH5OZ8pX7REBEZYNYGn+6drB/nLfAnwqjsugzmRPa1GB7J5mgM2nIOvMj9nMUNqsaxt7hyXb+kl/+/urM2900K1VJtyLqlGqKxVDUIMPnyTGD9wrjb3tnAtqfN6BeDG7dqOARzZwR4+L/BUxq09H2KLVhzI7k1WLQM6QLlV3DMCi70AHA6g8wF6QPfob5z3w0+miWPjdf7y6nQIcDfyjpzMFhfQ==
Received: from bigre.localdomain (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-3 (Postfix) with ESMTPSA id 13D5A1801822;
	Tue, 21 Jul 2026 18:59:35 +0000 (UTC)
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
Subject: [PATCH v3 3/4] power: supply: max17042_battery: Honor MAX17055 charge voltage
Date: Tue, 21 Jul 2026 14:57:35 -0400
Message-ID: <20260721185904.40756-4-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721185904.40756-1-vincent.cloutier@icloud.com>
References: <20260721185904.40756-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE5OSBTYWx0ZWRfX+Cx+dPXcv0XU
 g8V1LgJBEBL04zjys+Asq2Kp0ZIfIvaero0kefwMk6PZLYl5pRYv2RZW9PxpnO2tLhLb/G8DdUc
 5pWVQV/6xT0EIFi7z3rzZZAxMpc33UkoYVJMB/kt01bFaGcg/7NPEroL4QhK1CiwWxAfBV79vzX
 FIMJ9xwcTxQ6rYfwb/AB5HTHf2ajopSZlM9Y66hROmRFgt1sqnVfeHe5F4czbeE9zbfuKxnt6x6
 bDTxefYMNikjw+kOc4noij6hR4fIJZMXE1tcEEhOG6yMT1Jh8eUzBKrwRI6EeD5dlesgbNALyNI
 JDr52FTAPEJxZML/MiB
X-Proofpoint-GUID: Iddilkg9rgge7z6L683povkqfllri423
X-Proofpoint-ORIG-GUID: Iddilkg9rgge7z6L683povkqfllri423

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

