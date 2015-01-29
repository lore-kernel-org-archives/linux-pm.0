From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/2] Thermal/int340x_thermal: remove unused uuids.
Date: Thu, 29 Jan 2015 21:04:37 +0800
Message-ID: <1422536677-18591-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41056 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753653AbbA2NE6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 29 Jan 2015 08:04:58 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com, rui.zhang@intel.com

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/int340x_thermal/int3400_thermal.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
index 65a98a9..25d244c 100644
--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -18,19 +18,15 @@
 
 enum int3400_thermal_uuid {
 	INT3400_THERMAL_PASSIVE_1,
-	INT3400_THERMAL_PASSIVE_2,
 	INT3400_THERMAL_ACTIVE,
 	INT3400_THERMAL_CRITICAL,
-	INT3400_THERMAL_COOLING_MODE,
 	INT3400_THERMAL_MAXIMUM_UUID,
 };
 
 static u8 *int3400_thermal_uuids[INT3400_THERMAL_MAXIMUM_UUID] = {
 	"42A441D6-AE6A-462b-A84B-4A8CE79027D3",
-	"9E04115A-AE87-4D1C-9500-0F3E340BFE75",
 	"3A95C389-E4B8-4629-A526-C52C88626BAE",
 	"97C68AE7-15FA-499c-B8C9-5DA81D606E0A",
-	"16CAF1B7-DD38-40ed-B1C1-1B8A1913D531",
 };
 
 struct int3400_thermal_priv {
-- 
1.9.1

