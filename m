From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] cpufreq: schedutil: add up/down frequency transition rate limits
Date: Tue, 22 Nov 2016 10:27:40 +0100
Message-ID: <CAKfTPtCCMaV_k-3V7ReVC7VXYWuxgwovY+BAQ0jMGig947R+bA@mail.gmail.com>
References: <c6248ec9475117a1d6c9ff9aafa8894f6574a82f.1479359903.git.viresh.kumar@linaro.org>
 <20161121100805.GB10014@vireshk-i7> <20161121101946.GI3102@twins.programming.kicks-ass.net>
 <20161121121432.GK24383@e106622-lin> <20161121122622.GC3092@twins.programming.kicks-ass.net>
 <20161121135308.GN24383@e106622-lin> <20161121141728.GF3092@twins.programming.kicks-ass.net>
 <20161121143727.GO24383@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38230 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755414AbcKVJ2D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2016 04:28:03 -0500
Received: by mail-wm0-f49.google.com with SMTP id f82so14454961wmf.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Nov 2016 01:28:02 -0800 (PST)
In-Reply-To: <20161121143727.GO24383@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <Juri.Lelli@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>, Todd Kjos <tkjos@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>

On 21 November 2016 at 15:37, Juri Lelli <Juri.Lelli@arm.com> wrote:
> On 21/11/16 15:17, Peter Zijlstra wrote:
>> On Mon, Nov 21, 2016 at 01:53:08PM +0000, Juri Lelli wrote:
>> > On 21/11/16 13:26, Peter Zijlstra wrote:
>>
>> > > So the limited decay would be the dominant factor in ramp-up time,
>> > > leaving the regular PELT period the dominant factor for ramp-down.
>> > >
>> >
>> > Hmmm, AFAIU the limited decay will help not forgetting completely the
>> > contribution of tasks that sleep for a long time, but it won't modify
>> > the actual ramp-up of the signal. So, for new tasks we will need to play
>> > with a sensible initial value (trading off perf and power as usual).
>>
>> Oh, you mean ramp-up for bright spanking new tasks? I forgot the
>> details, but I think we can fudge the 'history' such that those too ramp
>> up quickly.
>>
>
> Right. I think Vincent had some ideas on this front already.

You are probably referring to some properties linked to how the PELT
signal is evolving. As an example, an increase of 100 pf the
utilization during the running phase means that we have for sure run
for more than 5ms. This could probably used such kind of properties
when estimating the utilization level of the task or the CPU

>
>> > > (Note that the decay limit would only be applied on the per-task signal,
>> > > not the accumulated signal.)
>> > >
>> >
>> > Right, and since schedutil consumes the latter, we could still suffer
>> > from too frequent frequency switch events I guess (this is where the
>> > down threshold thing came as a quick and dirty fix). Maybe we can think
>> > of some smoothing applied to the accumulated signal, or make it decay
>> > slower (don't really know what this means in practice, though :) ?
>>
>> Not sure I follow. So by limiting decay to the task value, the moment we
>> add it back to the accumulated signal (wakeup), the accumulated signal
>> jumps up quickly and ramp-up is achieved.
>>
>
> This is true, but it seems that this potentially spiky behaviour
> (which in general depends on tasks composition and periodicity) might
> affect power savings (as in you don't generally want to switch between
> high and low freqs too often). So that's why I was just thinking that
> some sort of smoothing applied to the signal schedutil uses might help.
