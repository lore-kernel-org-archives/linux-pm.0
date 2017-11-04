From: Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH] freezer: Fix typo in commnent to function freezable_schedule_timeout()
Date: Sun,  5 Nov 2017 03:27:32 +0530
Message-ID: <1509832652-1552-1-git-send-email-himanshujha199640@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:49777 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbdKDV5r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Nov 2017 17:57:47 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, Himanshu Jha <himanshujha199640@gmail.com>

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 include/linux/freezer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index 3995df1..21f5aa0 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -182,7 +182,7 @@ static inline void freezable_schedule_unsafe(void)
 }
 
 /*
- * Like freezable_schedule_timeout(), but should not block the freezer.  Do not
+ * Like schedule_timeout(), but should not block the freezer.  Do not
  * call this with locks held.
  */
 static inline long freezable_schedule_timeout(long timeout)
-- 
2.7.4
