From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v7 1/2] PM-runtime: update accounting_timestamp only when enable
Date: Wed, 23 Jan 2019 08:50:13 +0100
Message-ID: <1548229814-24913-2-git-send-email-vincent.guittot@linaro.org>
References: <1548229814-24913-1-git-send-email-vincent.guittot@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548229814-24913-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, thara.gopinath@linaro.org, linux@roeck-us.net
Cc: ulf.hansson@linaro.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

Initializing accounting_timestamp to something different from 0 during
pm_runtime_init() doesn't make sense and put useless ordering constraint between
timekeeping_init() and pm_runtime_init().
PM runtime should start accounting time only when it is enable and discard
the period when disabled.
Set accounting_timestamp to now when enabling PM runtime.

Suggested-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/base/power/runtime.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index fb5e2b6..eccd37f1 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1306,10 +1306,15 @@ void pm_runtime_enable(struct device *dev)
 
 	spin_lock_irqsave(&dev->power.lock, flags);
 
-	if (dev->power.disable_depth > 0)
+	if (dev->power.disable_depth > 0) {
 		dev->power.disable_depth--;
-	else
+
+		/* About to enable runtime pm, set accounting_timestamp to now */
+		if (!dev->power.disable_depth)
+			dev->power.accounting_timestamp = jiffies;
+	} else {
 		dev_warn(dev, "Unbalanced %s!\n", __func__);
+	}
 
 	WARN(!dev->power.disable_depth &&
 	     dev->power.runtime_status == RPM_SUSPENDED &&
@@ -1506,7 +1511,7 @@ void pm_runtime_init(struct device *dev)
 	dev->power.request_pending = false;
 	dev->power.request = RPM_REQ_NONE;
 	dev->power.deferred_resume = false;
-	dev->power.accounting_timestamp = jiffies;
+	dev->power.accounting_timestamp = 0;
 	INIT_WORK(&dev->power.work, pm_runtime_work);
 
 	dev->power.timer_expires = 0;
-- 
2.7.4
