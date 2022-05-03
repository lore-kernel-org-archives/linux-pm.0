Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E67EC433EF
	for <linux-pm@archiver.kernel.org>; Tue,  3 May 2022 19:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbiECTlA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 3 May 2022 15:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiECTk7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 May 2022 15:40:59 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B9924597;
        Tue,  3 May 2022 12:37:26 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:56078)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nlyKo-00AaEh-5z; Tue, 03 May 2022 13:37:22 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:36796 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nlyKn-007Sew-2a; Tue, 03 May 2022 13:37:21 -0600
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
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
References: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
        <20220429214837.386518-6-ebiederm@xmission.com>
        <20220502143750.GC17276@redhat.com>
Date:   Tue, 03 May 2022 14:36:55 -0500
In-Reply-To: <20220502143750.GC17276@redhat.com> (Oleg Nesterov's message of
        "Mon, 2 May 2022 16:37:51 +0200")
Message-ID: <87y1zio1bc.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nlyKn-007Sew-2a;;;mid=<87y1zio1bc.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+j7nUi9NCECp7X522Zs1J0RePdyckNPD8=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 06/12] ptrace: Reimplement PTRACE_KILL by always
 sending SIGKILL
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 04/29, Eric W. Biederman wrote:
>>
>> Call send_sig_info in PTRACE_KILL instead of ptrace_resume.  Calling
>> ptrace_resume is not safe to call if the task has not been stopped
>> with ptrace_freeze_traced.
>
> Oh, I was never, never able to understand why do we have PTRACE_KILL
> and what should it actually do.
>
> I suggested many times to simply remove it but OK, we probably can't
> do this.

I thought I remembered you suggesting fixing it in some other way.

I took at quick look in codesearch.debian.net and PTRACE_KILL is
definitely in use. I find uses in gcc-10, firefox-esr_91.8,
llvm_toolchain, qtwebengine.  At which point I stopped looking.


>> --- a/kernel/ptrace.c
>> +++ b/kernel/ptrace.c
>> @@ -1238,7 +1238,7 @@ int ptrace_request(struct task_struct *child, long request,
>>  	case PTRACE_KILL:
>>  		if (child->exit_state)	/* already dead */
>>  			return 0;
>> -		return ptrace_resume(child, request, SIGKILL);
>> +		return send_sig_info(SIGKILL, SEND_SIG_NOINFO, child);
>
> Note that currently ptrace(PTRACE_KILL) can never fail (yes, yes, it
> is unsafe), but send_sig_info() can. If we do not remove PTRACE_KILL,
> then I'd suggest
>
> 	case PTRACE_KILL:
> 		if (!child->exit_state)
> 			send_sig_info(SIGKILL);
> 		return 0;
>
> to make this change a bit more compatible.


Quite.  The only failure I can find from send_sig_info is if
lock_task_sighand fails and PTRACE_KILL is deliberately ignoring errors
when the target task has exited.

 	case PTRACE_KILL:
 		send_sig_info(SIGKILL);
 		return 0;

I think that should suffice.


> Also, please remove the note about PTRACE_KILL in
> set_task_blockstep().

Good catch, thank you.

Eric
