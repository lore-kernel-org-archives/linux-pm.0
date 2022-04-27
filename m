Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FABCC433EF
	for <linux-pm@archiver.kernel.org>; Wed, 27 Apr 2022 16:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242936AbiD0QhF (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 27 Apr 2022 12:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241617AbiD0QhD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2022 12:37:03 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5105EBC9;
        Wed, 27 Apr 2022 09:33:52 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:59410)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njkbt-003CeB-6u; Wed, 27 Apr 2022 10:33:49 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35922 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njkbs-00Bkn9-90; Wed, 27 Apr 2022 10:33:48 -0600
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
In-Reply-To: <20220427160901.GI17421@redhat.com> (Oleg Nesterov's message of
        "Wed, 27 Apr 2022 18:09:03 +0200")
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <20220426225211.308418-9-ebiederm@xmission.com>
        <20220427160901.GI17421@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Wed, 27 Apr 2022 11:33:40 -0500
Message-ID: <87o80m7afv.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1njkbs-00Bkn9-90;;;mid=<87o80m7afv.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/ERgJ97yOK665IszA6bR2ejt/teDKEMaQ=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 9/9] ptrace: Don't change __state
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 04/26, Eric W. Biederman wrote:
>>
>> @@ -253,7 +252,7 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
>>  	 */
>>  	if (lock_task_sighand(child, &flags)) {
>>  		if (child->ptrace && child->parent == current) {
>> -			WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
>> +			WARN_ON(child->jobctl & JOBCTL_DELAY_WAKEKILL);
>
> This WARN_ON() doesn't look right.
>
> It is possible that this child was traced by another task and PTRACE_DETACH'ed,
> but it didn't clear DELAY_WAKEKILL.

That would be a bug.  That would mean that PTRACE_DETACHED process can
not be SIGKILL'd.

> If the new debugger attaches and calls ptrace() before the child takes siglock
> ptrace_freeze_traced() will fail, but we can hit this WARN_ON().

Eric

