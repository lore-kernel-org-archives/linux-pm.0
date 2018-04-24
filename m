From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 1/6] PM / devfreq: Free devfreq upon set_freq_table error
Date: Tue, 24 Apr 2018 15:35:16 -0700
Message-ID: <20180424223521.28193-2-bjorn.andersson@linaro.org>
References: <20180424223521.28193-1-bjorn.andersson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180424223521.28193-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When set_freq_table() fails we must still free the previously allocated
devfreq context, so jump to the correct label for this. Also when this
happens devfreq will always be non-NULL, so drop the unnecessary
conditional.

Also destroy the devfreq mutex as we're cleaning up the devfreq object.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/devfreq/devfreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 2067cd229ce3..30a672397ff0 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -597,7 +597,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		mutex_unlock(&devfreq->lock);
 		err = set_freq_table(devfreq);
 		if (err < 0)
-			goto err_out;
+			goto err_dev;
 		mutex_lock(&devfreq->lock);
 	}
 
@@ -669,8 +669,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	device_unregister(&devfreq->dev);
 err_dev:
-	if (devfreq)
-		kfree(devfreq);
+	mutex_destroy(&devfreq->lock);
+	kfree(devfreq);
 err_out:
 	return ERR_PTR(err);
 }
-- 
2.16.2
