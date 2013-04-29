From: Colin Cross <ccross@android.com>
Subject: [PATCH 05/10] epoll: use freezable blocking call
Date: Mon, 29 Apr 2013 14:45:41 -0700
Message-ID: <1367271946-7239-6-git-send-email-ccross@android.com>
References: <1367271946-7239-1-git-send-email-ccross@android.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f201.google.com ([209.85.216.201]:33772 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932453Ab3D2Vp5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2013 17:45:57 -0400
Received: by mail-qc0-f201.google.com with SMTP id o22so712369qcr.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2013 14:45:57 -0700 (PDT)
In-Reply-To: <1367271946-7239-1-git-send-email-ccross@android.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, arve@android.com, Colin Cross <ccross@android.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org

Avoid waking up every thread sleeping in an epoll_wait call during
suspend and resume by calling a freezable blocking call.

Signed-off-by: Colin Cross <ccross@android.com>
---
 fs/eventpoll.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 9fec183..65245e7 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -34,6 +34,7 @@
 #include <linux/mutex.h>
 #include <linux/anon_inodes.h>
 #include <linux/device.h>
+#include <linux/freezer.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/mman.h>
@@ -1543,7 +1544,8 @@ fetch_events:
 			}
 
 			spin_unlock_irqrestore(&ep->lock, flags);
-			if (!schedule_hrtimeout_range(to, slack, HRTIMER_MODE_ABS))
+			if (!freezable_schedule_hrtimeout_range(to, slack,
+								HRTIMER_MODE_ABS))
 				timed_out = 1;
 
 			spin_lock_irqsave(&ep->lock, flags);
-- 
1.8.2.1

