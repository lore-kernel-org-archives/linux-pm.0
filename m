Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4886DC433FE
	for <linux-pm@archiver.kernel.org>; Wed, 18 May 2022 22:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiERWyi (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 18 May 2022 18:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiERWyg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2022 18:54:36 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71332265CA;
        Wed, 18 May 2022 15:54:35 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:60758)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSYm-00CkVS-Ou; Wed, 18 May 2022 16:54:28 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38724 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSYl-002Z0O-QC; Wed, 18 May 2022 16:54:28 -0600
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
Date:   Wed, 18 May 2022 17:53:41 -0500
Message-Id: <20220518225355.784371-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nrSYl-002Z0O-QC;;;mid=<20220518225355.784371-2-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+0Tx89ud0mnpvdpypNDCuPwLhWFRBvyWQ=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 02/16] signal/ia64: Remove unused definition of IA64_TASK_REAL_PARENT_OFFSET
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rather than update the unused definition of IA64_TASK_REAL_PARENT_OFFSENT
when I move tsk->real_parent into signal_struct remove it now.

Cc: linux-ia64@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/ia64/kernel/asm-offsets.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/ia64/kernel/asm-offsets.c b/arch/ia64/kernel/asm-offsets.c
index be3b90fef2e9..245c4333ea30 100644
--- a/arch/ia64/kernel/asm-offsets.c
+++ b/arch/ia64/kernel/asm-offsets.c
@@ -55,7 +55,6 @@ void foo(void)
 	DEFINE(IA64_PID_UPID_OFFSET, offsetof (struct pid, numbers[0]));
 	DEFINE(IA64_TASK_PENDING_OFFSET,offsetof (struct task_struct, pending));
 	DEFINE(IA64_TASK_PID_OFFSET, offsetof (struct task_struct, pid));
-	DEFINE(IA64_TASK_REAL_PARENT_OFFSET, offsetof (struct task_struct, real_parent));
 	DEFINE(IA64_TASK_SIGNAL_OFFSET,offsetof (struct task_struct, signal));
 	DEFINE(IA64_TASK_TGID_OFFSET, offsetof (struct task_struct, tgid));
 	DEFINE(IA64_TASK_THREAD_KSP_OFFSET, offsetof (struct task_struct, thread.ksp));
-- 
2.35.3

