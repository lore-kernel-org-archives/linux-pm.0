From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 3/6] PM / devfreq: Reorder devfreq_add_device()
Date: Tue, 24 Apr 2018 15:35:18 -0700
Message-ID: <20180424223521.28193-4-bjorn.andersson@linaro.org>
References: <20180424223521.28193-1-bjorn.andersson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180424223521.28193-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The devfreq lock is used to ensure that the devfreq object is fully
initialized before e.g. the sysfs interface is accessing it. Moving all
these operations before the device_register() call ensures the same
thing without a lock; as it's yet to be shared outside the current
context.

This allows us to simplify the locking done in devfreq_add_device().

Instead of using devres for trans_table and time_in_state we use the
release function to free them as the devfreq device is released.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/devfreq/devfreq.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index d5b278b8f20e..2e50f5d9d92a 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -539,6 +539,8 @@ static void devfreq_dev_release(struct device *dev)
 		devfreq->profile->exit(devfreq->dev.parent);
 
 	mutex_destroy(&devfreq->lock);
+	kfree(devfreq->time_in_state);
+	kfree(devfreq->trans_table);
 	kfree(devfreq);
 }
 
@@ -617,6 +619,18 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	}
 	devfreq->scaling_max_freq = devfreq->max_freq;
 
+	devfreq->trans_table =	kcalloc(devfreq->profile->max_state *
+					devfreq->profile->max_state,
+					sizeof(unsigned int),
+					GFP_KERNEL);
+	devfreq->time_in_state = kcalloc(devfreq->profile->max_state,
+					 sizeof(unsigned long),
+					 GFP_KERNEL);
+
+	devfreq->last_stat_updated = jiffies;
+
+	srcu_init_notifier_head(&devfreq->transition_notifier_list);
+
 	dev_set_name(&devfreq->dev, "devfreq%d",
 				atomic_inc_return(&devfreq_no));
 	err = device_register(&devfreq->dev);
@@ -625,19 +639,6 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_dev;
 	}
 
-	devfreq->trans_table =	devm_kzalloc(&devfreq->dev,
-						sizeof(unsigned int) *
-						devfreq->profile->max_state *
-						devfreq->profile->max_state,
-						GFP_KERNEL);
-	devfreq->time_in_state = devm_kzalloc(&devfreq->dev,
-						sizeof(unsigned long) *
-						devfreq->profile->max_state,
-						GFP_KERNEL);
-	devfreq->last_stat_updated = jiffies;
-
-	srcu_init_notifier_head(&devfreq->transition_notifier_list);
-
 	mutex_unlock(&devfreq->lock);
 
 	mutex_lock(&devfreq_list_lock);
@@ -669,6 +670,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 err_dev:
 	mutex_destroy(&devfreq->lock);
+	kfree(devfreq->time_in_state);
+	kfree(devfreq->trans_table);
 	kfree(devfreq);
 err_out:
 	return ERR_PTR(err);
-- 
2.16.2
