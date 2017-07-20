From: Ed Swierk <eswierk@skyportsystems.com>
Subject: [PATCH] thermal: intel_pch_thermal: Read large temp values correctly
Date: Wed, 19 Jul 2017 17:47:31 -0700
Message-ID: <1500511651-52403-1-git-send-email-eswierk@skyportsystems.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34437 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753627AbdGTAri (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jul 2017 20:47:38 -0400
Received: by mail-pg0-f46.google.com with SMTP id 123so7150405pgj.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Jul 2017 17:47:38 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Cc: Ed Swierk <eswierk@skyportsystems.com>

On all supported platforms, the TS Reading (TSR) field in the
Temperature (TEMP) register is 9 bits wide. Values above 0x100 (78
degrees C) are plausible, so don't mask out the topmost bit. And the
register itself is 16 bits wide, so use readw() rather than readl().

Signed-off-by: Ed Swierk <eswierk@skyportsystems.com>
---
 drivers/thermal/intel_pch_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/intel_pch_thermal.c b/drivers/thermal/intel_pch_thermal.c
index 9889c90..318fc1b 100644
--- a/drivers/thermal/intel_pch_thermal.c
+++ b/drivers/thermal/intel_pch_thermal.c
@@ -49,7 +49,7 @@
 #define WPT_TSGPEN	0x84	/* General Purpose Event Enables */
 
 /*  Wildcat Point-LP  PCH Thermal Register bit definitions */
-#define WPT_TEMP_TSR	0x00ff	/* Temp TS Reading */
+#define WPT_TEMP_TSR	0x01ff	/* Temp TS Reading */
 #define WPT_TSC_CPDE	0x01	/* Catastrophic Power-Down Enable */
 #define WPT_TSS_TSDSS	0x10	/* Thermal Sensor Dynamic Shutdown Status */
 #define WPT_TSS_GPES	0x08	/* GPE status */
@@ -174,9 +174,9 @@ static int pch_wpt_init(struct pch_thermal_device *ptd, int *nr_trips)
 
 static int pch_wpt_get_temp(struct pch_thermal_device *ptd, int *temp)
 {
-	u8 wpt_temp;
+	u16 wpt_temp;
 
-	wpt_temp = WPT_TEMP_TSR & readl(ptd->hw_base + WPT_TEMP);
+	wpt_temp = WPT_TEMP_TSR & readw(ptd->hw_base + WPT_TEMP);
 
 	/* Resolution of 1/2 degree C and an offset of -50C */
 	*temp = (wpt_temp * 1000 / 2 - 50000);
-- 
1.9.1
