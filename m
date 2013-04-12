From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH] PM / Runtime: Asyncronous idle|suspend parent devices at removal
Date: Fri, 12 Apr 2013 11:41:30 +0200
Message-ID: <1365759690-23687-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117]:36541 "EHLO
	eu1sys200aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752713Ab3DLJmL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Apr 2013 05:42:11 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Rickard Andersson <rickard.andersson@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>

From: Ulf Hansson <ulf.hansson@linaro.org>

For irq safe devices return the runtime reference for the parent
by using the asyncronous runtime PM API. Thus we don't have to
wait for it to become idle|suspended. Instead we can move on and
handle the next device in queue.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/base/power/runtime.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 1244930..ef13ad08 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1400,5 +1400,5 @@ void pm_runtime_remove(struct device *dev)
 	if (dev->power.runtime_status == RPM_ACTIVE)
 		pm_runtime_set_suspended(dev);
 	if (dev->power.irq_safe && dev->parent)
-		pm_runtime_put_sync(dev->parent);
+		pm_runtime_put(dev->parent);
 }
-- 
1.7.10

