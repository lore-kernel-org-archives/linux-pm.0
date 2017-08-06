From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2] power: supply: Fix power_supply_am_i_supplied to return -ENODEV when apropriate
Date: Sun,  6 Aug 2017 18:23:52 +0200
Message-ID: <20170806162352.12906-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751300AbdHFQXz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 6 Aug 2017 12:23:55 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org

Commit 2848e039c562 ("power: supply: Make power_supply_am_i_supplied return
-ENODEV if there are no suppliers") was supposed to make
power_supply_am_i_supplied() return -ENODEV when there are no supplies
which supply the supply passed to it.

But instead it will only return -ENODEV when there are no supplies at
all as data->count++; is incremented on every call of the iterator, rather
then only when __power_supply_is_supplied_by returns true. This commit
fixes this.

Fixes: 2848e039c562 ("power: supply: Make power_supply_am_i_supplied ...")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Resend as a standalone patch rather then as part of an unrelated patch-set,
 no changes
---
 drivers/power/supply/power_supply_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 0aacc721ebda..3f92574222de 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -314,11 +314,12 @@ static int __power_supply_am_i_supplied(struct device *dev, void *_data)
 	struct power_supply *epsy = dev_get_drvdata(dev);
 	struct psy_am_i_supplied_data *data = _data;
 
-	data->count++;
-	if (__power_supply_is_supplied_by(epsy, data->psy))
+	if (__power_supply_is_supplied_by(epsy, data->psy)) {
+		data->count++;
 		if (!epsy->desc->get_property(epsy, POWER_SUPPLY_PROP_ONLINE,
 					&ret))
 			return ret.intval;
+	}
 
 	return 0;
 }
-- 
2.13.3
