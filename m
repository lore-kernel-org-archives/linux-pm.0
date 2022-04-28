Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B842FC433F5
	for <linux-pm@archiver.kernel.org>; Thu, 28 Apr 2022 18:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351090AbiD1SlS (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 28 Apr 2022 14:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiD1SlR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Apr 2022 14:41:17 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F0BBE9E5;
        Thu, 28 Apr 2022 11:37:59 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:50494)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nk91Y-006tgx-5X; Thu, 28 Apr 2022 12:37:56 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:36160 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nk91X-00GPuy-5E; Thu, 28 Apr 2022 12:37:55 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        tj@kernel.org, linux-pm@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <20220426225211.308418-6-ebiederm@xmission.com>
        <20220427141018.GA17421@redhat.com>
        <874k2ea9q4.fsf@email.froward.int.ebiederm.org>
        <87zgk67fdd.fsf@email.froward.int.ebiederm.org>
        <YmrSijTc6HIv4sAG@hirez.programming.kicks-ass.net>
Date:   Thu, 28 Apr 2022 13:37:47 -0500
In-Reply-To: <YmrSijTc6HIv4sAG@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Thu, 28 Apr 2022 19:44:42 +0200")
Message-ID: <8735hxxddw.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nk91X-00GPuy-5E;;;mid=<8735hxxddw.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18yrR4biUCy745ffIUgk1VZ5ZnVJz1nEjE=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 6/9] signal: Always call do_notify_parent_cldstop with
 siglock held
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Wed, Apr 27, 2022 at 09:47:10AM -0500, Eric W. Biederman wrote:
>
>> Hmm.  If we have the following process tree.
>> 
>>     A
>>      \
>>       B
>>        \
>>         C
>> 
>> Process A, B, and C are all in the same process group.
>> Process A and B are setup to receive SIGCHILD when
>> their process stops.
>> 
>> Process C traces process A.
>> 
>> When a sigstop is delivered to the group we can have:
>> 
>> Process B takes siglock(B) siglock(A) to notify the real_parent
>> Process C takes siglock(C) siglock(B) to notify the real_parent
>> Process A takes siglock(A) siglock(C) to notify the tracer
>> 
>> If they all take their local lock at the same time there is
>> a deadlock.
>> 
>> I don't think the restriction that you can never ptrace anyone
>> up the process tree is going to fly.  So it looks like I am back to the
>> drawing board for this one.
>
> I've not had time to fully appreciate the nested locking here, but if it
> is possible to rework things to always take both locks at the same time,
> then it would be possible to impose an arbitrary lock order on things
> and break the cycle that way.
>
> That is, simply order the locks by their heap address or something:
>
> static void double_siglock_irq(struct sighand *sh1, struct sighand2 *sh2)
> {
> 	if (sh1 > sh2)
> 		swap(sh1, sh2)
>
> 	spin_lock_irq(&sh1->siglock);
> 	spin_lock_nested(&sh2->siglock, SINGLE_DEPTH_NESTING);
> }

You know it might be.  Especially given that the existing code is
already dropping siglock and grabbing tasklist_lock.

It would take a potentially triple lock function to lock
the task it's real_parent and it's tracer (aka parent).

That makes this possible to consider is that notifying the ``parents''
is a fundamental part of the operation so we know we are going to
need the lock so we can move it up.

Throw in a pinch of lock_task_sighand and the triple lock function
gets quite interesting.

It is certainly worth trying, and I will.

Eric

