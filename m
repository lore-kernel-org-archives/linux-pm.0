Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC212175A79;
	Wed,  1 Apr 2026 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775078248; cv=none; b=m2/ATdSYeqm2TRtgBgjk9puXGWjJNHcmLRc+VpzEx0uA1AfMkaYDDQlg6kkRA6BjU4y2XrDbldi9t8bqz68blOmETtkN8pvo8bSrBaKbkUXbjTkjhQwS9Ab8Hh6fk8NoT8KO9yTdaWTg36mpRATXIVF2lxpzkG/nvJhMHkuIUGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775078248; c=relaxed/simple;
	bh=vxYCkKFS8KYxXuY/y+EJC0b+wUuiuzN8/O21XKUdN5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ojm1sCLYJAugem9MbpD3Qmp0v7q4ByGTPbzRo0VB1MsNZCWixhTPUhyudB4q14jLh1zmKJIvswYpc7wyom3w3wd1jndNri4vMipWjlTDUp+JrZ5gqG5TyS7Cr8/XryO8WrNJg6hhi82kprg4Deq6UWoO1WCH0MpHFb998dtL2j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=+SOGif/T; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="+SOGif/T"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=4MH7Zvnrlu1IJA+YDyoC2Jd/fk+SzpyANHY6ofPAKTY=; b=+SOGif/Tn3FJgNVW4B/a3Utc0r
	WOMBmTQK3jeViHGOmgijibaZk8KmK+roqoD/P6pXzn6UQ0n4lU6vMIipvJBt+617i5xvRDZ14ik/p
	lj5creehWX7cRTGW8dDNyDToBD1gUpmAwZOpdOzXs3s94s+a4JEjk3hk5rfXT60z3NzW7UWw2KWYN
	+GVkFSEPVzLu7tGHfdF9+skByPdXdyjT9HeCCmsyNaF2YrTiwAIpsLLS0DS78QYndkvcnKYbtI+Wk
	yQYt8aAyf023YCGosWPlHaQwZivlwI3X72ZtvTc5ajWL8YrXc9hwNgp74SUZdXD0DrSrPMfoP/8Ex
	EoS8d1IQ==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Wed, 01 Apr 2026 23:17:05 +0200
Subject: [PATCH] power: supply: bd71828: add input current limit property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-bd-inp-limit-v1-1-689eb22531e2@kemnade.info>
X-B4-Tracking: v=1; b=H4sIAFCLzWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwND3aQU3cy8At2czNzMEl3jxOQkU8NUQ9NUy2QloJaCotS0zAqwcdG
 xtbUAUnGTjl4AAAA=
X-Change-ID: 20260401-bd-inp-limit-3acb51e15e9c
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4542; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=vxYCkKFS8KYxXuY/y+EJC0b+wUuiuzN8/O21XKUdN5Q=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDJlnu2P77+ikf39hkpFtYzQ/Lm7aourFhuKfbbvF1quKL
 YpcHvmlo5SFQYyLQVZMkeWXtYLbJ5VnucFTI+xh5rAygQxh4OIUgIl8zGRkuHTyS8l37aqDnsf/
 1J/m1NmmnLhUsIrtktdsmw3dAkvu7GJk+CeofGLDh0MsP7YKf1NjuFV6S+Lwq6TYTyuZuHmXLKz
 7wg0A
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Add input current property to be able to work around issues created by
automatic input limiting and have some control.
Disabling the automatic management is another step.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/power/supply/bd71828-power.c | 62 ++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/power/supply/bd71828-power.c b/drivers/power/supply/bd71828-power.c
index 0e00acb589937..5e78faa0a4aaf 100644
--- a/drivers/power/supply/bd71828-power.c
+++ b/drivers/power/supply/bd71828-power.c
@@ -24,6 +24,7 @@
 #define BD7182x_MASK_CONF_PON			BIT(0)
 #define BD71815_MASK_CONF_XSTB			BIT(1)
 #define BD7182x_MASK_BAT_STAT			0x3f
+#define BD7182x_MASK_ILIM			0x3f
 #define BD7182x_MASK_DCIN_STAT			0x07
 
 #define BD7182x_MASK_WDT_AUTO			0x40
