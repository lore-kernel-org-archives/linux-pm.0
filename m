From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 5/6] PM / devfreq: Use put_device() on device_register error
Date: Tue, 24 Apr 2018 15:35:20 -0700
Message-ID: <20180424223521.28193-6-bjorn.andersson@linaro.org>
References: <20180424223521.28193-1-bjorn.andersson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180424223521.28193-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

After calling device_register() the dev must be released using
put_device() rather than just freeing the carrying object.

The release function of the devfreq device will be called in this case,
but as we're yet to add the devfreq instance to the devfreq_list the
release function would print a warning and return.

But as the error path of devfreq_add_device() has been cleaned up the
release function is now the only function taking the devfreq off the
list, so we do not need to safe guard against the devfreq not being on
the list.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/devfreq/devfreq.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 70588dc2032c..c804bd72a644 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -523,11 +523,6 @@ static void devfreq_dev_release(struct device *dev)
 	struct devfreq *devfreq = to_devfreq(dev);
 
 	mutex_lock(&devfreq_list_lock);
-	if (IS_ERR(find_device_devfreq(devfreq->dev.parent))) {
-		mutex_unlock(&devfreq_list_lock);
-		dev_warn(&devfreq->dev, "releasing devfreq which doesn't exist\n");
-		return;
-	}
 	list_del(&devfreq->node);
 	mutex_unlock(&devfreq_list_lock);
 
@@ -583,6 +578,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_out;
 	}
 
+	INIT_LIST_HEAD(&devfreq->node);
 	mutex_init(&devfreq->lock);
 	devfreq->dev.parent = dev;
 	devfreq->dev.class = devfreq_class;
@@ -630,7 +626,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
 				atomic_inc_return(&devfreq_no));
 	err = device_register(&devfreq->dev);
 	if (err) {
-		goto err_dev;
+		put_device(&devfreq->dev);
+		goto err_out;
 	}
 
 	mutex_lock(&devfreq_list_lock);
-- 
2.16.2
