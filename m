From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v3 2/8] Revert
 "PM / devfreq: Add show_one macro to delete the duplicate code"
Date: Wed, 11 Oct 2017 12:09:18 +0900
Message-ID: <1507691364-3899-3-git-send-email-cw00.choi@samsung.com>
References: <1507691364-3899-1-git-send-email-cw00.choi@samsung.com>
        <CGME20171011030946epcas1p11592eaf29e9b9717ccf7a8965d8e2286@epcas1p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1507691364-3899-1-git-send-email-cw00.choi@samsung.com>
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
