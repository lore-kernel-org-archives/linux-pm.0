From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: [RFC v2 2/7] PM / devfreq: Track suspend state of DevFreq devices
Date: Mon, 19 Dec 2016 03:16:22 +0100
Message-ID: <1482113787-28422-3-git-send-email-tjakobi@math.uni-bielefeld.de>
References: <1482113787-28422-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1482113787-28422-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-pm@vger.kernel.org, m.reichl@fivetechno.de, myungjoo.ham@gmail.com, cw00.choi@samsung.com, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
List-Id: linux-pm@vger.kernel.org

In preparation to suspend the whole DevFreq subsystem.

Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
---
 drivers/devfreq/devfreq.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 82d8052..3904ebc 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -30,6 +30,8 @@
 
 enum devfreq_flag_bits {
 	DEVFREQ_BIT_STOP_POLLING,
+	/* Bit set if DevFreq device was suspended in devfreq_suspend_device(). */
+	DEVFREQ_BIT_SUSPENDED,
 };
 
 static struct class *devfreq_class;
@@ -822,14 +824,21 @@ EXPORT_SYMBOL(devfreq_turbo_put);
  */
 int devfreq_suspend_device(struct devfreq *devfreq)
 {
+	int ret;
+
 	if (!devfreq)
 		return -EINVAL;
 
 	if (!devfreq->governor)
 		return 0;
 
-	return devfreq->governor->event_handler(devfreq,
+	ret = devfreq->governor->event_handler(devfreq,
 				DEVFREQ_GOV_SUSPEND, NULL);
+
+	if (ret == 0)
+		__set_bit(DEVFREQ_BIT_SUSPENDED, &devfreq->flags);
+
+	return ret;
 }
 EXPORT_SYMBOL(devfreq_suspend_device);
 
@@ -843,14 +852,21 @@ EXPORT_SYMBOL(devfreq_suspend_device);
  */
 int devfreq_resume_device(struct devfreq *devfreq)
 {
+	int ret;
+
 	if (!devfreq)
 		return -EINVAL;
 
 	if (!devfreq->governor)
 		return 0;
 
-	return devfreq->governor->event_handler(devfreq,
+	ret = devfreq->governor->event_handler(devfreq,
 				DEVFREQ_GOV_RESUME, NULL);
+
+	if (ret == 0)
+		__clear_bit(DEVFREQ_BIT_SUSPENDED, &devfreq->flags);
+
+	return ret;
 }
 EXPORT_SYMBOL(devfreq_resume_device);
 
-- 
2.7.3
