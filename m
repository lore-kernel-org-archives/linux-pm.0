Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1308C433F5
	for <linux-pm@archiver.kernel.org>; Wed, 18 May 2022 22:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiERWzf (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 18 May 2022 18:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiERWzA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2022 18:55:00 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F68B2265DF;
        Wed, 18 May 2022 15:54:59 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:33018)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSZG-00CkZV-Mj; Wed, 18 May 2022 16:54:58 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38724 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSZF-002Z0O-HE; Wed, 18 May 2022 16:54:58 -0600
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
Date:   Wed, 18 May 2022 17:53:48 -0500
Message-Id: <20220518225355.784371-9-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nrSZF-002Z0O-HE;;;mid=<20220518225355.784371-9-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19tbqiOJHWnZVuKgNQ7Jp3oXCI1nNuPXUo=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 09/16] ptrace: In ptrace_setsiginfo deal with invalid si_signo
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If the tracer calls PTRACE_SETSIGINFO it only has an effect if the
tracee is stopped in ptrace_signal.

When one of PTRACE_DETACH, PTRACE_SINGLESTEP, PTRACE_SINGLEBLOCK,
PTRACE_SYSEMU, PTRACE_SYSEMU_SINGLESTEP, PTRACE_SYSCALL, or
PTRACE_CONT pass in a signel number to continue with the kernel
validates that signal number and the ptrace_signal verifies the signal
number matches the si_signo, before the siginfo is used.

As the signal number to continue with is verified to be a valid signal
number the signal number in si_signo must be a valid signal number.

Make this obvious and avoid needing checks later by immediately
clearing siginfo if si_signo is not valid.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ptrace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index a24eed725cec..a0a07d140751 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -716,7 +716,9 @@ static int ptrace_setsiginfo(struct task_struct *child, const kernel_siginfo_t *
 	if (unlikely(!child->last_siginfo))
 		return -EINVAL;
 
-	copy_siginfo(child->last_siginfo, info);
+	clear_siginfo(child->last_siginfo);
+	if (valid_signal(info->si_signo))
+		copy_siginfo(child->last_siginfo, info);
 	return 0;
 }
 
-- 
2.35.3

