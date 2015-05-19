From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 1/2] power_supply: Use wrappers to avoid races when registering
 power supply
Date: Tue, 19 May 2015 16:16:29 +0900
Message-ID: <1432019790-5664-2-git-send-email-k.kozlowski@samsung.com>
References: <1432019790-5664-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1432019790-5664-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Use wrappers over get_property() and set_property() internally in power
supply and for sysfs interface. The wrappers provide safe access if
power supply is not yet registered or t is being destroyed.

In case of syfs the theoretical race could happen between ending of
driver's probe and parallel sysfs access:
some_driver_probe()                    userspace
====================================   ===========================
  drv->psy = power_supply_register()
    device_add()
      sysfs entries are created
    atomic_inc(&psy->use_cnt);
                                       store on sysfs attributes
                                         drv->set_property()
                                           dereference of drv->psy
  drv->psy = returned psy;

For leds the race could happen between power supply being destroyed and
ongoing power_supply_changed_work().

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/power/power_supply_leds.c  | 4 ++--
 drivers/power/power_supply_sysfs.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/power_supply_leds.c b/drivers/power/power_supply_leds.c
index 2d41a43fc81a..2277ad9c2f68 100644
--- a/drivers/power/power_supply_leds.c
+++ b/drivers/power/power_supply_leds.c
@@ -25,7 +25,7 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
 	unsigned long delay_on = 0;
 	unsigned long delay_off = 0;
 
-	if (psy->desc->get_property(psy, POWER_SUPPLY_PROP_STATUS, &status))
+	if (power_supply_get_property(psy, POWER_SUPPLY_PROP_STATUS, &status))
 		return;
 
 	dev_dbg(&psy->dev, "%s %d\n", __func__, status.intval);
@@ -115,7 +115,7 @@ static void power_supply_update_gen_leds(struct power_supply *psy)
 {
 	union power_supply_propval online;
 
-	if (psy->desc->get_property(psy, POWER_SUPPLY_PROP_ONLINE, &online))
+	if (power_supply_get_property(psy, POWER_SUPPLY_PROP_ONLINE, &online))
 		return;
 
 	dev_dbg(&psy->dev, "%s %d\n", __func__, online.intval);
diff --git a/drivers/power/power_supply_sysfs.c b/drivers/power/power_supply_sysfs.c
index 9134e3d2d95e..af026806cba5 100644
--- a/drivers/power/power_supply_sysfs.c
+++ b/drivers/power/power_supply_sysfs.c
@@ -125,7 +125,7 @@ static ssize_t power_supply_store_property(struct device *dev,
 
 	value.intval = long_val;
 
-	ret = psy->desc->set_property(psy, off, &value);
+	ret = power_supply_set_property(psy, off, &value);
 	if (ret < 0)
 		return ret;
 
-- 
1.9.1
