Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C852C433F5
	for <linux-pm@archiver.kernel.org>; Wed, 27 Apr 2022 21:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237726AbiD0WBG (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 27 Apr 2022 18:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237763AbiD0WBF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2022 18:01:05 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762ED21A1;
        Wed, 27 Apr 2022 14:57:51 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:57788)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njpfP-0010l2-WF; Wed, 27 Apr 2022 15:57:48 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35986 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njpfO-00BQOO-4X; Wed, 27 Apr 2022 15:57:47 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org
References: <20220421150248.667412396@infradead.org>
        <20220421150654.817117821@infradead.org>
        <20220427155335.GH17421@redhat.com>
Date:   Wed, 27 Apr 2022 16:57:39 -0500
In-Reply-To: <20220427155335.GH17421@redhat.com> (Oleg Nesterov's message of
        "Wed, 27 Apr 2022 17:53:37 +0200")
Message-ID: <87sfpy42b0.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1njpfO-00BQOO-4X;;;mid=<87sfpy42b0.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX181KTp4kKYFA1nut2sJgRrZ1wCAbW/YUAA=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 2/5] sched,ptrace: Fix ptrace_check_attach() vs
 PREEMPT_RT
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 04/21, Peter Zijlstra wrote:
>>
>> @@ -1329,8 +1337,7 @@ SYSCALL_DEFINE4(ptrace, long, request, l
>>  		goto out_put_task_struct;
>>  
>>  	ret = arch_ptrace(child, request, addr, data);
>> -	if (ret || request != PTRACE_DETACH)
>> -		ptrace_unfreeze_traced(child);
>> +	ptrace_unfreeze_traced(child);
>
> Forgot to mention... whatever we do this doesn't look right.
>
> ptrace_unfreeze_traced() must not be called if the tracee was untraced,
> anothet debugger can come after that. I agree, the current code looks
> a bit confusing, perhaps it makes sense to re-write it:
>
> 	if (request == PTRACE_DETACH && ret == 0)
> 		; /* nothing to do, no longer traced by us */
> 	else
> 		ptrace_unfreeze_traced(child);

This was a bug in my original JOBCTL_DELAY_WAITKILL patch and it was
just cut and pasted here.  I thought it made sense when I was throwing
things together but when I looked more closely I realized that it is
not safe.

Eric

