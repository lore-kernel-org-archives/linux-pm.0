From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH] PM / Runtime: Asyncronous idle|suspend devices at system resume
Date: Fri, 12 Apr 2013 11:41:06 +0200
Message-ID: <1365759666-23652-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:60904 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752463Ab3DLJnD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Apr 2013 05:43:03 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Rickard Andersson <rickard.andersson@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>

From: Ulf Hansson <ulf.hansson@linaro.org>

Use the asyncronous runtime PM API when returning the runtime
reference for the device after the system resume is completed.

By using the asyncronous runtime PM API we don't have to wait
for each an every device to become idle|suspended. Instead we
can move on and handle the next device in queue.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/base/power/domain.c      |    2 +-
 drivers/base/power/generic_ops.c |    2 +-
 drivers/base/power/main.c        |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 9a6b05a..bba5758 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1327,7 +1327,7 @@ static void pm_genpd_complete(struct device *dev)
 		pm_generic_complete(dev);
 		pm_runtime_set_active(dev);
 		pm_runtime_enable(dev);
-		pm_runtime_idle(dev);
+		pm_request_idle(dev);
 	}
 }
 
diff --git a/drivers/base/power/generic_ops.c b/drivers/base/power/generic_ops.c
index d03d290..bfd898b 100644
--- a/drivers/base/power/generic_ops.c
+++ b/drivers/base/power/generic_ops.c
@@ -324,6 +324,6 @@ void pm_generic_complete(struct device *dev)
 	 * Let runtime PM try to suspend devices that haven't been in use before
 	 * going into the system-wide sleep state we're resuming from.
 	 */
-	pm_runtime_idle(dev);
+	pm_request_idle(dev);
 }
 #endif /* CONFIG_PM_SLEEP */
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 15beb50..5a9b656 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -756,7 +756,7 @@ static void device_complete(struct device *dev, pm_message_t state)
 
 	device_unlock(dev);
 
-	pm_runtime_put_sync(dev);
+	pm_runtime_put(dev);
 }
 
 /**
-- 
1.7.10

