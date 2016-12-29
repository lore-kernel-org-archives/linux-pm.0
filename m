From: Wanpeng Li <kernellwp@gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: add up/down frequency transition rate limits
Date: Thu, 29 Dec 2016 11:24:56 +0800
Message-ID: <CANRm+CzQ3H1YJEcAJk4pwFJ+v4c0nFSNu5G+kx_e7Y1XWz1rNQ@mail.gmail.com>
References: <c6248ec9475117a1d6c9ff9aafa8894f6574a82f.1479359903.git.viresh.kumar@linaro.org>
 <20161121100805.GB10014@vireshk-i7> <20161121101946.GI3102@twins.programming.kicks-ass.net>
 <20161121121432.GK24383@e106622-lin> <20161121122622.GC3092@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34261 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752218AbcL2DY7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Dec 2016 22:24:59 -0500
In-Reply-To: <20161121122622.GC3092@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <Juri.Lelli@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>, tkjos@google.com, Morten Rasmussen <morten.rasmussen@arm.com>

2016-11-21 20:26 GMT+08:00 Peter Zijlstra <peterz@infradead.org>:
> On Mon, Nov 21, 2016 at 12:14:32PM +0000, Juri Lelli wrote:
>> On 21/11/16 11:19, Peter Zijlstra wrote:
>
>> > So no tunables and rate limits here at all please.
>> >
>> > During LPC we discussed the rampup and decay issues and decided that we
>> > should very much first address them by playing with the PELT stuff.
>> > Morton was going to play with capping the decay on the util signal. This
>> > should greatly improve the ramp-up scenario and cure some other wobbles.
>> >
>> > The decay can be set by changing the over-all pelt decay, if so desired.
>> >
>>
>> Do you mean we might want to change the decay (make it different from
>> ramp-up) once for all, or maybe we make it tunable so that we can
>> address different power/perf requirements?
>
> So the limited decay would be the dominant factor in ramp-up time,
> leaving the regular PELT period the dominant factor for ramp-down.
>
> (Note that the decay limit would only be applied on the per-task signal,
> not the accumulated signal.)

What's the meaning of "signal" in this thread?

Regards,
Wanpeng Li
