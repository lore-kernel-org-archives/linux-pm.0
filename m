Received: from outbound.ms.icloud.com (ms-2002e-snip4-8.eps.apple.com [57.103.74.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10626280A58
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 01:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.74.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785114888; cv=none; b=qVFPlY4hPowYS6ypaGuZgixSE+CMNYox32E6jm+tiyEhMJnKsoZxg+dVBxxH+mxhSb/qITgguVxjZvEdsPTjpVN4zR7MFFWAvts2G4srZXkYH5WvWOQi8ceA05Dr7p3IFj125Sh4smRbeMhrEcflfCOqZRQvgEY+DkNpe0DxUQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785114888; c=relaxed/simple;
	bh=v8R7G84r2F1fi5EbZtbAFD/eZzldX/J243d5UGcw5HI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkrarDjwE1dT0pIB6raoTxTSIQTCGaIGAa44uBOA4u/mHUhSo7Uwt4vclu6bg6wMJDG9awviPZ+kd5M/evHuUgcQCFt9Zlw2G53IM+JYnSlXdXJPMB9oXpvWWzCq7KNOm9W50JFij1Lzu4G2807LFauI8t8AWrMC0rw+v23eXN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=QL1GnVWG; arc=none smtp.client-ip=57.103.74.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="QL1GnVWG"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPS id 91D9F1800102;
	Mon, 27 Jul 2026 01:14:44 +0000 (UTC)
X-ICL-RepId: 019fa123-79bd-7948-aae1-ea000bc255aa
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPAEMGXAVeC1YBXwFLVxQEDloDVA5cBBcbXwJCH1sVSzhaDlsERxQXG1wAFw1WTVAbXwJCDxwTVhUTH1RWA0IZEFYBWFZdBU0aXBhZDxwdSlZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1QG18CQg8cE1YVEwBeDw9MC0gBWwdcAEcJSQJeBlIcRgtJBFQDRgpdTxFdDlIFRl5aFFwYQwJXAnkRUAFYHlZeWhdeUxcfSwBcRVoOWwRHFA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1785114886; x=1787706886; bh=6Qo5NM04j1cCpQp+osEAKu4SrVf8v8vvaTUO6q6iP3I=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=QL1GnVWGJJhpdo7+8E6+fBKxFr+ZltAj3ccHw3NHuFz6L3F0xkieQFEqY6tU5kOFHYBXIwP3ZZ3QTEA6CDOk+QQ3vixs6e2KcAr5fgczJDvGrbUMhrHGGWLs8y6qNaAcSdtA+wMAcuXlMl8Y45PMC2Lt3KF5CcqlofdGxkhXbP5XAZI3ILeJ6vf3FaIqv0H7PVDzq8/cX+JFjPHHQWXQZIxuojEwr0gDooySKDDUbHSoElIxR0bc4emRZiERlXaFfHRgT2uVRfNW3hslljbAkluB6TFmyCo89Pk7hngRcPPz+vVw822TlEtasBgDL5ZtwipI/RsV4Z7ZKJ9zZzEKSg==
Received: from bigre.localdomain (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPSA id EE0361800109;
	Mon, 27 Jul 2026 01:14:42 +0000 (UTC)
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
Subject: [PATCH v4 07/11] power: supply: max17042_battery: Program MAX17055 EZ Config values
Date: Sun, 26 Jul 2026 21:13:05 -0400
Message-ID: <20260727011319.621794-8-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727011319.621794-1-vincent.cloutier@icloud.com>
References: <20260727011319.621794-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDAwOSBTYWx0ZWRfX0TQlyLqi9orX
 H/M+L15apYLf/10FM0wBmZSnn1PQO1g5kJehP3bBQwoyloOkbEQtIMfDxdTzGO7mMBoNSuzCa06
 Ysh0fiaK+3V6NAihjg4YvE4WpmH4ay7wpjZY/GuJwEkzwiJKe47wSqxl+6ae/bxYtkl7EqmsRdP
 fgADepnsCasww4oVdL2MJfpFqb+4Ao6KGKX2nZcquWsNtqK7S9xF6wgSoBnVBtnV5Gimkheyco/
 JLxfEIehO0J/ZnpM42yJINFVx4OtYbgbDosOuQIoMgtZZL4GRItABi95atH8qfna65BrDOkzdOv
 RIDfjJ9YlaQnuwuZZ6PnTfOif15NSxkt5zC5M7LhncxV3wHiGW755gZW9gTh/8=
X-Proofpoint-GUID: B16hGrMaWB69JoSvFoLm-FE5Sj1kqW-1
X-Proofpoint-ORIG-GUID: B16hGrMaWB69JoSvFoLm-FE5Sj1kqW-1
X-Authority-Info-Out: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=6a66b105
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=x7bEGLp0ZPQA:10 a=5j__JWfIoqoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=e_zewkccU6FyYt0SBuwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10

From: Vincent Cloutier <vincent@cloutier.co>

MAX17055 EZ Config requires DesignCap, dQAcc, IChgTerm, and dPAcc to
be programmed coherently. Write each supplied stable register once, wait
1 ms, and verify its read-back instead of relying on the unchecked generic
POR override path.

Derive dPAcc from the effective DesignCap, dQAcc, and ModelCfg values so
the accumulator matches the selected charge-voltage range. Propagate all
read, write, verification, and range errors to the retrying init worker.

Assisted-by: OpenCode:gpt-5.6-sol
Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
---
 drivers/power/supply/max17042_battery.c | 99 ++++++++++++++++++++++++-
 include/linux/power/max17042_battery.h  |  1 +
 2 files changed, 96 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 27d881d4324f..600b2689f316 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -62,6 +62,8 @@
 #define MAX17042_RESISTANCE_LSB		1 / 4096 /* Ω */
 #define MAX17042_TEMPERATURE_LSB	1 / 256 /* °C */
 
+#define MAX17055_DPACC_FACTOR		44138
+#define MAX17055_DPACC_VCHG_FACTOR	51200
 #define MAX17055_INIT_RETRY_DELAY_MS	10000
 
 struct max17042_chip {
@@ -568,6 +570,24 @@ static int max17042_write_verify_reg(struct regmap *map, u8 reg, u32 value)
 	return ret;
 }
 
+static int max17055_write_verify_reg(struct regmap *map, u8 reg, u32 value)
+{
+	u32 read_value;
+	int ret;
+
+	ret = regmap_write(map, reg, value);
+	if (ret)
+		return ret;
+
+	usleep_range(1000, 2000);
+
+	ret = regmap_read(map, reg, &read_value);
+	if (ret)
+		return ret;
+
+	return read_value == value ? 0 : -EIO;
+}
+
 static inline void max17042_override_por(struct regmap *map,
 					 u8 reg, u16 value)
 {
@@ -803,8 +823,12 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
 	max17042_override_por(map, MAX17042_CONFIG, config->config);
 	max17042_override_por(map, MAX17042_SHDNTIMER, config->shdntimer);
 
-	max17042_override_por(map, MAX17042_DesignCap, config->design_cap);
-	max17042_override_por(map, MAX17042_ICHGTerm, config->ichgt_term);
+	if (chip->chip_type != MAXIM_DEVICE_TYPE_MAX17055) {
+		max17042_override_por(map, MAX17042_DesignCap,
+				      config->design_cap);
+		max17042_override_por(map, MAX17042_ICHGTerm,
+				      config->ichgt_term);
+	}
 
 	max17042_override_por(map, MAX17042_AtRate, config->at_rate);
 	max17042_override_por(map, MAX17042_LearnCFG, config->learn_cfg);
@@ -814,8 +838,10 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
 
 	max17042_override_por(map, MAX17042_FullCAP, config->fullcap);
 	max17042_override_por(map, MAX17042_FullCAPNom, config->fullcapnom);
-	max17042_override_por(map, MAX17042_dQacc, config->dqacc);
-	max17042_override_por(map, MAX17042_dPacc, config->dpacc);
+	if (chip->chip_type != MAXIM_DEVICE_TYPE_MAX17055) {
+		max17042_override_por(map, MAX17042_dQacc, config->dqacc);
+		max17042_override_por(map, MAX17042_dPacc, config->dpacc);
+	}
 
 	max17042_override_por(map, MAX17042_RCOMP0, config->rcomp0);
 	max17042_override_por(map, MAX17042_TempCo, config->tcompc0);
@@ -849,10 +875,75 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
 		max17042_override_por(map, MAX17055_ModelCfg, config->model_cfg);
 }
 
+static int max17055_override_battery_values(struct max17042_chip *chip)
+{
+	struct max17042_config_data *config = chip->config_data;
+	struct regmap *map = chip->regmap;
+	unsigned int design_cap;
+	unsigned int model_cfg;
+	unsigned int dqacc;
+	u64 dpacc;
+	int ret;
+
+	if (config->design_cap) {
+		ret = max17055_write_verify_reg(map, MAX17042_DesignCap,
+						config->design_cap);
+		if (ret)
+			return ret;
+	}
+
+	if (config->dqacc) {
+		ret = max17055_write_verify_reg(map, MAX17042_dQacc,
+						config->dqacc);
+		if (ret)
+			return ret;
+	}
+
+	if (config->ichgt_term) {
+		ret = max17055_write_verify_reg(map, MAX17042_ICHGTerm,
+						config->ichgt_term);
+		if (ret)
+			return ret;
+	}
+
+	if (!config->design_cap && !config->dqacc)
+		return 0;
+
+	ret = regmap_read(map, MAX17042_DesignCap, &design_cap);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(map, MAX17042_dQacc, &dqacc);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(map, MAX17055_ModelCfg, &model_cfg);
+	if (ret)
+		return ret;
+
+	if (!design_cap || !dqacc)
+		return -ERANGE;
+
+	dpacc = (u64)dqacc *
+		(model_cfg & MAX17055_MODELCFG_VCHG_BIT ?
+		 MAX17055_DPACC_VCHG_FACTOR : MAX17055_DPACC_FACTOR);
+	do_div(dpacc, design_cap);
+	if (dpacc > U16_MAX)
+		return -ERANGE;
+
+	return max17055_write_verify_reg(map, MAX17042_dPacc, (u16)dpacc);
+}
+
 static int max17055_init_chip(struct max17042_chip *chip)
 {
+	int ret;
+
 	max17042_override_por_values(chip);
 
+	ret = max17055_override_battery_values(chip);
+	if (ret)
+		return ret;
+
 	return regmap_write_bits(chip->regmap, MAX17055_ModelCfg,
 				 MAX17055_MODELCFG_REFRESH_BIT,
 				 MAX17055_MODELCFG_REFRESH_BIT);
diff --git a/include/linux/power/max17042_battery.h b/include/linux/power/max17042_battery.h
index 13aeab1597c6..61af6fe2f4fe 100644
--- a/include/linux/power/max17042_battery.h
+++ b/include/linux/power/max17042_battery.h
@@ -25,6 +25,7 @@
 #define MAX17042_CHARACTERIZATION_DATA_SIZE 48
 
 #define MAX17055_MODELCFG_REFRESH_BIT	BIT(15)
+#define MAX17055_MODELCFG_VCHG_BIT	BIT(10)
 
 enum max17042_register {
 	MAX17042_STATUS		= 0x00,
-- 
2.55.0

