From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH] cpufreq: schedutil: add up/down frequency transition
 rate limits
Date: Tue, 22 Nov 2016 11:03:16 +0000
Message-ID: <20161122110316.GE3414@e105326-lin>
References: <c6248ec9475117a1d6c9ff9aafa8894f6574a82f.1479359903.git.viresh.kumar@linaro.org>
 <20161121100805.GB10014@vireshk-i7>
 <20161121101946.GI3102@twins.programming.kicks-ass.net>
 <20161121121432.GK24383@e106622-lin>
 <20161121122622.GC3092@twins.programming.kicks-ass.net>
 <20161121135308.GN24383@e106622-lin>
 <20161121141728.GF3092@twins.programming.kicks-ass.net>
 <20161121143727.GO24383@e106622-lin>
 <CAKfTPtCCMaV_k-3V7ReVC7VXYWuxgwovY+BAQ0jMGig947R+bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53320 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932250AbcKVLDV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Nov 2016 06:03:21 -0500
Content-Disposition: inline
In-Reply-To: <CAKfTPtCCMaV_k-3V7ReVC7VXYWuxgwovY+BAQ0jMGig947R+bA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <Juri.Lelli@arm.com>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>, Todd Kjos <tkjos@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>

On 22-Nov 10:27, Vincent Guittot wrote:
> On 21 November 2016 at 15:37, Juri Lelli <Juri.Lelli@arm.com> wrote:
> > On 21/11/16 15:17, Peter Zijlstra wrote:
> >> On Mon, Nov 21, 2016 at 01:53:08PM +0000, Juri Lelli wrote:
> >> > On 21/11/16 13:26, Peter Zijlstra wrote:
> >>
> >> > > So the limited decay would be the dominant factor in ramp-up time,
> >> > > leaving the regular PELT period the dominant factor for ramp-down.
> >> > >
> >> >
> >> > Hmmm, AFAIU the limited decay will help not forgetting completely the
> >> > contribution of tasks that sleep for a long time, but it won't modify
> >> > the actual ramp-up of the signal. So, for new tasks we will need to play
> >> > with a sensible initial value (trading off perf and power as usual).
> >>
> >> Oh, you mean ramp-up for bright spanking new tasks? I forgot the
> >> details, but I think we can fudge the 'history' such that those too ramp
> >> up quickly.
> >>
> >
> > Right. I think Vincent had some ideas on this front already.
> 
> You are probably referring to some properties linked to how the PELT
> signal is evolving. As an example, an increase of 100 pf the
> utilization during the running phase means that we have for sure run
> for more than 5ms. This could probably used such kind of properties
> when estimating the utilization level of the task or the CPU

I like the idea of using PELT features to derive richer information.
However, to better evaluate the effect we can expect, we should always
keep in mind the specific timings of the different scenarios we want
to target the optimizations for.

Thus, for example in the specific case of Android phones, the most
important tasks for the user experience are usually running every 16ms
and for a time which is in the range of 4 to 6ms. This means that
having to wait 5ms to trigger an action it can be a too long time.

I know that your example was intentionally simplified, however it
suggested me that maybe we should try to start a "campaign" to collect
a description of use-cases we would like to optimize for.

Knowing timing and desirable behaviours at the end can also help on
design and implement better solutions.

-- 
#include <best/regards.h>

Patrick Bellasi
