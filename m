From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH] PM / devfreq: fix double kfree
Date: Thu,  1 Oct 2015 22:18:19 +0800
Message-ID: <bc9a3c0005e8504a2a98a3f79aa65d5f4dbf74d0.1443708993.git.geliangtang@163.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from m50-138.163.com ([123.125.50.138]:60834 "EHLO m50-138.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755000AbbJAOSf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 1 Oct 2015 10:18:35 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: Geliang Tang <geliangtang@163.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

When device_register() fails, kfree(devfreq) is called already in
devfreq_dev_release(), hence there is no need to call kfree(devfreq)
in err_dev again.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/devfreq/devfreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 3927ed9..9b352da 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -492,7 +492,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	if (err) {
 		put_device(&devfreq->dev);
 		mutex_unlock(&devfreq->lock);
-		goto err_dev;
+		goto err_out;
 	}
 
 	mutex_unlock(&devfreq->lock);
@@ -518,7 +518,6 @@ struct devfreq *devfreq_add_device(struct device *dev,
 err_init:
 	list_del(&devfreq->node);
 	device_unregister(&devfreq->dev);
-err_dev:
 	kfree(devfreq);
 err_out:
 	return ERR_PTR(err);
-- 
2.5.0


