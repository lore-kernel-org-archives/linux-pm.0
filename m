Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85FDC433EF
	for <linux-pm@archiver.kernel.org>; Tue, 10 May 2022 14:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345479AbiEJPDy (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 10 May 2022 11:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345476AbiEJPDd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 May 2022 11:03:33 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F92327A00;
        Tue, 10 May 2022 07:27:25 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:42716)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1noQpd-0012or-S8; Tue, 10 May 2022 08:27:21 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37624 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1noQpc-00DmkJ-RI; Tue, 10 May 2022 08:27:21 -0600
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
        linux-xtensa@linux-xtensa.org, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>, linux-ia64@vger.kernel.org
References: <20220421150248.667412396@infradead.org>
        <20220421150654.817117821@infradead.org>
        <87czhap9dy.fsf@email.froward.int.ebiederm.org>
        <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
        <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
        <20220510141119.GA23277@redhat.com>
Date:   Tue, 10 May 2022 09:26:36 -0500
In-Reply-To: <20220510141119.GA23277@redhat.com> (Oleg Nesterov's message of
        "Tue, 10 May 2022 16:11:21 +0200")
Message-ID: <87lev9xy3n.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1noQpc-00DmkJ-RI;;;mid=<87lev9xy3n.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19KRDu+EXVWb48tgdlPoAOQU75bKyGlPTs=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v4 0/12] ptrace: cleaning up ptrace_stop
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 05/05, Eric W. Biederman wrote:
>>
>> Eric W. Biederman (11):
>>       signal: Rename send_signal send_signal_locked
>>       signal: Replace __group_send_sig_info with send_signal_locked
>>       ptrace/um: Replace PT_DTRACE with TIF_SINGLESTEP
>>       ptrace/xtensa: Replace PT_SINGLESTEP with TIF_SINGLESTEP
>>       ptrace: Remove arch_ptrace_attach
>>       signal: Use lockdep_assert_held instead of assert_spin_locked
>>       ptrace: Reimplement PTRACE_KILL by always sending SIGKILL
>>       ptrace: Document that wait_task_inactive can't fail
>>       ptrace: Admit ptrace_stop can generate spuriuos SIGTRAPs
>>       ptrace: Don't change __state
>>       ptrace: Always take siglock in ptrace_resume
>>
>> Peter Zijlstra (1):
>>       sched,signal,ptrace: Rework TASK_TRACED, TASK_STOPPED state
>
> OK, lgtm.
>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
>
>
> I still dislike you removed TASK_WAKEKILL from TASK_TRACED, but I can't
> find a good argument against it ;) and yes, this is subjective.

Does anyone else have any comments on this patchset?

If not I am going to apply this to a branch and get it into linux-next.

Eric

