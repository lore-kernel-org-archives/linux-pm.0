From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] sched: cpufreq: use rt_avg as estimate of required
 RT CPU capacity
Date: Wed, 31 Aug 2016 16:39:07 +0200
Message-ID: <20160831143907.GX10121@twins.programming.kicks-ass.net>
References: <1472236848-17038-1-git-send-email-smuckle@linaro.org>
 <1472236848-17038-3-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1472236848-17038-3-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Steve Muckle <smuckle@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 26, 2016 at 11:40:48AM -0700, Steve Muckle wrote:
> A policy of going to fmax on any RT activity will be detrimental
> for power on many platforms. Often RT accounts for only a small amount
> of CPU activity so sending the CPU frequency to fmax is overkill. Worse
> still, some platforms may not be able to even complete the CPU frequency
> change before the RT activity has already completed.
> 
> Cpufreq governors have not treated RT activity this way in the past so
> it is not part of the expected semantics of the RT scheduling class. The
> DL class offers guarantees about task completion and could be used for
> this purpose.

Not entirely true. People have simply disabled cpufreq because of this.

Yes, RR/FIFO are a pain, but they should still be deterministic, and
variable cpufreq destroys that.

I realize that the fmax thing is annoying, but I'm not seeing how rt_avg
is much better.
