From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v3 3/5] thermal: fair_share: fix typo
Date: Wed, 18 Feb 2015 16:04:23 +0000
Message-ID: <1424275465-16144-4-git-send-email-javi.merino@arm.com>
References: <1424275465-16144-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss-mx-na.arm.com ([217.140.108.86]:44014 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbbBRQFV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Feb 2015 11:05:21 -0500
In-Reply-To: <1424275465-16144-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Javi Merino <javi.merino@arm.com>, Durgadoss R <durgadoss.r@intel.com>

s/asscciated/associated/

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Durgadoss R <durgadoss.r@intel.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/thermal/fair_share.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
index 9e392d34ac9f..692f4053f08b 100644
--- a/drivers/thermal/fair_share.c
+++ b/drivers/thermal/fair_share.c
@@ -69,7 +69,7 @@ static long get_target_state(struct thermal_zone_device *tz,
 }
 
 /**
- * fair_share_throttle - throttles devices asscciated with the given zone
+ * fair_share_throttle - throttles devices associated with the given zone
  * @tz - thermal_zone_device
  *
  * Throttling Logic: This uses three parameters to calculate the new
-- 
1.9.1

