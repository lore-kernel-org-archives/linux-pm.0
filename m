From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] power: supply: core: Add support for supplied-from device-property
Date: Mon,  8 May 2017 17:13:54 +0200
Message-ID: <20170508151354.21711-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755002AbdEHPN5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 May 2017 11:13:57 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org

On devicetree using platforms the devicetree can provide info on which
power-supplies supply another power-supply through phandles.

This commit adds support for providing this info on non devicetree
platforms through the platform code setting a supplied-from
device-property on the power-supplies parent device.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/power_supply_core.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 7ec7c7c202bd..0c09144193a6 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -274,8 +274,30 @@ static int power_supply_check_supplies(struct power_supply *psy)
 	return power_supply_populate_supplied_from(psy);
 }
 #else
-static inline int power_supply_check_supplies(struct power_supply *psy)
+static int power_supply_check_supplies(struct power_supply *psy)
 {
+	int nval, ret;
+
+	if (!psy->dev.parent)
+		return 0;
+
+	nval = device_property_read_string_array(psy->dev.parent,
+						 "supplied-from", NULL, 0);
+	if (nval <= 0)
+		return 0;
+
+	psy->supplied_from = devm_kmalloc_array(&psy->dev, nval,
+						sizeof(char *), GFP_KERNEL);
+	if (!psy->supplied_from)
+		return -ENOMEM;
+
+	ret = device_property_read_string_array(psy->dev.parent,
+		"supplied-from", (const char **)psy->supplied_from, nval);
+	if (ret < 0)
+		return ret;
+
+	psy->num_supplies = nval;
+
 	return 0;
 }
 #endif
-- 
2.12.2
