From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V2 3/3] Thermal: do thermal zone update after a cooling device registered
Date: Wed, 25 Mar 2015 15:53:16 +0800
Message-ID: <1427269996-29501-4-git-send-email-rui.zhang@intel.com>
References: <1427269996-29501-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44556 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbbCYHy6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 25 Mar 2015 03:54:58 -0400
In-Reply-To: <1427269996-29501-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, stable@vger.kernel.org

When a new cooling device is registered, we need to update the
thermal zone to set the new registered cooling device to a proper
state.

This fixes a problem that the system is cool, while the fan devices are left
running on full speed after boot, if fan device is registered after
thermal zone device.

CC: <stable@vger.kernel.org> #3.18+
Reference:https://bugzilla.kernel.org/show_bug.cgi?id=92431
Tested-by: Manuel Krause <manuelkrause@netscape.net>
Tested-by: szegad <szegadlo@poczta.onet.pl>
Tested-by: prash <prash.n.rao@gmail.com>
Tested-by: amish <ammdispose-arch@yahoo.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2f3c829..f872744 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1140,6 +1140,7 @@ __thermal_cooling_device_register(struct device_node *np,
 				  const struct thermal_cooling_device_ops *ops)
 {
 	struct thermal_cooling_device *cdev;
+	struct thermal_instance *pos, *next;
 	int result;
 
 	if (type && strlen(type) >= THERMAL_NAME_LENGTH)
@@ -1184,6 +1185,15 @@ __thermal_cooling_device_register(struct device_node *np,
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
1.9.1

