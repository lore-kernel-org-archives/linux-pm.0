Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F78CC433F5
	for <linux-pm@archiver.kernel.org>; Thu,  5 May 2022 17:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352476AbiEER5i (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 5 May 2022 13:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbiEER5h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2022 13:57:37 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D5328E33;
        Thu,  5 May 2022 10:53:57 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:54714)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmffl-004Sf2-UZ; Thu, 05 May 2022 11:53:54 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37098 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmffl-0021uq-3P; Thu, 05 May 2022 11:53:53 -0600
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
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org
References: <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
        <20220504224058.476193-8-ebiederm@xmission.com>
        <20220505152801.GC13929@redhat.com>
Date:   Thu, 05 May 2022 12:53:45 -0500
In-Reply-To: <20220505152801.GC13929@redhat.com> (Oleg Nesterov's message of
        "Thu, 5 May 2022 17:28:03 +0200")
Message-ID: <87zgjv6f2u.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nmffl-0021uq-3P;;;mid=<87zgjv6f2u.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19B+JiTwRJgtZEdFQmx7oMLSPSifAAdFb0=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v3 08/11] ptrace: Admit ptrace_stop can generate
 spuriuos SIGTRAPs
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 05/04, Eric W. Biederman wrote:
>>
>> -static int ptrace_stop(int exit_code, int why, int clear_code,
>> -			unsigned long message, kernel_siginfo_t *info)
>> +static int ptrace_stop(int exit_code, int why, unsigned long message,
>> +		       kernel_siginfo_t *info)
>
> Forgot to mention... but in general I like this change.
>
> In particular, I like the fact it kills the ugly "int clear_code" arg
> which looks as if it solves the problems with the exiting tracer, but
> actually it doesn't. And we do not really care, imo.

Further either this change is necessary or we need to take siglock in
the !current->ptrace path in "ptrace: Don't change __state" so that
JOBCTL_TRACED can be cleared.

So I vote for deleting code, and making ptrace_stop easier to reason
about.

Eric
