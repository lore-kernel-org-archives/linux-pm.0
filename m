From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 2/8] Revert
 "PM / devfreq: Add show_one macro to delete the duplicate code"
Date: Thu, 21 Sep 2017 09:33:46 +0900
Message-ID: <1505954032-3327-3-git-send-email-cw00.choi@samsung.com>
References: <1505954032-3327-1-git-send-email-cw00.choi@samsung.com>
        <CGME20170921003355epcas1p4ecc54d2b7437b4e0d052d9b99647930e@epcas1p4.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:55650 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbdIUAd6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Sep 2017 20:33:58 -0400
In-reply-to: <1505954032-3327-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

This reverts commit 3104fa3081126c9bda35793af5f335d0ee0d5818.

The {min|max}_freq_show() show the stored value of the struct devfreq.
But, if the drivers/thermal/devfreq_cooling.c disables the specific
frequency value, {min|max}_freq_show() have to check this situation
before showing the stored value. So, this patch revert the macro
in order to add the additional codes.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index ae8717a6eee1..2ce1fd0a1324 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1125,6 +1125,12 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
 	return ret;
 }
 
+static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	return sprintf(buf, "%lu\n", to_devfreq(dev)->min_freq);
+}
+
 static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
@@ -1151,17 +1157,13 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
 	mutex_unlock(&df->lock);
 	return ret;
 }
+static DEVICE_ATTR_RW(min_freq);
 
-#define show_one(name)						\
-static ssize_t name##_show					\
-(struct device *dev, struct device_attribute *attr, char *buf)	\
-{								\
-	return sprintf(buf, "%lu\n", to_devfreq(dev)->name);	\
+static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	return sprintf(buf, "%lu\n", to_devfreq(dev)->max_freq);
 }
-show_one(min_freq);
-show_one(max_freq);
-
-static DEVICE_ATTR_RW(min_freq);
 static DEVICE_ATTR_RW(max_freq);
 
 static ssize_t available_frequencies_show(struct device *d,
-- 
1.9.1
