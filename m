Received: from chaosmail.tech (chaosmail.tech [77.81.229.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5B340BCD3;
	Thu, 11 Jun 2026 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.81.229.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196970; cv=none; b=PGtzZ7nmCkplqyVNfnLhgOo6PGgpskjiLIBKn3PARSaYWcce3j15h+WUAQIRZkbHWvwTcRelsMsCeIYTPIe3kGidJl+gxn6AcNHS/9eJTThJ1VWnpggCZmQIvTeGbTgNeoc3BtZCcwHmfwBgR3H3VSb0bJNLCZpdPbmQlA6d60E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196970; c=relaxed/simple;
	bh=j1r/8sY3Ac5Mv74SC6M7yo0s1bKstpo1/iNrmZWqntM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pHTT4vzSe2C4xpBu5WLttAjay4GHk9Tj16Blw0+So441Q/ZrTLZ3erHO5pe7heJF4UGgPycMfKSVitQSe+iLcyX3UcEF+JGMNU5275bzqMd1zMWTAhgmyKCuHTQueoDXYjQpw7AKn+tNRPQpwQxBclXt100gwEPdt98CWUxUkVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chaosmail.tech; spf=pass smtp.mailfrom=chaosmail.tech; dkim=pass (1024-bit key) header.d=chaosmail.tech header.i=@chaosmail.tech header.b=YXS9i3kH; arc=none smtp.client-ip=77.81.229.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chaosmail.tech header.i=@chaosmail.tech header.b="YXS9i3kH"
Received: by chaosmail.tech (Postfix) id 093201CA007;
	Thu, 11 Jun 2026 16:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chaosmail.tech;
	s=mail; t=1781196560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JCKxt4CJrWbA/Kxvm+FttEzjVPa3DbGPVSW9P7DhCSY=;
	b=YXS9i3kHJgfXC4w5bHLhMAYf7n05XOqtLsNv3fx6tmjrVO3e/pbtU5uiCmYe82zwVUszNQ
	0ebWWhGUsz2wNLVjzmcTNun6l7kqNrpGAeFDvNAT0L5TBRLiSsHMWBUqHPj/f1rzOwmj5w
	lhyEIGkCr9c9t19xK4jHUZ/LhKw8xgI=
From: Sasha Finkelstein <k@chaosmail.tech>
Date: Thu, 11 Jun 2026 18:49:14 +0200
Subject: [PATCH] power: supply: macsmc: Support macOS 27 SMC firmware
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-gate-power-v1-1-8a62721086c7@chaosmail.tech>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMOw6AIBAA0auYrSUBCky8irFAWHAtlIC/hHB3U
 ctXzGRIGAkT9E2GiCcl2tYK0TZgZr16ZGSrQXKpuBKCeb0jC9uFkRlnO6ms4bZzUIMQ0dH9zYb
 xdzqmBc3+HqCUB/lVyQFuAAAA
X-Change-ID: 20260611-gate-power-cfd726dc0d7f
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Sebastian Reichel <sre@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sasha Finkelstein <k@chaosmail.tech>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781196559; l=3957;
 i=k@chaosmail.tech; s=20241124; h=from:subject:message-id;
 bh=j1r/8sY3Ac5Mv74SC6M7yo0s1bKstpo1/iNrmZWqntM=;
 b=LU3j9N/7qxItSItu0oLNOWtCYY+mzSDXnVYp2unJvt7UCSqNs94NLt5Jx5zgQhrEU9uMZaTWU
 dAbqXMM5LJvC/UAW+6nFCmVLOniYS+tclSdef9hnvuUAjmJcZg+S6x/
X-Developer-Key: i=k@chaosmail.tech; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=

The SMC firmware included in macOS 27 changed the size of BCF0 key from
4 to 1 bytes. This key is used for indicating that battery state is
critically low.

Signed-off-by: Sasha Finkelstein <k@chaosmail.tech>
---
 drivers/power/supply/macsmc-power.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/macsmc-power.c b/drivers/power/supply/macsmc-power.c
index 33ca07460f3a..650dc8740f71 100644
--- a/drivers/power/supply/macsmc-power.c
+++ b/drivers/power/supply/macsmc-power.c
@@ -86,6 +86,7 @@ struct macsmc_power {
 	bool has_ch0i; /* Force discharge (Older firmware) */
 	bool has_ch0c; /* Inhibit charge (Older firmware) */
 	bool has_chte; /* Inhibit charge (Modern firmware) */
+	bool bcf0_1byte; /* Battery critical */
 
 	u8 num_cells;
 	int nominal_voltage_mv;
@@ -273,6 +274,18 @@ static int macsmc_battery_get_date(const char *s, int *out)
 	return 0;
 }
 
+static int macsmc_battery_read_bcf0(struct macsmc_power *power, u32 *val)
+{
+	u8 tval;
+	int ret;
+
+	if (!power->bcf0_1byte)
+		return apple_smc_read_u32(power->smc, SMC_KEY(BCF0), val);
+	ret = apple_smc_read_u8(power->smc, SMC_KEY(BCF0), &tval);
+	*val = tval;
+	return ret;
+}
+
 static int macsmc_battery_get_capacity_level(struct macsmc_power *power)
 {
 	bool flag;
@@ -280,7 +293,7 @@ static int macsmc_battery_get_capacity_level(struct macsmc_power *power)
 	int ret;
 
 	/* Check for emergency shutdown condition */
-	if (apple_smc_read_u32(power->smc, SMC_KEY(BCF0), &val) >= 0 && val)
+	if (macsmc_battery_read_bcf0(power, &val) >= 0 && val)
 		return POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
 
 	/* Check AC status for whether we could boot in this state */
@@ -577,7 +590,7 @@ static void macsmc_power_critical_work(struct work_struct *wrk)
 	 * Check if SMC flagged the battery as empty.
 	 * We trigger a graceful shutdown to let the OS save data.
 	 */
-	if (apple_smc_read_u32(power->smc, SMC_KEY(BCF0), &bcf0) == 0 && bcf0 != 0) {
+	if (macsmc_battery_read_bcf0(power, &bcf0) == 0 && bcf0 != 0) {
 		power->orderly_shutdown_triggered = true;
 		dev_crit(power->dev, "Battery critical (empty flag set). Triggering orderly shutdown.\n");
 		orderly_poweroff(true);
@@ -616,6 +629,7 @@ static int macsmc_power_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct apple_smc *smc = dev_get_drvdata(pdev->dev.parent);
 	struct power_supply_config psy_cfg = {};
+	struct apple_smc_key_info info;
 	struct macsmc_power *power;
 	bool has_battery = false;
 	bool has_ac_adapter = false;
@@ -714,6 +728,20 @@ static int macsmc_power_probe(struct platform_device *pdev)
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
@@ -766,7 +794,7 @@ static int macsmc_power_probe(struct platform_device *pdev)
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

