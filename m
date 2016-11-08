From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 11/49] thermal: core: fix style on remove_trip_attrs()
Date: Mon,  7 Nov 2016 21:08:49 -0800
Message-ID: <1478581767-7009-12-git-send-email-edubezval@gmail.com>
References: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Align to parentheses, removing checkpatch warning.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 122eba7..592c72b 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1900,7 +1900,7 @@ static void remove_trip_attrs(struct thermal_zone_device *tz)
 				   &tz->trip_temp_attrs[indx].attr);
 		if (tz->ops->get_trip_hyst)
 			device_remove_file(&tz->device,
-				  &tz->trip_hyst_attrs[indx].attr);
+					   &tz->trip_hyst_attrs[indx].attr);
 	}
 	kfree(tz->trip_type_attrs);
 	kfree(tz->trip_temp_attrs);
-- 
2.1.4
