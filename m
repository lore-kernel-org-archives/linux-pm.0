From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 1/12] thermal: introduce multiple cooling
 states support for Active cooling devices
Date: Mon, 11 Jun 2012 11:19:40 +0800
Message-ID: <1339384780.1492.154.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


Introduce multiple cooling states support for Active cooling devices.

This is because general active cooling devices, like fans,
may have multiple speeds, which can be mapped to different cooling states.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_sys.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

Index: rtd3/drivers/thermal/thermal_sys.c
===================================================================
--- rtd3.orig/drivers/thermal/thermal_sys.c
+++ rtd3/drivers/thermal/thermal_sys.c
@@ -1018,6 +1018,7 @@ void thermal_zone_device_update(struct t
 	enum thermal_trip_type trip_type;
 	struct thermal_cooling_device_instance *instance;
 	struct thermal_cooling_device *cdev;
+	unsigned long cur_state, max_state;
 
 	mutex_lock(&tz->lock);
 
@@ -1057,10 +1058,17 @@ void thermal_zone_device_update(struct t
 
 				cdev = instance->cdev;
 
+				cdev->ops->get_cur_state(cdev, &cur_state);
+				cdev->ops->get_max_state(cdev, &max_state);
+
 				if (temp >= trip_temp)
-					cdev->ops->set_cur_state(cdev, 1);
+					cur_state = cur_state < max_state ?
+						(cur_state + 1) : max_state;
 				else
-					cdev->ops->set_cur_state(cdev, 0);
+					cur_state = cur_state > 0 ?
+						(cur_state - 1) : 0;
+
+				cdev->ops->set_cur_state(cdev, cur_state);
 			}
 			break;
 		case THERMAL_TRIP_PASSIVE:
