Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DF2C433EF
	for <linux-pm@archiver.kernel.org>; Wed, 18 May 2022 22:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiERWzL (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 18 May 2022 18:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiERWy6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2022 18:54:58 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D270F2265E7;
        Wed, 18 May 2022 15:54:48 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:32820)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSZ5-00CkXx-Ei; Wed, 18 May 2022 16:54:47 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38724 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSZ4-002Z0O-4S; Wed, 18 May 2022 16:54:46 -0600
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
        Robert OCallahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed, 18 May 2022 17:53:45 -0500
Message-Id: <20220518225355.784371-6-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nrSZ4-002Z0O-4S;;;mid=<20220518225355.784371-6-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18JPO9y9/8egXH47VwwlNDJMZCh2Vmg12Y=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 06/16] ptrace: Remove unnecessary locking in ptrace_(get|set)siginfo
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since commit 9899d11f6544 ("ptrace: ensure arch_ptrace/ptrace_request
can never race with SIGKILL") it has been unnecessary for
ptrace_getsiginfo and ptrace_setsiginfo to use lock_task_sighand.

Having the code taking an unnecessary lock is confusing
as it suggests that other parts of the code need to take
the unnecessary lock as well.

So remove the unnecessary lock to make the code more
efficient, simpler, and less confusing.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ptrace.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index ca0e47691229..15e93eafa6f0 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -677,34 +677,20 @@ static int ptrace_setoptions(struct task_struct *child, unsigned long data)
 
 static int ptrace_getsiginfo(struct task_struct *child, kernel_siginfo_t *info)
 {
-	unsigned long flags;
-	int error = -ESRCH;
+	if (unlikely(!child->last_siginfo))
+		return -EINVAL;
 
-	if (lock_task_sighand(child, &flags)) {
-		error = -EINVAL;
-		if (likely(child->last_siginfo != NULL)) {
-			copy_siginfo(info, child->last_siginfo);
-			error = 0;
-		}
-		unlock_task_sighand(child, &flags);
-	}
-	return error;
+	copy_siginfo(info, child->last_siginfo);
+	return 0;
 }
 
 static int ptrace_setsiginfo(struct task_struct *child, const kernel_siginfo_t *info)
 {
-	unsigned long flags;
-	int error = -ESRCH;
+	if (unlikely(!child->last_siginfo))
+		return -EINVAL;
 
-	if (lock_task_sighand(child, &flags)) {
-		error = -EINVAL;
-		if (likely(child->last_siginfo != NULL)) {
-			copy_siginfo(child->last_siginfo, info);
-			error = 0;
-		}
-		unlock_task_sighand(child, &flags);
-	}
-	return error;
+	copy_siginfo(child->last_siginfo, info);
+	return 0;
 }
 
 static int ptrace_peek_siginfo(struct task_struct *child,
-- 
2.35.3

