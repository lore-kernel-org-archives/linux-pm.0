From: zhong jiang <zhongjiang@huawei.com>
Subject: [PATCH] PM / devfreq: remove redundant null pointer check before kfree
Date: Fri, 21 Sep 2018 21:18:43 +0800
Message-ID: <1537535923-46240-1-git-send-email-zhongjiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: cw00.choi@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

kfree has taken the null pointer into account. hence it is safe
to remove the redundant null pointer check before kfree.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/devfreq/devfreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 4c49bb1..c37021d 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -675,8 +675,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	device_unregister(&devfreq->dev);
 	devfreq = NULL;
 err_dev:
-	if (devfreq)
-		kfree(devfreq);
+	kfree(devfreq);
 err_out:
 	return ERR_PTR(err);
 }
-- 
1.7.12.4
