From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv3 39/48] thermal: core: add a comment describing the device management section
Date: Mon, 30 May 2016 15:16:15 -0700
Message-ID: <1464646584-14322-40-git-send-email-edubezval@gmail.com>
References: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35016 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423645AbcE3WRk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 May 2016 18:17:40 -0400
In-Reply-To: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

comment describing the section with function to handle
registration, unregistration, binding, and unbinding of
thermal devices.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 5ce6504..98176aa 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -581,8 +581,15 @@ void thermal_zone_device_unbind_exception(struct thermal_zone_device *tz,
 	mutex_unlock(&thermal_list_lock);
 }
 
-/* Device management */
-
+/*
+ * Device management section: cooling devices, zones devices, and binding
+ *
+ * Set of functions provided by the thermal core for:
+ * - cooling devices lifecycle: registration, unregistration,
+ *				binding, and unbinding.
+ * - thermal zone devices lifecycle: registration, unregistration,
+ *				     binding, and unbinding.
+ */
 static int get_idr(struct idr *idr, struct mutex *lock, int *id)
 {
 	int ret;
-- 
2.1.4

