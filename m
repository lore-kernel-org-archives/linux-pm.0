From: Anda-Maria Nicolae <anda-maria.nicolae-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] power_supply: rt9455_charger: Properly notify userspace about charging events
Date: Tue,  7 Jul 2015 15:25:53 +0300
Message-ID: <1436271953-24564-1-git-send-email-anda-maria.nicolae@intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: k.kozlowski.k-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Charging events this patch refers to are:
- charger is connected to/disconnected from the power source
- battery is reconnected to the charger, after it was absent.

When the charger is connected to/disconnected from the power source, CHRVPI
interrupt occurs and PWR_RDY bit is either set or cleared. PWR_RDY bit is
updated after 1-2 seconds CHRVPI interrupt has occurred.
power_supply_changed() should be called after PWR_RDY bit is updated.
/sys/class/power_supply/rt9455-charger/online file displays the value of
PWR_RDY bit.
This way, if the userspace is notified that a charging event has occurred
and the userspace reads /sys/class/power_supply/rt9455-charger/online file,
this file is properly updated when the userspace reads it.
This is the reason why power_supply_changed() is called in
rt9455_pwr_rdy_work_callback(), instead of being called in interrupt
handler.

Since no interrupt is triggered when the battery is reconnected to the
charger, the userspace is never notified that the battery is reconnected.
This is why power_supply_changed() is called in
rt9455_max_charging_time_work_callback(), so that the userspace is notified
that the battery is reconnected.

Signed-off-by: Anda-Maria Nicolae <anda-maria.nicolae-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---

Updates from v1 version:
- I have followed Kzrysztof's suggestion and I have added explanations in
the commit message so that the change is more clear
- Code is the same as in v1

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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
