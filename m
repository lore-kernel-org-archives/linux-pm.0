From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpufreq: schedutil: add up/down frequency transition
 rate limits
Date: Mon, 21 Nov 2016 15:17:28 +0100
Message-ID: <20161121141728.GF3092@twins.programming.kicks-ass.net>
References: <c6248ec9475117a1d6c9ff9aafa8894f6574a82f.1479359903.git.viresh.kumar@linaro.org>
 <20161121100805.GB10014@vireshk-i7>
 <20161121101946.GI3102@twins.programming.kicks-ass.net>
 <20161121121432.GK24383@e106622-lin>
 <20161121122622.GC3092@twins.programming.kicks-ass.net>
 <20161121135308.GN24383@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161121135308.GN24383@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <Juri.Lelli@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>, tkjos@google.com, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 21, 2016 at 01:53:08PM +0000, Juri Lelli wrote:
> On 21/11/16 13:26, Peter Zijlstra wrote:

> > So the limited decay would be the dominant factor in ramp-up time,
> > leaving the regular PELT period the dominant factor for ramp-down.
> > 
> 
> Hmmm, AFAIU the limited decay will help not forgetting completely the
> contribution of tasks that sleep for a long time, but it won't modify
> the actual ramp-up of the signal. So, for new tasks we will need to play
> with a sensible initial value (trading off perf and power as usual).

Oh, you mean ramp-up for bright spanking new tasks? I forgot the
details, but I think we can fudge the 'history' such that those too ramp
up quickly.

> > (Note that the decay limit would only be applied on the per-task signal,
> > not the accumulated signal.)
> > 
> 
> Right, and since schedutil consumes the latter, we could still suffer
> from too frequent frequency switch events I guess (this is where the
> down threshold thing came as a quick and dirty fix). Maybe we can think
> of some smoothing applied to the accumulated signal, or make it decay
> slower (don't really know what this means in practice, though :) ?

Not sure I follow. So by limiting decay to the task value, the moment we
add it back to the accumulated signal (wakeup), the accumulated signal
jumps up quickly and ramp-up is achieved.
