From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC PATCH] sched/fair: call cpufreq hook in additional paths
Date: Fri, 1 Apr 2016 14:40:32 -0700
Message-ID: <56FEEAD0.2040108@linaro.org>
References: <1458858367-2831-1-git-send-email-smuckle@linaro.org>
 <20160331075951.GG3408@twins.programming.kicks-ass.net>
 <20160331091426.GE11035@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36707 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585AbcDAVkf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2016 17:40:35 -0400
Received: by mail-pf0-f178.google.com with SMTP id e128so78104600pfe.3
        for <linux-pm@vger.kernel.org>; Fri, 01 Apr 2016 14:40:35 -0700 (PDT)
In-Reply-To: <20160331091426.GE11035@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Byungchul Park <byungchul.park@lge.com>

On 03/31/2016 02:14 AM, Peter Zijlstra wrote:
> On Thu, Mar 31, 2016 at 09:59:51AM +0200, Peter Zijlstra wrote:
>>> > >  - passing an argument into attach_entity_load_avg() to indicate                                                 
>>> > >    whether calling the cpufreq hook is necessary
>>> > > 
>>> > > Both of these are ugly in their own way but would avoid a runtime
>>> > > cost. Opinions welcome.
>> > 
>> > Lemme see what this would look like while I throw the below into the bit
>> > bucket.
> OK, so the below looks a lot more sane; and has the surprising benefit
> of actually shrinking the text size..
> 
>   43675    1226      24   44925    af7d defconfig-build/kernel/sched/fair.o.base
>   43723    1226      24   44973    afad defconfig-build/kernel/sched/fair.o.patch
>   43595    1226      24   44845    af2d defconfig-build/kernel/sched/fair.o.patch+
> 
> ---
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c

Cool, thanks. Shall I fold this into this patch and resend the series of
3? Or would you prefer to add this change separately?

thanks,
Steve
