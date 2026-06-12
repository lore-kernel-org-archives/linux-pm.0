Received: from chaosmail.tech (chaosmail.tech [77.81.229.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36D437D132;
	Fri, 12 Jun 2026 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.81.229.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289377; cv=none; b=aBmzULDWzPLEdvTk+TUw2Sebje82zDrA8bOqL3GqyJN0TyVqW1+0Cp4a6F/YmB1DwbtSekC2e3VXe7Y/ftSnUXsXa/GtKMvyDOht2VAH8wUcCm8k6vRU+GI06306oniQdqURaaaahdqLf/a19c/FNlqNwz+XeHl3gBmz0He7U6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289377; c=relaxed/simple;
	bh=4A/C+EOHO465w2u8xamdqNmkNqrHgUkGdvhtrLwE2lg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BWO5VVjLg2lQdSxuwRcwvuKA4NlglaYgTQTAxt8cKJVjjhJBYfxYud6jiTb0VxatlLipSJyJrPjFPlccQokfUFbcPoAHWeao6xjUDfjgsxxGnar4KxMcqu9ub1woFoyBftc73moJzCZ7L6juxeZ28Sn6MrpDVbX61tmoVNL4ESE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chaosmail.tech; spf=pass smtp.mailfrom=chaosmail.tech; dkim=pass (1024-bit key) header.d=chaosmail.tech header.i=@chaosmail.tech header.b=cLzecYpO; arc=none smtp.client-ip=77.81.229.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chaosmail.tech header.i=@chaosmail.tech header.b="cLzecYpO"
Received: by chaosmail.tech (Postfix) id D91181C962C;
	Fri, 12 Jun 2026 18:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chaosmail.tech;
	s=mail; t=1781289367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UsS4dqSrxqQyi+VfVrN7/Fkk7cMDG+DRbrc2q63ns0c=;
	b=cLzecYpO3379MUQW5o4pE5ay4aiiwjREr51eLEUYK5B9Fjqj/B8pT253oF/WYXImOw608/
	c/2u9eUo3N4l4n7ubKhjj2JaAuoVXFEOdtfo6lskWibWlFFuTB1Lu3K4LbgrTa1aWEbD/G
	1RjTTtWduTKCFzYnhIBgh7oX8e0uaNk=
From: Sasha Finkelstein <k@chaosmail.tech>
Date: Fri, 12 Jun 2026 20:36:03 +0200
Subject: [PATCH v2] power: supply: macsmc: Support macOS 27 SMC firmware
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-gate-power-v2-1-de76cb9bb7ef@chaosmail.tech>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22OQQ7CIBREr9L8tRhgAY0r72G6QPgt32hpAFHT9
 O5C3bp8ycybWSFhJExw6laIWChRmCvIQwfWm3lCRq4ySC4VV0KwyWRkS3hhZHZ0WipnudMj1MI
 ScaT3LrsMP07P6w1tboaW8JRyiJ99rYiW+ysuggnWGyW1FLxXVp/rl5Aehu7HjNbDsG3bF3Ss9
 4O7AAAA
X-Change-ID: 20260611-gate-power-cfd726dc0d7f
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Sebastian Reichel <sre@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sasha Finkelstein <k@chaosmail.tech>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781289366; l=4184;
 i=k@chaosmail.tech; s=20241124; h=from:subject:message-id;
 bh=4A/C+EOHO465w2u8xamdqNmkNqrHgUkGdvhtrLwE2lg=;
 b=zoMPXpuIXjYSJqYFvYM9W4fKfd3tt2rqG5nEEW941D4Q6fM6tY3egLexCairjGf7a9qLa561Q
 Av/sJno8GlRDap+GJsoD0s/1O+VMCwdXvjt3giaYCF88YDj7S4MQbQl
X-Developer-Key: i=k@chaosmail.tech; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=

The SMC firmware included in macOS 27 changed the size of BCF0 key from
4 to 1 bytes. This key is used for indicating that battery state is
critically low.

Reviewed-by: Sven Peter <sven@kernel.org>
Signed-off-by: Sasha Finkelstein <k@chaosmail.tech>
---
Changes in v2:
- Addressing review feedback
- Link to v1: https://patch.msgid.link/20260611-gate-power-v1-1-8a62721086c7@chaosmail.tech
---
 drivers/power/supply/macsmc-power.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/macsmc-power.c b/drivers/power/supply/macsmc-power.c
index 33ca07460f3a..747315e372bc 100644
--- a/drivers/power/supply/macsmc-power.c
+++ b/drivers/power/supply/macsmc-power.c
@@ -86,6 +86,7 @@ struct macsmc_power {
 	bool has_ch0i; /* Force discharge (Older firmware) */
 	bool has_ch0c; /* Inhibit charge (Older firmware) */
 	bool has_chte; /* Inhibit charge (Modern firmware) */
+	bool bcf0_1byte; /* Battery critical key is 1 byte (Modern firmware) */
 
 	u8 num_cells;
 	int nominal_voltage_mv;
@@ -273,6 +274,19 @@ static int macsmc_battery_get_date(const char *s, int *out)
 	return 0;
 }
 
+static int macsmc_battery_read_bcf0(struct macsmc_power *power, u32 *val)
+{
+	u8 tval = 0;
+	int ret;
+
+	if (!power->bcf0_1byte)
+		return apple_smc_read_u32(power->smc, SMC_KEY(BCF0), val);
+
+	ret = apple_smc_read_u8(power->smc, SMC_KEY(BCF0), &tval);
+	*val = tval;
+	return ret;
+}
+
 static int macsmc_battery_get_capacity_level(struct macsmc_power *power)
 {
 	bool flag;
@@ -280,7 +294,7 @@ static int macsmc_battery_get_capacity_level(struct macsmc_power *power)
 	int ret;
 
 	/* Check for emergency shutdown condition */
-	if (apple_smc_read_u32(power->smc, SMC_KEY(BCF0), &val) >= 0 && val)
+	if (macsmc_battery_read_bcf0(power, &val) >= 0 && val)
 		return POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
 
 	/* Check AC status for whether we could boot in this state */
@@ -577,7 +591,7 @@ static void macsmc_power_critical_work(struct work_struct *wrk)
 	 * Check if SMC flagged the battery as empty.
 	 * We trigger a graceful shutdown to let the OS save data.
 	 */
-	if (apple_smc_read_u32(power->smc, SMC_KEY(BCF0), &bcf0) == 0 && bcf0 != 0) {
+	if (macsmc_battery_read_bcf0(power, &bcf0) == 0 && bcf0 != 0) {
 		power->orderly_shutdown_triggered = true;
 		dev_crit(power->dev, "Battery critical (empty flag set). Triggering orderly shutdown.\n");
 		orderly_poweroff(true);
@@ -616,6 +630,7 @@ static int macsmc_power_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct apple_smc *smc = dev_get_drvdata(pdev->dev.parent);
 	struct power_supply_config psy_cfg = {};
+	struct apple_smc_key_info info;
 	struct macsmc_power *power;
 	bool has_battery = false;
 	bool has_ac_adapter = false;
@@ -714,6 +729,20 @@ static int macsmc_power_probe(struct platform_device *pdev)
 		if (apple_smc_key_exists(smc, SMC_KEY(CH0I)))
 			power->has_ch0i = true;
 
+		ret = apple_smc_get_key_info(power->smc, SMC_KEY(BCF0), &info);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to determine BCF0 key size\n");
+			return ret;
+		}
+		if (info.size == 1)
+			power->bcf0_1byte = true;
+		else if (info.size == 4)
+			power->bcf0_1byte = false;
+		else {
+			dev_err(&pdev->dev, "Unexpected BCF0 key size %d\n", info.size);
+			return -EIO;
+		}
+
 		/* Reset "Optimised Battery Charging" flags to default state */
 		if (power->has_chte)
 			apple_smc_write_u32(smc, SMC_KEY(CHTE), 0);
@@ -766,7 +795,7 @@ static int macsmc_power_probe(struct platform_device *pdev)
 		power->nominal_voltage_mv = MACSMC_NOMINAL_CELL_VOLTAGE_MV * power->num_cells;
 
 		/* Enable critical shutdown notifications by reading status once */
-		apple_smc_read_u32(power->smc, SMC_KEY(BCF0), &val32);
+		macsmc_battery_read_bcf0(power, &val32);
 
 		psy_cfg.drv_data = power;
 		power->batt = devm_power_supply_register(dev, &power->batt_desc, &psy_cfg);

---
base-commit: 9716c086c8e8b141d35aa61f2e96a2e83de212a7
change-id: 20260611-gate-power-cfd726dc0d7f

Best regards,
--  
Sasha Finkelstein <k@chaosmail.tech>

