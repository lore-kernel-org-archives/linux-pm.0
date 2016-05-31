From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 13/15] thermal: sysfs: lock cdev while accessing cur_state
Date: Mon, 30 May 2016 23:31:34 -0700
Message-ID: <1464676296-5610-14-git-send-email-edubezval@gmail.com>
References: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36142 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162141AbcEaGca (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 02:32:30 -0400
In-Reply-To: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Serialized calls to cdev->ops in user facing
sysfs handlers thermal_cooling_device_cur_state_show()
and thermal_cooling_device_cur_state_store().

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 3eaa081..ab78e08 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -715,7 +715,9 @@ thermal_cooling_device_cur_state_show(struct device *dev,
 	unsigned long state;
 	int ret;
 
+	mutex_lock(&cdev->lock);
 	ret = cdev->ops->get_cur_state(cdev, &state);
+	mutex_unlock(&cdev->lock);
 	if (ret)
 		return ret;
 	return sprintf(buf, "%ld\n", state);
@@ -736,7 +738,9 @@ thermal_cooling_device_cur_state_store(struct device *dev,
 	if ((long)state < 0)
 		return -EINVAL;
 
+	mutex_lock(&cdev->lock);
 	result = cdev->ops->set_cur_state(cdev, state);
+	mutex_unlock(&cdev->lock);
 	if (result)
 		return result;
 	return count;
-- 
2.1.4

