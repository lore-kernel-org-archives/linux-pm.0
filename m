From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [RFD PATCH 00/10] cpuidle: Predict the next events with the IO
 latencies
Date: Thu, 30 Oct 2014 11:14:59 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1410301108400.20099@knanqh.ubzr>
References: <1413986273-28522-1-git-send-email-daniel.lezcano@linaro.org> <20141030143853.GF23531@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141030143853.GF23531@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, axboe@kernel.dk, rafael.j.wysocki@intel.com, mingo@kernel.org, preeti@linux.vnet.ibm.com, Morten.Rasmussen@arm.com, mturquette@linaro.org, tuukka.tikkanen@linaro.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

On Thu, 30 Oct 2014, Peter Zijlstra wrote:

> On Wed, Oct 22, 2014 at 03:57:43PM +0200, Daniel Lezcano wrote:
> > After discussing at the LPC2014 Dusseldorf, it appears the idea is
> > good but the approach is wrong. The latency tracking must be done at
> > the device level, per device and not in the task as what is doing this
> > patchset.
> 
> end_page_writeback()->test_clear_page_writeback()->__bdi_writeout_inc()
> 
> Is the IO completion path that has a fair amount of statistics in, maybe
> some of that is usable.

I had a look and I don't think it does what we need.  The statistics in 
there are about estimating the device throughput for throttling writers. 
That doesn't help much for predicting when the next interrupt for the 
device is going to fire (some devices can do scatter-gather, some don't, 
etc.)

And this doesn't cover the read path.


Nicolas
