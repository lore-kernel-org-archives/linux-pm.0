From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v6 1/2] PM-runtime: update accounting_timestamp only when enable
Date: Tue, 22 Jan 2019 15:24:29 +0100
Message-ID: <1548167070-421-2-git-send-email-vincent.guittot@linaro.org>
References: <1548167070-421-1-git-send-email-vincent.guittot@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548167070-421-1-git-send-email-vincent.guittot@linaro.org>
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
 drivers/base/power/runtime.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index fb5e2b6..7df1d05 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1306,6 +1306,10 @@ void pm_runtime_enable(struct device *dev)
 
 	spin_lock_irqsave(&dev->power.lock, flags);
 
+	/* About to enable runtime pm, set accounting_timestamp to now */
+	if (dev->power.disable_depth == 1)
+		dev->power.accounting_timestamp = jiffies;
+
 	if (dev->power.disable_depth > 0)
 		dev->power.disable_depth--;
 	else
@@ -1506,7 +1510,7 @@ void pm_runtime_init(struct device *dev)
 	dev->power.request_pending = false;
 	dev->power.request = RPM_REQ_NONE;
 	dev->power.deferred_resume = false;
-	dev->power.accounting_timestamp = jiffies;
+	dev->power.accounting_timestamp = 0;
 	INIT_WORK(&dev->power.work, pm_runtime_work);
 
 	dev->power.timer_expires = 0;
-- 
2.7.4
