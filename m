From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 3/6] PM / devfreq: Add show_one macro to delete the duplicate
 code
Date: Thu, 19 Nov 2015 17:17:47 +0900
Message-ID: <1447921070-6045-4-git-send-email-cw00.choi@samsung.com>
References: <1447921070-6045-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:39728 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756094AbbKSIR7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2015 03:17:59 -0500
In-reply-to: <1447921070-6045-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>

This patch adds the 'show_one' macro to simplify the duplicate code
of both max_freq_show() and min_freq_show().

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index ca848cc6a8fd..49fc7dcf664c 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -921,12 +921,6 @@ unlock:
 	return ret;
 }
 
-static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
-			     char *buf)
-{
-	return sprintf(buf, "%lu\n", to_devfreq(dev)->min_freq);
-}
-
 static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
@@ -953,13 +947,17 @@ unlock:
 	mutex_unlock(&df->lock);
 	return ret;
 }
-static DEVICE_ATTR_RW(min_freq);
 
-static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
-			     char *buf)
-{
-	return sprintf(buf, "%lu\n", to_devfreq(dev)->max_freq);
+#define show_one(name)						\
+static ssize_t name##_show					\
+(struct device *dev, struct device_attribute *attr, char *buf)	\
+{								\
+	return sprintf(buf, "%lu\n", to_devfreq(dev)->name);	\
 }
+show_one(min_freq);
+show_one(max_freq);
+
+static DEVICE_ATTR_RW(min_freq);
 static DEVICE_ATTR_RW(max_freq);
 
 static ssize_t available_frequencies_show(struct device *d,
-- 
1.9.1

