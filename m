Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCEFC433F5
	for <linux-pm@archiver.kernel.org>; Wed, 18 May 2022 22:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiERWzB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 18 May 2022 18:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiERWy7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2022 18:54:59 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4CB227067;
        Wed, 18 May 2022 15:54:51 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:54962)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSZ9-001T6U-1F; Wed, 18 May 2022 16:54:51 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38724 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSZ8-002Z0O-20; Wed, 18 May 2022 16:54:50 -0600
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
Date:   Wed, 18 May 2022 17:53:46 -0500
Message-Id: <20220518225355.784371-7-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nrSZ8-002Z0O-20;;;mid=<20220518225355.784371-7-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19piXvSGZGlwtEypRa3+k4c3ag8pD6xkSw=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 07/16] signal: Wake up the designated parent
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Today if a process is ptraced only the ptracer will ever be woken up in
wait, if the parent is waiting with __WNOTHREAD.  Update the code
so that the real_parent can also be woken up with __WNOTHREAD even
when the code is ptraced.

Fixes: 75b95953a569 ("job control: Add @for_ptrace to do_notify_parent_cldstop()")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/exit.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index f072959fcab7..0e26f73c49ac 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1421,26 +1421,35 @@ static int ptrace_do_wait(struct wait_opts *wo, struct task_struct *tsk)
 	return 0;
 }
 
+struct child_wait_info {
+	struct task_struct *p;
+	struct task_struct *parent;
+};
+
 static int child_wait_callback(wait_queue_entry_t *wait, unsigned mode,
 				int sync, void *key)
 {
 	struct wait_opts *wo = container_of(wait, struct wait_opts,
 						child_wait);
-	struct task_struct *p = key;
+	struct child_wait_info *info = key;
 
-	if (!eligible_pid(wo, p))
+	if (!eligible_pid(wo, info->p))
 		return 0;
 
-	if ((wo->wo_flags & __WNOTHREAD) && wait->private != p->parent)
-		return 0;
+	if ((wo->wo_flags & __WNOTHREAD) && (wait->private != info->parent))
+			return 0;
 
 	return default_wake_function(wait, mode, sync, key);
 }
 
 void __wake_up_parent(struct task_struct *p, struct task_struct *parent)
 {
+	struct child_wait_info info = {
+		.p = p,
+		.parent = parent,
+	};
 	__wake_up_sync_key(&parent->signal->wait_chldexit,
-			   TASK_INTERRUPTIBLE, p);
+			   TASK_INTERRUPTIBLE, &info);
 }
 
 static bool is_effectively_child(struct wait_opts *wo, bool ptrace,
-- 
2.35.3

