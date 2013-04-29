From: Colin Cross <ccross@android.com>
Subject: [PATCH 07/10] futex: use freezable blocking call
Date: Mon, 29 Apr 2013 14:45:43 -0700
Message-ID: <1367271946-7239-8-git-send-email-ccross@android.com>
References: <1367271946-7239-1-git-send-email-ccross@android.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f202.google.com ([209.85.216.202]:64362 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759492Ab3D2Vpz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2013 17:45:55 -0400
Received: by mail-qc0-f202.google.com with SMTP id k26so712477qcs.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2013 14:45:54 -0700 (PDT)
In-Reply-To: <1367271946-7239-1-git-send-email-ccross@android.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, arve@android.com, Colin Cross <ccross@android.com>, Darren Hart <dvhart@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>

Avoid waking up every thread sleeping in a futex_wait call during
suspend and resume by calling a freezable blocking call.

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

