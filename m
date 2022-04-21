Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD28C433F5
	for <linux-pm@archiver.kernel.org>; Thu, 21 Apr 2022 15:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389842AbiDUPEE (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 21 Apr 2022 11:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389841AbiDUPEB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2022 11:04:01 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8981C443ED;
        Thu, 21 Apr 2022 08:01:11 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:43958)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nhYIw-00FLoJ-8n; Thu, 21 Apr 2022 09:01:10 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35194 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nhYIv-009aEA-3r; Thu, 21 Apr 2022 09:01:09 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org
References: <20220414115410.GA32752@redhat.com>
        <20220414183433.GC32752@redhat.com>
        <YlikBjA3kL3XEQP5@hirez.programming.kicks-ass.net>
        <20220415101644.GA10421@redhat.com>
        <20220415105755.GA15217@redhat.com>
        <Yllep6B8eva2VURJ@hirez.programming.kicks-ass.net>
        <20220418170104.GA16199@redhat.com>
        <20220420131731.GF2731@worktop.programming.kicks-ass.net>
        <20220420180323.GA14947@redhat.com>
        <875yn3zdag.fsf_-_@email.froward.int.ebiederm.org>
        <20220421094640.GA18344@redhat.com>
Date:   Thu, 21 Apr 2022 10:01:02 -0500
In-Reply-To: <20220421094640.GA18344@redhat.com> (Oleg Nesterov's message of
        "Thu, 21 Apr 2022 11:46:41 +0200")
Message-ID: <878rryxyz5.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nhYIv-009aEA-3r;;;mid=<878rryxyz5.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+NV/MeA4RuUk65001EaQXJ7hjH0TPEZjc=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH] ptrace: Don't change __state
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 04/20, Eric W. Biederman wrote:
>> @@ -892,7 +891,6 @@ static int ptrace_resume(struct task_struct *child, long request,
>>  	 * status and clears the code too; this can't race with the tracee, it
>>  	 * takes siglock after resume.
>>  	 */
>> -	need_siglock = data && !thread_group_empty(current);
>>  	if (need_siglock)
>>  		spin_lock_irq(&child->sighand->siglock);
>
> Hmm?

A half backed out change (I thought ptrace_resume would need to clear
JOBCTL_DELAY_WAKEKILL) in ptrace_resume.  I somehow failed to
restore the need_siglock line.

Eric

