From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 37/40] thermal: core: add a comment describing the main update loop
Date: Mon, 30 May 2016 14:27:56 -0700
Message-ID: <1464643679-2733-38-git-send-email-edubezval@gmail.com>
References: <1464643679-2733-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35802 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423457AbcE3V30 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 May 2016 17:29:26 -0400
In-Reply-To: <1464643679-2733-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Simply marking the main update loop section and adding a
comment describing it.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6dbb86f..063fb15 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -286,6 +286,17 @@ static void thermal_unregister_governors(void)
 	thermal_gov_power_allocator_unregister();
 }
 
+/*
+ * Zone update section: main control loop applied to each zone while monitoring
+ *
+ * in polling mode. The monitoring is done using a workqueue.
+ * Same update may be done on a zone by calling thermal_zone_device_update().
+ *
+ * An update means:
+ * - Non-critical trips will invoke the governor responsible for that zone;
+ * - Hot trips will produce a notification to userspace;
+ * - Critical trip point will cause a system shutdown.
+ */
 static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 					    int delay)
 {
-- 
2.1.4

