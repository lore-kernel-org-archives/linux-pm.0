From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] PM / devfreq: Add proper locking around list_del()
Date: Wed, 28 Sep 2016 17:17:56 +0800
Message-ID: <1475054276-29528-1-git-send-email-axel.lin@ingics.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35204 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754076AbcI1JSP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Sep 2016 05:18:15 -0400
Received: by mail-pa0-f67.google.com with SMTP id j3so1833200paj.2
        for <linux-pm@vger.kernel.org>; Wed, 28 Sep 2016 02:18:15 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Axel Lin <axel.lin@ingics.com>

Use devfreq_list_lock around list_del() to prevent list corruption.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/devfreq/devfreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 478006b..70369b0 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -604,7 +604,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	return devfreq;
 
 err_init:
+	mutex_lock(&devfreq_list_lock);
 	list_del(&devfreq->node);
+	mutex_unlock(&devfreq_list_lock);
+
 	device_unregister(&devfreq->dev);
 err_out:
 	return ERR_PTR(err);
-- 
2.7.4

