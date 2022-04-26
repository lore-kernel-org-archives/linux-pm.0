Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43645C433F5
	for <linux-pm@archiver.kernel.org>; Tue, 26 Apr 2022 22:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355944AbiDZW4a (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 26 Apr 2022 18:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355949AbiDZW4Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2022 18:56:16 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D13D4CD43;
        Tue, 26 Apr 2022 15:53:08 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:57512)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njU3P-00CcWA-H2; Tue, 26 Apr 2022 16:53:07 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35772 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njU3O-006ASW-76; Tue, 26 Apr 2022 16:53:06 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, Oleg Nesterov <oleg@redhat.com>,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        tj@kernel.org, linux-pm@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 26 Apr 2022 17:52:10 -0500
Message-Id: <20220426225211.308418-8-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1njU3O-006ASW-76;;;mid=<20220426225211.308418-8-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19vCMILBL9SRVw0QkC5/xHZqHpvkZOM2VA=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 8/9] ptrace: Use siglock instead of tasklist_lock in ptrace_check_attach
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that siglock protects tsk->parent and tsk->ptrace there is no need
to grab tasklist_lock in ptrace_check_attach.  The siglock can handle
all of the locking needs of ptrace_check_attach.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ptrace.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 0634da7ac685..842511ee9a9f 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -189,17 +189,14 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 {
 	bool ret = false;
 
-	/* Lockless, nobody but us can set this flag */
 	if (task->jobctl & JOBCTL_LISTENING)
 		return ret;
 
-	spin_lock_irq(&task->sighand->siglock);
 	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
 	    !__fatal_signal_pending(task)) {
 		WRITE_ONCE(task->__state, __TASK_TRACED);
 		ret = true;
 	}
-	spin_unlock_irq(&task->sighand->siglock);
 
 	return ret;
 }
@@ -237,33 +234,35 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
  * state.
  *
  * CONTEXT:
- * Grabs and releases tasklist_lock and @child->sighand->siglock.
+ * Grabs and releases @child->sighand->siglock.
  *
  * RETURNS:
  * 0 on success, -ESRCH if %child is not ready.
  */
 static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 {
+	unsigned long flags;
 	int ret = -ESRCH;
 
 	/*
-	 * We take the read lock around doing both checks to close a
+	 * We take the siglock around doing both checks to close a
 	 * possible race where someone else was tracing our child and
 	 * detached between these two checks.  After this locked check,
 	 * we are sure that this is our traced child and that can only
 	 * be changed by us so it's not changing right after this.
 	 */
-	read_lock(&tasklist_lock);
-	if (child->ptrace && child->parent == current) {
-		WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
-		/*
-		 * child->sighand can't be NULL, release_task()
-		 * does ptrace_unlink() before __exit_signal().
-		 */
-		if (ignore_state || ptrace_freeze_traced(child))
-			ret = 0;
+	if (lock_task_sighand(child, &flags)) {
+		if (child->ptrace && child->parent == current) {
+			WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
+			/*
+			 * child->sighand can't be NULL, release_task()
+			 * does ptrace_unlink() before __exit_signal().
+			 */
+			if (ignore_state || ptrace_freeze_traced(child))
+				ret = 0;
+		}
+		unlock_task_sighand(child, &flags);
 	}
-	read_unlock(&tasklist_lock);
 
 	if (!ret && !ignore_state &&
 	    WARN_ON_ONCE(!wait_task_inactive(child, 0)))
-- 
2.35.3

