From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 01/14] power: Make power_supply_am_i_supplied return -ENODEV if there are no suppliers
Date: Fri, 14 Apr 2017 20:32:46 +0200
Message-ID: <20170414183259.24382-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752042AbdDNSdD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Apr 2017 14:33:03 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org

It is sensible to assume that the hardware actually always has a
way of charging the battery so when power_supply_am_i_supplied does not
find any suppliers, that does not mean that there are none, but simply
that no power_supply-drivers are registered / bound for any suppliers for
the supply calling power_supply_am_i_supplied.

At which point a fuel-gauge driver calling power_supply_am_i_supplied()
cannot determine whether the battery is being charged or not.

Allow a caller of power_supply_am_i_supplied to differentiate between
there not being any suppliers, vs no suppliers being online by returning
-ENODEV if there are no suppliers matching supplied_to / supplied_from,
which allows fuel-gauge drivers to return POWER_SUPPLY_STATUS_UNKNOWN
rather then POWER_SUPPLY_STATUS_DISCHARGING if there are no suppliers.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Improve commit message
---
 drivers/power/supply/power_supply_core.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 1e0960b..13a39da 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -280,13 +280,19 @@ static inline int power_supply_check_supplies(struct power_supply *psy)
 }
 #endif
 
-static int __power_supply_am_i_supplied(struct device *dev, void *data)
+struct am_i_supplied_data {
+	struct power_supply *psy;
+	unsigned int count;
+};
+
+static int __power_supply_am_i_supplied(struct device *dev, void *_data)
 {
 	union power_supply_propval ret = {0,};
-	struct power_supply *psy = data;
 	struct power_supply *epsy = dev_get_drvdata(dev);
+	struct am_i_supplied_data *data = _data;
 
-	if (__power_supply_is_supplied_by(epsy, psy))
+	data->count++;
+	if (__power_supply_is_supplied_by(epsy, data->psy))
 		if (!epsy->desc->get_property(epsy, POWER_SUPPLY_PROP_ONLINE,
 					&ret))
 			return ret.intval;
@@ -296,12 +302,16 @@ static int __power_supply_am_i_supplied(struct device *dev, void *data)
 
 int power_supply_am_i_supplied(struct power_supply *psy)
 {
+	struct am_i_supplied_data data = { psy, 0 };
 	int error;
 
-	error = class_for_each_device(power_supply_class, NULL, psy,
+	error = class_for_each_device(power_supply_class, NULL, &data,
 				      __power_supply_am_i_supplied);
 
-	dev_dbg(&psy->dev, "%s %d\n", __func__, error);
+	dev_dbg(&psy->dev, "%s count %u err %d\n", __func__, data.count, error);
+
+	if (data.count == 0)
+		return -ENODEV;
 
 	return error;
 }
-- 
2.9.3
