From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] power_supply: sysfs: Bring back write to writeable properties
Date: Mon, 08 Jun 2015 10:09:48 +0900
Message-ID: <1433725788-13693-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:27266 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbbFHBKA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2015 21:10:00 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

The fix for NULL pointer exception related to calling uevent for not
finished probe caused to set all writeable properties as non-writeable.
This was caused by checking if property is writeable before the initial
increase of power supply usage counter and in the same time using
wrapper over property_is_writeable(). The wrapper returns ENODEV if the
usage counter is still 0.

The call trace looked like:
  device probe:
    power_supply_register()
      use_cnt = 0;
      device_add()
        create sysfs entries
          power_supply_attr_is_visible()
            power_supply_property_is_writeable()
              if (use_cnt == 0) return -ENODEV;
      use_cnt++;

Replace the usage of wrapper with direct call to property_is_writeable()
from driver. This should be safe call during device probe because
implementations of this callback just return 0/1 for different
properties and they do not access any of the driver's internal data.

Fixes: 8e59c7f23410 ("power_supply: Fix NULL pointer dereference during bq27x00_battery probe")
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/power/power_supply_sysfs.c | 2 +-
 include/linux/power_supply.h       | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/power/power_supply_sysfs.c b/drivers/power/power_supply_sysfs.c
index af026806cba5..ed2d7fd0c734 100644
--- a/drivers/power/power_supply_sysfs.c
+++ b/drivers/power/power_supply_sysfs.c
@@ -223,7 +223,7 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
 
 		if (property == attrno) {
 			if (psy->desc->property_is_writeable &&
-			    power_supply_property_is_writeable(psy, property) > 0)
+			    psy->desc->property_is_writeable(psy, property) > 0)
 				mode |= S_IWUSR;
 
 			return mode;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index a80f1fd01ddb..0395bcb18ddb 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -206,6 +206,11 @@ struct power_supply_desc {
 	int (*set_property)(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    const union power_supply_propval *val);
+	/*
+	 * property_is_writeable() will be called during registration
+	 * of power supply. If this happens during device probe then it must
+	 * not access internal data of device (because probe did not end).
+	 */
 	int (*property_is_writeable)(struct power_supply *psy,
 				     enum power_supply_property psp);
 	void (*external_power_changed)(struct power_supply *psy);
-- 
1.9.1

