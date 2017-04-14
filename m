From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 07/13] power: max17042_battery: Add external_power_changed callback
Date: Fri, 14 Apr 2017 14:59:13 +0200
Message-ID: <20170414125919.25771-7-hdegoede@redhat.com>
References: <20170414125919.25771-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752700AbdDNM7b (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Apr 2017 08:59:31 -0400
In-Reply-To: <20170414125919.25771-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org

If our supplier changes status, chances are we've changed status too,
let any listeners know about this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/max17042_battery.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 1ea8368..e4288b5 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -432,6 +432,11 @@ static int max17042_property_is_writeable(struct power_supply *psy,
 	return ret;
 }
 
+static void max17042_external_power_changed(struct power_supply *psy)
+{
+	power_supply_changed(psy);
+}
+
 static int max17042_write_verify_reg(struct regmap *map, u8 reg, u32 value)
 {
 	int retries = 8;
@@ -920,6 +925,7 @@ static const struct power_supply_desc max17042_psy_desc = {
 	.get_property	= max17042_get_property,
 	.set_property	= max17042_set_property,
 	.property_is_writeable	= max17042_property_is_writeable,
+	.external_power_changed	= max17042_external_power_changed,
 	.properties	= max17042_battery_props,
 	.num_properties	= ARRAY_SIZE(max17042_battery_props),
 };
-- 
2.9.3
