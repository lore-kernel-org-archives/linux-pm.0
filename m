From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v13 04/11] power: supply: core: Add power_supply_prop_precharge
Date: Wed,  3 May 2017 23:18:04 -0700
Message-ID: <20170504061811.18107-5-liam@networkimprov.net>
References: <20170504061811.18107-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34292 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752110AbdEDGTL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 May 2017 02:19:11 -0400
Received: by mail-pf0-f196.google.com with SMTP id d1so801388pfe.1
        for <linux-pm@vger.kernel.org>; Wed, 03 May 2017 23:19:11 -0700 (PDT)
In-Reply-To: <20170504061811.18107-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org
Cc: Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

Battery chargers use POWER_SUPPLY_PROP_PRECHARGE_CURRENT
Clarify related item POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT

Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 Documentation/power/power_supply_class.txt | 19 ++++++++++++-------
 drivers/power/supply/power_supply_sysfs.c  |  1 +
 include/linux/power_supply.h               |  3 +++
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/Documentation/power/power_supply_class.txt b/Documentation/power/power_supply_class.txt
index 01f0075..300d378 100644
--- a/Documentation/power/power_supply_class.txt
+++ b/Documentation/power/power_supply_class.txt
@@ -115,28 +115,33 @@ of charge when battery became full/empty". It also could mean "value of
 charge when battery considered full/empty at given conditions (temperature,
 age)". I.e. these attributes represents real thresholds, not design values.
 
+ENERGY_FULL, ENERGY_EMPTY - same as above but for energy.
+
 CHARGE_COUNTER - the current charge counter (in µAh).  This could easily
 be negative; there is no empty or full value.  It is only useful for
 relative, time-based measurements.
 
+PRECHARGE_CURRENT - the maximum charge current during precharge phase
+of charge cycle (typically 20% of battery capacity).
+CHARGE_TERM_CURRENT - Charge termination current. The charge cycle
+terminates when battery voltage is above recharge threshold, and charge
+current is below this setting (typically 10% of battery capacity).
+
 CONSTANT_CHARGE_CURRENT - constant charge current programmed by charger.
 CONSTANT_CHARGE_CURRENT_MAX - maximum charge current supported by the
 power supply object.
-INPUT_CURRENT_LIMIT - input current limit programmed by charger. Indicates
-the current drawn from a charging source.
-CHARGE_TERM_CURRENT - Charge termination current used to detect the end of charge
-condition.
-
-CALIBRATE - battery or coulomb counter calibration status
 
 CONSTANT_CHARGE_VOLTAGE - constant charge voltage programmed by charger.
 CONSTANT_CHARGE_VOLTAGE_MAX - maximum charge voltage supported by the
 power supply object.
 
+INPUT_CURRENT_LIMIT - input current limit programmed by charger. Indicates
+the current drawn from a charging source.
+
 CHARGE_CONTROL_LIMIT - current charge control limit setting
 CHARGE_CONTROL_LIMIT_MAX - maximum charge control limit setting
 
-ENERGY_FULL, ENERGY_EMPTY - same as above but for energy.
+CALIBRATE - battery or coulomb counter calibration status
 
 CAPACITY - capacity in percents.
 CAPACITY_ALERT_MIN - minimum capacity alert value in percents.
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index bcde8d1..937b03c 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -196,6 +196,7 @@ static struct device_attribute power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(time_to_full_avg),
 	POWER_SUPPLY_ATTR(type),
 	POWER_SUPPLY_ATTR(scope),
+	POWER_SUPPLY_ATTR(precharge_current),
 	POWER_SUPPLY_ATTR(charge_term_current),
 	POWER_SUPPLY_ATTR(calibrate),
 	/* Properties of type `const char *' */
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 67f363b..1a83f47 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -146,6 +146,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
 	POWER_SUPPLY_PROP_TYPE, /* use power_supply.type instead */
 	POWER_SUPPLY_PROP_SCOPE,
+	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
 	POWER_SUPPLY_PROP_CALIBRATE,
 	/* Properties of type `const char *' */
@@ -379,6 +380,8 @@ static inline bool power_supply_is_amp_property(enum power_supply_property psp)
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
 	case POWER_SUPPLY_PROP_CHARGE_AVG:
 	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
+	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
-- 
2.9.3
