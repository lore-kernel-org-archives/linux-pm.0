From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 06/12] PM / devfreq: Check the entered min/max_freq is
 supported or not
Date: Thu, 24 Aug 2017 10:42:53 +0900
Message-ID: <1503538979-22693-7-git-send-email-cw00.choi@samsung.com>
References: <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
        <CGME20170824014259epcas2p1c8618349053a9aab5d8774234e322848@epcas2p1.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:45174 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbdHXBnB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Aug 2017 21:43:01 -0400
In-reply-to: <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

The existing {min|max}_freq_store() only check the range of
entered frequency. If the unsupported frequency is entered
and the entered frequency is within the ranges, {min|max}_freq_store()
will store it to devfreq->{min|max}_freq. And then when some user
try to read the {min|max}_freq, the devfreq show the unsupported
frequency value.

In order to fix this issue, this patch checks whether the entered
frequency is supported or not by OPP interface.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 56f8a0473834..f10017fe400f 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -97,6 +97,25 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
 	return max_freq;
 }
 
+static int is_supported_freq(struct devfreq *devfreq, unsigned long freq)
+{
+	struct device *dev = devfreq->dev.parent;
+	struct dev_pm_opp *opp;
+	int ret = 0;
+
+	/* Check whether entered frequency is supported or not */
+	opp = dev_pm_opp_find_freq_exact(dev, freq, true);
+	if (PTR_ERR(opp) == -ERANGE)
+		opp = dev_pm_opp_find_freq_exact(dev, freq, false);
+
+	if (IS_ERR(opp))
+		ret = PTR_ERR(opp);
+
+	dev_pm_opp_put(opp);
+
+	return ret;
+}
+
 /**
  * devfreq_get_freq_level() - Lookup freq_table for the frequency
  * @devfreq:	the devfreq instance
@@ -1099,9 +1118,8 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
 	struct devfreq *df = to_devfreq(dev);
-	unsigned long value;
+	unsigned long value, max;
 	int ret;
-	unsigned long max;
 
 	ret = sscanf(buf, "%lu", &value);
 	if (ret != 1)
@@ -1114,6 +1132,11 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
 		goto unlock;
 	}
 
+	/* Check whether entered frequency is supported or not */
+	ret = is_supported_freq(df, value);
+	if (ret < 0)
+		goto unlock;
+
 	df->min_freq = value;
 	update_devfreq(df);
 	ret = count;
@@ -1126,9 +1149,8 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
 	struct devfreq *df = to_devfreq(dev);
-	unsigned long value;
+	unsigned long value, min;
 	int ret;
-	unsigned long min;
 
 	ret = sscanf(buf, "%lu", &value);
 	if (ret != 1)
@@ -1141,6 +1163,11 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
 		goto unlock;
 	}
 
+	/* Check whether entered frequency is supported or not */
+	ret = is_supported_freq(df, value);
+	if (ret < 0)
+		goto unlock;
+
 	df->max_freq = value;
 	update_devfreq(df);
 	ret = count;
-- 
1.9.1
