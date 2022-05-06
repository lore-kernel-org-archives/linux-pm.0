Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316C2C433F5
	for <linux-pm@archiver.kernel.org>; Fri,  6 May 2022 21:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391122AbiEFWDA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 6 May 2022 18:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350991AbiEFWDA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 May 2022 18:03:00 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BF8255AC;
        Fri,  6 May 2022 14:59:16 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:41340)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nn5yh-008b7d-Gi; Fri, 06 May 2022 15:59:11 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37292 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nn5yg-00Aw1E-9W; Fri, 06 May 2022 15:59:11 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net, oleg@redhat.com,
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
        linux-xtensa@linux-xtensa.org, Jann Horn <jannh@google.com>,
        linux-ia64@vger.kernel.org, Robert O'Callahan <roc@pernos.co>,
        Kyle Huey <khuey@pernos.co>
References: <20220421150248.667412396@infradead.org>
        <20220421150654.817117821@infradead.org>
        <87czhap9dy.fsf@email.froward.int.ebiederm.org>
        <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
        <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
        <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
        <202205061348.927E94729E@keescook>
Date:   Fri, 06 May 2022 16:59:03 -0500
In-Reply-To: <202205061348.927E94729E@keescook> (Kees Cook's message of "Fri,
        6 May 2022 14:26:36 -0700")
Message-ID: <87h762z5js.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nn5yg-00Aw1E-9W;;;mid=<87h762z5js.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/VPXqGxLyk6k3FEwGJyXklghMod61nqrE=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v4 0/12] ptrace: cleaning up ptrace_stop
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Thu, May 05, 2022 at 01:25:57PM -0500, Eric W. Biederman wrote:
>> The states TASK_STOPPED and TASK_TRACE are special in they can not
>> handle spurious wake-ups.  This plus actively depending upon and
>> changing the value of tsk->__state causes problems for PREEMPT_RT and
>> Peter's freezer rewrite.
>> 
>> There are a lot of details we have to get right to sort out the
>> technical challenges and this is my parred back version of the changes
>> that contains just those problems I see good solutions to that I believe
>> are ready.
>> 
>> A couple of issues have been pointed but I think this parred back set of
>> changes is still on the right track.  The biggest change in v4 is the
>> split of "ptrace: Admit ptrace_stop can generate spuriuos SIGTRAPs" into
>> two patches because the dependency I thought exited between two
>> different changes did not exist.  The rest of the changes are minor
>> tweaks to "ptrace: Admit ptrace_stop can generate spuriuos SIGTRAPs";
>> removing an always true branch, and adding an early  test to see if the
>> ptracer had gone, before TASK_TRAPPING was set.
>> 
>> This set of changes should support Peter's freezer rewrite, and with the
>> addition of changing wait_task_inactive(TASK_TRACED) to be
>> wait_task_inactive(0) in ptrace_check_attach I don't think there are any
>> races or issues to be concerned about from the ptrace side.
>> 
>> More work is needed to support PREEMPT_RT, but these changes get things
>> closer.
>> 
>> This set of changes continues to look like it will provide a firm
>> foundation for solving the PREEMPT_RT and freezer challenges.
>
> One of the more sensitive projects to changes around ptrace is rr
> (Robert and Kyle added to CC). I ran rr's selftests before/after this
> series and saw no changes. My failures remained the same; I assume
> they're due to missing CPU features (pkeys) or build configs (bpf), etc:
>
> 99% tests passed, 19 tests failed out of 2777
>
> Total Test time (real) = 773.40 sec
>
> The following tests FAILED:
>          42 - bpf_map (Failed)
>          43 - bpf_map-no-syscallbuf (Failed)
>         414 - netfilter (Failed)
>         415 - netfilter-no-syscallbuf (Failed)
>         454 - x86/pkeys (Failed)
>         455 - x86/pkeys-no-syscallbuf (Failed)
>         1152 - ttyname (Failed)
>         1153 - ttyname-no-syscallbuf (Failed)
>         1430 - bpf_map-32 (Failed)
>         1431 - bpf_map-32-no-syscallbuf (Failed)
>         1502 - detach_sigkill-32 (Failed)
>         1802 - netfilter-32 (Failed)
>         1803 - netfilter-32-no-syscallbuf (Failed)
>         1842 - x86/pkeys-32 (Failed)
>         1843 - x86/pkeys-32-no-syscallbuf (Failed)
>         2316 - crash_in_function-32 (Failed)
>         2317 - crash_in_function-32-no-syscallbuf (Failed)
>         2540 - ttyname-32 (Failed)
>         2541 - ttyname-32-no-syscallbuf (Failed)
>
> So, I guess:
>
> Tested-by: Kees Cook <keescook@chromium.org>
>
> :)

Thank you.  I was thinking it would be good to add the rr folks to the
discussion.

Eric

