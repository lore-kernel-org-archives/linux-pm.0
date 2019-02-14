From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH 2/2] drivers: devfreq: add tracing for scheduling work
Date: Thu, 14 Feb 2019 19:57:56 +0100
Message-ID: <1550170676-14173-3-git-send-email-l.luba@partner.samsung.com>
References: <1550170676-14173-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190214185811eucas1p1e2f44d59495296fbfed42f28a2c897a0@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550170676-14173-1-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: b.zolnierkie@samsung.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, mka@chromium.org, rostedt@goodmis.org, mingo@redhat.com, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch add basic tracing of the devfreq workqueue and delayed work.
It aims to capture changes of the polling intervals and device state.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/devfreq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 0ae3de7..c9714fd 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -29,6 +29,9 @@
 #include <linux/of.h>
 #include "governor.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/devfreq.h>
+
 static struct class *devfreq_class;
 
 /*
@@ -394,6 +397,11 @@ static void devfreq_monitor(struct work_struct *work)
 	queue_delayed_work(devfreq_wq, &devfreq->work,
 				msecs_to_jiffies(devfreq->profile->polling_ms));
 	mutex_unlock(&devfreq->lock);
+
+	trace_devfreq_monitor(dev_name(&devfreq->dev), devfreq->previous_freq,
+			      devfreq->profile->polling_ms,
+			      devfreq->last_status.busy_time,
+			      devfreq->last_status.total_time);
 }
 
 /**
-- 
2.7.4
