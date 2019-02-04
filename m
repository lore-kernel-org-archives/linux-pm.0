From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/2] PM-runtime: move runtime accounting on ktime_get_mono_fast_ns()
Date: Mon,  4 Feb 2019 17:25:52 +0100
Message-ID: <1549297553-17647-2-git-send-email-vincent.guittot@linaro.org>
References: <1549297553-17647-1-git-send-email-vincent.guittot@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549297553-17647-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, biju.das@bp.renesas.com
Cc: linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, thara.gopinath@linaro.org, linux-renesas-soc@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

Similarly to what happened whith autosuspend, a deadlock has been raised
with runtime accounting in the sequence:

change_clocksource
    ...
    write_seqcount_begin
    ...
    timekeeping_update
        ...
        sh_cmt_clocksource_enable
            ...
            rpm_resume
                update_pm_runtime_accounting
                    ktime_get
                        do
                            read_seqcount_begin
                        while read_seqcount_retry
    ....
    write_seqcount_end

Move runtime accounting on ktime_get_mono_fast_ns()
With ktime_get_mono_fast_ns, the timestamp is not guaranteed to be
monotonic across an update of timekeeping and as a result time can goes
backward. Add a test to skip accounting for such situation which should
stay exceptional.

Fixes: a08c2a5a3194 ("PM-runtime: Replace jiffies-based accounting with ktime-based accounting")
Reported-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/base/power/runtime.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 1caa394..50740da 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -66,13 +66,22 @@ static int rpm_suspend(struct device *dev, int rpmflags);
  */
 void update_pm_runtime_accounting(struct device *dev)
 {
-	u64 now = ktime_to_ns(ktime_get());
+	u64 now = ktime_get_mono_fast_ns();
+	u64 last = dev->power.accounting_timestamp;
 	u64 delta;
 
-	delta = now - dev->power.accounting_timestamp;
-
 	dev->power.accounting_timestamp = now;
 
+	/*
+	 * Because ktime_get_mono_fast_ns() is not monotonic during
+	 * timekeeping update, we must ensure that now is after the last saved
+	 * timesptamp
+	 */
+	if (now < last)
+		return;
+
+	delta = now - last;
+
 	if (dev->power.disable_depth > 0)
 		return;
 
@@ -1312,7 +1321,7 @@ void pm_runtime_enable(struct device *dev)
 
 		/* About to enable runtime pm, set accounting_timestamp to now */
 		if (!dev->power.disable_depth)
-			dev->power.accounting_timestamp = ktime_to_ns(ktime_get());
+			dev->power.accounting_timestamp = ktime_get_mono_fast_ns();
 	} else {
 		dev_warn(dev, "Unbalanced %s!\n", __func__);
 	}
-- 
2.7.4
