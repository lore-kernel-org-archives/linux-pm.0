From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 3/3] Thermal: do thermal zone update after a cooling device registered
Date: Sun, 27 Sep 2015 13:48:44 +0800
Message-ID: <1443332924-14028-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com, javi.merino@arm.com
Cc: rui.zhang@intel.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

When a new cooling device is registered, we need to update the
thermal zone to set the new registered cooling device to a proper
state.

This fixes a problem that the system is cool, while the fan devices
are left running on full speed after boot, if fan device is registered
after thermal zone device.

CC: <stable@vger.kernel.org> #3.18+
Reference:https://bugzilla.kernel.org/show_bug.cgi?id=92431
Tested-by: Manuel Krause <manuelkrause@netscape.net>
Tested-by: szegad <szegadlo@poczta.onet.pl>
Tested-by: prash <prash.n.rao@gmail.com>
Tested-by: amish <ammdispose-arch@yahoo.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/thermal/thermal_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index c3bdb48..09c78a4 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1450,6 +1450,7 @@ __thermal_cooling_device_register(struct device_node *np,
 				  const struct thermal_cooling_device_ops *ops)
 {
 	struct thermal_cooling_device *cdev;
+	struct thermal_instance *pos, *next;
 	int result;
 
 	if (type && strlen(type) >= THERMAL_NAME_LENGTH)
@@ -1494,6 +1495,15 @@ __thermal_cooling_device_register(struct device_node *np,
 	/* Update binding information for 'this' new cdev */
 	bind_cdev(cdev);
 
+	list_for_each_entry_safe(pos, next, &cdev->thermal_instances, cdev_node) {
+			if (next->cdev_node.next == &cdev->thermal_instances) {
+				thermal_zone_device_update(next->tz);
+				break;
+			}
+			if (pos->tz != next->tz)
+				thermal_zone_device_update(pos->tz);
+	}
+
 	return cdev;
 }
 
-- 
1.8.4.2
