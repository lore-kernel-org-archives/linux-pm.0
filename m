Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25DFC433F5
	for <linux-pm@archiver.kernel.org>; Wed,  4 May 2022 22:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379152AbiEDWqD (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 4 May 2022 18:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379105AbiEDWpb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 May 2022 18:45:31 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8CC52E4B;
        Wed,  4 May 2022 15:41:53 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:56942)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmNgu-004uJm-Ua; Wed, 04 May 2022 16:41:52 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37004 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmNgs-00GI0k-T1; Wed, 04 May 2022 16:41:52 -0600
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
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed,  4 May 2022 17:40:57 -0500
Message-Id: <20220504224058.476193-10-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
References: <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nmNgs-00GI0k-T1;;;mid=<20220504224058.476193-10-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/pkv1iYfm/nXJgj0Lm6o2PFT2hvX4ewTk=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v3 10/11] ptrace: Always take siglock in ptrace_resume
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Make code analysis simpler and future changes easier by
always taking siglock in ptrace_resume.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ptrace.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 83ed28262708..36a5b7a00d2f 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -837,8 +837,6 @@ static long ptrace_get_rseq_configuration(struct task_struct *task,
 static int ptrace_resume(struct task_struct *child, long request,
 			 unsigned long data)
 {
-	bool need_siglock;
-
 	if (!valid_signal(data))
 		return -EIO;
 
@@ -874,18 +872,11 @@ static int ptrace_resume(struct task_struct *child, long request,
 	 * Note that we need siglock even if ->exit_code == data and/or this
 	 * status was not reported yet, the new status must not be cleared by
 	 * wait_task_stopped() after resume.
-	 *
-	 * If data == 0 we do not care if wait_task_stopped() reports the old
-	 * status and clears the code too; this can't race with the tracee, it
-	 * takes siglock after resume.
 	 */
-	need_siglock = data && !thread_group_empty(current);
-	if (need_siglock)
-		spin_lock_irq(&child->sighand->siglock);
+	spin_lock_irq(&child->sighand->siglock);
 	child->exit_code = data;
 	wake_up_state(child, __TASK_TRACED);
-	if (need_siglock)
-		spin_unlock_irq(&child->sighand->siglock);
+	spin_unlock_irq(&child->sighand->siglock);
 
 	return 0;
 }
-- 
2.35.3

