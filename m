From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFCv6 PATCH 09/10] sched: deadline: use deadline bandwidth in scale_rt_capacity
Date: Tue, 15 Dec 2015 13:56:03 +0100
Message-ID: <CAKfTPtDBba=XnVV_z8ahFk1BznkdoWPtBTEp1BnUM3MOsGFrfA@mail.gmail.com>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-10-git-send-email-smuckle@linaro.org> <20151214151729.GQ6357@twins.programming.kicks-ass.net>
 <CAKfTPtAVmS6BHWcGz4cB0bpEE91QzU5sSmMWZB9j_vpK0qjwHg@mail.gmail.com>
 <20151214165128.GU6357@twins.programming.kicks-ass.net> <CAKfTPtCRGuWY8aXCKVHumM3nLODsWm55ZHhkBm4v5HzPEn+J_g@mail.gmail.com>
 <20151215124144.GD6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:34198 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884AbbLOM4Y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2015 07:56:24 -0500
Received: by mail-lb0-f170.google.com with SMTP id cs9so4979332lbb.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2015 04:56:23 -0800 (PST)
In-Reply-To: <20151215124144.GD6357@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Luca Abeni <luca.abeni@unitn.it>

On 15 December 2015 at 13:41, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Dec 15, 2015 at 05:43:44AM +0100, Vincent Guittot wrote:
>> On 14 December 2015 at 17:51, Peter Zijlstra <peterz@infradead.org> wrote:
>
>> > No, since the WCET can and _will_ happen, its the best you can do with
>> > cpufreq. If you were to set it lower you could not be able to execute
>> > correctly in your 'never' tail cases.
>>
>> In the context of frequency scaling, This mean that we will never
>> reach low frequency
>
> Only if you've stuffed your machine full of deadline tasks, if you take
> Luca's example of the I/B frame decoder thingy, then even the WCET for
> the I frames should not be very much (albeit significantly more than B
> frames).

But in this case, the impact of deadline scheduler on the remaining
capacity for CFS should not be that much as well. This will not
prevent a CFS task but only will only make it a bit smaller than the
other

>
> So while the WCET is pessimistic compared to the avg case, most CPUs can
> do video decoding without much effort at all, so even the WCET for the
> I-frames might allow us to drop to the lowest cpufreq.
>
> Now, if you were to decode 10 streams at the same time, different story
> of course ;-)
