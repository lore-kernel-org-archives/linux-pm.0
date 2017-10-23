From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v5 2/7] Revert
 "PM / devfreq: Add show_one macro to delete the duplicate code"
Date: Mon, 23 Oct 2017 10:32:07 +0900
Message-ID: <1508722332-10628-3-git-send-email-cw00.choi@samsung.com>
References: <1508722332-10628-1-git-send-email-cw00.choi@samsung.com>
        <CGME20171023013214epcas1p341c10076a9dfdea26510c12fac0d723a@epcas1p3.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:30130 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932171AbdJWBe7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Oct 2017 21:34:59 -0400
In-reply-to: <1508722332-10628-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

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
index 6a6f88bccdee..b6ba24e5db0d 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1124,6 +1124,12 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
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
@@ -1150,17 +1156,13 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
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
