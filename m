From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v3 7/7] drivers: devfreq: add tracing for scheduling work
Date: Tue, 12 Feb 2019 23:23:58 +0100
Message-ID: <1550010238-24002-8-git-send-email-l.luba@partner.samsung.com>
References: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190212222438eucas1p27e020c2b36f2e5a2188e4df6fb18488b@eucas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: b.zolnierkie@samsung.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com, joel@joelfernandes.org, chris.diamand@arm.com, mka@chromium.org, rostedt@goodmis.org, mingo@redhat.com, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch add basic tracing of the devfreq workqueue and delayed work.
It aims to capture changes of the polling intervals and device state.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/devfreq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 29e99ce..c1d0d8c 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -29,6 +29,9 @@
 #include <linux/of.h>
 #include "governor.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/devfreq.h>
+
 /* The ~30% load threshold used for load calculation (due to fixed point
  * arithmetic) */
 #define LOAD_THRESHOLD_IN_DEVICE_USAGE (300)
@@ -418,6 +421,7 @@ static void devfreq_monitor(struct work_struct *work)
 	struct devfreq *devfreq = container_of(work,
 					struct devfreq, work.work);
 	unsigned int polling_ms;
+	const char *df_name = dev_name(&devfreq->dev);
 
 	mutex_lock(&devfreq->lock);
 	polling_ms = devfreq_get_polling_delay(devfreq);
@@ -429,6 +433,10 @@ static void devfreq_monitor(struct work_struct *work)
 	schedule_delayed_work(&devfreq->work,
 			      msecs_to_jiffies(polling_ms));
 	mutex_unlock(&devfreq->lock);
+
+	trace_devfreq_monitor(df_name, devfreq->previous_freq, polling_ms,
+			      devfreq->last_status.busy_time,
+			      devfreq->last_status.total_time);
 }
 
 /**
-- 
2.7.4
