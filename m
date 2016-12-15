From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH] PM / QoS: Remove unneeded linux/miscdevice.h include
Date: Thu, 15 Dec 2016 11:15:25 +0100
Message-ID: <20161215101525.22282-1-clabbe.montjoie@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>
List-Id: linux-pm@vger.kernel.org

pm_qos.h does not use any miscdevice, so this patch
remove this unnecessary inclusion.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 include/linux/pm_qos.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 0f65d36..d4d3479 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -6,7 +6,6 @@
  */
 #include <linux/plist.h>
 #include <linux/notifier.h>
-#include <linux/miscdevice.h>
 #include <linux/device.h>
 #include <linux/workqueue.h>
 
-- 
2.10.2
