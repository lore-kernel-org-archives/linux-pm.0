From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] thermal: max77620: constify platform_device_id
Date: Sun, 13 Aug 2017 17:03:31 +0530
Message-ID: <30f8e66e4397f59747e9843e7c09b0c42b2d5804.1502623863.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34502 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbdHMLdq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Aug 2017 07:33:46 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

platform_device_id are not supposed to change at runtime. All functions
working with platform_device_id provided by <linux/platform_device.h>
work with const platform_device_id. So mark the non-const structs as
const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/thermal/max77620_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
index 159bbce..3c74b91 100644
--- a/drivers/thermal/max77620_thermal.c
+++ b/drivers/thermal/max77620_thermal.c
@@ -149,7 +149,7 @@ static int max77620_thermal_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device_id max77620_thermal_devtype[] = {
+static const struct platform_device_id max77620_thermal_devtype[] = {
 	{ .name = "max77620-thermal", },
 	{},
 };
-- 
2.7.4
