Received: from outbound.ms.icloud.com (ms-2002b-snip4-11.eps.apple.com [57.103.74.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E533A25C80E
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 01:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.74.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785114899; cv=none; b=oF/E6PScWen0jvvbHlInH/DKqfxKTsaHW05uD8HevsPfcZAbp83IFGUOCRiMSKhAzBD8HVdxgDidJpUbHX8xTCDHnFxp+11CyW4dS/V3oXO+CtzqoDlndQNJlFczepCxcVz99EBTl9SXOhXl9hkw1P5QiZCN/qOKEZumeWD5F14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785114899; c=relaxed/simple;
	bh=i9IUhNeLjKAxNgsi8lY2B6DapxEsRfX9No0yKsjkA58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqdMZ6w++dLfGiYBXQYep6XCazn2FZLNSzLqIb/rLq02PwKzjHPHeK1FKTAdeGWooD2Vye9dpQFUSMf988WsJT766TxbQrUj5l47HqwhTYI1fkp5o75aDPGzdHlhqoCnM/DdZDmjdV60rF72gJ16VL4Jc+GraykHD+KFYRbZW5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=dKIDGIH0; arc=none smtp.client-ip=57.103.74.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="dKIDGIH0"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPS id 379D518000DB;
	Mon, 27 Jul 2026 01:14:52 +0000 (UTC)
X-ICL-RepId: 019fa123-9b24-795d-96e4-da8bf2ead925
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPAEMGXAVeC1YBXwFLVxQEDloDVA5cBBcbXwJCH1sVSzhaDlsERxQXG1wAFw1WTVAbXwJCDxwTVhUTH1RWA0IZEFYBWFZdBU0aXBhZDxwdSlZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1QG18CQg8cE1YVEwBeDw9MC0gBWwdcAEcJSQJeBlIcRgtJBFQDRgNBFA5aA1QOXAQXG18CQh9bFUs4Wg5bBEcUFxtcAAlLRglJHQ4EVAddBV0=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1785114897; x=1787706897; bh=LKUvWmlm8qW9R0rdKSrLgcPx21c4L2fSBbpnVUL3Yqw=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=dKIDGIH0C8CK9KylerKj5vF28LD/nOuxGaKEbQ7OO3PEbCfeRW4GKFNa3bXslgOkUC4Ds09IL9Q6i0OlYnTWuCxTC88J2OVbtwmDjHF2K8VPV2zh/X5icgd4bMajTH/pdkbzTCYJbvzIcxEU8hcO9/oDPclshP4il+X84DE85nVhb0vuI4cSMxOBVcBngyEVAjHonsujOu2g+qHxDD4a2aLqrGaEYKb3BMtsp85grYwSyYR12jqF+Y+wKwmOgHFcF9YQAf4BMePk9emNNKpuy8sk3Cl/AVxMC8BmbAvpIb6sRWIHlE3451lfDbihCWDkdF6N5ipFr+0eZ8nYoyhTGw==
Received: from bigre.localdomain (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPSA id 12E0218000C2;
	Mon, 27 Jul 2026 01:14:49 +0000 (UTC)
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
Subject: [PATCH v4 10/11] power: supply: max17042_battery: Honor MAX17055 charge voltage
Date: Sun, 26 Jul 2026 21:13:08 -0400
Message-ID: <20260727011319.621794-11-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727011319.621794-1-vincent.cloutier@icloud.com>
References: <20260727011319.621794-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDAwOSBTYWx0ZWRfX2YRL9SPxL/7g
 bT0UNCMk24ZY8qmKxx4owvZbCggShFC9NyUimS3cRAK8/XlRYLiMQlL7Ua4aBrpNQ+QQZ8G/fkd
 HCv7gzO8fhF8eUYWZ66MpqAn5tNyO3AaPgRwDs5aBB+fi3ujx+e0IB4IvTeAs4iqey5xq0vS1b0
 LDHwMRuMd/A58DX6s+GHPaQwNuw+zcR1ldHaB5jBCFVZueheX7MDpPFNDGLNozxC63kEsbovqRA
 mxIBWy0at8CWLVUvaNCX5q1jmv5EncFb9Jt/AhGGgixqeD/yRAx/UQLZqcAn5O0NeOEpUCIOQM1
 H0Po/+FXurTKwQoksvUl1GvtzPzuyUIlBaMuUsDqNx4MWOycfC6FjULHKc6kQ8=
X-Proofpoint-ORIG-GUID: sYqcHoX6o1SSCG6-lubS-he2-KS9WVZ8
X-Proofpoint-GUID: sYqcHoX6o1SSCG6-lubS-he2-KS9WVZ8
X-Authority-Info-Out: v=2.4 cv=bY1mkePB c=1 sm=1 tr=0 ts=6a66b10f
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=RAioF0-LDSMA:10
 a=x7bEGLp0ZPQA:10 a=5j__JWfIoqoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Y7L-nm5eWvuGTx37qJkA:9

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
index db3b1bc5388f..6278e7c89bdd 100644
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
 		info->charge_full_design_uah > 0;
 	have_ichgt_term = chip->enable_current_sense &&
 		info->charge_term_current_ua > 0;
-	if (!have_design_cap && !have_ichgt_term)
+	have_vchg = info->voltage_max_design_uv >= 0;
+	if (!have_design_cap && !have_ichgt_term && !have_vchg)
 		return 0;
 
 	if (have_design_cap) {
@@ -1293,6 +1315,15 @@ static int max17042_apply_battery_properties(struct max17042_chip *chip,
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
@@ -1306,6 +1337,11 @@ static int max17042_apply_battery_properties(struct max17042_chip *chip,
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

