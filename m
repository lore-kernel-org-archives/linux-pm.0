From: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
Subject: [PATCH] power_supply: rt9455_charger: Properly notify userspace about charging events
Date: Wed, 17 Jun 2015 19:28:59 +0300
Message-ID: <1434558539-30591-1-git-send-email-anda-maria.nicolae@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:34713 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755239AbbFQQZa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Jun 2015 12:25:30 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

Do not call power_supply_changed() when CHRVPI interrupt has occurred.
CHRVPI interrupt occurs when the charger is connected to or disconnected
from the power source. Call power_supply_changed() after PWR_RDY bit is
read, to distinguish between connection to or disconnection from the power
source.
Also, call power_supply_changed() after the battery is reconnected to the
charger, to notify userspace that the battery is no longer absent.

Signed-off-by: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
---
 drivers/power/rt9455_charger.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/power/rt9455_charger.c b/drivers/power/rt9455_charger.c
index 08baac6..a49a9d4 100644
--- a/drivers/power/rt9455_charger.c
+++ b/drivers/power/rt9455_charger.c
@@ -973,7 +973,6 @@ static int rt9455_irq_handler_check_irq2_register(struct rt9455_info *info,
 
 	if (irq2 & GET_MASK(F_CHRVPI)) {
 		dev_dbg(dev, "Charger fault occurred\n");
-		alert_userspace = true;
 		/*
 		 * CHRVPI bit is set in 2 cases:
 		 * 1. when the power source is connected to the charger.
@@ -981,6 +980,9 @@ static int rt9455_irq_handler_check_irq2_register(struct rt9455_info *info,
 		 * To identify the case, PWR_RDY bit is checked. Because
 		 * PWR_RDY bit is set / cleared after CHRVPI interrupt is
 		 * triggered, it is used delayed_work to later read PWR_RDY bit.
+		 * Also, do not set to true alert_userspace, because there is no
+		 * need to notify userspace when CHRVPI interrupt has occurred.
+		 * Userspace will be notified after PWR_RDY bit is read.
 		 */
 		queue_delayed_work(system_power_efficient_wq,
 				   &info->pwr_rdy_work,
@@ -1178,7 +1180,7 @@ static irqreturn_t rt9455_irq_handler_thread(int irq, void *data)
 		/*
 		 * Sometimes, an interrupt occurs while rt9455_probe() function
 		 * is executing and power_supply_register() is not yet called.
-		 * Do not call power_supply_charged() in this case.
+		 * Do not call power_supply_changed() in this case.
 		 */
 		if (info->charger)
 			power_supply_changed(info->charger);
@@ -1478,6 +1480,11 @@ static void rt9455_pwr_rdy_work_callback(struct work_struct *work)
 				   RT9455_MAX_CHARGING_TIME * HZ);
 		break;
 	}
+	/*
+	 * Notify userspace that the charger has been either connected to or
+	 * disconnected from the power source.
+	 */
+	power_supply_changed(info->charger);
 }
 
 static void rt9455_max_charging_time_work_callback(struct work_struct *work)
@@ -1533,6 +1540,11 @@ static void rt9455_batt_presence_work_callback(struct work_struct *work)
 			if (ret)
 				dev_err(dev, "Failed to unmask BATAB interrupt\n");
 		}
+		/*
+		 * Notify userspace that the battery is now connected to the
+		 * charger.
+		 */
+		power_supply_changed(info->charger);
 	}
 }
 
-- 
1.7.9.5

