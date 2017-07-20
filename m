From: Ed Swierk <eswierk@skyportsystems.com>
Subject: [PATCH] thermal: intel_pch_thermal: Fix enable check on Broadwell-DE
Date: Wed, 19 Jul 2017 17:44:40 -0700
Message-ID: <1500511480-52312-1-git-send-email-eswierk@skyportsystems.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:37786 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932495AbdGTAos (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jul 2017 20:44:48 -0400
Received: by mail-pg0-f50.google.com with SMTP id y129so7054617pgy.4
        for <linux-pm@vger.kernel.org>; Wed, 19 Jul 2017 17:44:48 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, tushar.n.dave@intel.com
Cc: Ed Swierk <eswierk@skyportsystems.com>

Using the TSDSS flag to determine whether the thermal sensor is
enabled is problematic. Broadwell-DE (Xeon D-1500) does not support
dynamic shutdown and the TSDSS flag always reads 0 (contrary to the
current datasheet). Even on hardware supporting dynamic shutdown, the
driver does nothing to configure it, and the dynamic shutdown state
should not prevent the driver from loading. The ETS flag itself
indicates whether the thermal sensor is enabled, so use it instead of
the TSDSS flag on all hardware platforms.

Signed-off-by: Ed Swierk <eswierk@skyportsystems.com>
---
 drivers/thermal/intel_pch_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel_pch_thermal.c b/drivers/thermal/intel_pch_thermal.c
index 2b49e8d..9889c90 100644
--- a/drivers/thermal/intel_pch_thermal.c
+++ b/drivers/thermal/intel_pch_thermal.c
@@ -125,7 +125,7 @@ static int pch_wpt_init(struct pch_thermal_device *ptd, int *nr_trips)
 	*nr_trips = 0;
 
 	/* Check if BIOS has already enabled thermal sensor */
-	if (WPT_TSS_TSDSS & readb(ptd->hw_base + WPT_TSS)) {
+	if (WPT_TSEL_ETS & readb(ptd->hw_base + WPT_TSEL)) {
 		ptd->bios_enabled = true;
 		goto read_trips;
 	}
@@ -141,7 +141,7 @@ static int pch_wpt_init(struct pch_thermal_device *ptd, int *nr_trips)
 	}
 
 	writeb(tsel|WPT_TSEL_ETS, ptd->hw_base + WPT_TSEL);
-	if (!(WPT_TSS_TSDSS & readb(ptd->hw_base + WPT_TSS))) {
+	if (!(WPT_TSEL_ETS & readb(ptd->hw_base + WPT_TSEL))) {
 		dev_err(&ptd->pdev->dev, "Sensor can't be enabled\n");
 		return -ENODEV;
 	}
-- 
1.9.1
