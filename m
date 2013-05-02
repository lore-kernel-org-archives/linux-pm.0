From: Colin Cross <ccross@android.com>
Subject: [PATCH v2 07/10] futex: use freezable blocking call
Date: Wed,  1 May 2013 18:35:05 -0700
Message-ID: <1367458508-9133-8-git-send-email-ccross@android.com>
References: <1367458508-9133-1-git-send-email-ccross@android.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-gg0-f201.google.com ([209.85.161.201]:50247 "EHLO
	mail-gg0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758912Ab3EBBfV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2013 21:35:21 -0400
Received: by mail-gg0-f201.google.com with SMTP id k25so14310ggl.2
        for <linux-pm@vger.kernel.org>; Wed, 01 May 2013 18:35:20 -0700 (PDT)
In-Reply-To: <1367458508-9133-1-git-send-email-ccross@android.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, arve@android.com, Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Colin Cross <ccross@android.com>, Darren Hart <dvhart@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>

Avoid waking up every thread sleeping in a futex_wait call during
suspend and resume by calling a freezable blocking call.  Previous
patches modified the freezer to avoid sending wakeups to threads
that are blocked in freezable blocking calls.

This call was selected to be converted to a freezable call because
it doesn't hold any locks or release any resources when interrupted
that might be needed by another freezing task or a kernel driver
during suspend, and is a common site where idle userspace tasks are
blocked.

Signed-off-by: Colin Cross <ccross@android.com>
---
 kernel/futex.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index b26dcfc..d710fae 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -61,6 +61,7 @@
 #include <linux/nsproxy.h>
 #include <linux/ptrace.h>
 #include <linux/sched/rt.h>
+#include <linux/freezer.h>
 
 #include <asm/futex.h>
 
@@ -1807,7 +1808,7 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
 		 * is no timeout, or if it has yet to expire.
 		 */
 		if (!timeout || timeout->task)
-			schedule();
+			freezable_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
 }
-- 
1.8.2.1

