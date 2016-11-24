From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 1/6] PM / devfreq: Fix the checkpatch warnings
Date: Thu, 24 Nov 2016 14:01:03 +0900
Message-ID: <1479963668-22845-2-git-send-email-cw00.choi@samsung.com>
References: <1479963668-22845-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1479963668-22845-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rjw@rjwysocki.net, chanwoo@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch just fixes the checkpatch warnings.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index a324801d6a66..dfef5ea57e4c 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -538,15 +538,14 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq = find_device_devfreq(dev);
 	mutex_unlock(&devfreq_list_lock);
 	if (!IS_ERR(devfreq)) {
-		dev_err(dev, "%s: Unable to create devfreq for the device. It already has one.\n", __func__);
+		dev_err(dev, "%s: Unable to create devfreq for the device.\n",
+			__func__);
 		err = -EINVAL;
 		goto err_out;
 	}
 
 	devfreq = kzalloc(sizeof(struct devfreq), GFP_KERNEL);
 	if (!devfreq) {
-		dev_err(dev, "%s: Unable to create devfreq for the device\n",
-			__func__);
 		err = -ENOMEM;
 		goto err_out;
 	}
@@ -576,11 +575,13 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_out;
 	}
 
-	devfreq->trans_table =	devm_kzalloc(&devfreq->dev, sizeof(unsigned int) *
+	devfreq->trans_table =	devm_kzalloc(&devfreq->dev,
+						sizeof(unsigned int) *
 						devfreq->profile->max_state *
 						devfreq->profile->max_state,
 						GFP_KERNEL);
-	devfreq->time_in_state = devm_kzalloc(&devfreq->dev, sizeof(unsigned long) *
+	devfreq->time_in_state = devm_kzalloc(&devfreq->dev,
+						sizeof(unsigned long) *
 						devfreq->profile->max_state,
 						GFP_KERNEL);
 	devfreq->last_stat_updated = jiffies;
@@ -990,7 +991,7 @@ static ssize_t cur_freq_show(struct device *dev, struct device_attribute *attr,
 
 	if (devfreq->profile->get_cur_freq &&
 		!devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq))
-			return sprintf(buf, "%lu\n", freq);
+		return sprintf(buf, "%lu\n", freq);
 
 	return sprintf(buf, "%lu\n", devfreq->previous_freq);
 }
-- 
1.9.1
