From: Ulises Brindis <brindisu@lab126.com>
Subject: [PATCH] thermal: of: fix cleanup when building a thermal zone
Date: Fri, 25 Mar 2016 12:55:41 -0700
Message-ID: <1458935741-21355-1-git-send-email-brindisu@lab126.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:56393 "EHLO
	smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbcCYTzX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Mar 2016 15:55:23 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
Cc: Ulises Brindis <brindisu@lab126.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

of_node_put is iterating through all terms in the tbps array even though
the bind has failed. We need to only iterate through the terms that have
already passed the binding step.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ulises Brindis <brindisu@lab126.com>
---
 drivers/thermal/of-thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 9043f8f..0f1c420 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -825,7 +825,7 @@ finish:
 	return tz;
 
 free_tbps:
-	for (i = 0; i < tz->num_tbps; i++)
+	for (i = i - 1; i >= 0; i--)
 		of_node_put(tz->tbps[i].cooling_device);
 	kfree(tz->tbps);
 free_trips:
-- 
1.7.9.5

