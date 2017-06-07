From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v14 04/11] power: supply: core: Add power_supply_prop_precharge
Date: Wed,  7 Jun 2017 11:37:52 -0700
Message-ID: <20170607183759.20261-5-liam@networkimprov.net>
References: <20170607183759.20261-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36831 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752277AbdFGSi3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2017 14:38:29 -0400
Received: by mail-pg0-f65.google.com with SMTP id v18so2154856pgb.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Jun 2017 11:38:29 -0700 (PDT)
In-Reply-To: <20170607183759.20261-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Pali Rohar <pali.rohar@gmail.com>, linux-pm@vger.kernel.org
Cc: Enric Balletbo <enric.balletbo@collabora.com>, Paul Kocialkowski <contact@paulk.fr>, Quentin Schulz <quentin.schulz@free-electrons.com>, Liam Breck <kernel@networkimprov.net>

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
index 01f00759..300d3789 100644
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
index bcde8d13..937b03c7 100644
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
index 85853834..31c4961b 100644
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
@@ -381,6 +382,8 @@ static inline bool power_supply_is_amp_property(enum power_supply_property psp)
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
 	case POWER_SUPPLY_PROP_CHARGE_AVG:
 	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
+	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
-- 
2.13.0
