From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH] drivers: thermal: allow ti-soc-thermal run without pcb zone
Date: Sun, 15 Sep 2013 15:21:51 -0400
Message-ID: <1379272911-29401-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33777 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753007Ab3IOTWD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 15 Sep 2013 15:22:03 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

This patch changes the behavior of TI SoC thermal driver
when there is a PCB thermal zone.

Instead of reporting an error code when reading from
PCB temperature sensor fails, this patch will make
the driver attempt to compose the hotspot extrapolation
based on bandgap readings only.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index f588b32..e5b1cde 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -111,6 +111,7 @@ static inline int __ti_thermal_get_temp(void *devdata, long *temp)
 		} else {
 			dev_err(bgp->dev,
 				"Failed to read PCB state. Using defaults\n");
+			ret = 0;
 		}
 	}
 	*temp = ti_thermal_hotspot_temperature(tmp, slope, constant);
-- 
1.8.2.1.342.gfa7285d

