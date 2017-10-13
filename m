From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v4 4/8] PM / devfreq: Change return type of
 devfreq_set_freq_table()
Date: Fri, 13 Oct 2017 16:48:20 +0900
Message-ID: <1507880904-31956-5-git-send-email-cw00.choi@samsung.com>
References: <1507880904-31956-1-git-send-email-cw00.choi@samsung.com>
        <CGME20171013074833epcas1p24b7e56770d8199dd12972de1c8447007@epcas1p2.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:20216 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757014AbdJMHsg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2017 03:48:36 -0400
In-reply-to: <1507880904-31956-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

This patch changes the return type of devfreq_set_freq_table()
from 'void' to 'int' in order to check whether it fails or not.

And This patch just removes the 'devfreq' prefix and the description
of function. Because the helper functions are only used by the devfreq.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 9de013ffeb67..909cedef7caa 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -116,11 +116,7 @@ static int devfreq_get_freq_level(struct devfreq *devfreq, unsigned long freq)
 	return -EINVAL;
 }
 
-/**
- * devfreq_set_freq_table() - Initialize freq_table for the frequency
- * @devfreq:	the devfreq instance
- */
-static void devfreq_set_freq_table(struct devfreq *devfreq)
+static int set_freq_table(struct devfreq *devfreq)
 {
 	struct devfreq_dev_profile *profile = devfreq->profile;
 	struct dev_pm_opp *opp;
@@ -130,7 +126,7 @@ static void devfreq_set_freq_table(struct devfreq *devfreq)
 	/* Initialize the freq_table from OPP table */
 	count = dev_pm_opp_get_opp_count(devfreq->dev.parent);
 	if (count <= 0)
-		return;
+		return -EINVAL;
 
 	profile->max_state = count;
 	profile->freq_table = devm_kcalloc(devfreq->dev.parent,
@@ -139,7 +135,7 @@ static void devfreq_set_freq_table(struct devfreq *devfreq)
 					GFP_KERNEL);
 	if (!profile->freq_table) {
 		profile->max_state = 0;
-		return;
+		return -ENOMEM;
 	}
 
 	for (i = 0, freq = 0; i < profile->max_state; i++, freq++) {
@@ -147,11 +143,13 @@ static void devfreq_set_freq_table(struct devfreq *devfreq)
 		if (IS_ERR(opp)) {
 			devm_kfree(devfreq->dev.parent, profile->freq_table);
 			profile->max_state = 0;
-			return;
+			return PTR_ERR(opp);
 		}
 		dev_pm_opp_put(opp);
 		profile->freq_table[i] = freq;
 	}
+
+	return 0;
 }
 
 /**
@@ -601,7 +599,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
 		mutex_unlock(&devfreq->lock);
-		devfreq_set_freq_table(devfreq);
+		err = set_freq_table(devfreq);
+		if (err < 0)
+			goto err_out;
 		mutex_lock(&devfreq->lock);
 	}
 
-- 
1.9.1
