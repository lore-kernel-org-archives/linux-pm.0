From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/2] PM-runtime: update time accounting only when enabled
Date: Mon,  4 Feb 2019 17:25:53 +0100
Message-ID: <1549297553-17647-3-git-send-email-vincent.guittot@linaro.org>
References: <1549297553-17647-1-git-send-email-vincent.guittot@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549297553-17647-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, biju.das@bp.renesas.com
Cc: linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, thara.gopinath@linaro.org, linux-renesas-soc@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

Update accounting_timestamp field only when PM runtime is enable
and don't forget to account the last state before disabling it.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/base/power/runtime.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 50740da..ed62cca 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -66,11 +66,14 @@ static int rpm_suspend(struct device *dev, int rpmflags);
  */
 void update_pm_runtime_accounting(struct device *dev)
 {
-	u64 now = ktime_get_mono_fast_ns();
-	u64 last = dev->power.accounting_timestamp;
-	u64 delta;
+	u64 now, last, delta;
 
-	dev->power.accounting_timestamp = now;
+	if (dev->power.disable_depth > 0)
+		return;
+
+	last = dev->power.accounting_timestamp;
+
+	dev->power.accounting_timestamp = now = ktime_get_mono_fast_ns();
 
 	/*
 	 * Because ktime_get_mono_fast_ns() is not monotonic during
@@ -82,9 +85,6 @@ void update_pm_runtime_accounting(struct device *dev)
 
 	delta = now - last;
 
-	if (dev->power.disable_depth > 0)
-		return;
-
 	if (dev->power.runtime_status == RPM_SUSPENDED)
 		dev->power.suspended_time += delta;
 	else
@@ -1298,6 +1298,9 @@ void __pm_runtime_disable(struct device *dev, bool check_resume)
 		pm_runtime_put_noidle(dev);
 	}
 
+	/* Update time accounting before disabling pm runtime */
+	update_pm_runtime_accounting(dev);
+
 	if (!dev->power.disable_depth++)
 		__pm_runtime_barrier(dev);
 
@@ -1521,7 +1524,6 @@ void pm_runtime_init(struct device *dev)
 	dev->power.request_pending = false;
 	dev->power.request = RPM_REQ_NONE;
 	dev->power.deferred_resume = false;
-	dev->power.accounting_timestamp = 0;
 	INIT_WORK(&dev->power.work, pm_runtime_work);
 
 	dev->power.timer_expires = 0;
-- 
2.7.4
