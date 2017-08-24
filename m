From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 08/12] PM / devfreq: Show the available min/max frequency
 through sysfs node
Date: Thu, 24 Aug 2017 10:42:55 +0900
Message-ID: <1503538979-22693-9-git-send-email-cw00.choi@samsung.com>
References: <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
        <CGME20170824014300epcas1p442352e3d95c164aa023bf16120e7f7a4@epcas1p4.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:29206 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbdHXBnC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Aug 2017 21:43:02 -0400
In-reply-to: <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

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
index be3d42f140ff..8b0bbfa0a50b 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1148,7 +1148,14 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
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
@@ -1186,7 +1193,14 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
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