@@ -48,9 +49,11 @@ struct pwr_regs {
 	unsigned int vbat_avg;
 	unsigned int ibat;
 	unsigned int ibat_avg;
+	unsigned int ilim_stat;
 	unsigned int btemp_vth;
 	unsigned int chg_state;
 	unsigned int bat_temp;
+	unsigned int dcin_set;
 	unsigned int dcin_stat;
 	unsigned int dcin_online_mask;
 	unsigned int dcin_collapse_limit;
@@ -66,9 +69,11 @@ static const struct pwr_regs pwr_regs_bd71828 = {
 	.vbat_avg = BD71828_REG_VBAT_U,
 	.ibat = BD71828_REG_IBAT_U,
 	.ibat_avg = BD71828_REG_IBAT_AVG_U,
+	.ilim_stat = BD71828_REG_ILIM_STAT,
 	.btemp_vth = BD71828_REG_VM_BTMP_U,
 	.chg_state = BD71828_REG_CHG_STATE,
 	.bat_temp = BD71828_REG_BAT_TEMP,
+	.dcin_set = BD71828_REG_DCIN_SET,
 	.dcin_stat = BD71828_REG_DCIN_STAT,
 	.dcin_online_mask = BD7182x_MASK_DCIN_DET,
 	.dcin_collapse_limit = BD71828_REG_DCIN_CLPS,
@@ -441,6 +446,7 @@ static int bd71828_charger_get_property(struct power_supply *psy,
 	struct bd71828_power *pwr = dev_get_drvdata(psy->dev.parent);
 	u32 vot;
 	u16 tmp;
+	int t;
 	int online;
 	int ret;
 
@@ -459,6 +465,20 @@ static int bd71828_charger_get_property(struct power_supply *psy,
 		vot = tmp;
 		/* 5 milli volt steps */
 		val->intval = 5000 * vot;
+		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		if (!pwr->regs->ilim_stat)
+			return -ENODATA;
+
+		ret = regmap_read(pwr->regmap, pwr->regs->ilim_stat, &t);
+		if (ret)
+			return ret;
+
+		t++;
+		val->intval = (t & BD7182x_MASK_ILIM) * 50000;
+		if (val->intval > 2000000)
+			val->intval = 2000000;
+
 		break;
 	default:
 		return -EINVAL;
@@ -467,6 +487,45 @@ static int bd71828_charger_get_property(struct power_supply *psy,
 	return 0;
 }
 
+static int bd71828_charger_set_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					const union power_supply_propval *val)
+{
+	struct bd71828_power *pwr = dev_get_drvdata(psy->dev.parent);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		if (val->intval > 2000000)
+			return -EINVAL;
+
+		if (val->intval < 50000)
+			return -EINVAL;
+
+		if (!pwr->regs->dcin_set)
+			return -EINVAL;
+
+		return regmap_update_bits(pwr->regmap, pwr->regs->dcin_set,
+					  BD7182x_MASK_ILIM,
+					  val->intval / 50000 - 1);
+		break;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bd71828_charger_property_is_writeable(struct power_supply *psy,
+						 enum power_supply_property psp)
+{
+	struct bd71828_power *pwr = dev_get_drvdata(psy->dev.parent);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return !!(pwr->regs->dcin_set);
+	default:
+		return false;
+	}
+}
+
 static int bd71828_battery_get_property(struct power_supply *psy,
 					enum power_supply_property psp,
 					union power_supply_propval *val)
@@ -571,6 +630,7 @@ static int bd71828_battery_property_is_writeable(struct power_supply *psy,
 
 /** @brief ac properties */
 static const enum power_supply_property bd71828_charger_props[] = {
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 };
@@ -600,6 +660,8 @@ static const struct power_supply_desc bd71828_ac_desc = {
 	.properties	= bd71828_charger_props,
 	.num_properties	= ARRAY_SIZE(bd71828_charger_props),
 	.get_property	= bd71828_charger_get_property,
+	.set_property	= bd71828_charger_set_property,
+	.property_is_writeable   = bd71828_charger_property_is_writeable,
 };
 
 static const struct power_supply_desc bd71828_bat_desc = {

---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20260401-bd-inp-limit-3acb51e15e9c

Best regards,
--  
Andreas Kemnade <andreas@kemnade.info>

