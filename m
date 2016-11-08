From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 33/49] thermal: core: fix couple of style issues on __bind() helper
Date: Mon,  7 Nov 2016 21:09:11 -0800
Message-ID: <1478581767-7009-34-git-send-email-edubezval@gmail.com>
References: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35391 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932373AbcKHFKw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Nov 2016 00:10:52 -0500
In-Reply-To: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Removing style issues on __bind() and its helpers.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index bff2905..ebec7ce 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -287,16 +287,16 @@ static void thermal_unregister_governors(void)
 }
 
 static void print_bind_err_msg(struct thermal_zone_device *tz,
-			struct thermal_cooling_device *cdev, int ret)
+			       struct thermal_cooling_device *cdev, int ret)
 {
 	dev_err(&tz->device, "binding zone %s with cdev %s failed:%d\n",
-				tz->type, cdev->type, ret);
+		tz->type, cdev->type, ret);
 }
 
 static void __bind(struct thermal_zone_device *tz, int mask,
-			struct thermal_cooling_device *cdev,
-			unsigned long *limits,
-			unsigned int weight)
+		   struct thermal_cooling_device *cdev,
+		   unsigned long *limits,
+		   unsigned int weight)
 {
 	int i, ret;
 
-- 
2.1.4

