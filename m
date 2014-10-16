From: Vishnu Pratap Singh <vishnu.ps@samsung.com>
Subject: [PATCH] [kernel]: process: replace printk with pr_err
Date: Thu, 16 Oct 2014 10:36:35 +0530
Message-ID: <1413435995-32317-1-git-send-email-vishnu.ps@samsung.com>
References: <[kernel]: process: replace printk with pr_err>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:63624 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbaJPFJD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Oct 2014 01:09:03 -0400
In-reply-to: <[kernel]: process: replace printk with pr_err>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: akpm@linux-foundation.org, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: cpgs@samsung.com, pintu.k@samsung.com, vishu13285@gmail.com, Vishnu Pratap Singh <vishnu.ps@samsung.com>

This patch replaces printk(KERN_ERR...) with pr_err found.

Signed-off-by: Vishnu Pratap Singh <vishnu.ps@samsung.com>
---
 kernel/power/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 7b32322..401f7ee 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -85,7 +85,7 @@ static int try_to_freeze_tasks(bool user_only)
 
 	if (todo) {
 		printk("\n");
-		printk(KERN_ERR "Freezing of tasks %s after %d.%03d seconds "
+		pr_err("Freezing of tasks %s after %d.%03d seconds "
 		       "(%d tasks refusing to freeze, wq_busy=%d):\n",
 		       wakeup ? "aborted" : "failed",
 		       elapsed_msecs / 1000, elapsed_msecs % 1000,
-- 
1.8.3.2

