Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF91C433EF
	for <linux-pm@archiver.kernel.org>; Wed, 27 Apr 2022 21:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiD0V42 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 27 Apr 2022 17:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiD0V41 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2022 17:56:27 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28F34F445;
        Wed, 27 Apr 2022 14:53:14 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:52896)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njpax-0044AO-B2; Wed, 27 Apr 2022 15:53:11 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35982 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njpav-00BOen-6l; Wed, 27 Apr 2022 15:53:10 -0600
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
        inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <20220426225211.308418-6-ebiederm@xmission.com>
        <20220427145646.GC17421@redhat.com>
        <20220427150053.GD17421@redhat.com>
Date:   Wed, 27 Apr 2022 16:52:43 -0500
In-Reply-To: <20220427150053.GD17421@redhat.com> (Oleg Nesterov's message of
        "Wed, 27 Apr 2022 17:00:54 +0200")
Message-ID: <871qxi5h3o.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1njpav-00BOen-6l;;;mid=<871qxi5h3o.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/dRW6uGwzPPdDcp4HFC3w+8KCOzLk/q1o=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 6/9] signal: Always call do_notify_parent_cldstop with
 siglock held
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 04/27, Oleg Nesterov wrote:
>>
>> On 04/26, Eric W. Biederman wrote:
>> >
>> > @@ -2209,6 +2213,34 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
>> >  		spin_lock_irq(&current->sighand->siglock);
>> >  	}
>> >
>> > +	/* Don't stop if current is not ptraced */
>> > +	if (unlikely(!current->ptrace))
>> > +		return (clear_code) ? 0 : exit_code;
>> > +
>> > +	/*
>> > +	 * If @why is CLD_STOPPED, we're trapping to participate in a group
>> > +	 * stop.  Do the bookkeeping.  Note that if SIGCONT was delievered
>> > +	 * across siglock relocks since INTERRUPT was scheduled, PENDING
>> > +	 * could be clear now.  We act as if SIGCONT is received after
>> > +	 * TASK_TRACED is entered - ignore it.
>> > +	 */
>> > +	if (why == CLD_STOPPED && (current->jobctl & JOBCTL_STOP_PENDING))
>> > +		gstop_done = task_participate_group_stop(current);
>> > +
>> > +	/*
>> > +	 * Notify parents of the stop.
>> > +	 *
>> > +	 * While ptraced, there are two parents - the ptracer and
>> > +	 * the real_parent of the group_leader.  The ptracer should
>> > +	 * know about every stop while the real parent is only
>> > +	 * interested in the completion of group stop.  The states
>> > +	 * for the two don't interact with each other.  Notify
>> > +	 * separately unless they're gonna be duplicates.
>> > +	 */
>> > +	do_notify_parent_cldstop(current, true, why);
>> > +	if (gstop_done && ptrace_reparented(current))
>> > +		do_notify_parent_cldstop(current, false, why);
>>
>> This doesn't look right too. The parent should be notified only after
>> we set __state = TASK_TRACED and ->exit code.
>>
>> Suppose that debugger sleeps in do_wait(). do_notify_parent_cldstop()
>> wakes it up, debugger calls wait_task_stopped() and then it will sleep
>> again, task_stopped_code() returns 0.
>>
>> This can be probably fixed if you remove the lockless (fast path)
>> task_stopped_code() check in wait_task_stopped(), but this is not
>> nice performance-wise...

Another detail I have overlooked.  Thank you.

Or we can change task_stopped_code look something like:

static int *task_stopped_code(struct task_struct *p, bool ptrace)
{
	if (ptrace) {
-		if (task_is_traced(p) && !(p->jobctl & JOBCTL_LISTENING))
+		if (p->ptrace && !(p->jobctl & JOBCTL_LISTENING))
			return &p->exit_code;
	} else {
		if (p->signal->flags & SIGNAL_STOP_STOPPED)
			return &p->signal->group_exit_code;
	}
	return NULL;
}

I probably need to do a little bit more to ensure that it isn't an
actual process exit_code in p->exit_code.  But the we don't have to
limit ourselves to being precisely in the task_is_traced stopped place
for the fast path.


> On the other hand, I don't understand why did you move the callsite
> of do_notify_parent_cldstop() up... just don't do this?

My goal and I still think it makes sense (if not my implementation)
is to move set_special_state as close as possible to schedule().

That way we can avoid sleeping spin_locks clobbering it and making
our life difficult.

My hope is we can just clean up ptrace_stop instead of making it more
complicated and harder to follow.  Not that I am fundamentally opposed
to the quiesce bit but the code is already very hard to follow because
of all it's nuance and complexity, and I would really like to reduce
that complexity if we can possibly figure out how.

Eric


