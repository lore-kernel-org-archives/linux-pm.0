From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH v2] PM / devfreq: Add proper locking around list_del()
Date: Thu, 29 Sep 2016 10:13:28 +0800
Message-ID: <1475115208-6817-1-git-send-email-axel.lin@ingics.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
List-Id: linux-pm@vger.kernel.org

Use devfreq_list_lock around list_del() to prevent list corruption.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
v2: changes base on MyungJoo's comment.
Note, devfreq_list_lock lock region does not to include device_unregister(&devfreq->dev);
 drivers/devfreq/devfreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 478006b..66d3c718 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -594,17 +594,19 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	if (devfreq->governor)
 		err = devfreq->governor->event_handler(devfreq,
 					DEVFREQ_GOV_START, NULL);
-	mutex_unlock(&devfreq_list_lock);
 	if (err) {
 		dev_err(dev, "%s: Unable to start governor for the device\n",
 			__func__);
 		goto err_init;
 	}
+	mutex_unlock(&devfreq_list_lock);
 
 	return devfreq;
 
 err_init:
 	list_del(&devfreq->node);
+	mutex_unlock(&devfreq_list_lock);
+
 	device_unregister(&devfreq->dev);
 err_out:
 	return ERR_PTR(err);
-- 
2.7.4
