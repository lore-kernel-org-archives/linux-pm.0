From: Juri Lelli <Juri.Lelli@arm.com>
Subject: Re: [PATCH] cpufreq: schedutil: add up/down frequency transition
 rate limits
Date: Mon, 21 Nov 2016 14:37:27 +0000
Message-ID: <20161121143727.GO24383@e106622-lin>
References: <c6248ec9475117a1d6c9ff9aafa8894f6574a82f.1479359903.git.viresh.kumar@linaro.org>
 <20161121100805.GB10014@vireshk-i7>
 <20161121101946.GI3102@twins.programming.kicks-ass.net>
 <20161121121432.GK24383@e106622-lin>
 <20161121122622.GC3092@twins.programming.kicks-ass.net>
 <20161121135308.GN24383@e106622-lin>
 <20161121141728.GF3092@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753226AbcKUOhD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Nov 2016 09:37:03 -0500
Content-Disposition: inline
In-Reply-To: <20161121141728.GF3092@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>, tkjos@google.com, Morten Rasmussen <morten.rasmussen@arm.com>

On 21/11/16 15:17, Peter Zijlstra wrote:
> On Mon, Nov 21, 2016 at 01:53:08PM +0000, Juri Lelli wrote:
> > On 21/11/16 13:26, Peter Zijlstra wrote:
> 
> > > So the limited decay would be the dominant factor in ramp-up time,
> > > leaving the regular PELT period the dominant factor for ramp-down.
> > > 
> > 
> > Hmmm, AFAIU the limited decay will help not forgetting completely the
> > contribution of tasks that sleep for a long time, but it won't modify
> > the actual ramp-up of the signal. So, for new tasks we will need to play
> > with a sensible initial value (trading off perf and power as usual).
> 
> Oh, you mean ramp-up for bright spanking new tasks? I forgot the
> details, but I think we can fudge the 'history' such that those too ramp
> up quickly.
> 

Right. I think Vincent had some ideas on this front already.

> > > (Note that the decay limit would only be applied on the per-task signal,
> > > not the accumulated signal.)
> > > 
> > 
> > Right, and since schedutil consumes the latter, we could still suffer
> > from too frequent frequency switch events I guess (this is where the
> > down threshold thing came as a quick and dirty fix). Maybe we can think
> > of some smoothing applied to the accumulated signal, or make it decay
> > slower (don't really know what this means in practice, though :) ?
> 
> Not sure I follow. So by limiting decay to the task value, the moment we
> add it back to the accumulated signal (wakeup), the accumulated signal
> jumps up quickly and ramp-up is achieved.
> 

This is true, but it seems that this potentially spiky behaviour
(which in general depends on tasks composition and periodicity) might
affect power savings (as in you don't generally want to switch between
high and low freqs too often). So that's why I was just thinking that
some sort of smoothing applied to the signal schedutil uses might help.
