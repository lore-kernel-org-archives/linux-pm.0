Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913ACC433F5
	for <linux-pm@archiver.kernel.org>; Fri, 29 Apr 2022 22:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381444AbiD2WPz (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 29 Apr 2022 18:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381448AbiD2WPt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Apr 2022 18:15:49 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE9FDCE06;
        Fri, 29 Apr 2022 15:12:24 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:38182)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nkYSx-00AIAD-EI; Fri, 29 Apr 2022 15:47:55 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:36454 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nkYSv-005dKg-DP; Fri, 29 Apr 2022 15:47:55 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>, linux-ia64@vger.kernel.org
References: <20220421150248.667412396@infradead.org>
        <20220421150654.817117821@infradead.org>
        <87czhap9dy.fsf@email.froward.int.ebiederm.org>
        <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
Date:   Fri, 29 Apr 2022 16:46:59 -0500
In-Reply-To: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Tue, 26 Apr 2022 17:50:21 -0500")
Message-ID: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nkYSv-005dKg-DP;;;mid=<87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+ZIVHGWhwXaAZQuMgvUvy1NsqcM6xYpoc=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 0/12] ptrace: cleaning up ptrace_stop
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


The states TASK_STOPPED and TASK_TRACE are special in they can not
handle spurious wake-ups.  This plus actively depending upon and
changing the value of tsk->__state causes problems for PREEMPT_RT and
Peter's freezer rewrite.

There are a lot of details we have to get right to sort out the
technical challenges and this is my parred back version of the changes
that contains just those problems I see good solutions to that I believe
are ready.

In particular I don't have a solution that is ready for the challenges
presented by wait_task_inactive.

I hope we can review these changes and then have a firm foundation
for the rest of the challenges.

There are cleanups to the ptrace support for xtensa, um, and
ia64.

I have sucked in the first patch of Peter's freezer change as
with minor modifications I believe it is ready to go.

Eric W. Biederman (12):
      signal: Rename send_signal send_signal_locked
      signal: Replace __group_send_sig_info with send_signal_locked
      ptrace/um: Replace PT_DTRACE with TIF_SINGLESTEP
      ptrace/xtensa: Replace PT_SINGLESTEP with TIF_SINGLESTEP
      signal: Use lockdep_assert_held instead of assert_spin_locked
      ptrace: Reimplement PTRACE_KILL by always sending SIGKILL
      ptrace: Don't change __state
      ptrace: Remove arch_ptrace_attach
      ptrace: Always take siglock in ptrace_resume
      ptrace: Only return signr from ptrace_stop if it was provided
      ptrace: Always call schedule in ptrace_stop
      sched,signal,ptrace: Rework TASK_TRACED, TASK_STOPPED state

 arch/ia64/include/asm/ptrace.h    |   4 --
 arch/ia64/kernel/ptrace.c         |  57 ----------------
 arch/um/include/asm/thread_info.h |   2 +
 arch/um/kernel/exec.c             |   2 +-
 arch/um/kernel/process.c          |   2 +-
 arch/um/kernel/ptrace.c           |   8 +--
 arch/um/kernel/signal.c           |   4 +-
 arch/xtensa/kernel/ptrace.c       |   4 +-
 arch/xtensa/kernel/signal.c       |   4 +-
 drivers/tty/tty_jobctrl.c         |   4 +-
 include/linux/ptrace.h            |   7 --
 include/linux/sched.h             |  10 ++-
 include/linux/sched/jobctl.h      |  10 +++
 include/linux/sched/signal.h      |  23 ++++++-
 include/linux/signal.h            |   3 +-
 kernel/ptrace.c                   |  88 +++++++++----------------
 kernel/signal.c                   | 135 +++++++++++++++++---------------------
 kernel/time/posix-cpu-timers.c    |   6 +-
 18 files changed, 145 insertions(+), 228 deletions(-)

Eric
