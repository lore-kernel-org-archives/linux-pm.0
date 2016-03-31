From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] sched/fair: move cpufreq hook to
 update_cfs_rq_load_avg()
Date: Thu, 31 Mar 2016 09:37:43 +0200
Message-ID: <20160331073743.GF3408@twins.programming.kicks-ass.net>
References: <1458606068-7476-1-git-send-email-smuckle@linaro.org>
 <56F91D56.4020007@arm.com>
 <56F95D10.4070400@linaro.org>
 <56F97856.4040804@arm.com>
 <56F98832.3030207@linaro.org>
 <20160330193544.GD407@worktop>
 <56FC807C.80204@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56FC807C.80204@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 30, 2016 at 06:42:20PM -0700, Steve Muckle wrote:
> On 03/30/2016 12:35 PM, Peter Zijlstra wrote:
> > On Mon, Mar 28, 2016 at 12:38:26PM -0700, Steve Muckle wrote:
> >> Without covering all the paths where CFS utilization changes it's
> >> possible to have to wait up to a tick to act on some changes, since the
> >> tick is the only guaranteed regularly-occurring instance of the hook.
> >> That's an unacceptable amount of latency IMO...
> > 
> > Note that even with your patches that might still be the case. Remote
> > wakeups might not happen on the destination CPU at all, so it might not
> > be until the next tick (which always happens locally) that we'll
> > 'observe' the utilization change brought with the wakeups.
> > 
> > We could force all the remote wakeups to IPI the destination CPU, but
> > that comes at a significant performance cost.
> 
> What about only IPI'ing the destination when the utilization change is
> known to require a higher CPU frequency?

Can't, the way the wakeup path is constructed we would be sending the
IPI way before we know about utilization.
