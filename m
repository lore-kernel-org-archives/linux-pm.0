From: vincent.donnefort@arm.com
Subject: [PATCH v2] PM / devfreq: Stop the governor before device_unregister()
Date: Fri, 21 Sep 2018 16:40:32 +0100
Message-ID: <1537544432-34712-1-git-send-email-vincent.donnefort@arm.com>
References: <5B8901D7.5040301@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5B8901D7.5040301@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: john.reitan@arm.com, beata.michalska@arm.com, Vincent Donnefort <vincent.donnefort@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Vincent Donnefort <vincent.donnefort@arm.com>

device_release() is freeing the resources before calling the device
specific release callback which is, in the case of devfreq, stopping
the governor.

It is a problem as some governors are using the device resources. e.g.
simpleondemand which is using the devfreq deferrable monitoring work. If it
is not stopped before the resources are freed, it might lead to a use after
free.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Reviewed-by: John Einar Reitan <john.reitan@arm.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 4c49bb1..4e43830 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -534,10 +534,6 @@ static void devfreq_dev_release(struct device *dev)
 	list_del(&devfreq->node);
 	mutex_unlock(&devfreq_list_lock);
 
-	if (devfreq->governor)
-		devfreq->governor->event_handler(devfreq,
-						 DEVFREQ_GOV_STOP, NULL);
-
 	if (devfreq->profile->exit)
 		devfreq->profile->exit(devfreq->dev.parent);
 
@@ -672,7 +668,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	list_del(&devfreq->node);
 	mutex_unlock(&devfreq_list_lock);
 
-	device_unregister(&devfreq->dev);
+	devfreq_remove_device(devfreq);
 	devfreq = NULL;
 err_dev:
 	if (devfreq)
@@ -693,6 +689,9 @@ int devfreq_remove_device(struct devfreq *devfreq)
 	if (!devfreq)
 		return -EINVAL;
 
+	if (devfreq->governor)
+		devfreq->governor->event_handler(devfreq,
+						 DEVFREQ_GOV_STOP, NULL);
 	device_unregister(&devfreq->dev);
 
 	return 0;
-- 
1.9.1
