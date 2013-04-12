From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH] PM / Runtime: Improve prepare handling at system suspend for genpd
Date: Fri, 12 Apr 2013 11:41:44 +0200
Message-ID: <1365759704-23722-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:38096 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750870Ab3DLJmm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Apr 2013 05:42:42 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Rickard Andersson <rickard.andersson@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>

From: Ulf Hansson <ulf.hansson@linaro.org>

When genpd prepares for a system suspend it will fetch a runtime
reference for the device. When returning it we now use the
asyncronous runtime PM API. Thus we don't have to wait for the
device to become idle|suspended before we move on and handle the
next device in queue.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/base/power/domain.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 9a6b05a..e6ec4a7 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -920,7 +920,7 @@ static int pm_genpd_prepare(struct device *dev)
 		pm_wakeup_event(dev, 0);
 
 	if (pm_wakeup_pending()) {
-		pm_runtime_put_sync(dev);
+		pm_runtime_put(dev);
 		return -EBUSY;
 	}
 
@@ -961,7 +961,7 @@ static int pm_genpd_prepare(struct device *dev)
 		pm_runtime_enable(dev);
 	}
 
-	pm_runtime_put_sync(dev);
+	pm_runtime_put(dev);
 	return ret;
 }
 
-- 
1.7.10

