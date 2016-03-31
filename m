From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC PATCH] sched/fair: call cpufreq hook in additional paths
Date: Thu, 31 Mar 2016 13:50:24 +0200
Message-ID: <CAJZ5v0iz2wxTbKvH4_YkE5wQswWATBGNo08RRmbY_SCA_n4tgw@mail.gmail.com>
References: <1458858367-2831-1-git-send-email-smuckle@linaro.org>
	<20160331075951.GG3408@twins.programming.kicks-ass.net>
	<20160331091426.GE11035@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35054 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbcCaLu0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2016 07:50:26 -0400
In-Reply-To: <20160331091426.GE11035@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Byungchul Park <byungchul.park@lge.com>

On Thu, Mar 31, 2016 at 11:14 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Mar 31, 2016 at 09:59:51AM +0200, Peter Zijlstra wrote:
>> >  - passing an argument into attach_entity_load_avg() to indicate
>> >    whether calling the cpufreq hook is necessary
>> >
>> > Both of these are ugly in their own way but would avoid a runtime
>> > cost. Opinions welcome.
>>
>> Lemme see what this would look like while I throw the below into the bit
>> bucket.
>
> OK, so the below looks a lot more sane;

Yup.

> and has the surprising benefit of actually shrinking the text size..
>
>   43675    1226      24   44925    af7d defconfig-build/kernel/sched/fair.o.base
>   43723    1226      24   44973    afad defconfig-build/kernel/sched/fair.o.patch
>   43595    1226      24   44845    af2d defconfig-build/kernel/sched/fair.o.patch+

Interesting. :-)
