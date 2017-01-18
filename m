From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 1/3] PM / devfreq: Fix available_governor sysfs
Date: Wed, 18 Jan 2017 15:56:49 +0900
Message-ID: <1484722611-10555-2-git-send-email-cw00.choi@samsung.com>
References: <1484722611-10555-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170118065653epcas5p2b1b4a964772e300b56356a26ec5cb9e5@epcas5p2.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:54626 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbdARG4z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2017 01:56:55 -0500
In-reply-to: <1484722611-10555-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net
Cc: cw00.choi@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

The devfreq using passive governor is not able to change the governor.
So, the user can not change the governor through 'available_governor' sysfs
entry. Also, the devfreq which don't use the passive governor is not able to
change to 'passive' governor on the fly.

Fixes: 996133119f57 ("PM / devfreq: Add new passive governor")
Cc: stable@vger.kernel.org
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 4bd7a8f71b07..a2c575a5a9ab 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -43,6 +43,11 @@
 static LIST_HEAD(devfreq_list);
 static DEFINE_MUTEX(devfreq_list_lock);
 
+static int is_passive_gov(const char *governor_name)
+{
+	return (!strncmp(governor_name, "passive", 7)) ? 1 : 0;
+}
+
 /**
  * find_device_devfreq() - find devfreq struct using device pointer
  * @dev:	device pointer used to lookup device devfreq.
@@ -933,6 +938,10 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	if (ret != 1)
 		return -EINVAL;
 
+	/* The passive devfreq is not able to change the governor. */
+	if (is_passive_gov(df->governor_name))
+		return 0;
+
 	mutex_lock(&devfreq_list_lock);
 	governor = find_devfreq_governor(str_governor);
 	if (IS_ERR(governor)) {
@@ -972,12 +981,35 @@ static ssize_t available_governors_show(struct device *d,
 					char *buf)
 {
 	struct devfreq_governor *tmp_governor;
+	struct devfreq *df = to_devfreq(d);
 	ssize_t count = 0;
 
 	mutex_lock(&devfreq_list_lock);
-	list_for_each_entry(tmp_governor, &devfreq_governor_list, node)
+
+	/*
+	 * The passive devfreq shows only passive governor.
+	 * The governor except for passive are not available
+	 * for passive devfreq device.
+	 */
+	if (is_passive_gov(df->governor_name)) {
+		count += scnprintf(&buf[count], (PAGE_SIZE - count - 2),
+				   "%s ", df->governor_name);
+		goto out;
+	}
+
+	/*
+	 * The devfreq device show the registered governor except for
+	 * 'passive' governor.
+	 */
+	list_for_each_entry(tmp_governor, &devfreq_governor_list, node) {
+		if (is_passive_gov(tmp_governor->name))
+			continue;
+
 		count += scnprintf(&buf[count], (PAGE_SIZE - count - 2),
 				   "%s ", tmp_governor->name);
+	}
+
+out:
 	mutex_unlock(&devfreq_list_lock);
 
 	/* Truncate the trailing space */
-- 
1.9.1

