Received: from outbound.qs.icloud.com (qs-2002c-snip4-6.eps.apple.com [57.103.87.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3344446DFE3
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.87.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660380; cv=none; b=s4QF1dmJPlT6sSR2liQ7xYstlyvewuDhKz/bEIFY+NiCUr7VZt6YNaKIuyhXc5p3RLYzxzhCpyn9F32ucARpW3sjzenp5c4+b/CZ8nuCPSvc6QePi/az4YsQsLKIh1uRA+IEZM9GNdAosRwvH6hDh6PG2w6mLZegEHMed1/5R7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660380; c=relaxed/simple;
	bh=MpCEGbVhBKIlAdc1p/tHkHq4S3ljcuQWEtg0SJcUGGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vogi7T/Y3/sHXudgUIG+0tualITxIQ0iYXTugwl6NSwqeD08uOb4bEcCaYEmmH4IgEBxfpMBwIzjkTYT9NhaHUb+N/vF14lsEN1VQPRNtWNwba2paV/DaCl4SP9gW7rCvrqDIMkDVIoH6OdD5l85EZcA3dZZExWSWuC810g8cNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=cCt/NFHV; arc=none smtp.client-ip=57.103.87.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="cCt/NFHV"
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-3 (Postfix) with ESMTPS id 8FCC61800275;
	Tue, 21 Jul 2026 18:59:35 +0000 (UTC)
X-ICL-RepId: 019f860c-37e2-7708-b1f4-59dcc3b191ba
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPAEMGXAVeC1YBXwFLVxQEDloDVA5cBBcbXwJCH1sVSzhaDlsERxQXG1wAFw1WTVAbXwJCDxwTVhUTH1RWA0IZEFYBWFZdBU0aXBhZDxwBSlZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1QG18CQg8cE1YVEwBeDw9MC0gBWwdcAEEIQAZUB18cRAlPBlsaWB8GUBZQCFkfHBNVF0YZXg5AMFAbXwJCDxwTVhUNTUMSQhUEEVABWB5W
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1784660377; x=1787252377; bh=vAAou0ItuODHJ7VRRr9+GAd58QJ1e8SPQzYumIVrkD8=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=cCt/NFHVYfv340bzbTcNPgixa6azLjp533bLLKq74hwFFDedeV6bLOsiI+SeMXlJH5rgwzb8eA/hRQLwfvLvI3+k5lcteOuRBKV1PMbAiQ2OWeStr3zS/eXlK8uvXNxQBpmgrts+rUbK2mbl54W/0bLMsI54M6HO2RW6uzhIbyEI8ogo3DV4oMSMJZbVU+AHSOR46JcEnJ1T3Ia42xD33qJQPh44CDXTn95cR6sTBtLkEdi4pujdvivbjygt/ooro1w62lNJTLk0JN51+XZk/28t05b7BAMdk+tMa6cK2auRYP5ClNQrx5TPMzkMVYtO5LDIflUxkQmaOn0aoKx08w==
Received: from bigre.localdomain (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-3 (Postfix) with ESMTPSA id 8F6C618004F2;
	Tue, 21 Jul 2026 18:59:34 +0000 (UTC)
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
Subject: [PATCH v3 2/4] power: supply: max17042_battery: Initialize MAX17055 from battery info
Date: Tue, 21 Jul 2026 14:57:34 -0400
Message-ID: <20260721185904.40756-3-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721185904.40756-1-vincent.cloutier@icloud.com>
References: <20260721185904.40756-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MmWNXYdaDwmrDHVAFpGvbywHTmBTDA9G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE5OSBTYWx0ZWRfX/+RinmhL0l8+
 nYYriQ5FCro48u1G8gvpSugO0nqKudlHFccpqmMoBcASRZQGZU2SoXCii2ZmyWjFdgkr+YGySR4
 KJA91mLMHNvJfBK5zR8GgvXPejekjYlYag0wK3SFEPdrP3+YFCkqyF8B7MZ/5rWL5bXAQHd/c/j
 c5yUoDLd4UZg/hXfepcEZegtRtTTpXPjMi9KD0ASbxjLn0XzqB1i92rGfU7ecZKs+k+02FKpP0y
 Vk2cKJJ7WM5HNy2I1n6sPSwz0dRmF2io386f/EpCSbMNOEJwGVPx4YwUGEYBoabC5xMAkQlfCPQ
 F7MqiU171jDFZGvWZGG
X-Proofpoint-GUID: MmWNXYdaDwmrDHVAFpGvbywHTmBTDA9G

From: Vincent Cloutier <vincent@cloutier.co>

MAX17055 can use charge-full-design-microamp-hours and
charge-term-current-microamp from monitored-battery for its POR
configuration. Prepare quantized DesignCap, IChgTerm, and EZ Config dQAcc
values in the power-supply registration callback after the core has parsed
battery information.

Validate all supplied values before changing the sparse configuration.
Reject zero, values that quantize to zero, capacities that cannot produce
dQAcc, and positive termination currents outside the signed register range.
Limit this path to MAX17055 because the other supported gauges require
complete characterization data.

Follow the documented POR sequence. Wait for FSTAT.DNR, save HibCfg, exit
hibernate, write stable battery registers once and verify them after 1 ms,
issue command writes directly, poll until refresh clears, and restore
HibCfg. Clear POR only after every step succeeds.

Keep driver-backed properties unavailable while initialization is
incomplete. If an I/O error interrupts the transaction, restore hibernate
before the next attempt and retry periodically so a transient startup
failure does not become permanent.

Assisted-by: OpenCode:gpt-5.6-sol
Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
---
 drivers/power/supply/max17042_battery.c | 335 +++++++++++++++++++++---
 include/linux/power/max17042_battery.h  |   2 +
 2 files changed, 306 insertions(+), 31 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index d409d2f0d383..b25bf26135e0 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -62,18 +62,30 @@
 #define MAX17042_RESISTANCE_LSB		1 / 4096 /* Ω */
 #define MAX17042_TEMPERATURE_LSB	1 / 256 /* °C */
 
+#define MAX17055_DQACC_DIV		32
+#define MAX17055_DPACC_FACTOR		44138
+#define MAX17055_DPACC_VCHG_FACTOR	51200
+#define MAX17055_FSTAT_DNR_BIT		BIT(0)
+#define MAX17055_DNR_POLL_US		10000
+#define MAX17055_DNR_TIMEOUT_US		2000000
+#define MAX17055_INIT_RETRY_DELAY_MS	10000
+#define MAX17055_REFRESH_POLL_US		10000
+#define MAX17055_REFRESH_TIMEOUT_US	1000000
+
 struct max17042_chip {
 	struct device *dev;
 	struct regmap *regmap;
 	struct power_supply *battery;
 	enum max170xx_chip_type chip_type;
 	struct max17042_config_data *config_data;
-	struct work_struct work;
-	int    init_complete;
+	struct delayed_work work;
 	int    irq;
 	int    task_period;
 	bool   enable_current_sense;
 	bool   enable_por_init;
+	bool   init_complete;
+	bool   hib_restore_pending;
+	u16    hib_cfg;
 	unsigned int r_sns;
 	int    vmin;	/* in millivolts */
 	int    vmax;	/* in millivolts */
@@ -256,7 +268,7 @@ static int max17042_get_property(struct power_supply *psy,
 	u32 data;
 	u64 data64;
 
-	if (!chip->init_complete)
+	if (!READ_ONCE(chip->init_complete))
 		return -EAGAIN;
 
 	switch (psp) {
@@ -566,6 +578,24 @@ static int max17042_write_verify_reg(struct regmap *map, u8 reg, u32 value)
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
@@ -801,8 +831,12 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
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
@@ -812,8 +846,10 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
 
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
@@ -847,26 +883,162 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
 		max17042_override_por(map, MAX17055_ModelCfg, config->model_cfg);
 }
 
-static int max17042_init_chip(struct max17042_chip *chip)
+static int max17055_override_battery_values(struct max17042_chip *chip)
 {
+	struct max17042_config_data *config = chip->config_data;
 	struct regmap *map = chip->regmap;
+	unsigned int design_cap;
+	unsigned int model_cfg;
+	unsigned int dqacc;
+	u64 dpacc;
 	int ret;
 
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
+static int max17055_restore_hibernate(struct max17042_chip *chip)
+{
+	int restore_hib_ret;
+	int soft_wakeup_ret;
+
+	soft_wakeup_ret = regmap_write(chip->regmap, MAX17055_SoftWakeup, 0);
+	restore_hib_ret = max17055_write_verify_reg(chip->regmap,
+						    MAX17055_HibCfg,
+						    chip->hib_cfg);
+	if (!soft_wakeup_ret && !restore_hib_ret)
+		chip->hib_restore_pending = false;
+
+	return soft_wakeup_ret ?: restore_hib_ret;
+}
+
+static int max17055_init_chip(struct max17042_chip *chip)
+{
+	struct regmap *map = chip->regmap;
+	unsigned int hib_cfg;
+	unsigned int model_cfg;
+	unsigned int fstat;
+	int restore_ret;
+	int ret;
+
+	if (chip->hib_restore_pending) {
+		ret = max17055_restore_hibernate(chip);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_read_poll_timeout(map, MAX17042_FSTAT, fstat,
+				       !(fstat & MAX17055_FSTAT_DNR_BIT),
+				       MAX17055_DNR_POLL_US,
+				       MAX17055_DNR_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(map, MAX17055_HibCfg, &hib_cfg);
+	if (ret)
+		return ret;
+
+	chip->hib_cfg = hib_cfg;
+	chip->hib_restore_pending = true;
+
+	ret = regmap_write(map, MAX17055_SoftWakeup, 0x0090);
+	if (ret)
+		goto restore_hibernate;
+
+	ret = max17055_write_verify_reg(map, MAX17055_HibCfg, 0);
+	if (ret)
+		goto restore_hibernate;
+
+	ret = regmap_write(map, MAX17055_SoftWakeup, 0);
+	if (ret)
+		goto restore_hibernate;
+
 	max17042_override_por_values(chip);
 
+	ret = max17055_override_battery_values(chip);
+	if (ret)
+		goto restore_hibernate;
+
+	ret = regmap_write_bits(map, MAX17055_ModelCfg,
+				MAX17055_MODELCFG_REFRESH_BIT,
+				MAX17055_MODELCFG_REFRESH_BIT);
+	if (ret)
+		goto restore_hibernate;
+
+	ret = regmap_read_poll_timeout(map, MAX17055_ModelCfg, model_cfg,
+				       !(model_cfg &
+					 MAX17055_MODELCFG_REFRESH_BIT),
+				       MAX17055_REFRESH_POLL_US,
+				       MAX17055_REFRESH_TIMEOUT_US);
+
+restore_hibernate:
+	restore_ret = max17055_restore_hibernate(chip);
+	if (restore_ret)
+		return restore_ret;
+
+	return ret;
+}
+
+static int max17042_init_chip(struct max17042_chip *chip)
+{
+	struct regmap *map = chip->regmap;
+	int ret;
+
 	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055) {
-		regmap_write_bits(map, MAX17055_ModelCfg,
-				  MAX17055_MODELCFG_REFRESH_BIT,
-				  MAX17055_MODELCFG_REFRESH_BIT);
-	}
+		ret = max17055_init_chip(chip);
+		if (ret)
+			return ret;
+	} else {
+		max17042_override_por_values(chip);
 
-	/* After Power up, the MAX17042 requires 500mS in order
-	 * to perform signal debouncing and initial SOC reporting
-	 */
-	msleep(500);
+		/* Allow signal debouncing and initial SOC reporting. */
+		msleep(500);
 
-	if (chip->chip_type != MAXIM_DEVICE_TYPE_MAX17055) {
-		/* Initialize configuration */
 		max17042_write_config_regs(chip);
 
 		/* write cell characterization data */
@@ -902,8 +1074,7 @@ static int max17042_init_chip(struct max17042_chip *chip)
 	}
 
 	/* Init complete, Clear the POR bit */
-	regmap_update_bits(map, MAX17042_STATUS, STATUS_POR_BIT, 0x0);
-	return 0;
+	return regmap_clear_bits(map, MAX17042_STATUS, STATUS_POR_BIT);
 }
 
 static void max17042_set_soc_threshold(struct max17042_chip *chip, u16 off)
@@ -989,18 +1160,28 @@ static irqreturn_t max17042_thread_handler(int id, void *dev)
 
 static void max17042_init_worker(struct work_struct *work)
 {
-	struct max17042_chip *chip = container_of(work,
+	struct max17042_chip *chip = container_of(to_delayed_work(work),
 				struct max17042_chip, work);
-	int ret;
+	int ret = 0;
 
 	/* Initialize registers according to values from config_data */
-	if (chip->enable_por_init && chip->config_data) {
+	if (chip->enable_por_init && chip->config_data)
 		ret = max17042_init_chip(chip);
-		if (ret)
-			return;
+
+	if (ret) {
+		if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055) {
+			dev_warn_ratelimited(chip->dev,
+				"initialization failed: %d, retrying\n", ret);
+			queue_delayed_work(system_freezable_wq, &chip->work,
+				msecs_to_jiffies(MAX17055_INIT_RETRY_DELAY_MS));
+		} else {
+			dev_err(chip->dev, "initialization failed: %d\n", ret);
+		}
+		return;
 	}
 
-	chip->init_complete = 1;
+	WRITE_ONCE(chip->init_complete, true);
+	power_supply_changed(chip->battery);
 }
 
 #ifdef CONFIG_OF
@@ -1060,6 +1241,93 @@ static int max17042_init_defaults(struct max17042_chip *chip)
 	return 0;
 }
 
+static int max17042_apply_battery_properties(struct max17042_chip *chip,
+					     struct power_supply_battery_info *info)
+{
+	struct max17042_config_data *config;
+	struct device *dev = chip->dev;
+	bool have_design_cap;
+	bool have_ichgt_term;
+	u16 design_cap = 0;
+	u16 ichgt_term = 0;
+	u16 dqacc = 0;
+	u64 data64;
+
+	if (!info || chip->chip_type != MAXIM_DEVICE_TYPE_MAX17055)
+		return 0;
+
+	have_design_cap = chip->enable_current_sense &&
+		info->charge_full_design_uah >= 0;
+	have_ichgt_term = chip->enable_current_sense &&
+		info->charge_term_current_ua >= 0;
+	if (!have_design_cap && !have_ichgt_term)
+		return 0;
+
+	if (have_design_cap) {
+		if (!info->charge_full_design_uah)
+			return dev_err_probe(dev, -EINVAL,
+					     "battery design capacity must be positive\n");
+
+		data64 = (u64)info->charge_full_design_uah * chip->r_sns;
+		do_div(data64, MAX17042_CAPACITY_LSB);
+		if (!data64)
+			return dev_err_probe(dev, -ERANGE,
+					     "battery design capacity is too small for sense resistor\n");
+		if (data64 > U16_MAX)
+			return dev_err_probe(dev, -ERANGE,
+					     "battery design capacity exceeds register range\n");
+
+		design_cap = (u16)data64;
+		dqacc = design_cap / MAX17055_DQACC_DIV;
+		if (!dqacc)
+			return dev_err_probe(dev, -ERANGE,
+					     "battery design capacity is too small for EZ config\n");
+	}
+
+	if (have_ichgt_term) {
+		if (!info->charge_term_current_ua)
+			return dev_err_probe(dev, -EINVAL,
+					     "charge termination current must be positive\n");
+
+		data64 = (u64)info->charge_term_current_ua * chip->r_sns;
+		do_div(data64, MAX17042_CURRENT_LSB);
+		if (!data64)
+			return dev_err_probe(dev, -ERANGE,
+					     "charge termination current is too small for sense resistor\n");
+		if (data64 > S16_MAX)
+			return dev_err_probe(dev, -ERANGE,
+					     "charge termination current exceeds positive register range\n");
+
+		ichgt_term = (u16)data64;
+	}
+
+	config = chip->config_data;
+	if (!config) {
+		config = devm_kzalloc(dev, sizeof(*config), GFP_KERNEL);
+		if (!config)
+			return -ENOMEM;
+	}
+
+	if (have_design_cap) {
+		config->design_cap = design_cap;
+		config->dqacc = dqacc;
+	}
+	if (have_ichgt_term)
+		config->ichgt_term = ichgt_term;
+
+	chip->config_data = config;
+	chip->enable_por_init = true;
+
+	return 0;
+}
+
+static int max17042_init_battery(struct power_supply *psy)
+{
+	struct max17042_chip *chip = power_supply_get_drvdata(psy);
+
+	return max17042_apply_battery_properties(chip, psy->battery_info);
+}
+
 static const struct regmap_config max17042_regmap_config = {
 	.name = "max17042",
 	.reg_bits = 8,
@@ -1113,6 +1381,7 @@ static const struct power_supply_desc max17042_psy_desc = {
 	.set_property	= max17042_set_property,
 	.property_is_writeable	= max17042_property_is_writeable,
 	.external_power_changed	= power_supply_changed,
+	.init		= max17042_init_battery,
 	.properties	= max17042_battery_props,
 	.num_properties	= ARRAY_SIZE(max17042_battery_props),
 };
@@ -1123,6 +1392,7 @@ static const struct power_supply_desc max17042_no_current_sense_psy_desc = {
 	.get_property	= max17042_get_property,
 	.set_property	= max17042_set_property,
 	.property_is_writeable	= max17042_property_is_writeable,
+	.init		= max17042_init_battery,
 	.properties	= max17042_battery_props,
 	.num_properties	= ARRAY_SIZE(max17042_battery_props) - 2,
 };
@@ -1242,15 +1512,18 @@ static int max17042_probe(struct i2c_client *client, struct device *dev, int irq
 
 	chip->irq = irq;
 
-	regmap_read(chip->regmap, MAX17042_STATUS, &val);
+	ret = regmap_read(chip->regmap, MAX17042_STATUS, &val);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to read status\n");
+
 	if (val & STATUS_POR_BIT) {
-		ret = devm_work_autocancel(dev, &chip->work,
-					   max17042_init_worker);
+		ret = devm_delayed_work_autocancel(dev, &chip->work,
+						   max17042_init_worker);
 		if (ret)
 			return ret;
-		schedule_work(&chip->work);
+		queue_delayed_work(system_freezable_wq, &chip->work, 0);
 	} else {
-		chip->init_complete = 1;
+		WRITE_ONCE(chip->init_complete, true);
 	}
 
 	return 0;
diff --git a/include/linux/power/max17042_battery.h b/include/linux/power/max17042_battery.h
index 13aeab1597c6..810e068eafd2 100644
--- a/include/linux/power/max17042_battery.h
+++ b/include/linux/power/max17042_battery.h
@@ -25,6 +25,7 @@
 #define MAX17042_CHARACTERIZATION_DATA_SIZE 48
 
 #define MAX17055_MODELCFG_REFRESH_BIT	BIT(15)
+#define MAX17055_MODELCFG_VCHG_BIT	BIT(10)
 
 enum max17042_register {
 	MAX17042_STATUS		= 0x00,
@@ -124,6 +125,7 @@ enum max17055_register {
 
 	MAX17055_ConvgCfg	= 0x49,
 	MAX17055_VFRemCap	= 0x4A,
+	MAX17055_SoftWakeup	= 0x60,
 
 	MAX17055_STATUS2	= 0xB0,
 	MAX17055_POWER		= 0xB1,
-- 
2.55.0

