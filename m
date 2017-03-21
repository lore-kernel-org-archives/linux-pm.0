From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v1 3/7] power: power_supply_core: Add *_battery_info fields for pre- and end-charge current
Date: Tue, 21 Mar 2017 15:09:17 -0700
Message-ID: <20170321220921.5834-4-liam@networkimprov.net>
References: <20170321220921.5834-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35695 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932822AbdCUWQj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Mar 2017 18:16:39 -0400
Received: by mail-pf0-f193.google.com with SMTP id n11so12561822pfg.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Mar 2017 15:16:38 -0700 (PDT)
In-Reply-To: <20170321220921.5834-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

Battery chargers use precharge_current_ua and endcharge_current_ua
at the beginning and end of a charging cycle. These values are set
according to battery capacity.

Depends-on: https://patchwork.kernel.org/patch/9633613/
Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/power_supply_core.c | 6 ++++++
 include/linux/power_supply.h             | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 61e20b1..17088c5 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -498,6 +498,8 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	info->energy_full_design_uwh = -EINVAL;
 	info->charge_full_design_uah = -EINVAL;
 	info->voltage_min_design_uv  = -EINVAL;
+	info->precharge_current_ua   = -EINVAL;
+	info->endcharge_current_ua   = -EINVAL;
 
 	if (!psy->of_node) {
 		dev_warn(&psy->dev, "%s currently only supports devicetree\n",
@@ -527,6 +529,10 @@ int power_supply_get_battery_info(struct power_supply *psy,
 			     &info->charge_full_design_uah);
 	of_property_read_u32(battery_np, "voltage-min-design-microvolt",
 			     &info->voltage_min_design_uv);
+	of_property_read_u32(battery_np, "precharge-current-microamp",
+			     &info->precharge_current_ua);
+	of_property_read_u32(battery_np, "endcharge-current-microamp",
+			     &info->endcharge_current_ua);
 
 	return 0;
 }
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index e84f1d3..864214c 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -152,6 +152,9 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+/* where to place these? inserting above causes sysfs errors */
+	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
+	POWER_SUPPLY_PROP_ENDCHARGE_CURRENT,
 };
 
 enum power_supply_type {
@@ -301,6 +304,8 @@ struct power_supply_battery_info {
 	int energy_full_design_uwh;	/* microWatt-hours */
 	int charge_full_design_uah;	/* microAmp-hours */
 	int voltage_min_design_uv;	/* microVolts */
+	int precharge_current_ua;	/* microAmps */
+	int endcharge_current_ua;       /* microAmps */
 };
 
 extern struct atomic_notifier_head power_supply_notifier;
-- 
2.9.3
