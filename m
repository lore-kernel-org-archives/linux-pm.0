From: Colin Cross <ccross@android.com>
Subject: [PATCH v2 09/10] sigtimedwait: use freezable blocking call
Date: Wed,  1 May 2013 18:35:07 -0700
Message-ID: <1367458508-9133-10-git-send-email-ccross@android.com>
References: <1367458508-9133-1-git-send-email-ccross@android.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-gg0-f202.google.com ([209.85.161.202]:45980 "EHLO
	mail-gg0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758997Ab3EBBfX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2013 21:35:23 -0400
Received: by mail-gg0-f202.google.com with SMTP id 4so14281ggm.1
        for <linux-pm@vger.kernel.org>; Wed, 01 May 2013 18:35:22 -0700 (PDT)
In-Reply-To: <1367458508-9133-1-git-send-email-ccross@android.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, arve@android.com, Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Colin Cross <ccross@android.com>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Serge Hallyn <serge.hallyn@canonical.com>

Avoid waking up every thread sleeping in a sigtimedwait call during
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
 kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 598dc06..10a70a0 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2845,7 +2845,7 @@ int do_sigtimedwait(const sigset_t *which, siginfo_t *info,
 		recalc_sigpending();
 		spin_unlock_irq(&tsk->sighand->siglock);
 
-		timeout = schedule_timeout_interruptible(timeout);
+		timeout = freezable_schedule_timeout_interruptible(timeout);
 
 		spin_lock_irq(&tsk->sighand->siglock);
 		__set_task_blocked(tsk, &tsk->real_blocked);
-- 
1.8.2.1

