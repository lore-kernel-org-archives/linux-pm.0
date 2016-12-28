From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 1/2] PM / devfreq: Add separate target function
Date: Wed, 28 Dec 2016 21:07:07 +0900
Message-ID: <1482926828-19746-2-git-send-email-cw00.choi@samsung.com>
References: <1482926828-19746-1-git-send-email-cw00.choi@samsung.com>
 <CGME20161228120710epcas5p2f4e9d8350446b08048aeed4e87b24f5d@epcas5p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1482926828-19746-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: hl@rock-chips.com, tjakobi@math.uni-bielefeld.de, chanwoo@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch adds the separate target function to set the freq/voltage
because the devfreq have to handle the passive devfreq device using passive
governor when chaning the freq/voltage of parent devfreq device.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 65 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 4bd7a8f71b07..e386f14d91c3 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -216,6 +216,43 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
 	return 0;
 }
 
+static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
+				u32 flags)
+{
+	struct devfreq_freqs freqs;
+	unsigned long freq, cur_freq;
+	int ret;
+
+	freq = new_freq;
+	if (devfreq->profile->get_cur_freq)
+		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
+	else
+		cur_freq = devfreq->previous_freq;
+
+	freqs.old = cur_freq;
+	freqs.new = freq;
+	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
+
+	ret = devfreq->profile->target(devfreq->dev.parent, &freq, flags);
+	if (ret < 0) {
+		freqs.new = cur_freq;
+		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
+		return ret;
+	}
+
+	freqs.new = freq;
+	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
+
+	if (devfreq->profile->freq_table
+		&& (devfreq_update_status(devfreq, freq)))
+		dev_err(&devfreq->dev,
+			"Couldn't update frequency transition information.\n");
+
+	devfreq->previous_freq = freq;
+
+	return 0;
+}
+
 /* Load monitoring helper functions for governors use */
 
 /**
@@ -227,8 +264,7 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
  */
 int update_devfreq(struct devfreq *devfreq)
 {
-	struct devfreq_freqs freqs;
-	unsigned long freq, cur_freq;
+	unsigned long freq;
 	int err = 0;
 	u32 flags = 0;
 
@@ -262,31 +298,12 @@ int update_devfreq(struct devfreq *devfreq)
 		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
 	}
 
-	if (devfreq->profile->get_cur_freq)
-		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
-	else
-		cur_freq = devfreq->previous_freq;
-
-	freqs.old = cur_freq;
-	freqs.new = freq;
-	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
-
-	err = devfreq->profile->target(devfreq->dev.parent, &freq, flags);
-	if (err) {
-		freqs.new = cur_freq;
-		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
+	err = devfreq_set_target(devfreq, freq, flags);
+	if (err < 0) {
+		dev_err(devfreq->dev.parent, "failed to set frequency\n");
 		return err;
 	}
 
-	freqs.new = freq;
-	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
-
-	if (devfreq->profile->freq_table)
-		if (devfreq_update_status(devfreq, freq))
-			dev_err(&devfreq->dev,
-				"Couldn't update frequency transition information.\n");
-
-	devfreq->previous_freq = freq;
 	return err;
 }
 EXPORT_SYMBOL(update_devfreq);
-- 
1.9.1
