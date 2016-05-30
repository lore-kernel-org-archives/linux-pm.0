From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv3 46/48] thermal: core: improve kerneldoc entry of thermal_cooling_device_unregister
Date: Mon, 30 May 2016 15:16:22 -0700
Message-ID: <1464646584-14322-47-git-send-email-edubezval@gmail.com>
References: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33692 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423617AbcE3WRu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 May 2016 18:17:50 -0400
In-Reply-To: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

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

