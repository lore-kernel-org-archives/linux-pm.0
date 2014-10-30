From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFD PATCH 10/10] sched: io_latency: Tracking via buckets
Date: Thu, 30 Oct 2014 15:46:34 +0100
Message-ID: <20141030144634.GH23531@worktop.programming.kicks-ass.net>
References: <1413986273-28522-1-git-send-email-daniel.lezcano@linaro.org>
 <1413986273-28522-11-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1413986273-28522-11-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, axboe@kernel.dk, rafael.j.wysocki@intel.com, mingo@kernel.org, preeti@linux.vnet.ibm.com, Morten.Rasmussen@arm.com, mturquette@linaro.org, tuukka.tikkanen@linaro.org, nicolas.pitre@linaro.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 22, 2014 at 03:57:53PM +0200, Daniel Lezcano wrote:
> The size of the bucket is the bucket interval and represent the resolution
> of the statistic model. Eg with a bucket interval of 1us, it leads us to
> do statitics on all numbers, with of course a bad prediction because the
> number of latencies is big. A big interval can give better statistics,
> but can give us a misprediction as the interval is larger.
> 
> Choosing the size of the bucket interval vs the idle sleep time is the
> tradeoff to find. With a 200us bucket interval, the measurements show
> we still have good predictions, less mispredictions and cover the idle
> state target residency.
> 

For the record:

The suggestion in DUS was to align the bucket sizes with the various
break even times of the actual C states.

I forgot who suggested this; it might have been Morten; but it seems to
make sense.
