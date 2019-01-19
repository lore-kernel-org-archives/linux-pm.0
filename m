From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/3] PM / devfreq: fix missing check of return value in devfreq_add_device()
Date: Sat, 19 Jan 2019 11:04:53 -0500
Message-ID: <20190119160454.23151-2-tiny.windzz@gmail.com>
References: <20190119160454.23151-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190119160454.23151-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

devm_kzalloc() could fail, so insert a check of its return value. And
if it fails, returns -ENOMEM.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/devfreq/devfreq.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 076b1c2f40a4..923889229a0b 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -688,10 +688,22 @@ struct devfreq *devfreq_add_device(struct device *dev,
 					    devfreq->profile->max_state,
 					    devfreq->profile->max_state),
 					    GFP_KERNEL);
+	if (!devfreq->trans_table) {
+		mutex_unlock(&devfreq->lock);
+		err = -ENOMEM;
+		goto err_devfreq;
+	}
+
 	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
 					      devfreq->profile->max_state,
 					      sizeof(unsigned long),
 					      GFP_KERNEL);
+	if (!devfreq->time_in_state) {
+		mutex_unlock(&devfreq->lock);
+		err = -ENOMEM;
+		goto err_devfreq;
+	}
+
 	devfreq->last_stat_updated = jiffies;
 
 	srcu_init_notifier_head(&devfreq->transition_notifier_list);
@@ -725,7 +737,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 err_init:
 	mutex_unlock(&devfreq_list_lock);
-
+err_devfreq:
 	devfreq_remove_device(devfreq);
 	devfreq = NULL;
 err_dev:
-- 
2.17.0
