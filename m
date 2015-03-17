From: Deva Ramasubramanian <dramasub@codeaurora.org>
Subject: [PATCH] PM / devfreq: Fix faulty error message
Date: Tue, 17 Mar 2015 13:59:26 -0700
Message-ID: <1426625966-22187-1-git-send-email-dramasub@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48713 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754316AbbCQVAM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Mar 2015 17:00:12 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: Deva Ramasubramanian <dramasub@codeaurora.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

The misleading log "releasing devfreq which doesn't exist" prints out
for well behaved clients.  This is due to the fact that _remove_devfreq
calls itself recursively by proxy (via put_device()).  The second time
_devfreq_remove is called the respective device has already been
deleted, causing the misleading warning.

So just skip printing the message if _devfreq_remove was called via
put_device().

Signed-off-by: Deva Ramasubramanian <dramasub@codeaurora.org>
---
 drivers/devfreq/devfreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 30b538d8..bee59db 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -399,7 +399,8 @@ static void _remove_devfreq(struct devfreq *devfreq)
 	mutex_lock(&devfreq_list_lock);
 	if (IS_ERR(find_device_devfreq(devfreq->dev.parent))) {
 		mutex_unlock(&devfreq_list_lock);
-		dev_warn(&devfreq->dev, "releasing devfreq which doesn't exist\n");
+		if (!skip)
+			dev_warn(&devfreq->dev, "releasing devfreq which doesn't exist\n");
 		return;
 	}
 	list_del(&devfreq->node);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

