Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3886C433F5
	for <linux-pm@archiver.kernel.org>; Wed, 27 Apr 2022 23:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbiD0XJW (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 27 Apr 2022 19:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237842AbiD0XJN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2022 19:09:13 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120FF4EF42;
        Wed, 27 Apr 2022 16:05:59 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:51442)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njqjL-004GYP-WE; Wed, 27 Apr 2022 17:05:56 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:36000 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njqjK-00DmT9-Ut; Wed, 27 Apr 2022 17:05:55 -0600
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
        Jann Horn <jannh@google.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <20220426225211.308418-9-ebiederm@xmission.com>
Date:   Wed, 27 Apr 2022 18:05:47 -0500
In-Reply-To: <20220426225211.308418-9-ebiederm@xmission.com> (Eric
        W. Biederman's message of "Tue, 26 Apr 2022 17:52:11 -0500")
Message-ID: <87czh2160k.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1njqjK-00DmT9-Ut;;;mid=<87czh2160k.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/koGqdANEmvAjzDoG/4Ztqacq2eIk+J9E=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 9/9] ptrace: Don't change __state
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 3c8b34876744..1947c85aa9d9 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -437,7 +437,8 @@ extern void signal_wake_up_state(struct task_struct *t, unsigned int state);
>  
>  static inline void signal_wake_up(struct task_struct *t, bool resume)
>  {
> -	signal_wake_up_state(t, resume ? TASK_WAKEKILL : 0);
> +	bool wakekill = resume && !(t->jobctl & JOBCTL_DELAY_WAKEKILL);
> +	signal_wake_up_state(t, wakekill ? TASK_WAKEKILL : 0);
>  }
>  static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
>  {

Grrr.  While looking through everything today I have realized that there
is a bug.

Suppose we have 3 processes: TRACER, TRACEE, KILLER.

Meanwhile TRACEE is in the middle of ptrace_stop, just after siglock has
been dropped.

The TRACER process has performed ptrace_attach on TRACEE and is in the
middle of a ptrace operation and has just set JOBCTL_DELAY_WAKEKILL.

Then comes in the KILLER process and sends the TRACEE a SIGKILL.
The TRACEE __state remains TASK_TRACED, as designed.

The bug appears when the TRACEE makes it to schedule().  Inside
schedule there is a call to signal_pending_state() which notices
a SIGKILL is pending and refuses to sleep.

I could avoid setting TIF_SIGPENDING in signal_wake_up but that
is insufficient as another signal may be pending.

I could avoid marking the task as __fatal_signal_pending but then
where would the information that the task needs to become
__fatal_signal_pending go.

Hmm.

This looks like I need my other pending cleanup which introduces a
helper to get this idea to work.

Eric

