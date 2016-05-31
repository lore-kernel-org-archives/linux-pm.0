From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 12/15] thermal: sysfs: lock cdev while accessing max_state
Date: Mon, 30 May 2016 23:31:33 -0700
Message-ID: <1464676296-5610-13-git-send-email-edubezval@gmail.com>
References: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36108 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162133AbcEaGc3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 02:32:29 -0400
In-Reply-To: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Serialized calls to cdev->ops in user facing
sysfs handler thermal_cooling_device_max_state_show().

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 044090a..3eaa081 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -699,7 +699,9 @@ thermal_cooling_device_max_state_show(struct device *dev,
 	unsigned long state;
 	int ret;
 
+	mutex_lock(&cdev->lock);
 	ret = cdev->ops->get_max_state(cdev, &state);
+	mutex_unlock(&cdev->lock);
 	if (ret)
 		return ret;
 	return sprintf(buf, "%ld\n", state);
-- 
2.1.4

