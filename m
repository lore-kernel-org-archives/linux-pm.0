From: Lukasz Luba <lukasz.luba@arm.com>
Subject: [RFC PATCH] fix: thermal: avoid possible deadlock calling thermal_zone_get_temp()
Date: Fri, 10 Feb 2017 16:15:47 +0000
Message-ID: <20170210161547.28625-1-lukasz.luba@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752168AbdBJQYe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Feb 2017 11:24:34 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org
Cc: lukasz.luba@arm.com

There is possible scenario when the system hits deadlock.
One of the examples is when IPA (power_allocator.c) calculates
power budget and calls every cooling device in the thermal zone
using function get_requested_power().
This function in devfreq_cooling calls driver's code via
get_static_power().
If the driver code tries to calculate properly static power
based on current temperature, it might call API functions:
tz = thermal_zone_get_zone_by_name(priv->tz_name)
and then:
thermal_zone_get_temp(tz, &temp)

Here is the call graph:

tz->gov->throttle() [=power_allocator_throttle]
  power_allocator_throttle
    allocate_power
==>   (lock tz->lock taken)
      (for each cooling device:)
         cdev->ops->get_requested_power
         [=devfreq_cooling_get_requested_power]
              get_static_power
                 (call driver specific function)
                 dfc->power_ops->get_static_power
                 [=mock_devfreq_get_static_power]
                      tz = thermal_zone_get_zone_by_name()
                      thermal_zone_get_temp(tz, &temp)
===>                    (try to lock again tz->lock)

This patch changes the mutex_lock into mutex_trylock
just to avoid the deadlock.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
Hi,

This is a RFC to start some discussion.
I am not sure if it should go with stable label
(it affects few versions back though).
It is based on v4.10-rc7.

Regards,
Lukasz Luba

 drivers/thermal/thermal_helpers.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 8cdf75a..7b01a85 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -75,6 +75,12 @@ EXPORT_SYMBOL(get_thermal_instance);
  * When a valid thermal zone reference is passed, it will fetch its
  * temperature and fill @temp.
  *
+ * IMPORTANT NOTICE:
+ * This function should not be used from driver's code which is called
+ * by IPA (power_allocator.c). The IPA already holds the tz->lock.
+ * Therefore, it is possible to get the temperature in driver code
+ * in a simple way: reading tz->temperature.
+ *
  * Return: On success returns 0, an error code otherwise
  */
 int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
@@ -87,7 +93,8 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
 		goto exit;
 
-	mutex_lock(&tz->lock);
+	if (!mutex_trylock(&tz->lock))
+		goto exit;
 
 	ret = tz->ops->get_temp(tz, temp);
 
-- 
2.9.2

