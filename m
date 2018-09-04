From: Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH] thermal: core: using power_efficient_wq for thermal worker
Date: Tue, 4 Sep 2018 14:37:48 +0800
Message-ID: <1536043068-11487-1-git-send-email-chunyan.zhang@unisoc.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jeson Gao <jeson.gao@unisoc.com>, Orson Zhai <orson.zhai@spreadtrum.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Chunyan Zhang <chunyan.zhang@spreadtrum.com>
List-Id: linux-pm@vger.kernel.org

From: Jeson Gao <jeson.gao@unisoc.com>

For SMP systems, thermal worker should use power_efficient_wq in power
saving mode, that will make scheduler more flexible on switching cpu
on/off for running work handler to avoid keeping work handler always
running on a single core, that will same some power.

Even if 'power_efficient_wq' relevant configs are disabled
'system_freezable_power_efficient_wq' is identical to system_freezable_wq,
behavior is unchanged.

Signed-off-by: Jeson Gao <jeson.gao@unisoc.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 drivers/thermal/thermal_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6ab9823..99df89f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -290,10 +290,12 @@ static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 					    int delay)
 {
 	if (delay > 1000)
-		mod_delayed_work(system_freezable_wq, &tz->poll_queue,
+		mod_delayed_work(system_freezable_power_efficient_wq,
+				 &tz->poll_queue,
 				 round_jiffies(msecs_to_jiffies(delay)));
 	else if (delay)
-		mod_delayed_work(system_freezable_wq, &tz->poll_queue,
+		mod_delayed_work(system_freezable_power_efficient_wq,
+				 &tz->poll_queue,
 				 msecs_to_jiffies(delay));
 	else
 		cancel_delayed_work(&tz->poll_queue);
-- 
2.7.4
