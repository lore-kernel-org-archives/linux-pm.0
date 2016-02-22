From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: governors: Drop unnecessary checks from show() and store()
Date: Mon, 22 Feb 2016 14:18:20 +0530
Message-ID: <306e197065818fbd8d696fbe2071ccb39682a775.1456130856.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36164 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753544AbcBVIss (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2016 03:48:48 -0500
Received: by mail-pf0-f173.google.com with SMTP id e127so89491913pfe.3
        for <linux-pm@vger.kernel.org>; Mon, 22 Feb 2016 00:48:48 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

The show() and store() routines in the cpufreq-governor core don't need
to check if the struct governor_attr they want to use really provides
the callbacks they need as expected (if that's not the case, it means a
bug in the code anyway), so change them to avoid doing that.

Also change the error value to -EBUSY, if the governor is getting
removed and we aren't allowed to store any more changes.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index aeb5ad81d869..528cd7a49398 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -125,12 +125,8 @@ static ssize_t governor_show(struct kobject *kobj, struct attribute *attr,
 {
 	struct dbs_data *dbs_data = to_dbs_data(kobj);
 	struct governor_attr *gattr = to_gov_attr(attr);
-	int ret = -EIO;
 
-	if (gattr->show)
-		ret = gattr->show(dbs_data, buf);
-
-	return ret;
+	return gattr->show(dbs_data, buf);
 }
 
 static ssize_t governor_store(struct kobject *kobj, struct attribute *attr,
@@ -138,11 +134,11 @@ static ssize_t governor_store(struct kobject *kobj, struct attribute *attr,
 {
 	struct dbs_data *dbs_data = to_dbs_data(kobj);
 	struct governor_attr *gattr = to_gov_attr(attr);
-	int ret = -EIO;
+	int ret = -EBUSY;
 
 	mutex_lock(&dbs_data->mutex);
 
-	if (dbs_data->usage_count && gattr->store)
+	if (dbs_data->usage_count)
 		ret = gattr->store(dbs_data, buf, count);
 
 	mutex_unlock(&dbs_data->mutex);
-- 
2.7.1.410.g6faf27b

