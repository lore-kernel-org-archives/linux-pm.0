Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29310C43334
	for <linux-pm@archiver.kernel.org>; Wed, 29 Jun 2022 03:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiF2Dkb (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 28 Jun 2022 23:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiF2Dka (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jun 2022 23:40:30 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870E6183B4;
        Tue, 28 Jun 2022 20:40:29 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:34038)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o6OYz-005Xi0-LX; Tue, 28 Jun 2022 21:40:25 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57912 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o6OYy-0010GF-O0; Tue, 28 Jun 2022 21:40:25 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org
References: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
        <20220505182645.497868-12-ebiederm@xmission.com>
        <YrHA5UkJLornOdCz@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
        <877d5ajesi.fsf@email.froward.int.ebiederm.org>
        <YrHgo8GKFPWwoBoJ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
        <87y1xk8zx5.fsf@email.froward.int.ebiederm.org>
        <YrtKReO2vIiX8VVU@tuxmaker.boeblingen.de.ibm.com>
        <87czess94h.fsf@email.froward.int.ebiederm.org>
        <20220628184850.05f60d1e@gandalf.local.home>
Date:   Tue, 28 Jun 2022 22:39:59 -0500
In-Reply-To: <20220628184850.05f60d1e@gandalf.local.home> (Steven Rostedt's
        message of "Tue, 28 Jun 2022 18:48:50 -0400")
Message-ID: <87pmisqgs0.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o6OYy-0010GF-O0;;;mid=<87pmisqgs0.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18oP8UqrTa/BKAZUBBA+/xHj8a9vCOtJn8=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v4 12/12] sched,signal,ptrace: Rework TASK_TRACED,
 TASK_STOPPED state
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Tue, 28 Jun 2022 17:42:22 -0500
> "Eric W. Biederman" <ebiederm@xmission.com> wrote:
>
>> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
>> index 156a99283b11..cb85bcf84640 100644
>> --- a/kernel/ptrace.c
>> +++ b/kernel/ptrace.c
>> @@ -202,6 +202,7 @@ static bool ptrace_freeze_traced(struct task_struct *task)
>>  	spin_lock_irq(&task->sighand->siglock);
>>  	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
>>  	    !__fatal_signal_pending(task)) {
>> +		smp_rmb();
>>  		task->jobctl |= JOBCTL_PTRACE_FROZEN;
>>  		ret = true;
>>  	}
>> diff --git a/kernel/signal.c b/kernel/signal.c
>> index edb1dc9b00dc..bcd576e9de66 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -2233,6 +2233,7 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
>>  		return exit_code;
>>  
>>  	set_special_state(TASK_TRACED);
>> +	smp_wmb();
>>  	current->jobctl |= JOBCTL_TRACED;
>>  
>
> Are not these both done under the sighand->siglock spinlock?
>
> That is, the two paths should already be synchronized, and the memory
> barriers will not help anything inside the locks. The locking should (and
> must) handle all that.

I would presume so to.  However the READ_ONCE that is going astray
does not look like it is honoring that.

So perhaps there is a bug in the s390 spin_lock barriers?  Perhaps there
is a subtle detail in the barriers that spin locks provide that we are
overlooking?

I just know the observed behavior is:

- reading tsk->jobctl and seeing  JOBCTL_TRACED set.
- reading tsk->__state and seeing TASK_RUNNING.

So unless PREEMPT_RT is enabled on s390.  It looks like there is a
barrier problem.

Alexander do you have PREEMPT_RT enabled on s390?  I have been assuming
you don't but I figure I should ask and make certain as PREEMPT_RT can
cause this kind of failure.

Eric
