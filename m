From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFCv6 PATCH 09/10] sched: deadline: use deadline bandwidth in scale_rt_capacity
Date: Tue, 15 Dec 2015 05:43:44 +0100
Message-ID: <CAKfTPtCRGuWY8aXCKVHumM3nLODsWm55ZHhkBm4v5HzPEn+J_g@mail.gmail.com>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-10-git-send-email-smuckle@linaro.org> <20151214151729.GQ6357@twins.programming.kicks-ass.net>
 <CAKfTPtAVmS6BHWcGz4cB0bpEE91QzU5sSmMWZB9j_vpK0qjwHg@mail.gmail.com> <20151214165128.GU6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:33885 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933186AbbLOEoG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2015 23:44:06 -0500
Received: by lbbcs9 with SMTP id cs9so119570149lbb.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Dec 2015 20:44:04 -0800 (PST)
In-Reply-To: <20151214165128.GU6357@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Luca Abeni <luca.abeni@unitn.it>

On 14 December 2015 at 17:51, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Dec 14, 2015 at 04:56:17PM +0100, Vincent Guittot wrote:
>> I agree that if the WCET is far from reality, we will underestimate
>> available capacity for CFS. Have you got some use case in mind which
>> overestimates the WCET ?
>
> Pretty much any 'correct' WCET is pessimistic. There's heaps of smart
> people working on improving WCET bounds, but they're still out there.
> This is mostly because of the .00001% tail cases that 'never' happen but
> would make your tokamak burn a hole just when you're outside.
>
>> If we can't rely on this parameters to evaluate the amount of capacity
>> used by deadline scheduler on a core, this will imply that we can't
>> also use it for requesting capacity to cpufreq and we should fallback
>> on a monitoring mechanism which reacts to a change instead of
>> anticipating it.
>
> No, since the WCET can and _will_ happen, its the best you can do with
> cpufreq. If you were to set it lower you could not be able to execute
> correctly in your 'never' tail cases.

In the context of frequency scaling, This mean that we will never
reach low frequency


>
> There 'might' be smart pants ways around this, where you run part of the
> execution at lower speed and switch to a higher speed to 'catch' up if
> you exceed some boundary, such that, on average, you run at the same
> speed the WCET mandates, but I'm not sure that's worth it. Juri/Luca
> might know.
