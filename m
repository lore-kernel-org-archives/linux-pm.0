Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9BBC433EF
	for <linux-pm@archiver.kernel.org>; Fri, 22 Apr 2022 22:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiDVWHO (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbiDVWGy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2022 18:06:54 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35F829A8DD;
        Fri, 22 Apr 2022 13:51:51 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:38310)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nhyrw-009dKx-2e; Fri, 22 Apr 2022 13:23:04 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35330 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nhyru-001u6V-Vt; Fri, 22 Apr 2022 13:23:03 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        oleg@redhat.com, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
References: <20220421150248.667412396@infradead.org>
        <YmLpNhXD8+EzF9/D@linutronix.de>
Date:   Fri, 22 Apr 2022 14:15:35 -0500
In-Reply-To: <YmLpNhXD8+EzF9/D@linutronix.de> (Sebastian Andrzej Siewior's
        message of "Fri, 22 Apr 2022 19:43:18 +0200")
Message-ID: <878rrxnd48.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nhyru-001u6V-Vt;;;mid=<878rrxnd48.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19hvqqRkMVEC3l3uQe4MMAWSxUUPffs0mA=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 0/5] ptrace-vs-PREEMPT_RT and freezer rewrite
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2022-04-21 17:02:48 [+0200], Peter Zijlstra wrote:
>> Find here a new posting of the ptrace and freezer patches :-)
>> 
>> The majority of the changes are in patch 2, which with much feedback from Oleg
>> and Eric has changed lots.
>> 
>> I'm hoping we're converging on something agreeable.
>
> I tested this under RT (had to remove the preempt-disable section in
> ptrace_stop()) with ssdd [0]. It forks a few tasks and then
> PTRACE_SINGLESTEPs them for a few iterations.

Out of curiosity why did you need to remove the preempt_disable section
on PREEMPT_RT?  It should have lasted for just a moment until schedule
was called.

Eric
