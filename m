From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 4/6] PM / devfreq: Remove unnecessary locking
Date: Tue, 24 Apr 2018 15:35:19 -0700
Message-ID: <20180424223521.28193-5-bjorn.andersson@linaro.org>
References: <20180424223521.28193-1-bjorn.andersson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180424223521.28193-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The devfreq lock is used to prevent concurrent access to the devfreq
object, but as all operations leading up to the registration of the
devfreq device are local to devfreq_add_device() there's no reason to
hold the lock.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/devfreq/devfreq.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 2e50f5d9d92a..70588dc2032c 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -584,7 +584,6 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	}
 
 	mutex_init(&devfreq->lock);
-	mutex_lock(&devfreq->lock);
 	devfreq->dev.parent = dev;
 	devfreq->dev.class = devfreq_class;
 	devfreq->dev.release = devfreq_dev_release;
@@ -596,16 +595,13 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->nb.notifier_call = devfreq_notifier_call;
 
 	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
-		mutex_unlock(&devfreq->lock);
 		err = set_freq_table(devfreq);
 		if (err < 0)
 			goto err_dev;
-		mutex_lock(&devfreq->lock);
 	}
 
 	devfreq->min_freq = find_available_min_freq(devfreq);
 	if (!devfreq->min_freq) {
-		mutex_unlock(&devfreq->lock);
 		err = -EINVAL;
 		goto err_dev;
 	}
@@ -613,7 +609,6 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	devfreq->max_freq = find_available_max_freq(devfreq);
 	if (!devfreq->max_freq) {
-		mutex_unlock(&devfreq->lock);
 		err = -EINVAL;
 		goto err_dev;
 	}
@@ -635,12 +630,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
 				atomic_inc_return(&devfreq_no));
 	err = device_register(&devfreq->dev);
 	if (err) {
-		mutex_unlock(&devfreq->lock);
 		goto err_dev;
 	}
 
-	mutex_unlock(&devfreq->lock);
-
 	mutex_lock(&devfreq_list_lock);
 	list_add(&devfreq->node, &devfreq_list);
 
-- 
2.16.2
