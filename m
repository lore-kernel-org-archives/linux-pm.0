From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [RFD PATCH 10/10] sched: io_latency: Tracking via buckets
Date: Thu, 30 Oct 2014 11:07:54 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1410301059180.20099@knanqh.ubzr>
References: <1413986273-28522-1-git-send-email-daniel.lezcano@linaro.org> <1413986273-28522-11-git-send-email-daniel.lezcano@linaro.org> <20141030144634.GH23531@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141030144634.GH23531@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, axboe@kernel.dk, rafael.j.wysocki@intel.com, mingo@kernel.org, preeti@linux.vnet.ibm.com, Morten.Rasmussen@arm.com, mturquette@linaro.org, tuukka.tikkanen@linaro.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

On Thu, 30 Oct 2014, Peter Zijlstra wrote:

> On Wed, Oct 22, 2014 at 03:57:53PM +0200, Daniel Lezcano wrote:
> > The size of the bucket is the bucket interval and represent the resolution
> > of the statistic model. Eg with a bucket interval of 1us, it leads us to
> > do statitics on all numbers, with of course a bad prediction because the
> > number of latencies is big. A big interval can give better statistics,
> > but can give us a misprediction as the interval is larger.
> > 
> > Choosing the size of the bucket interval vs the idle sleep time is the
> > tradeoff to find. With a 200us bucket interval, the measurements show
> > we still have good predictions, less mispredictions and cover the idle
> > state target residency.
> > 
> 
> For the record:
> 
> The suggestion in DUS was to align the bucket sizes with the various
> break even times of the actual C states.
> 
> I forgot who suggested this; it might have been Morten; but it seems to
> make sense.

I suggested that a while ago too.  But IIRC Daniel envisioned some 
possible additional use for those buckets in the future e.g.. a measure 
of how many tasks can be packed on a CPU knowing their sleep periods.

However, if the IO latency can be predicted at the driver level with 
good accuracy (it normally should) then there is no need to do any kind 
of averaging and bucketing since the driver should be able to provide a 
relatively precise number almost every time.


Nicolas
