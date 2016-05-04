From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 27/31] thermal: core: add inline to print_bind_err_msg()
Date: Tue,  3 May 2016 23:02:41 -0700
Message-ID: <1462341765-13268-28-git-send-email-edubezval@gmail.com>
References: <1462341765-13268-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33986 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757334AbcEDGDe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 May 2016 02:03:34 -0400
In-Reply-To: <1462341765-13268-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Given that this is simple wrapper, adding the inline flag.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d836a90..609c3be 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -770,7 +770,7 @@ static struct class thermal_class = {
 	.dev_release = thermal_release,
 };
 
-static void print_bind_err_msg(struct thermal_zone_device *tz,
+static inline void print_bind_err_msg(struct thermal_zone_device *tz,
 			struct thermal_cooling_device *cdev, int ret)
 {
 	dev_err(&tz->device, "binding zone %s with cdev %s failed:%d\n",
-- 
2.1.4

