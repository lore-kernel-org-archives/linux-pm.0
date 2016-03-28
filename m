From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 1/1] thermal: reduce the size of trips_disabled
Date: Mon, 28 Mar 2016 07:03:48 -0700
Message-ID: <1459173828-11149-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36223 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbcC1ODw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Mar 2016 10:03:52 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Currently we have a maximum of 12 trips per thermal zone:
 #define THERMAL_MAX_TRIPS       12

For this reason, there is no need to have a long to keep
track of status of each trip.

Fixes: 81ad4276b505e987dd8ebbdf63605f92cd172b52

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 include/linux/thermal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index a55d052..47e3a93 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -192,7 +192,7 @@ struct thermal_zone_device {
 	struct thermal_attr *trip_hyst_attrs;
 	void *devdata;
 	int trips;
-	unsigned long trips_disabled;	/* bitmap for disabled trips */
+	unsigned int trips_disabled;	/* bitmap for disabled trips */
 	int passive_delay;
 	int polling_delay;
 	int temperature;
-- 
2.1.4

