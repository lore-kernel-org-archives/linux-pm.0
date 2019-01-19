From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] PM / devfreq: fix mem leak and missing check of return value in devfreq_add_device()
Date: Sat, 19 Jan 2019 00:02:56 -0500
Message-ID: <20190119050256.22520-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

'devfreq' is malloced in devfreq_add_device() and should be freed in
the error handling cases, otherwise it will cause memory leak.

devm_kzalloc() could fail, so insert a check of its return value. And
if it fails, returns -ENOMEM.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/devfreq/devfreq.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 0ae3de76833b..fe6c157cb7e0 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -651,7 +651,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		mutex_unlock(&devfreq->lock);
 		err = set_freq_table(devfreq);
 		if (err < 0)
-			goto err_out;
+			goto err_dev;
 		mutex_lock(&devfreq->lock);
 	}
 
@@ -683,16 +683,27 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_out;
 	}
 
-	devfreq->trans_table =
-		devm_kzalloc(&devfreq->dev,
-			     array3_size(sizeof(unsigned int),
-					 devfreq->profile->max_state,
-					 devfreq->profile->max_state),
-			     GFP_KERNEL);
+	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
+					    array3_size(sizeof(unsigned int),
+					    devfreq->profile->max_state,
+					    devfreq->profile->max_state),
+					    GFP_KERNEL);
+	if (!devfreq->trans_table) {
+		mutex_unlock(&devfreq->lock);
+		err = -ENOMEM;
+		goto err_devfreq;
+	}
+
 	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
-						devfreq->profile->max_state,
-						sizeof(unsigned long),
-						GFP_KERNEL);
+					      devfreq->profile->max_state,
+					      sizeof(unsigned long),
+					      GFP_KERNEL);
+	if (!devfreq->time_in_state) {
+		mutex_unlock(&devfreq->lock);
+		err = -ENOMEM;
+		goto err_devfreq;
+	}
+
 	devfreq->last_stat_updated = jiffies;
 
 	srcu_init_notifier_head(&devfreq->transition_notifier_list);
@@ -726,7 +737,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 err_init:
 	mutex_unlock(&devfreq_list_lock);
-
+err_devfreq:
 	devfreq_remove_device(devfreq);
 	devfreq = NULL;
 err_dev:
-- 
2.17.0
