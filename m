From: Liam Breck <liam@networkimprov.net>
Subject: [RFC] power: power_supply: Add power_supply_prop_precharge/endcharge
Date: Tue, 28 Mar 2017 23:30:55 -0700
Message-ID: <20170329063055.4517-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35437 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753037AbdC2GbM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Mar 2017 02:31:12 -0400
Received: by mail-pf0-f193.google.com with SMTP id n11so726133pfg.2
        for <linux-pm@vger.kernel.org>; Tue, 28 Mar 2017 23:31:06 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Hans de Goede <hdegoede@redhat.com>, Liam Breck <kernel@networkimprov.net>

Battery chargers allow get/set of:
POWER_SUPPLY_PROP_PRECHARGE_CURRENT
POWER_SUPPLY_PROP_ENDCHARGE_CURRENT

Cc: Tony Lindgren <tony@atomide.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
---

Hi Sebastian,
This is a RFC draft of the power_supply property patch for my bq24190_charger
series. It also highlights charge_term_current with a cosmetic change. Is this
the same as the proposed endcharge_current?

 Documentation/power/power_supply_class.txt | 10 ++++++++--
 drivers/power/supply/power_supply_sysfs.c  |  2 ++
 include/linux/power_supply.h               |  4 ++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/power/power_supply_class.txt b/Documentation/power/power_supply_class.txt
index dc92c77..ccffdad 100644
--- a/Documentation/power/power_supply_class.txt
+++ b/Documentation/power/power_supply_class.txt
@@ -119,13 +119,19 @@ CHARGE_COUNTER - the current charge counter (in µAh).  This could easily
 be negative; there is no empty or full value.  It is only useful for
 relative, time-based measurements.
 
+PRECHARGE_CURRENT - the maximum charge current during precharge phase
+of charge cycle (typically 20% of battery capacity).
+ENDCHARGE_CURRENT - charge cycle terminates when battery voltage is
+above recharge threshold, and charge current is below this setting
+(typically 10% of battery capacity).
+
 CONSTANT_CHARGE_CURRENT - constant charge current programmed by charger.
 CONSTANT_CHARGE_CURRENT_MAX - maximum charge current supported by the
 power supply object.
 INPUT_CURRENT_LIMIT - input current limit programmed by charger. Indicates
 the current drawn from a charging source.
-CHARGE_TERM_CURRENT - Charge termination current used to detect the end of charge
-condition.
+CHARGE_TERM_CURRENT - Charge termination current used to detect the end of
+charge condition.
 
 CALIBRATE - battery or coulomb counter calibration status
 
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index bcde8d1..7b091c9 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -165,6 +165,8 @@ static struct device_attribute power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(charge_now),
 	POWER_SUPPLY_ATTR(charge_avg),
 	POWER_SUPPLY_ATTR(charge_counter),
+	POWER_SUPPLY_ATTR(precharge_current),
+	POWER_SUPPLY_ATTR(endcharge_current),
 	POWER_SUPPLY_ATTR(constant_charge_current),
 	POWER_SUPPLY_ATTR(constant_charge_current_max),
 	POWER_SUPPLY_ATTR(constant_charge_voltage),
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index f1e4b30..b909935 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -115,6 +115,8 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_CHARGE_AVG,
 	POWER_SUPPLY_PROP_CHARGE_COUNTER,
+	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
+	POWER_SUPPLY_PROP_ENDCHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
@@ -379,6 +381,8 @@ static inline bool power_supply_is_amp_property(enum power_supply_property psp)
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
 	case POWER_SUPPLY_PROP_CHARGE_AVG:
 	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
+	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+	case POWER_SUPPLY_PROP_ENDCHARGE_CURRENT:
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
-- 
2.9.3
