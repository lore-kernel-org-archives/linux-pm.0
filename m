From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v4 2/8] Revert
 "PM / devfreq: Add show_one macro to delete the duplicate code"
Date: Fri, 13 Oct 2017 16:48:18 +0900
Message-ID: <1507880904-31956-3-git-send-email-cw00.choi@samsung.com>
References: <1507880904-31956-1-git-send-email-cw00.choi@samsung.com>
        <CGME20171013074832epcas2p1eac142dd59d78667e9a98be78d9487b1@epcas2p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1507880904-31956-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

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
