From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/3 v2] thermal: core: Use the new 'thermal_zone_destroy_device_groups()' helper function
Date: Tue,  8 Aug 2017 16:39:53 +0200
Message-ID: <5b5eea549341cfe25a1dfd608898ad9899a086a4.1502201798.git.christophe.jaillet@wanadoo.fr>
References: <cover.1502201798.git.christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1502201798.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1502201798.git.christophe.jaillet@wanadoo.fr>
References: <cover.1502201798.git.christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-pm@vger.kernel.org

Simplify code by using the new 'thermal_zone_destroy_device_groups()'
helper function.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/thermal/thermal_core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 5a51c740e372..2523901325d0 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -836,11 +836,7 @@ static void thermal_release(struct device *dev)
 	if (!strncmp(dev_name(dev), "thermal_zone",
 		     sizeof("thermal_zone") - 1)) {
 		tz = to_thermal_zone(dev);
-		kfree(tz->trip_type_attrs);
-		kfree(tz->trip_temp_attrs);
-		kfree(tz->trip_hyst_attrs);
-		kfree(tz->trips_attribute_group.attrs);
-		kfree(tz->device.groups);
+		thermal_zone_destroy_device_groups(tz);
 		kfree(tz);
 	} else if (!strncmp(dev_name(dev), "cooling_device",
 			    sizeof("cooling_device") - 1)) {
-- 
2.11.0
