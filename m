From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 10/12] PM / devfreq: Remove 'devfreq' prefix from helper
 function
Date: Thu, 24 Aug 2017 10:42:57 +0900
Message-ID: <1503538979-22693-11-git-send-email-cw00.choi@samsung.com>
References: <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
        <CGME20170824014300epcas2p452c864106cf4fd9754d075d57b8a9ca1@epcas2p4.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:45183 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbdHXBnC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Aug 2017 21:43:02 -0400
In-reply-to: <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

This patch just removes the 'devfreq' prefix from internal helper
function in order to clarify the role of the following functions.
- devfreq_get_freq_level() - get_freq_level()
- devfreq_set_freq_table() - set_freq_table()

Also, this patch changes the return value of set_freq_table()
from 'void' to 'int' and then removes the function description
of internal helper function. Because the internal helper function
is used by the devfreq core.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index d8ff16419452..77eb3edf6bf3 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -116,12 +116,7 @@ static int is_supported_freq(struct devfreq *devfreq, unsigned long freq)
 	return ret;
 }
 
-/**
- * devfreq_get_freq_level() - Lookup freq_table for the frequency
- * @devfreq:	the devfreq instance
- * @freq:	the target frequency
- */
-static int devfreq_get_freq_level(struct devfreq *devfreq, unsigned long freq)
+static int get_freq_level(struct devfreq *devfreq, unsigned long freq)
 {
 	int lev;
 
@@ -132,11 +127,7 @@ static int devfreq_get_freq_level(struct devfreq *devfreq, unsigned long freq)
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
@@ -146,7 +137,7 @@ static void devfreq_set_freq_table(struct devfreq *devfreq)
 	/* Initialize the freq_table from OPP table */
 	count = dev_pm_opp_get_opp_count(devfreq->dev.parent);
 	if (count <= 0)
-		return;
+		return count;
 
 	profile->max_state = count;
 	profile->freq_table = devm_kcalloc(devfreq->dev.parent,
@@ -155,7 +146,7 @@ static void devfreq_set_freq_table(struct devfreq *devfreq)
 					GFP_KERNEL);
 	if (!profile->freq_table) {
 		profile->max_state = 0;
-		return;
+		return -ENOMEM;
 	}
 
 	for (i = 0, freq = 0; i < profile->max_state; i++, freq++) {
@@ -163,11 +154,13 @@ static void devfreq_set_freq_table(struct devfreq *devfreq)
 		if (IS_ERR(opp)) {
 			devm_kfree(devfreq->dev.parent, profile->freq_table);
 			profile->max_state = 0;
-			return;
+			return -EINVAL;
 		}
 		dev_pm_opp_put(opp);
 		profile->freq_table[i] = freq;
 	}
+
+	return 0;
 }
 
 /**
@@ -186,7 +179,7 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 	if (!devfreq->previous_freq)
 		goto out;
 
-	prev_lev = devfreq_get_freq_level(devfreq, devfreq->previous_freq);
+	prev_lev = get_freq_level(devfreq, devfreq->previous_freq);
 	if (prev_lev < 0) {
 		ret = prev_lev;
 		goto out;
@@ -195,7 +188,7 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 	devfreq->time_in_state[prev_lev] +=
 			 cur_time - devfreq->last_stat_updated;
 
-	lev = devfreq_get_freq_level(devfreq, freq);
+	lev = get_freq_level(devfreq, freq);
 	if (lev < 0) {
 		ret = lev;
 		goto out;
@@ -600,8 +593,13 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->data = data;
 	devfreq->nb.notifier_call = devfreq_notifier_call;
 
-	if (!devfreq->profile->max_state && !devfreq->profile->freq_table)
-		devfreq_set_freq_table(devfreq);
+	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
+		err = set_freq_table(devfreq);
+		if (err < 0) {
+			mutex_unlock(&devfreq->lock);
+			goto err_dev;
+		}
+	}
 
 	/* Set the scaling available min_freq and max_freq */
 	devfreq->min_freq = find_available_min_freq(devfreq);
-- 
1.9.1
