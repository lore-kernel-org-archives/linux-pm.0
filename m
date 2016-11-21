From: Juri Lelli <Juri.Lelli@arm.com>
Subject: Re: [PATCH] cpufreq: schedutil: add up/down frequency transition
 rate limits
Date: Mon, 21 Nov 2016 14:59:47 +0000
Message-ID: <20161121145947.GQ24383@e106622-lin>
References: <c6248ec9475117a1d6c9ff9aafa8894f6574a82f.1479359903.git.viresh.kumar@linaro.org>
 <20161121100805.GB10014@vireshk-i7>
 <20161121101946.GI3102@twins.programming.kicks-ass.net>
 <20161121121432.GK24383@e106622-lin>
 <20161121122622.GC3092@twins.programming.kicks-ass.net>
 <20161121135308.GN24383@e106622-lin>
 <20161121141728.GF3092@twins.programming.kicks-ass.net>
 <20161121143727.GO24383@e106622-lin>
 <20161121144343.GH3092@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754029AbcKUO7Y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Nov 2016 09:59:24 -0500
Content-Disposition: inline
In-Reply-To: <20161121144343.GH3092@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>, tkjos@google.com, Morten Rasmussen <morten.rasmussen@arm.com>

On 21/11/16 15:43, Peter Zijlstra wrote:
> On Mon, Nov 21, 2016 at 02:37:27PM +0000, Juri Lelli wrote:
> > On 21/11/16 15:17, Peter Zijlstra wrote:
> 
> > > Not sure I follow. So by limiting decay to the task value, the moment we
> > > add it back to the accumulated signal (wakeup), the accumulated signal
> > > jumps up quickly and ramp-up is achieved.
> > > 
> > 
> > This is true, but it seems that this potentially spiky behaviour
> > (which in general depends on tasks composition and periodicity) might
> > affect power savings (as in you don't generally want to switch between
> > high and low freqs too often). So that's why I was just thinking that
> > some sort of smoothing applied to the signal schedutil uses might help.
> 
> Hurm.. so during LPC it was said that fast ramp-up was desired. Note
> that we'll not ramp down this fast, the accumulated signal will decay
> slowly as per blocked-load PELT rules. So only ramp-up is spiky, but
> that is what was desired AFAIU.
> 

Yep, fast ramp-up is quite crucial I'd say. And it's also true that we
should in theory already ramp-down slower. My worries originate mostly
from our experience with Android devices, for which we ended up
introducing thresholds as per subject of this thread. But it's also true
that the landscape it's different there (e.g., slightly different
governor, different utilization signal, etc.), so I guess we should now
re-evaluate things in light of what we discussed here and at LPC.
