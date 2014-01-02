From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH] Thermal: update thermal zone device after setting emul_temp
Date: Thu,  2 Jan 2014 15:47:54 +0800
Message-ID: <1388648874-14198-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, eduardo.valentin@ti.com
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch is to update thermal zone device after setting emul_temp
in order to make governor work according to input temperature immediately.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/thermal/thermal_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 547217c..9d951aa 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -777,6 +777,9 @@ emul_temp_store(struct device *dev, struct device_attribute *attr,
 		ret = tz->ops->set_emul_temp(tz, temperature);
 	}
 
+	if (!ret)
+		thermal_zone_device_update(tz);
+
 	return ret ? ret : count;
 }
 static DEVICE_ATTR(emul_temp, S_IWUSR, NULL, emul_temp_store);
-- 
1.8.2.1
