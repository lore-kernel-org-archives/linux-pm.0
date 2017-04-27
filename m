From: Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH] devfreq: do not ignore errors during store min, max frequency
Date: Thu, 27 Apr 2017 09:23:47 +0100
Message-ID: <1493281427-8671-1-git-send-email-lukasz.luba@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34896 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935983AbdD0IYP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Apr 2017 04:24:15 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: cw00.choi@samsung.com, kyungmin.park@samsung.com, myungjoo.ham@samsung.com, Lukasz Luba <lukasz.luba@arm.com>

This patch adds functionality to make sure when a call to set a new
max or min frequency is possible.
If storing the new value was not possible, restore previous one
and forward the error value.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
It is based on v4.11-rc8.

 drivers/devfreq/devfreq.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index dea0487..8586035 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1059,6 +1059,7 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
 	unsigned long value;
 	int ret;
 	unsigned long max;
+	unsigned long old_min;
 
 	ret = sscanf(buf, "%lu", &value);
 	if (ret != 1)
@@ -1071,9 +1072,22 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
 		goto unlock;
 	}
 
+	ret = devfreq_get_freq_level(df, value);
+	if (ret < 0) {
+		dev_warn(dev, "Storing min freq failed with (%d) error\n", ret);
+		goto unlock;
+	}
+
+	old_min = df->min_freq;
 	df->min_freq = value;
-	update_devfreq(df);
-	ret = count;
+	ret = update_devfreq(df);
+	if (ret) {
+		df->min_freq = old_min;
+		dev_warn(dev, "Storing min freq failed with (%d) error\n", ret);
+	} else {
+		ret = count;
+	}
+
 unlock:
 	mutex_unlock(&df->lock);
 	return ret;
@@ -1086,6 +1100,7 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
 	unsigned long value;
 	int ret;
 	unsigned long min;
+	unsigned long old_max;
 
 	ret = sscanf(buf, "%lu", &value);
 	if (ret != 1)
@@ -1098,9 +1113,22 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
 		goto unlock;
 	}
 
+	ret = devfreq_get_freq_level(df, value);
+	if (ret < 0) {
+		dev_warn(dev, "Storing max freq failed with (%d) error\n", ret);
+		goto unlock;
+	}
+
+	old_max = df->max_freq;
 	df->max_freq = value;
-	update_devfreq(df);
-	ret = count;
+	ret = update_devfreq(df);
+	if (ret) {
+		df->max_freq = old_max;
+		dev_warn(dev, "Storing max freq failed with (%d) error\n", ret);
+	} else {
+		ret = count;
+	}
+
 unlock:
 	mutex_unlock(&df->lock);
 	return ret;
-- 
1.9.1
