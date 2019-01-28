From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 100/304] Thermal: do not clear passive state during system sleep
Date: Mon, 28 Jan 2019 10:40:17 -0500
Message-ID: <20190128154341.47195-100-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Wei Wang <wvw@google.com>, Zhang Rui <rui.zhang@intel.com>, Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Wei Wang <wvw@google.com>

[ Upstream commit 964f4843a455d2ffb199512b08be8d5f077c4cac ]

commit ff140fea847e ("Thermal: handle thermal zone device properly
during system sleep") added PM hook to call thermal zone reset during
sleep. However resetting thermal zone will also clear the passive state
and thus cancel the polling queue which leads the passive cooling device
state not being cleared properly after sleep.

thermal_pm_notify => thermal_zone_device_reset set passive to 0
thermal_zone_trip_update will skip update passive as `old_target ==
instance->target'.
monitor_thermal_zone => thermal_zone_device_set_polling will cancel
tz->poll_queue, so the cooling device state will not be changed
afterwards.

Reported-by: Kame Wang <kamewang@google.com>
Signed-off-by: Wei Wang <wvw@google.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/thermal_core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d6ebc1cf6aa9..3a014cd8daf0 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -453,16 +453,20 @@ static void update_temperature(struct thermal_zone_device *tz)
 			tz->last_temperature, tz->temperature);
 }
 
-static void thermal_zone_device_reset(struct thermal_zone_device *tz)
+static void thermal_zone_device_init(struct thermal_zone_device *tz)
 {
 	struct thermal_instance *pos;
-
 	tz->temperature = THERMAL_TEMP_INVALID;
-	tz->passive = 0;
 	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
 		pos->initialized = false;
 }
 
+static void thermal_zone_device_reset(struct thermal_zone_device *tz)
+{
+	tz->passive = 0;
+	thermal_zone_device_init(tz);
+}
+
 void thermal_zone_device_update(struct thermal_zone_device *tz,
 				enum thermal_notify_event event)
 {
@@ -1504,7 +1508,7 @@ static int thermal_pm_notify(struct notifier_block *nb,
 	case PM_POST_SUSPEND:
 		atomic_set(&in_suspend, 0);
 		list_for_each_entry(tz, &thermal_tz_list, node) {
-			thermal_zone_device_reset(tz);
+			thermal_zone_device_init(tz);
 			thermal_zone_device_update(tz,
 						   THERMAL_EVENT_UNSPECIFIED);
 		}
-- 
2.19.1
