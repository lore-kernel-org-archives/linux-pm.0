From: Devendra Naga <devendra.aaru@gmail.com>
Subject: [PATCH] thermal: fair_share: check for a valid thermal zone device
Date: Sat, 30 Mar 2013 15:34:37 +0530
Message-ID: <1364637877-28068-1-git-send-email-devendra.aaru@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-da0-f49.google.com ([209.85.210.49]:36267 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab3C3KEx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 30 Mar 2013 06:04:53 -0400
Received: by mail-da0-f49.google.com with SMTP id t11so485490daj.22
        for <linux-pm@vger.kernel.org>; Sat, 30 Mar 2013 03:04:52 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Cc: Devendra Naga <devendra.aaru@gmail.com>

to be on safe side check for a valid thermal zone device and fail if there
is no thermal zone device.

Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
---
 drivers/thermal/fair_share.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
index 792479f..4cd1d47 100644
--- a/drivers/thermal/fair_share.c
+++ b/drivers/thermal/fair_share.c
@@ -85,7 +85,7 @@ static int fair_share_throttle(struct thermal_zone_device *tz, int trip)
 	int i;
 	int cur_trip_level = get_trip_level(tz);
 
-	if (!tz->tzp || !tz->tzp->tbp)
+	if (!tz || !tz->tzp || !tz->tzp->tbp)
 		return -EINVAL;
 
 	tzp = tz->tzp;
-- 
1.8.1.4

