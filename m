From: Pushkar Jambhlekar <pushkar.iit@gmail.com>
Subject: [PATCH] kernel/power: Declare variables as static
Date: Thu, 11 May 2017 10:31:24 +0530
Message-ID: <1494478884-32477-1-git-send-email-pushkar.iit@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34691 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbdEKFBd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 May 2017 01:01:33 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Pushkar Jambhlekar <pushkar.iit@gmail.com>

Fixing sparse warnings: 'symbol not declared. Should it be static?' Variables need to be
static since they have not used outside of the files.

Signed-off-by: Pushkar Jambhlekar <pushkar.iit@gmail.com>
---
 kernel/power/snapshot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 3b1e0f3..fa46606 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1425,7 +1425,7 @@ static unsigned int nr_meta_pages;
  * Numbers of normal and highmem page frames allocated for hibernation image
  * before suspending devices.
  */
-unsigned int alloc_normal, alloc_highmem;
+static unsigned int alloc_normal, alloc_highmem;
 /*
  * Memory bitmap used for marking saveable pages (during hibernation) or
  * hibernation image pages (during restore)
-- 
2.7.4
