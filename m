From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 5/5] opp: do error handling at the bottom of dev_pm_opp_add_dynamic()
Date: Wed, 10 Dec 2014 09:45:35 +0530
Message-ID: <8af17569020172e735177b13fa088c34ab4e7619.1418184737.git.viresh.kumar@linaro.org>
References: <0a31e317c90f601f77cc21b80455633928c70c96.1418184737.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:44613 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755310AbaLJEQZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Dec 2014 23:16:25 -0500
Received: by mail-pa0-f47.google.com with SMTP id kq14so1958087pab.34
        for <linux-pm@vger.kernel.org>; Tue, 09 Dec 2014 20:16:24 -0800 (PST)
In-Reply-To: <0a31e317c90f601f77cc21b80455633928c70c96.1418184737.git.viresh.kumar@linaro.org>
In-Reply-To: <0a31e317c90f601f77cc21b80455633928c70c96.1418184737.git.viresh.kumar@linaro.org>
References: <0a31e317c90f601f77cc21b80455633928c70c96.1418184737.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

This makes it less error prone and moves common resource deallocation at a
single place.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 1150b9d2e012..d24dd614a0bd 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -413,6 +413,7 @@ static int dev_pm_opp_add_dynamic(struct device *dev, unsigned long freq,
 	struct device_opp *dev_opp = NULL;
 	struct dev_pm_opp *opp, *new_opp;
 	struct list_head *head;
+	int ret;
 
 	/* allocate new OPP node */
 	new_opp = kzalloc(sizeof(*new_opp), GFP_KERNEL);
@@ -435,9 +436,8 @@ static int dev_pm_opp_add_dynamic(struct device *dev, unsigned long freq,
 	if (IS_ERR(dev_opp)) {
 		dev_opp = add_device_opp(dev);
 		if (!dev_opp) {
-			mutex_unlock(&dev_opp_list_lock);
-			kfree(new_opp);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto free_opp;
 		}
 
 		head = &dev_opp->opp_list;
@@ -458,15 +458,13 @@ static int dev_pm_opp_add_dynamic(struct device *dev, unsigned long freq,
 
 	/* Duplicate OPPs ? */
 	if (new_opp->rate == opp->rate) {
-		int ret = opp->available && new_opp->u_volt == opp->u_volt ?
+		ret = opp->available && new_opp->u_volt == opp->u_volt ?
 			0 : -EEXIST;
 
 		dev_warn(dev, "%s: duplicate OPPs detected. Existing: freq: %lu, volt: %lu, enabled: %d. New: freq: %lu, volt: %lu, enabled: %d\n",
 			 __func__, opp->rate, opp->u_volt, opp->available,
 			 new_opp->rate, new_opp->u_volt, new_opp->available);
-		mutex_unlock(&dev_opp_list_lock);
-		kfree(new_opp);
-		return ret;
+		goto free_opp;
 	}
 
 list_add:
@@ -480,6 +478,11 @@ static int dev_pm_opp_add_dynamic(struct device *dev, unsigned long freq,
 	 */
 	srcu_notifier_call_chain(&dev_opp->srcu_head, OPP_EVENT_ADD, new_opp);
 	return 0;
+
+free_opp:
+	mutex_unlock(&dev_opp_list_lock);
+	kfree(new_opp);
+	return ret;
 }
 
 /**
-- 
2.2.0

