From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 01/12] PM / devfreq: Fix memory leak when fail to register
 device
Date: Thu, 24 Aug 2017 10:42:48 +0900
Message-ID: <1503538979-22693-2-git-send-email-cw00.choi@samsung.com>
References: <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
        <CGME20170824014259epcas2p398a53a9a76d9aff7e35cf8515ec4e46a@epcas2p3.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:20003 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbdHXBnB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Aug 2017 21:43:01 -0400
In-reply-to: <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, stable@vger.kernel.org

When the devfreq_add_device fails to register deivce, the memory
leak of devfreq instance happen. So, this patch fix the memory
leak issue. Before freeing the devfreq instance checks whether
devfreq instance is NULL or not because the device_unregister()
frees the devfreq instance when jumping to the 'err_init'.
It is to prevent the duplicate the kfee(devfreq).

Cc: stable@vger.kernel.org
Fixes: ac4b281176a5 ("PM / devfreq: fix duplicated kfree on devfreq pointer")
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index dea04871b50d..a1c4ee818614 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -564,7 +564,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	err = device_register(&devfreq->dev);
 	if (err) {
 		mutex_unlock(&devfreq->lock);
-		goto err_out;
+		goto err_dev;
 	}
 
 	devfreq->trans_table =	devm_kzalloc(&devfreq->dev,
@@ -610,6 +610,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	mutex_unlock(&devfreq_list_lock);
 
 	device_unregister(&devfreq->dev);
+err_dev:
+	if (devfreq)
+		kfree(devfreq);
 err_out:
 	return ERR_PTR(err);
 }
-- 
1.9.1
