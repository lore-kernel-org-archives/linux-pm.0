From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 07/12] Revert
 "PM / devfreq: Add show_one macro to delete the duplicate code"
Date: Thu, 24 Aug 2017 10:42:54 +0900
Message-ID: <1503538979-22693-8-git-send-email-cw00.choi@samsung.com>
References: <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
        <CGME20170824014300epcas2p3069258855c2e233ab4c01745eae93a73@epcas2p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
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
index f10017fe400f..be3d42f140ff 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1145,6 +1145,12 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
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
@@ -1175,17 +1181,13 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
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
