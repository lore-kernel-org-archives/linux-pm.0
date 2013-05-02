From: Colin Cross <ccross@android.com>
Subject: [PATCH v2 02/10] freezer: skip waking up tasks with PF_FREEZER_SKIP set
Date: Wed,  1 May 2013 18:35:00 -0700
Message-ID: <1367458508-9133-3-git-send-email-ccross@android.com>
References: <1367458508-9133-1-git-send-email-ccross@android.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1367458508-9133-1-git-send-email-ccross@android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, arve@android.com, Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Colin Cross <ccross@android.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Android goes through suspend/resume very often (every few seconds when
on a busy wifi network with the screen off), and a significant portion
of the energy used to go in and out of suspend is spent in the
freezer.  If a task has called freezer_do_not_count(), don't bother
waking it up.  If it happens to wake up later it will call
freezer_count() and immediately enter the refrigerator.

Combined with patches to convert freezable helpers to use
freezer_do_not_count() and convert common sites where idle userspace
tasks are blocked to use the freezable helpers, this reduces the
time and energy required to suspend and resume.

Signed-off-by: Colin Cross <ccross@android.com>
---
v2:  move check to freeze_task()

 kernel/freezer.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/freezer.c b/kernel/freezer.c
index c38893b..8b2afc1 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -110,6 +110,18 @@ bool freeze_task(struct task_struct *p)
 {
 	unsigned long flags;
 
+	/*
+	 * This check can race with freezer_do_not_count, but worst case that
+	 * will result in an extra wakeup being sent to the task.  It does not
+	 * race with freezer_count(), the barriers in freezer_count() and
+	 * freezer_should_skip() ensure that either freezer_count() sees
+	 * freezing == true in try_to_freeze() and freezes, or
+	 * freezer_should_skip() sees !PF_FREEZE_SKIP and freezes the task
+	 * normally.
+	 */
+	if (freezer_should_skip(p))
+		return false;
+
 	spin_lock_irqsave(&freezer_lock, flags);
 	if (!freezing(p) || frozen(p)) {
 		spin_unlock_irqrestore(&freezer_lock, flags);
-- 
1.8.2.1
