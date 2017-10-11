From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v3 3/8] PM / devfreq: Show the available min/max frequency
 through sysfs node
Date: Wed, 11 Oct 2017 12:09:19 +0900
Message-ID: <1507691364-3899-4-git-send-email-cw00.choi@samsung.com>
References: <1507691364-3899-1-git-send-email-cw00.choi@samsung.com>
        <CGME20171011030946epcas1p40f32955da5dada46e95302701a0afb7d@epcas1p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1507691364-3899-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The existing {min|max}_freq sysfs nodes don't consider whether min/max_freq
are available or not. Those sysfs nodes show just the stored value
in the struct devfreq.

The devfreq uses the OPP interface and then dev_pm_opp_{disable|add}()
might change the state of the device's supported frequency. This patch
shows the available minimum and maximum frequency through sysfs node.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 2ce1fd0a1324..799a0cf75d39 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1128,7 +1128,14 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
 static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
-	return sprintf(buf, "%lu\n", to_devfreq(dev)->min_freq);
+	struct devfreq *df = to_devfreq(dev);
+	unsigned long min_freq = to_devfreq(dev)->min_freq;
+	unsigned long available_min_freq = find_available_min_freq(df);
+
+	if (available_min_freq != 0 && min_freq < available_min_freq)
+		min_freq = available_min_freq;
+
+	return sprintf(buf, "%lu\n", min_freq);
 }
 
 static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
@@ -1162,7 +1169,14 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
 static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
-	return sprintf(buf, "%lu\n", to_devfreq(dev)->max_freq);
+	struct devfreq *df = to_devfreq(dev);
+	unsigned long max_freq = to_devfreq(dev)->max_freq;
+	unsigned long available_max_freq = find_available_max_freq(df);
+
+	if (available_max_freq != 0 && max_freq > available_max_freq)
+		max_freq = available_max_freq;
+
+	return sprintf(buf, "%lu\n", max_freq);
 }
 static DEVICE_ATTR_RW(max_freq);
 
-- 
1.9.1
