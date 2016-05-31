From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 01/15] thermal: sysfs: lock tz in type_show
Date: Mon, 30 May 2016 23:31:22 -0700
Message-ID: <1464676296-5610-2-git-send-email-edubezval@gmail.com>
References: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35610 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755525AbcEaGby (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 02:31:54 -0400
In-Reply-To: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Avoid race while accessing tz->type.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_sysfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 4136b71..ee983ca 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -29,8 +29,13 @@ static ssize_t
 type_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	char *type;
 
-	return sprintf(buf, "%s\n", tz->type);
+	mutex_lock(&tz->lock);
+	type = tz->type;
+	mutex_unlock(&tz->lock);
+
+	return sprintf(buf, "%s\n", type);
 }
 
 static ssize_t
-- 
2.1.4

