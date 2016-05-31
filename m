From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv4 46/48] thermal: core: improve kerneldoc entry of thermal_cooling_device_unregister
Date: Mon, 30 May 2016 23:18:53 -0700
Message-ID: <1464675535-2433-47-git-send-email-edubezval@gmail.com>
References: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Keerthy <a0393675@ti.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Improve description and keep 80 columns limit.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 3957768..b3fa47e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1010,11 +1010,11 @@ static void __unbind(struct thermal_zone_device *tz, int mask,
 }
 
 /**
- * thermal_cooling_device_unregister - removes the registered thermal cooling device
+ * thermal_cooling_device_unregister - removes a thermal cooling device
  * @cdev:	the thermal cooling device to remove.
  *
- * thermal_cooling_device_unregister() must be called when the device is no
- * longer needed.
+ * thermal_cooling_device_unregister() must be called when a registered
+ * thermal cooling device is no longer needed.
  */
 void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 {
-- 
2.1.4
