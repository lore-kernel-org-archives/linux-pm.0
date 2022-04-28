Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24692C433EF
	for <linux-pm@archiver.kernel.org>; Thu, 28 Apr 2022 16:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344429AbiD1Qyd (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 28 Apr 2022 12:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbiD1Qyc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Apr 2022 12:54:32 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664038C7C7;
        Thu, 28 Apr 2022 09:51:13 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:46722)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nk7MD-006d9A-2m; Thu, 28 Apr 2022 10:51:09 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:36046 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nk7MC-000I0h-0D; Thu, 28 Apr 2022 10:51:08 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <20220426225211.308418-9-ebiederm@xmission.com>
        <87czh2160k.fsf@email.froward.int.ebiederm.org>
        <20220428151110.GB15485@redhat.com>
Date:   Thu, 28 Apr 2022 11:50:19 -0500
In-Reply-To: <20220428151110.GB15485@redhat.com> (Oleg Nesterov's message of
        "Thu, 28 Apr 2022 17:11:11 +0200")
Message-ID: <875ymtywxg.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nk7MC-000I0h-0D;;;mid=<875ymtywxg.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+Nj5WvQO35/e863lcGlkfLjjTdj24OUTQ=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 9/9] ptrace: Don't change __state
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 04/27, Eric W. Biederman wrote:
>>
>> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>>
>> > diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
>> > index 3c8b34876744..1947c85aa9d9 100644
>> > --- a/include/linux/sched/signal.h
>> > +++ b/include/linux/sched/signal.h
>> > @@ -437,7 +437,8 @@ extern void signal_wake_up_state(struct task_struct *t, unsigned int state);
>> >
>> >  static inline void signal_wake_up(struct task_struct *t, bool resume)
>> >  {
>> > -	signal_wake_up_state(t, resume ? TASK_WAKEKILL : 0);
>> > +	bool wakekill = resume && !(t->jobctl & JOBCTL_DELAY_WAKEKILL);
>> > +	signal_wake_up_state(t, wakekill ? TASK_WAKEKILL : 0);
>> >  }
>> >  static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
>> >  {
>>
>> Grrr.  While looking through everything today I have realized that there
>> is a bug.
>>
>> Suppose we have 3 processes: TRACER, TRACEE, KILLER.
>>
>> Meanwhile TRACEE is in the middle of ptrace_stop, just after siglock has
>> been dropped.
>>
>> The TRACER process has performed ptrace_attach on TRACEE and is in the
>> middle of a ptrace operation and has just set JOBCTL_DELAY_WAKEKILL.
>>
>> Then comes in the KILLER process and sends the TRACEE a SIGKILL.
>> The TRACEE __state remains TASK_TRACED, as designed.
>>
>> The bug appears when the TRACEE makes it to schedule().  Inside
>> schedule there is a call to signal_pending_state() which notices
>> a SIGKILL is pending and refuses to sleep.
>
> And I think this is fine. This doesn't really differ from the case
> when the tracee was killed before it takes siglock.

Hmm.  Maybe.

> The only problem (afaics) is that, once we introduce JOBCTL_TRACED,
> ptrace_stop() can leak this flag. That is why I suggested to clear
> it along with LISTENING/DELAY_WAKEKILL before return, exactly because
> schedule() won't block if fatal_signal_pending() is true.
>
> But may be I misunderstood you concern?

Prior to JOBCTL_DELAY_WAKEKILL once __state was set to __TASK_TRACED
we were guaranteed that schedule() would stop if a SIGKILL was
received after that point.  As well as being immune from wake-ups
from SIGKILL.

I guess we are immune from wake-ups with JOBCTL_DELAY_WAKEKILL as I have
implemented it.

The practical concern then seems to be that we are not guaranteed
wait_task_inactive will succeed.  Which means that it must continue
to include the TASK_TRACED bit.

Previously we were actually guaranteed in ptrace_check_attach that after
ptrace_freeze_traced would succeed as any pending fatal signal would
cause ptrace_freeze_traced to fail.  Any incoming fatal signal would not
stop schedule from sleeping.  The ptraced task would continue to be
ptraced, as all other ptrace operations are blocked by virtue of ptrace
being single threaded.

I think in my tired mind yesterday I thought it would messing things
up after schedule decided to sleep.  Still I would like to be able to
let wait_task_inactive not care about the state of the process it is
going to sleep for.

Eric

