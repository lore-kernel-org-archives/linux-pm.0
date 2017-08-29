From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] power: supply: max17042_battery: Fix compiler warning
Date: Tue, 29 Aug 2017 11:27:28 +0200
Message-ID: <20170829092728.15039-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45052 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751966AbdH2J1b (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Aug 2017 05:27:31 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org

Fix drivers/power/supply/max17042_battery.c:1059:6:
warning: 'acpi_id' may be used uninitialized in this function.

No idea why my gcc version did not catch this.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/max17042_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 18a44e4ed6ff..5b556a13f517 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -983,7 +983,7 @@ static int max17042_probe(struct i2c_client *client,
 	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
 	const struct power_supply_desc *max17042_desc = &max17042_psy_desc;
 	struct power_supply_config psy_cfg = {};
-	const struct acpi_device_id *acpi_id;
+	const struct acpi_device_id *acpi_id = NULL;
 	struct device *dev = &client->dev;
 	struct max17042_chip *chip;
 	int ret;
-- 
2.13.4
