Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB644C433EF
	for <linux-pm@archiver.kernel.org>; Thu, 21 Apr 2022 17:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390916AbiDURwB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 21 Apr 2022 13:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390904AbiDURwA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2022 13:52:00 -0400
X-Greylist: delayed 1316 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Apr 2022 10:49:10 PDT
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB284A3F4
        for <linux-pm@vger.kernel.org>; Thu, 21 Apr 2022 10:49:10 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:38236)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nhaaG-0075j1-0N; Thu, 21 Apr 2022 11:27:12 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35224 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nhaaE-00CsQK-DO; Thu, 21 Apr 2022 11:27:11 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
References: <20220421150248.667412396@infradead.org>
        <20220421150655.001952823@infradead.org>
Date:   Thu, 21 Apr 2022 12:26:44 -0500
In-Reply-To: <20220421150655.001952823@infradead.org> (Peter Zijlstra's
        message of "Thu, 21 Apr 2022 17:02:53 +0200")
Message-ID: <878rrys5yj.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nhaaE-00CsQK-DO;;;mid=<878rrys5yj.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/eM4M3vABt0zGjlkIS7dSJhVL77s2rIZ4=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 5/5] freezer,sched: Rewrite core freezer logic
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -288,7 +288,7 @@ static int ptrace_check_attach(struct ta
>  	}
>  	__set_current_state(TASK_RUNNING);
>  
> -	if (!wait_task_inactive(child, TASK_TRACED) ||
> +	if (!wait_task_inactive(child, TASK_TRACED|TASK_FREEZABLE) ||
>  	    !ptrace_freeze_traced(child))
>  		return -ESRCH;

Do we mind that this is going to fail if the child is frozen
during ptrace_check_attach?

I think to avoid that we need to safely get this to
wait_task_inactive(child, 0), like the coredump code uses.

I would like to say that we can do without the wait_task_inactive,
but it looks like it is necessary to ensure that all of the userspace
registers are saved where the tracer can get at them.

Eric
