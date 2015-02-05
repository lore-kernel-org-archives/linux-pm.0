From: Lad Prabhakar <prabhakar.csengg@gmail.com>
Subject: [PATCH] thermal: int340x: fix sparse warning
Date: Thu,  5 Feb 2015 13:43:37 +0000
Message-ID: <1423143817-16128-1-git-send-email-prabhakar.csengg@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:45073 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbbBENnu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Feb 2015 08:43:50 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

this patch fixes following sparse warning:

processor_thermal_device.c:188:6: warning: symbol 'proc_thermal_remove' was not declared. Should it be static?

Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 Found this issue on linux-next (gcc  version 4.9.2,
 sparse version  0.4.5-rc1)and applies on top linux-next.

 drivers/thermal/int340x_thermal/processor_thermal_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/int340x_thermal/processor_thermal_device.c b/drivers/thermal/int340x_thermal/processor_thermal_device.c
index 0fe5dbb..095acac 100644
--- a/drivers/thermal/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/int340x_thermal/processor_thermal_device.c
@@ -185,7 +185,7 @@ free_buffer:
 	return ret;
 }
 
-void proc_thermal_remove(struct proc_thermal_device *proc_priv)
+static void proc_thermal_remove(struct proc_thermal_device *proc_priv)
 {
 	sysfs_remove_group(&proc_priv->dev->kobj,
 			   &power_limit_attribute_group);
-- 
1.9.1

