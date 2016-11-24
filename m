From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 4/6] PM / devfreq: Remove the duplicate sysfs entry for current
 frequency
Date: Thu, 24 Nov 2016 14:01:06 +0900
Message-ID: <1479963668-22845-5-git-send-email-cw00.choi@samsung.com>
References: <1479963668-22845-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1479963668-22845-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rjw@rjwysocki.net, chanwoo@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch removes the duplicate 'target_freq' entry which shows the current
frequency of devfreq device. The 'cur_freq' entry has the same information.

Following two sysfs entry provide the same information to user-process.
Usually, the 'cur_freq' is more universal expression than 'target_freq'
such as cpufreq subsystem. This patch removes the 'target_freq' entry.
- /sys/class/devfreq/[devfreq name]/cur_freq
- /sys/class/devfreq/[devfreq name]/target_freq

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 4d2b7e5b8d3c..3eaa7b5d1c91 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -999,13 +999,6 @@ static ssize_t cur_freq_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(cur_freq);
 
-static ssize_t target_freq_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "%lu\n", to_devfreq(dev)->previous_freq);
-}
-static DEVICE_ATTR_RO(target_freq);
-
 static ssize_t polling_interval_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
@@ -1181,7 +1174,6 @@ static ssize_t trans_stat_show(struct device *dev,
 	&dev_attr_available_governors.attr,
 	&dev_attr_cur_freq.attr,
 	&dev_attr_available_frequencies.attr,
-	&dev_attr_target_freq.attr,
 	&dev_attr_polling_interval.attr,
 	&dev_attr_min_freq.attr,
 	&dev_attr_max_freq.attr,
-- 
1.9.1
