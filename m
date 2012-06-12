From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 3/4] thermal: cleanup: use dev_* helper functions
Date: Tue, 12 Jun 2012 16:25:18 +0300
Message-ID: <1339507519-14434-4-git-send-email-eduardo.valentin@ti.com>
References: <1339507519-14434-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1339507519-14434-1-git-send-email-eduardo.valentin@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rui.zhang@intel.com, durgadoss.r@intel.com
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Change the logging messages to used dev_* helper functions.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/thermal/thermal_sys.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 1ef9fc1..61d0003 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -1022,7 +1022,8 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 
 	if (tz->ops->get_temp(tz, &temp)) {
 		/* get_temp failed - retry it later */
-		pr_warn("failed to read out thermal zone %d\n", tz->id);
+		dev_warn(&tz->device, "Failed to read out thermal zone %d\n",
+			 tz->id);
 		goto leave;
 	}
 
@@ -1037,8 +1038,10 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 					ret = tz->ops->notify(tz, count,
 							      trip_type);
 				if (!ret) {
-					pr_emerg("Critical temperature reached (%ld C), shutting down\n",
-						 temp/1000);
+					dev_emerg(&tz->device,
+						  "Critical temperature reached"
+						  " (%ld C), shutting down.\n",
+						  temp/1000);
 					orderly_poweroff(true);
 				}
 			}
@@ -1346,7 +1349,7 @@ int thermal_generate_netlink_event(struct thermal_zone_device *tz,
 
 	result = genlmsg_multicast(skb, 0, thermal_event_mcgrp.id, GFP_ATOMIC);
 	if (result)
-		pr_info("failed to send netlink event:%d\n", result);
+		dev_err(&tz->device, "Failed to send netlink event:%d", result);
 
 	return result;
 }
-- 
1.7.7.1.488.ge8e1c
