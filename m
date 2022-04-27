Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD46C433F5
	for <linux-pm@archiver.kernel.org>; Wed, 27 Apr 2022 17:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244034AbiD0Rem (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 27 Apr 2022 13:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244082AbiD0Rel (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2022 13:34:41 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B142D1BFC97;
        Wed, 27 Apr 2022 10:31:21 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:35920)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njlVX-000Gnc-23; Wed, 27 Apr 2022 11:31:19 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35954 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njlVV-00C4Y5-KZ; Wed, 27 Apr 2022 11:31:18 -0600
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
        <20220426225211.308418-9-ebiederm@xmission.com>
        <20220427160901.GI17421@redhat.com>
        <87o80m7afv.fsf@email.froward.int.ebiederm.org>
        <20220427171829.GJ17421@redhat.com>
        <20220427172109.GK17421@redhat.com>
Date:   Wed, 27 Apr 2022 12:31:09 -0500
In-Reply-To: <20220427172109.GK17421@redhat.com> (Oleg Nesterov's message of
        "Wed, 27 Apr 2022 19:21:10 +0200")
Message-ID: <87wnfa5t7m.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1njlVV-00C4Y5-KZ;;;mid=<87wnfa5t7m.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+XoRe+WnUdHjZVGZxm2GNPI+jnxvpu6gg=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 9/9] ptrace: Don't change __state
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 04/27, Oleg Nesterov wrote:
>>
>> On 04/27, Eric W. Biederman wrote:
>> >
>> > Oleg Nesterov <oleg@redhat.com> writes:
>> >
>> > > On 04/26, Eric W. Biederman wrote:
>> > >>
>> > >> @@ -253,7 +252,7 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
>> > >>  	 */
>> > >>  	if (lock_task_sighand(child, &flags)) {
>> > >>  		if (child->ptrace && child->parent == current) {
>> > >> -			WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
>> > >> +			WARN_ON(child->jobctl & JOBCTL_DELAY_WAKEKILL);
>> > >
>> > > This WARN_ON() doesn't look right.
>> > >
>> > > It is possible that this child was traced by another task and PTRACE_DETACH'ed,
>> > > but it didn't clear DELAY_WAKEKILL.
>> >
>> > That would be a bug.  That would mean that PTRACE_DETACHED process can
>> > not be SIGKILL'd.
>>
>> Why? The tracee will take siglock, clear JOBCTL_DELAY_WAKEKILL and notice
>> SIGKILL after that.
>
> Not to mention that the tracee is TASK_RUNNING after PTRACE_DETACH wakes it
> up, so the pending JOBCTL_DELAY_WAKEKILL simply has no effect.

Oh.  You are talking about the window when between clearing the
traced state and when tracee resumes executing and clears
JOBCTL_DELAY_WAKEKILL.

I thought you were thinking about JOBCTL_DELAY_WAKEKILL being leaked.

That requires both ptrace_attach and ptrace_check_attach for the new
tracer to happen before the tracee is scheduled to run.

I agree.  I think the WARN_ON could reasonably be moved a bit later,
but I don't know that the WARN_ON is important. I simply kept it because
it seemed to make sense.

Eric
