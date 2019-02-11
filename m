From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v2 2/2] drivers: devfreq: change deferred work into delayed
Date: Mon, 11 Feb 2019 16:30:05 +0100
Message-ID: <1549899005-7760-3-git-send-email-l.luba@partner.samsung.com>
References: <1549899005-7760-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190211153037eucas1p20b80e44795e3599dabd9c2fc0291c063@eucas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549899005-7760-1-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: b.zolnierkie@samsung.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com, joel@joelfernandes.org, chris.diamand@arm.com, mka@chromium.org, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch changes deferred work to delayed work, which is now not missed
when timer is put on CPU that entered idle state.
The devfreq framework governor was not called, thus changing the device's
frequency did not happen.
Benchmarks for stressing Dynamic Memory Controller show x2 (in edge cases
even x5) performance boost with this patch when 'simpleondemand_governor'
is responsible for monitoring the device load and frequency changes.

With this patch, the delayed work is done no mater CPUs' idle.
All of the drivers in devfreq which rely on periodic, guaranteed wakeup
intervals should benefit from it.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 882e717..c200b3c 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -400,7 +400,7 @@ static void devfreq_monitor(struct work_struct *work)
  */
 void devfreq_monitor_start(struct devfreq *devfreq)
 {
-	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
+	INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
 	if (devfreq->profile->polling_ms)
 		schedule_delayed_work(&devfreq->work,
 			msecs_to_jiffies(devfreq->profile->polling_ms));
-- 
2.7.4
