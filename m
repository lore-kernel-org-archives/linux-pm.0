From: Juri Lelli <Juri.Lelli@arm.com>
Subject: Re: [PATCH] cpufreq: schedutil: add up/down frequency transition
 rate limits
Date: Mon, 21 Nov 2016 12:14:32 +0000
Message-ID: <20161121121432.GK24383@e106622-lin>
References: <c6248ec9475117a1d6c9ff9aafa8894f6574a82f.1479359903.git.viresh.kumar@linaro.org>
 <20161121100805.GB10014@vireshk-i7>
 <20161121101946.GI3102@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753347AbcKUMOI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Nov 2016 07:14:08 -0500
Content-Disposition: inline
In-Reply-To: <20161121101946.GI3102@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>, tkjos@google.com, Morten Rasmussen <morten.rasmussen@arm.com>

On 21/11/16 11:19, Peter Zijlstra wrote:
> On Mon, Nov 21, 2016 at 03:38:05PM +0530, Viresh Kumar wrote:
> > On 17-11-16, 10:48, Viresh Kumar wrote:

[...]

> > 
> > (Background story for others from my discussion with Rafael on IRC: Rafael
> > proposed that instead of this patch we can add down_rate_limit_delta_us (>0 =)
> > which can be added to rate_limit_us (rate limit while increasing freq) to find
> > the rate limit to be used in the downward direction. And I raised the point
> > that it looks much neater to have separate up and down rate_limit_us. I also
> > said that people may have a valid case where they want to keep down_rate_limit
> > lower than up_rate_limit and Rafael wasn't fully sure of any such cases).
> > 
> 
> Urgh...
> 
> 
> So no tunables and rate limits here at all please.
> 
> During LPC we discussed the rampup and decay issues and decided that we
> should very much first address them by playing with the PELT stuff.
> Morton was going to play with capping the decay on the util signal. This
> should greatly improve the ramp-up scenario and cure some other wobbles.
> 
> The decay can be set by changing the over-all pelt decay, if so desired.
> 

Do you mean we might want to change the decay (make it different from
ramp-up) once for all, or maybe we make it tunable so that we can
address different power/perf requirements?

> Also, there was the idea of; once the above ideas have all been
> explored; tying the freq ram rate to the power curve.
> 

Yep. That's an interesting one to look at, but it might require some
time.

> So NAK on everything tunable here.
