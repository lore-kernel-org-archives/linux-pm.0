From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 37/49] thermal: core: add a comment describing the main update loop
Date: Mon,  7 Nov 2016 21:09:15 -0800
Message-ID: <1478581767-7009-38-git-send-email-edubezval@gmail.com>
References: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

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
index 884235f..bf108db 100644
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
